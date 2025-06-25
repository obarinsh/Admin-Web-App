from dotenv import load_dotenv
import os
import psycopg2
from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from routes.login import setup_login_routes
from routes.tables import show_tables_routes
from routes.pending_changes import pending_changes_routes
load_dotenv()

# --- Initialize FastAPI ---
app = FastAPI()

# --- Middleware ---
app.add_middleware(
    CORSMiddleware,
    allow_origins=[
        "http://localhost:5173",
        "http://localhost:5174",
        "http://localhost:5175"
    ],
    allow_methods=["*"],
    allow_headers=["*"]
)

# --- Connect to Databases ---


def connect_db(name):
    return psycopg2.connect(
        dbname=name,
        user=os.getenv("PG_USER"),
        password=os.getenv("PG_PASSWORD"),
        host=os.getenv("PG_HOST"),
        port=os.getenv("PG_PORT")
    )


metadata_conn = connect_db(os.getenv("METADATA_DB"))

env_connections = {
    "dev": connect_db(os.getenv("DEV_DB")),
    "test": connect_db(os.getenv("TEST_DB")),
}

# --- Include Routes ---
app.include_router(setup_login_routes(metadata_conn))
app.include_router(show_tables_routes(env_connections))
app.include_router(pending_changes_routes(metadata_conn, env_connections))
# --- Test Route ---


@app.get("/")
def read_root():
    return {"message": "Hello from FastAPI"}
