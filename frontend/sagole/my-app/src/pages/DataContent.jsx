import React from "react"
import TablesList from "../components/TablesList"
import '../css/DataContent.css'

function DataContent({ selectedEnv }) {

    return (
        <div className="datacontent-container">
            <div className="datacontent-dashboard">
                <h3>Dashboard</h3>
                <p className="datacontent-description">Here are the tables available in your selected environment:</p>
                <TablesList selectedEnv={selectedEnv} />
            </div>
        </div>
    )
}

export default DataContent;