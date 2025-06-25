import { useState, useEffect } from 'react'
import { useParams, useNavigate } from 'react-router-dom'
import { Database, Loader2, AlertCircle, FileText, ArrowLeft } from 'lucide-react'
import '../css/TableView.css'

function TableView() {
    const { env, table } = useParams()  // This extracts from /table-view/:env/:table
    const navigate = useNavigate()
    const [tableData, setTableData] = useState([])
    const [columns, setColumns] = useState([])
    const [loading, setLoading] = useState(false)
    const [error, setError] = useState('')

    const fetchTableData = async (environment, tableName) => {
        setLoading(true)
        setError('')
        try {
            const response = await fetch('http://localhost:8000/api/table-data', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ env: environment, table: tableName }),
            })
            if (!response.ok) {
                throw new Error('Failed to fetch table data')
            }
            const data = await response.json()
            console.log(`🔍 TableView: Fetched data for ${env}.${table}:`, data)
            setTableData(data.rows || [])
            setColumns(data.columns || [])
        } catch (error) {
            setError(error.message)
            console.error('TableView: Error fetching table data:', error)
        } finally {
            setLoading(false)
        }
    }

    useEffect(() => {
        if (env && table) {
            fetchTableData(env, table)
        }
    }, [env, table])

    if (!env || !table) {
        return (
            <div className="table-view-error-container">
                <div className="table-view-error-message">
                    <p>Missing environment or table name parameters</p>
                    <button
                        onClick={() => navigate('/datacontent')}
                        className="table-view-error-button"
                    >
                        <ArrowLeft size={16} />
                        Back to Dashboard
                    </button>
                </div>
            </div>
        )
    }

    return (
        <div className="table-view-container">
            {/* Header */}
            <div className="table-view-header">
                <div>
                    <h2 className="table-view-title">
                        <Database size={24} />
                        {table}
                    </h2>
                    <p className="table-view-environment">
                        Environment: <strong>{env}</strong>
                    </p>
                </div>
                <button
                    onClick={() => navigate('/datacontent')}
                    className="table-view-back-button"
                >
                    <ArrowLeft size={16} />
                    Back to Dashboard
                </button>
            </div>

            {/* Content */}
            <div className="table-view-content">
                {loading && (
                    <div className="table-view-loading">
                        <Loader2 className="spinning" size={24} />
                        <p>Loading data from <strong>{table}</strong>...</p>
                    </div>
                )}

                {error && (
                    <div className="table-view-error">
                        <AlertCircle size={24} />
                        <p>{error}</p>
                    </div>
                )}

                {!loading && !error && tableData.length === 0 && (
                    <div className="table-view-empty">
                        <FileText size={24} />
                        <p>No data found in table <strong>{table}</strong></p>
                    </div>
                )}

                {!loading && !error && tableData.length > 0 && (
                    <div>
                        <div className="table-view-data-header">
                            Showing {tableData.length} rows
                        </div>

                        <div className="table-view-table-container">
                            <table className="table-view-table">
                                <thead>
                                    <tr>
                                        {columns.map((column, index) => (
                                            <th key={index}>
                                                {column}
                                            </th>
                                        ))}
                                    </tr>
                                </thead>
                                <tbody>
                                    {tableData.map((row, rowIndex) => (
                                        <tr key={rowIndex}>
                                            {row.map((cell, cellIndex) => (
                                                <td key={cellIndex}>
                                                    {cell !== null ? String(cell) : <em className="null-value">null</em>}
                                                </td>
                                            ))}
                                        </tr>
                                    ))}
                                </tbody>
                            </table>
                        </div>
                    </div>
                )}
            </div>
        </div>
    )
}

export default TableView