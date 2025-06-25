# Frontend - React Application

React-based user interface for the database management system. Provides an intuitive web interface for viewing and editing database tables with real-time change submission.

## 📁 Project Structure

```
frontend/
├── src/
│   ├── pages/
│   │   ├── Login.jsx           # Authentication page
│   │   ├── DataContent.jsx     # Environment/table selection
│   │   └── TableView.jsx       # Main table editing interface
│   ├── css/
│   │   ├── Login.css          # Login page styles
│   │   ├── DataContent.css    # Dashboard styles
│   │   └── TableView.css      # Table interface styles
│   ├── App.jsx                # Main app with routing
│   └── main.jsx               # React entry point
├── public/                    # Static assets
├── package.json              # Dependencies and scripts
├── vite.config.js            # Vite configuration
└── README.md                 # This file explains FE goals

## 🎯 What This Frontend Does

This React application allows users to:
- **Login** with role-based authentication (admin/user)
- **Browse** database tables across different environments (dev/test)
- **Edit** table data with click-to-edit functionality
- **Submit** changes that require admin approval
- **Manage** rows with add/delete operations

## 🛠️ Technology Stack

- **React 19.1.0** - Modern React with hooks
- **TypeScript 5.8.3** - Type safety and better development experience
- **Vite 6.3.5** - Fast build tool and development server
- **React Router DOM 7.6.2** - Client-side routing
- **Lucide React 0.523.0** -  Icons
- **CSS Modules** - Scoped styling

## 🚀 Quick Start

### Prerequisites
- **Node.js 16+** and npm
- **Backend API** running on http://localhost:8000

### Installation & Setup
```bash
# Navigate to frontend directory
cd frontend

# Install dependencies
npm install

# Start development server
npm run dev
```

### Available Commands
```bash
npm run dev      # Start development server with hot reload
npm run build    # Build for production
npm run preview  # Preview production build locally
npm run lint     # Run ESLint for code quality
```

### Access the Application
- **Development**: http://localhost:5173
- **Production Preview**: http://localhost:4173

## 🔐 Login & Access

| Role | Username | Password | What You Can Do |
|------|----------|----------|-----------------|
| **Admin** | `admin` | `admin123` | • View all tables<br>• Edit data<br>• Submit changes<br>• Access admin features |
| **User** | - functionality not added yet


## 🎨 User Interface Overview

### 1. Login Page (`/login`)
- Simple username/password form
- Role-based authentication
- Automatic redirect after successful login

### 2. Dashboard (`/datacontent`)
- **Environment Selection**: Choose between `dev` and `test` databases
- **Table Browser**: View all available tables in selected environment
- **Quick Navigation**: Click any table to start editing

### 3. Table Editor (`/table-view/:env/:table`)
- **Dynamic Table**: Automatically adapts to any table structure
- **Click-to-Edit**: Click any cell to edit its value
- **Auto-Save**: Changes submitted automatically when you click away
- **Row Operations**: Add new rows, select multiple rows for deletion
- **Real-time Feedback**: Immediate visual confirmation of edits

## 🧩 Key Features

### ✅ Working Features

#### Table Editing
- **Cell Editing**: Click any cell to edit its value
- **Auto-Submit**: Changes sent to backend automatically on blur
- **Change Detection**: Only modified values are submitted
- **Visual Feedback**: Edited cells show immediate updates

#### Row Management
- **Add New Rows**: Click "Add New" to insert empty rows
- **Row Selection**: Use checkboxes to select individual rows
- **Select All**: Toggle all rows at once with header checkbox
- **Delete Preparation**: Select rows for deletion (UI ready)

#### Navigation & UX
- **Responsive Navigation**: Easy back/forward navigation
- **Loading States**: Visual feedback during API calls
- **Error Handling**: User-friendly error messages
- **Session Management**: Login state persists across pages

### ⏳ In Development




```

## 🔧 Development Guide

### Component Architecture

#### App.jsx - Main Application
- **React Router Setup**: Handles all page routing
- **User Context**: Manages logged-in user state across pages
- **Route Protection**: Ensures authentication before accessing pages

#### Login.jsx - Authentication
- **Form Handling**: Username/password input with validation
- **API Integration**: Connects to backend `/api/login` endpoint
- **Error Display**: Shows authentication errors to users

#### DataContent.jsx - Dashboard
- **Environment Selection**: Dev/test database switching
- **Table Discovery**: Fetches available tables from selected environment
- **Navigation**: Routes to table editing interface

#### TableView.jsx - Table Editor (Main Component)
- **Dynamic Rendering**: Adapts to any table structure automatically
- **State Management**: Handles table data, editing state, row selection
- **API Integration**: Fetches table data and submits changes
- **User Interactions**: Click-to-edit, row selection, add/delete operations

### State Management Pattern

```javascript
// Example from TableView.jsx
const [tableData, setTableData] = useState([])      // All table rows
const [columns, setColumns] = useState([])          // Column names
const [editingCell, setEditingCell] = useState({})  // Currently editing cell
const [selectedRows, setSelectedRows] = useState([]) // Selected row indices
const [originalValue, setOriginalValue] = useState() // Value before editing
```

## 🎨 Styling & UI

### CSS Organization
- **Component-Scoped**: Each page has its own CSS file
- **Consistent Naming**: Clear, descriptive class names
- **Responsive Elements**: Flexible layouts that adapt to content

### Key Style Classes
```css
/* Main containers */
.table-view-container          /* Main table interface wrapper */
.table-view-table             /* Table element styling */
.table-view-data-header       /* Controls above table */

/* Interactive elements */
.table-view-back-button       /* Navigation buttons */
.null-value                   /* Styling for null/empty values */

/* States */
.table-view-loading          /* Loading indicators */
.table-view-error            /* Error message styling */
```


## 🚀 Deployment

### Production Build
```bash
# Create optimized build
npm run build

# Files will be in /dist directory
# Deploy /dist contents to your web server
```

### Environment Configuration
Create `.env` file for environment-specific settings:
```env
VITE_API_BASE_URL=http://localhost:8000
VITE_APP_TITLE=Database Manager
```

---

*This frontend connects to the FastAPI backend - see `../backend/README.md` for backend setup instructions.* 