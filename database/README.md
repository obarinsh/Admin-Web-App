# Database Setup Scripts

This directory contains PostgreSQL database dump files for setting up the Database Management System.

## 📁 Script Overview


| Script | Purpose | Database |
|--------|---------|----------|
| `metadata_env.sql` | Creates metadata database schema and structure | `metadata` |
| `metadata_seed.sql` | Inserts default users, roles, and sample data | `metadata` |
| `dev_env.sql` | Creates development environment schema | `dev` |
| `dev_seed.sql` | Inserts realistic business data for development | `dev` |
| `test_env.sql` | Creates test environment schema | `test` |
| `test_seed.sql` | Inserts test data and edge cases | `test` |



## 🚀 Quick Setup (All-in-One)

First, create the databases manually, then restore from dumps:

```bash
# Connect to PostgreSQL as superuser
psql -U postgres -h localhost

# Create the databases
CREATE DATABASE metadata;
CREATE DATABASE dev;
CREATE DATABASE test;

# Exit psql
\q

# Restore metadata database
psql -U postgres -h localhost -d metadata -f database/metadata_env.sql
psql -U postgres -h localhost -d metadata -f database/metadata_seed.sql

# Restore development database
psql -U postgres -h localhost -d dev -f database/dev_env.sql
psql -U postgres -h localhost -d dev -f database/dev_seed.sql

# Restore test database
psql -U postgres -h localhost -d test -f database/test_env.sql
psql -U postgres -h localhost -d test -f database/test_seed.sql
```

## 📋 Step-by-Step Setup

### Step 1: Create Empty Databases
```bash
psql -U postgres -h localhost
```

```sql
CREATE DATABASE metadata;
CREATE DATABASE dev;
CREATE DATABASE test;
\q
```

### Step 2: Restore Metadata Database
```bash
# Restore schema
psql -U postgres -h localhost -d metadata -f database/metadata_env.sql

# Insert seed data
psql -U postgres -h localhost -d metadata -f database/metadata_seed.sql
```

Creates tables:
- `roles` - User roles (admin, user)
- `users` - System users with authentication
- `pending_changes` - Change requests awaiting approval
- `snapshots` - Table snapshots for backup

### Step 3: Restore Development Environment
```bash
# Restore schema
psql -U postgres -h localhost -d dev -f database/dev_env.sql

# Insert seed data
psql -U postgres -h localhost -d dev -f database/dev_seed.sql
```

Creates business tables:
- `users` - Customer/user information
- `products` - Product catalog

### Step 4: Restore Test Environment
```bash
# Restore schema
psql -U postgres -h localhost -d test -f database/test_env.sql

# Insert seed data
psql -U postgres -h localhost -d test -f database/test_seed.sql
```

Creates test tables with the same structure as development environment.

## 🔐 Default User Accounts

The metadata database contains these default user accounts:

| Username | Password | Role | Purpose |
|----------|----------|------|---------|
| `admin` | `admin123` | admin | Full system access, can approve changes |
| `user1` | `user123` | user | Can view and edit tables, submit changes |
| `user2` | `user456` | user | Can view and edit tables, submit changes |

*Note: Check `metadata_seed.sql` for the complete list of users and their details.*

## 📊 Sample Data Overview

### Metadata Database
- **User roles**: admin, user
- **Default users**: Admin and regular users with authentication
- **Pending changes**: Sample change requests for demonstration
- **Snapshots**: Table backup functionality

### Development Environment
- **Users**: Customer/user profiles
- **Products**: Product catalog with names and prices

### Test Environment
- **Same structure as development** with test-specific data
- **Edge cases**: Data for testing validation and edge scenarios

## 🔍 Verification Queries

After setup, verify everything is working:

```sql
-- Check all databases exist
SELECT datname FROM pg_database WHERE datname IN ('metadata', 'dev', 'test');

-- Check metadata tables
\c metadata
SELECT COUNT(*) as users FROM users;
SELECT COUNT(*) as pending_changes FROM pending_changes;
SELECT COUNT(*) as roles FROM roles;

-- Check dev environment
\c dev
SELECT COUNT(*) as users FROM users;
SELECT COUNT(*) as products FROM products;

-- Check test environment
\c test
SELECT COUNT(*) as users FROM users;
SELECT COUNT(*) as products FROM products;
```

## 🛠️ Environment Variables

Make sure your application uses these database connections:

```bash
# Metadata database
METADATA_DB=metadata

# Environment databases
DEV_DB=dev
TEST_DB=test

# Connection settings
PG_HOST=localhost
PG_PORT=5432
PG_USER=postgres
PG_PASSWORD=your_password_here
```

## 🔄 Reset/Cleanup

To completely reset the databases:

```sql
-- Connect as superuser
psql -U postgres

-- Drop all databases (WARNING: This deletes all data!)
DROP DATABASE IF EXISTS metadata;
DROP DATABASE IF EXISTS dev;
DROP DATABASE IF EXISTS test;

-- Then re-run setup process
```

## 📝 Database Schema Details

### Metadata Database (`metadata`)
- **roles**: User role definitions
- **users**: System authentication and user management
- **pending_changes**: Change tracking with status, environment, and approval workflow
- **snapshots**: Table backup functionality for rollback capabilities

### Application Databases (`dev`, `test`)
- **users**: Application user profiles with name and email
- **products**: Product catalog with name and pricing

## ⚠️ Important Notes

1. **Database Dumps**: These are PostgreSQL dump files exported from working databases
2. **Owner Permissions**: Dumps may reference specific database owners - adjust as needed
3. **PostgreSQL Version**: Dumps were created with PostgreSQL 14.16/17.0
4. **Security**: Default passwords are for development only
5. **Compatibility**: Designed for PostgreSQL 12+


---

*For application-specific database configuration, see the backend README.md file.* 