import sql from "mssql/msnodesqlv8.js";

const config = {
  server: "localhost\MSSQLSERVER01",   // 👈 exact name from sqlcmd
  database: "master",
  driver: "msnodesqlv8",
  options: {
    trustedConnection: true,
    trustServerCertificate: true
  }
};

console.log("⏳ Connecting to SQL Server...");
sql.connect(config)
  .then(pool => {
    console.log("✅ Connected successfully to", config.server);
    return pool.close();
  })
  .catch(err => {
    console.error("❌ Connection failed:");
    console.dir(err, { depth: 6 });
  });