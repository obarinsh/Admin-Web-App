# Backend - FastAPI Application

FastAPI-based backend service for database management system. Provides REST API endpoints for authentication, table management, and pending change approval workflow.

### File Structure
```
backend/
├── app/
│   ├── main.py                 # FastAPI app initialization
│   └── routes/
│       ├── login.py           # Authentication endpoints
│       ├── tables.py          # Table data endpoints
│       └── pending_changes.py # Change management endpoints
├── requirements.txt           # Python dependencies
└── .env                      # Environment variables (create this)
```

## 🛠️ Technology Stack

- **Framework**: FastAPI 0.115.13
- **Database**: PostgreSQL with psycopg2-binary
- **Server**: Uvicorn
- **Environment**: python-dotenv for configuration

## 🚀 Setup Instructions

### 1. Python Environment
```bash
# Create virtual environment
python -m venv .venv

# Activate virtual environment
# On macOS/Linux:
source .venv/bin/activate
# On Windows:
.venv\Scripts\activate

# Install dependencies
pip install -r requirements.txt
```

### 2. Environment Variables
Create a `.env` file in the `backend/` directory:

```env
# PostgreSQL Connection Settings
PG_HOST=localhost
PG_PORT=5432
PG_USER=your_postgres_username
PG_PASSWORD=your_postgres_password

# Database Names
METADATA_DB=metadata    # Contains users, roles, pending_changes
DEV_DB=dev             # Development environment data
TEST_DB=test           # Test environment data
```

### 3. Database Setup

#### Create Databases
```
CREATE DATABASE metadata;
CREATE DATABASE dev;
CREATE DATABASE test;
```

#### Setup Metadata Database
```sql
\c metadata;

-- Create roles table
CREATE TABLE roles (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL UNIQUE
);

-- Create users table
CREATE TABLE users (
    id SERIAL PRIMARY KEY,
    username VARCHAR(50) UNIQUE NOT NULL,
    password VARCHAR(100) NOT NULL,  -- hardcoded
    role_id INTEGER REFERENCES roles(id)
);

-- Create pending_changes table
CREATE TABLE pending_changes (
    id SERIAL PRIMARY KEY,
    table_name VARCHAR(100) NOT NULL,
    change_type VARCHAR(20) NOT NULL,  -- 'UPDATE', 'INSERT', 'DELETE'
    change_data JSONB NOT NULL,        -- Stores change details as JSON
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert default roles
INSERT INTO roles (name) VALUES ('admin'), ('user');

-- Insert default users
INSERT INTO users (username, password, role_id) VALUES 
    ('admin', 'admin123', 1),
    ('data_user', 'pass456', 2),
    ('viewer', 'view789', 3);
```

#### Setup Development Database
```sql
-- Connect to sagole_dev database
\c dev;

-- Example: Create products table
CREATE TABLE products (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Insert sample data
INSERT INTO products (name, price) VALUES 
    ('Sample Product A', 0.00),
    ('Sample Product B', 1.00)

-- Create another example table
CREATE TABLE customers (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

INSERT INTO customers (name, email) VALUES 
    ('TestUser1', 'user1@test.com'),
    ('TestUser2', 'user2@test.com')
```

### 4. Start the Server
```bash
# Development mode with auto-reload
uvicorn app.main:app --reload --port 8000

# Production mode
uvicorn app.main:app --host 0.0.0.0 --port 8000
```

The API will be available at:
- **Base URL**: http://localhost:8000
- **Interactive Docs**: http://localhost:8000/docs
- **ReDoc**: http://localhost:8000/redoc

## 🔐 Authentication & Users

### Default Login Credentials

#### Admin User
- **Username**: `admin`
- **Password**: `admin123`
- **Role**: `Administrator`
- **Permissions**: 
  - View all tables
  - Approve/reject pending changes
  - Access admin-only endpoints


## 🏗️ Architecture Details

### Database Connections
The application maintains separate connections for:
- **Metadata DB**: User authentication and pending changes
- **Environment DBs**: Actual data tables (dev, test)

### Change Management Workflow
1. **User Edit**: Frontend sends change to `POST /api/pending-change`
2. **Storage**: Change stored as JSON in `pending_changes` table
3. **Admin Review**: Admin views pending changes via `GET /api/pending-changes`
4. **Approval**: Admin approves via `PUT /api/pending-change/{id}/approve`
5. **Application**: Change applied to target database and removed from pending


---
*For frontend integration details, see the frontend README.md* 