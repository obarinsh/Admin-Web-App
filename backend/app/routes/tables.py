from fastapi import APIRouter, HTTPException
from pydantic import BaseModel


def show_tables_routes(env_connections):
    router = APIRouter()

    class EnvRequest(BaseModel):
        env: str

    class TableDataRequest(BaseModel):
        env: str
        table: str

    @router.post("/api/tables")
    def get_tables(data: EnvRequest):
        if data.env not in env_connections:
            raise HTTPException(status_code=400, detail="Invalid environment")

        conn = env_connections[data.env]
        cursor = conn.cursor()

        try:
            # Get all tables in the database
            cursor.execute("""
                SELECT table_name 
                FROM information_schema.tables 
                WHERE table_schema = 'public' 
                ORDER BY table_name
            """)
            tables = cursor.fetchall()
            table_names = [table[0] for table in tables]

            return {
                "environment": data.env,
                "tables": table_names
            }
        except Exception as e:
            print("DB error:", e)
            raise HTTPException(
                status_code=500, detail="Failed to fetch tables")
        finally:
            cursor.close()

    @router.post("/api/table-data")
    def get_table_data(data: TableDataRequest):
        if data.env not in env_connections:
            raise HTTPException(status_code=400, detail="Invalid environment")

        conn = env_connections[data.env]
        cursor = conn.cursor()

        try:
            # Get column names first
            cursor.execute(f"""
                SELECT column_name 
                FROM information_schema.columns 
                WHERE table_name = %s 
                AND table_schema = 'public'
                ORDER BY ordinal_position
            """, (data.table,))

            columns = [col[0] for col in cursor.fetchall()]

            if not columns:
                raise HTTPException(
                    status_code=404, detail=f"Table '{data.table}' not found")

            # Get table data (limit to first 100 rows for performance)
            cursor.execute(f"SELECT * FROM {data.table} LIMIT 100")
            rows = cursor.fetchall()

            return {
                "environment": data.env,
                "table": data.table,
                "columns": columns,
                "rows": [list(row) for row in rows],
                "total_rows": len(rows)
            }
        except Exception as e:
            print("DB error:", e)
            raise HTTPException(
                status_code=500, detail=f"Failed to fetch data from table '{data.table}'")
        finally:
            cursor.close()

    return router
