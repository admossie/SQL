// server.js
import express from "express";
import msnodesqlv8 from "msnodesqlv8";

const app = express();

// ✅ Your working connection string
const cs =
  "Driver={ODBC Driver 18 for SQL Server};" +
  "Server=localhost\\MSSQLSERVER01;" +
  "Database=master;" +
  "Trusted_Connection=Yes;" +
  "TrustServerCertificate=Yes;";

// Simple route — test SQL connection
app.get("/databases", (req, res) => {
  msnodesqlv8.query(cs, "SELECT name FROM sys.databases", (err, rows) => {
    if (err) {
      console.error("SQL Error:", err);
      return res.status(500).json({ error: err.message });
    }
    res.json(rows);
  });
});

// Start web server on port 4000
app.listen(4000, () => {
  console.log("🚀 API running on http://localhost:4000");
});
