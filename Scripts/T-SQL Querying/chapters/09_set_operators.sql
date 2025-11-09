-- Chapter 9: Set Operators (UNION [ALL], INTERSECT, EXCEPT)
IF OBJECT_ID('tempdb..#VIP') IS NOT NULL DROP TABLE #VIP;
CREATE TABLE #VIP(CustomerID int PRIMARY KEY);
INSERT INTO #VIP VALUES (101),(999);

-- Customers with at least one sale
WITH cust_sales AS (
    SELECT DISTINCT CustomerID FROM #Sales
)
SELECT CustomerID FROM cust_sales
INTERSECT
SELECT CustomerID FROM #VIP;   -- VIPs who bought

-- Customers who bought but are not VIPs
SELECT CustomerID FROM cust_sales
EXCEPT
SELECT CustomerID FROM #VIP;
