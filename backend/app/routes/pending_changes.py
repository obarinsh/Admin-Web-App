from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
import json
from datetime import datetime


def pending_changes_routes(metadata_conn, env_connections):
    router = APIRouter()

    class CreatePendingChangeRequest(BaseModel):
        env: str
        table_name: str
        row_id: str
        column: str
        old_value: str
        new_value: str
        user_id: int

    class ApproveRejectRequest(BaseModel):
        admin_user_id: int

    @router.post("/api/pending-change")
    def create_pending_change(data: CreatePendingChangeRequest):
        """Create a new pending change request"""
        cursor = metadata_conn.cursor()

        try:
            # Prepare change_data as JSON
            change_data = {
                "env": data.env,
                "table_name": data.table_name,
                "row_id": data.row_id,
                "column": data.column,
                "old_value": data.old_value,
                "new_value": data.new_value,
                "user_id": data.user_id
            }

            # Insert into pending_changes table
            cursor.execute("""
                INSERT INTO pending_changes (table_name, change_type, change_data, created_at)
                VALUES (%s, %s, %s, %s)
                RETURNING id
            """, (
                data.table_name,
                'UPDATE',
                json.dumps(change_data),
                datetime.now()
            ))

            change_id = cursor.fetchone()[0]
            metadata_conn.commit()

            return {
                "success": True,
                "change_id": change_id,
                "message": "Change request created successfully"
            }

        except Exception as e:
            metadata_conn.rollback()
            print("DB error:", e)
            raise HTTPException(
                status_code=500, detail="Failed to create change request")
        finally:
            cursor.close()

    @router.get("/api/pending-changes")
    def get_all_pending_changes():
        """Get all pending changes for admin review"""
        cursor = metadata_conn.cursor()

        try:
            cursor.execute("""
                SELECT id, table_name, change_type, change_data, created_at
                FROM pending_changes
                WHERE change_type = 'UPDATE'
                ORDER BY created_at DESC
            """)

            changes = cursor.fetchall()
            result = []

            for change in changes:
                # Parse JSON from change_data column
                change_data = json.loads(change[3])
                result.append({
                    "id": change[0],
                    "table_name": change[1],
                    "change_type": change[2],
                    "env": change_data.get("env"),
                    "row_id": change_data.get("row_id"),
                    "column": change_data.get("column"),
                    "old_value": change_data.get("old_value"),
                    "new_value": change_data.get("new_value"),
                    "user_id": change_data.get("user_id"),
                    "created_at": change[4].isoformat() if change[4] else None
                })

            return {
                "success": True,
                "pending_changes": result
            }

        except Exception as e:
            print("DB error:", e)
            raise HTTPException(
                status_code=500, detail="Failed to fetch pending changes")
        finally:
            cursor.close()

    @router.put("/api/pending-change/{change_id}/approve")
    def approve_change(change_id: int, data: ApproveRejectRequest):
        """Approve a pending change and apply it to the target database"""
        metadata_cursor = metadata_conn.cursor()

        try:
            # Get the pending change
            metadata_cursor.execute("""
                SELECT table_name, change_data
                FROM pending_changes
                WHERE id = %s AND change_type = 'UPDATE'
            """, (change_id,))

            result = metadata_cursor.fetchone()
            if not result:
                raise HTTPException(
                    status_code=404, detail="Pending change not found")

            table_name, change_data_json = result
            change_data = json.loads(change_data_json)

            # Get the target environment connection
            env = change_data.get("env")
            if env not in env_connections:
                raise HTTPException(
                    status_code=400, detail="Invalid environment")

            target_conn = env_connections[env]
            target_cursor = target_conn.cursor()

            try:
                # Apply the change to the target database
                # Note: This assumes your tables have an 'id' column as primary key
                # Adjust the WHERE clause based on your actual table structure
                update_query = f"""
                    UPDATE {table_name}
                    SET {change_data['column']} = %s
                    WHERE id = %s
                """

                target_cursor.execute(update_query, (
                    change_data['new_value'],
                    change_data['row_id']
                ))

                target_conn.commit()

                # Remove the pending change (or mark as approved)
                metadata_cursor.execute("""
                    DELETE FROM pending_changes WHERE id = %s
                """, (change_id,))

                metadata_conn.commit()

                return {
                    "success": True,
                    "message": "Change approved and applied successfully"
                }

            except Exception as e:
                target_conn.rollback()
                raise e
            finally:
                target_cursor.close()

        except Exception as e:
            metadata_conn.rollback()
            print("DB error:", e)
            raise HTTPException(
                status_code=500, detail="Failed to approve change")
        finally:
            metadata_cursor.close()

    @router.put("/api/pending-change/{change_id}/reject")
    def reject_change(change_id: int, data: ApproveRejectRequest):
        """Reject a pending change"""
        cursor = metadata_conn.cursor()

        try:
            # Check if change exists
            cursor.execute("""
                SELECT id FROM pending_changes WHERE id = %s
            """, (change_id,))

            if not cursor.fetchone():
                raise HTTPException(
                    status_code=404, detail="Pending change not found")

            # Remove the pending change (or you could mark as rejected instead)
            cursor.execute("""
                DELETE FROM pending_changes WHERE id = %s
            """, (change_id,))

            metadata_conn.commit()

            return {
                "success": True,
                "message": "Change rejected successfully"
            }

        except Exception as e:
            metadata_conn.rollback()
            print("DB error:", e)
            raise HTTPException(
                status_code=500, detail="Failed to reject change")
        finally:
            cursor.close()

    return router
