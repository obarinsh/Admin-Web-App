import { useState, useEffect } from 'react'
import { useNavigate } from 'react-router-dom'
import { Search, Loader2, AlertCircle, FileText, Database } from 'lucide-react'
import '../css/TablesList.css'

function TablesList({ selectedEnv }) {
    const [tables, setTables] = useState([])
    const [loading, setLoading] = useState(false)
    const [error, setError] = useState('')
    const navigate = useNavigate()

    useEffect(() => {
        if (selectedEnv && selectedEnv !== 'default') {
            fetchTables(selectedEnv)
        } else {
            setTables([])
        }
    }, [selectedEnv])

    const fetchTables = async (env) => {
        setLoading(true)
        setError('')

        try {
            const response = await fetch('http://localhost:8000/api/tables', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ env: env }),
            })

            if (!response.ok) {
                throw new Error('Failed to fetch tables')
            }

            const data = await response.json()
            setTables(data.tables || [])
        } catch (error) {
            setError(error.message)
        } finally {
            setLoading(false)
        }
    }

    const handleTableClick = (tableName) => {
        navigate(`/table-view/${selectedEnv}/${tableName}`)
    }

    if (!selectedEnv || selectedEnv === 'default') {
        return (
            <div className="tables-list-empty-state">
                <Search className="icon" size={24} />
                <p>Select an environment to view available tables</p>
            </div>
        )
    }

    if (loading) {
        return (
            <div className="tables-list-loading">
                <Loader2 className="icon spinning" size={24} />
                <p>Loading tables from <strong>{selectedEnv}</strong> environment...</p>
            </div>
        )
    }

    if (error) {
        return (
            <div className="tables-list-error">
                <AlertCircle className="icon" size={24} />
                <p>Error: {error}</p>
            </div>
        )
    }

    if (tables.length === 0) {
        return (
            <div className="tables-list-no-tables">
                <FileText className="icon" size={24} />
                <p>No tables found in <strong>{selectedEnv}</strong> environment</p>
            </div>
        )
    }

    return (
        <div className="tables-list-container">
            <h4 className="tables-list-title">
                Tables in<bold>{selectedEnv}</bold>environment
            </h4>

            <div className="tables-list-grid">
                {tables.map((table, index) => (
                    <div
                        key={index}
                        className="tables-list-card"
                        onClick={() => handleTableClick(table)}
                    >
                        <Database className="icon" size={16} />
                        {table}
                    </div>
                ))}
            </div>
        </div>
    )
}

export default TablesList 