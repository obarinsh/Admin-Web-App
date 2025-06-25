# Database Management System

A full-stack web application that provides a secure, approval-based workflow for database management. Users can view and edit database tables through a web interface, but all changes require administrator approval before being applied to the actual database.

## 🎯 Project Overview

It solves the problem of database access control by providing a user-friendly interface where:
- **Regular users** can view and propose changes to database tables
- **Administrators** review and approve/reject proposed changes
- **All changes** are tracked and require explicit approval before execution
- **Multiple environments** (development, testing) are supported


## 📁 Project Structure
This ensures data integrity while allowing controlled access to database modifications.

├── backend/                 # FastAPI application
│   ├── app/
│   │   ├── main.py         # Application entry point
│   │   └── routes/         # API endpoints
│   └── README.md           # Backend setup and API documentation
├── frontend/               # React application
│   ├── src/
│   │   ├── pages/          # React components
│   │   └── css/            # Styling
│   └── README.md           # Frontend setup and component documentation
├── database/               # PostgreSQL setup scripts
│   ├── `metadata_env.sql` | Creates metadata database schema and structure | `metadata` |
|   ├── `metadata_seed.sql` | Inserts default users, roles, and sample data | `metadata` |
|   ├── `dev_env.sql` | Creates development environment schema | `dev` |
|   ├── `dev_seed.sql` | Inserts realistic business data for development | `dev` |
|   ├── `test_env.sql` | Creates test environment schema | `test` |
|   ├── `test_seed.sql` | Inserts test data and edge cases | `test` |
│   └── README.md           # Database setup instructions
└── README.md               # This overview document

**Components:**
- **Frontend**: React application for user interaction
- **Backend**: FastAPI service handling business logic and database operations
- **Database**: PostgreSQL with separate databases for metadata and application data
- **Database Scripts**: Complete SQL setup for all environments

## 📋 Project Objectives vs Implementation Status

### Original Requirements
Build a web-based admin panel to interact with multiple PostgreSQL environments with authenticated users able to:
1. View and filter data from environment-specific databases
2. Run predefined queries  
3. Edit records (with change tracking)
4. Submit changes for approval
5. Approve or reject pending changes (admin only)
6. Show a user-friendly GUI with role-based features

### Implementation Status

#### ✅ **Fully Implemented**
- ** Authentication System**: Login screen with hardcoded users (admin/user roles)
- ** Environment Switching**: Dev/test environment selector
- ** Table Management**: Table listing and dynamic table detection
- ** Data Viewing**: Data grid with all table data displayed
- ** Record Editing**: Inline cell editing with change detection
- ** Change Tracking**: All edits stored in metadata database
- ** Change Submission**: Automatic submission of edits for approval
- ** RESTful API**: Complete backend API for core functionality
- ** Metadata Storage**: Pending changes stored in dedicated database
- ** Database Setup**: Complete SQL scripts for all environments

#### ⚠️ **Partially Implemented**
- ** Admin Approvals**: Backend API exists but no web UI for admin review
- ** Row Operations**: Add/delete UI exists but backend integration incomplete
- ** Change Application**: Approval logic exists but INSERT/DELETE operations missing

#### ❌ **Not Implemented (Due to Time Constraints)**
- ** Data Filtering**: No search/filter functionality in data grid
- ** Role-based Access**: Different permissions for admin vs user
- ** Data Sorting**: No column sorting capabilities
- ** Predefined Queries**: No query runner interface
- ** Admin Dashboard**: No web interface for pending change review
- ** Change Diffs**: No before/after comparison display
- ** UI Feedback**: No toast notifications or success/failure messages
- ** Table Snapshots**: No backup of affected tables on approval
- ** Bulk Operations**: No mass approve/reject functionality

## 🏗️ System Architecture

```
┌─────────────────┐    ┌─────────────────┐    ┌─────────────────┐
│   React Frontend │    │  FastAPI Backend │    │   PostgreSQL    │
│                 │    │                 │    │                 │
│ • User Interface│◄──►│ • Authentication│◄──►│ • User Data     │
│ • Table Editing │    │ • Change Mgmt   │    │ • Pending Changes│
│ • Approval UI   │    │ • API Endpoints │    │ • Application Data│
└─────────────────┘    └─────────────────┘    └─────────────────┘
```

## 🚀 Quick Start

### Prerequisites
- Python 3.8+
- Node.js 16+
- PostgreSQL 12+


## 🔧 Development Workflow

### For Developers
1. **Database Changes**: Use scripts in `database/` directory
2. **Backend Changes**: See `backend/README.md` for API development
3. **Frontend Changes**: See `frontend/README.md` for UI development

### For Users
1. **Login** with provided credentials
2. **Select Environment** (dev/test) and table
3. **Edit Data** by clicking on table cells
4. **Submit Changes** automatically on cell blur
5. **Wait for Admin Approval** before changes take effect

### For Administrators
1. **Login** with admin credentials
2. **Review Pending Changes** via API endpoints (no web UI currently)
3. **Approve/Reject Changes** through API calls
4. **Monitor System** for change requests

## 🗄️ Database Information

The system uses PostgreSQL with multiple databases:

- **sagole_metadata**: User management and change tracking
- **sagole_dev**: Development environment data
- **sagole_test**: Test environment data  
- **sagole_stage**: Staging environment (planned)
- **sagole_prod**: Production environment (planned)

**Complete database setup instructions and SQL scripts are available in the `database/` directory.**

Sample data includes:
- **Products**: Electronics, furniture, clothing, books, sports items
- **Customers**: Realistic customer profiles with contact information
- **Orders**: Various order statuses and purchase history
- **Test Data**: Edge cases and validation scenarios

*For detailed technical documentation, please refer to the README files in the `backend/`, `frontend/`, and `database/` directories.* 