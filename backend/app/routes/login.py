from fastapi import APIRouter, HTTPException
from pydantic import BaseModel


def setup_login_routes(metadata_conn):
    router = APIRouter()

    class LoginData(BaseModel):
        username: str
        password: str

    @router.post("/api/login")
    def login(data: LoginData):
        cursor = metadata_conn.cursor()
        try:
            # Join users and roles tables to get role name
            cursor.execute(
                """SELECT u.id, u.username, r.name as role_name 
                   FROM users u 
                   JOIN roles r ON u.role_id = r.id 
                   WHERE u.username=%s AND u.password=%s""",
                (data.username, data.password)
            )
            user = cursor.fetchone()
            if not user:
                raise HTTPException(
                    status_code=401, detail="Invalid credentials")
            return {
                "id": user[0],
                "username": user[1],
                "role": user[2]  # Now returning role name instead of role_id
            }
        except Exception as e:
            metadata_conn.rollback()  # ✅ reset bad transaction
            print("Login error:", e)
            raise HTTPException(status_code=500, detail="Server error")
        finally:
            cursor.close()

    return router
