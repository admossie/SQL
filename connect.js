// connect.js
import msnodesqlv8 from "msnodesqlv8";

const cs =
  "Driver={ODBC Driver 18 for SQL Server};" +
  "Server=localhost\\MSSQLSERVER01;" +        // <--- your confirmed instance
  "Database=master;" +
  "Trusted_Connection=Yes;" +
  "TrustServerCertificate=Yes;";

console.log("⏳ Connecting via msnodesqlv8 (direct)...");

msnodesqlv8.query(cs, "SELECT name FROM sys.databases", (err, rows) => {
  if (err) return console.error(err);
  console.table(rows);
});

