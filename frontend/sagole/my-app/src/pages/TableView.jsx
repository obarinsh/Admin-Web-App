import { useState, useEffect } from 'react'
import { useParams, useNavigate } from 'react-router-dom'
import { Database, Loader2, AlertCircle, FileText, ArrowLeft } from 'lucide-react'
import '../css/TableView.css'

function TableView({ user }) {
    const { env, table } = useParams()  // This extracts from /table-view/:env/:table
    const navigate = useNavigate()
    const [tableData, setTableData] = useState([])
    const [columns, setColumns] = useState([])
    const [loading, setLoading] = useState(false)
    const [error, setError] = useState('')
    const [editingCell, setEditingCell] = useState({ row: null, col: null })
    const [originalValue, setOriginalValue] = useState(null)
    const [selectedRows, setSelectedRows] = useState([])

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

    async function submitPendingChange(rowIndex, columnIndex, oldValue, newValue) {
        try {
            // Check if this is a new row (empty first column means no database ID)
            const rowId = tableData[rowIndex][0]

            if (!rowId || rowId === "") {
                // This is a new row - we'll need to handle INSERT operations
                console.log('🆕 New row edit detected - INSERT operation needed')
                console.log('Row data:', tableData[rowIndex])
                // TODO: Implement INSERT pending change logic
                return
            }

            const requestData = {
                "env": env,
                "table_name": table,
                "row_id": String(rowId),
                "column": columns[columnIndex],
                "old_value": oldValue,
                "new_value": newValue,
                "user_id": user.id
            }

            const response = await fetch('http://localhost:8000/api/pending-change', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify(requestData),
            })
            if (!response.ok) {
                throw new Error('Failed to post pending changes')
            }
            const data = await response.json()

        } catch (error) {
            console.error('TableView: Error submitting pending changes:', error)
        }
    }

    const handleEditComplete = async (rowIndex, cellIndex, newValue, originalValue) => {
        // Close the editing state first
        setEditingCell({ row: null, col: null })
        setOriginalValue(null)

        // If value actually changed, submit the pending change
        if (newValue !== originalValue) {
            await submitPendingChange(rowIndex, cellIndex, originalValue, newValue)
        }
    }

    const handleCellChange = (rowIndex, cellIndex, value) => {
        const updatedData = [...tableData]
        updatedData[rowIndex][cellIndex] = value
        setTableData(updatedData)
    }

    const handleRowSelection = (rowIndex) => {
        setSelectedRows(prev => {
            // If row is already selected, remove it
            if (prev.includes(rowIndex)) {
                return prev.filter(index => index !== rowIndex)
            }
            // Otherwise, add it to selection
            return [...prev, rowIndex]
        })
    }

    const handleSelectAll = () => {
        if (selectedRows.length === tableData.length) {
            setSelectedRows([])
        } else {
            setSelectedRows(tableData.map((_, index) => index))
        }
    }

    const handleDeleteSelected = () => {
        const rowsToDelete = selectedRows.map(rowIndex => tableData[rowIndex][0])
        console.log('🗑️ Rows to delete:', rowsToDelete)
    }

    const handleAddNewRow = () => {
        // Create a new empty row with the same number of columns as existing data
        const newRow = new Array(columns.length).fill("")

        // Add the new row to the end of tableData
        setTableData(prev => [...prev, newRow])

        console.log('🆕 Added new empty row')
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
            </div>
            <button
                onClick={() => navigate('/datacontent')}
                className="table-view-back-button"
            >
                <ArrowLeft size={14} />
                Back
            </button>
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
                            <button
                                onClick={handleAddNewRow}
                            >Add New</button>
                            <button
                                onClick={handleDeleteSelected}
                                disabled={selectedRows.length === 0}
                            >Delete selected</button>
                        </div>

                        <div className="table-view-table-container">
                            <table className="table-view-table">
                                <thead>
                                    <tr>
                                        <th>
                                            <input
                                                type="checkbox"
                                                checked={selectedRows.length === tableData.length && tableData.length > 0}
                                                onChange={handleSelectAll}
                                            />
                                        </th>
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
                                            <td>
                                                <input
                                                    type="checkbox"
                                                    checked={selectedRows.includes(rowIndex)}
                                                    onChange={() => handleRowSelection(rowIndex)}
                                                />
                                            </td>
                                            {row.map((cell, cellIndex) => (
                                                <td
                                                    key={cellIndex}
                                                    onClick={() => {
                                                        setEditingCell({ row: rowIndex, col: cellIndex })
                                                        setOriginalValue(cell)
                                                    }}
                                                >
                                                    {editingCell.row === rowIndex && editingCell.col === cellIndex ? (
                                                        <input
                                                            value={cell || ''}
                                                            onChange={(e) => handleCellChange(rowIndex, cellIndex, e.target.value)}
                                                            onBlur={(e) => {
                                                                const newValue = e.target.value
                                                                handleEditComplete(rowIndex, cellIndex, newValue, originalValue)
                                                            }}
                                                            autoFocus
                                                        />
                                                    ) : (
                                                        cell !== null ? String(cell) : <em className="null-value">null</em>
                                                    )}
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
        </div >
    )
}

export default TableView