import { useState } from 'react'
import SimpleLogin from './components/SimpleLogin'

function SimpleApp() {
    const [user, setUser] = useState(null)

    const handleLogin = (userData) => {
        setUser(userData)
        console.log('User logged in:', userData)
        // You can add more logic here like:
        // - Save to localStorage
        // - Redirect to dashboard
        // - Fetch user profile data
    }

    const handleLogout = () => {
        setUser(null)
        console.log('User logged out')
        // Clear any stored data
    }

    return (
        <div style={{ minHeight: '100vh', backgroundColor: '#f5f5f5' }}>
            {!user ? (
                // Show login form when user is not logged in
                <SimpleLogin onLogin={handleLogin} />
            ) : (
                // Show welcome message when user is logged in
                <div style={{
                    maxWidth: '600px',
                    margin: '0 auto',
                    padding: '50px 20px',
                    textAlign: 'center'
                }}>
                    <div style={{
                        backgroundColor: 'white',
                        padding: '30px',
                        borderRadius: '10px',
                        boxShadow: '0 2px 10px rgba(0,0,0,0.1)'
                    }}>
                        <h1 style={{ color: '#333', marginBottom: '20px' }}>
                            Welcome, {user.username}! 🎉
                        </h1>
                        <p style={{ color: '#666', marginBottom: '30px' }}>
                            You have successfully logged in to your account.
                        </p>

                        {/* This is where you would add your main app content */}
                        <div style={{ marginBottom: '30px' }}>
                            <h3>Your Dashboard</h3>
                            <p>Here you can add your main application features...</p>
                        </div>

                        <button
                            onClick={handleLogout}
                            style={{
                                padding: '10px 20px',
                                fontSize: '16px',
                                backgroundColor: '#dc3545',
                                color: 'white',
                                border: 'none',
                                borderRadius: '5px',
                                cursor: 'pointer'
                            }}
                        >
                            Logout
                        </button>
                    </div>
                </div>
            )}
        </div>
    )
}

export default SimpleApp 