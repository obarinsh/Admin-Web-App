import { useState } from 'react'
import { useNavigate } from 'react-router-dom'
import '../css/LogIn.css'

function LogIn({ onLogin }) {
    const [username, setUsername] = useState('')
    const [password, setPassword] = useState('')
    const [error, setError] = useState('')
    const [isLoggingIn, setIsLoggingIn] = useState(false)

    const navigate = useNavigate()

    const handleSubmit = async (e) => {
        e.preventDefault()
        setIsLoggingIn(true)
        setError('')

        try {
            const response = await fetch('http://localhost:8000/api/login', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ username, password }),
            })
            if (!response.ok) {
                throw new Error('Login failed')
            }
            const userData = await response.json()

            const user = {
                id: userData.id,
                username: userData.username,
                role: userData.role_id || userData.role || 'guest' // Handle both role_id and role
            }

            onLogin(user)
            navigate('/datacontent')
        } catch (error) {
            setError(error.message)
        } finally {
            setIsLoggingIn(false)
        }
    }

    return (
        <div className="login-container">
            <h2 className="login-title">Login</h2>
            {error && <div className="login-error">{error}</div>}
            <form onSubmit={handleSubmit} className="login-form">
                <input
                    value={username}
                    onChange={(e) => setUsername(e.target.value)}
                    placeholder="Username"
                    required
                    className="login-input"
                />
                <input
                    type="password"
                    value={password}
                    onChange={(e) => setPassword(e.target.value)}
                    placeholder="Password"
                    required
                    className="login-input"
                />
                <button
                    type="submit"
                    disabled={isLoggingIn}
                    className="login-button"
                >
                    {isLoggingIn ? 'Logging in...' : 'Login'}
                </button>
            </form>
        </div>
    )
}

export default LogIn;