import { useState } from 'react'
import { BrowserRouter as Router, Routes, Route, Navigate } from 'react-router-dom'
import './App.css'
import LogIn from './components/LogIn'
import DataContent from './pages/DataContent'
import NavBar from './components/NavBar'
import TableView from './pages/TableView'

function App() {
  const [user, setUser] = useState(() => {
    const saved = localStorage.getItem("user")
    return saved ? JSON.parse(saved) : null
  })

  const [selectedEnv, setSelectedEnv] = useState(() => {
    const saved = localStorage.getItem("env")
    return saved || 'default'
  })

  const handleLogin = (userData) => {
    console.log('🔐 App: Logging in user:', userData)
    setUser(userData)
    localStorage.setItem("user", JSON.stringify(userData))
  }

  const handleLogout = () => {
    console.log('🚪 App: Logging out user:', user)
    setUser(null)
    localStorage.removeItem("user")
    localStorage.removeItem("env")
    setSelectedEnv('default')
    console.log('✅ App: User logged out, localStorage cleared')
    // Force page reload to ensure clean state
    window.location.href = '/'
  }

  const onEnvChange = (env) => {
    console.log('🌍 App: Environment changed to:', env)
    setSelectedEnv(env)
    localStorage.setItem("env", env)
  }

  console.log('🔄 App rendered with user:', user, 'env:', selectedEnv)

  return (
    <Router>
      <NavBar
        user={user}
        onLogout={handleLogout}
        selectedEnv={selectedEnv}
        onEnvChange={onEnvChange}
      />

      <Routes>
        <Route
          path="/login"
          element={!user ? <LogIn onLogin={handleLogin} /> : <Navigate to="/datacontent" />}
        />
        <Route
          path="/datacontent"
          element={user ? <DataContent user={user} selectedEnv={selectedEnv} /> : <Navigate to="/login" />}
        />
        <Route
          path="/"
          element={<Navigate to={user ? "/datacontent" : "/login"} />}
        />
        <Route
          path="/table-view/:env/:table"
          element={user ? <TableView user={user} /> : <Navigate to="/login" />}
        />
      </Routes>
    </Router>
  )
}

export default App
