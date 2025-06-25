import '../css/NavBar.css'

function Navbar({ user, onLogout, selectedEnv, onEnvChange }) {

    const handleLogout = () => {
        if (typeof onLogout === 'function') {
            onLogout();
        } else {
            console.error('❌ onLogout is not a function:', onLogout)
        }
    }

    const handleEnvChange = (e) => {
        const newSelectedEnv = e.target.value

        if (onEnvChange) {
            console.log('🌍 NavBar: Environment changed to:', newSelectedEnv)
            onEnvChange(newSelectedEnv);
        }
    }

    return (
        <nav className="navbar">
            <span className="navbar-brand">My App</span>

            {user ? (
                <div className="navbar-user-section">
                    <select
                        onChange={handleEnvChange}
                        value={selectedEnv}
                        className="navbar-env-select"
                    >
                        <option value="default">Choose an environment...</option>
                        <option value="dev">Development</option>
                        <option value="test">Testing</option>
                    </select>
                    <span className="navbar-welcome">
                        Welcome, <strong>{user.username}</strong> ({user.role})
                    </span>
                    <button
                        type="button"
                        onClick={handleLogout}
                        className="navbar-logout-btn"
                    >
                        Logout
                    </button>
                </div>
            ) : (
                <span className="navbar-not-logged"></span>
            )}
        </nav>
    )
}

export default Navbar;