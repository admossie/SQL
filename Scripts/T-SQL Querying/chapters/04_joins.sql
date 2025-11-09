-- Chapter 4: Joins (INNER, LEFT, RIGHT, FULL)
IF OBJECT_ID('tempdb..#Customers') IS NOT NULL DROP TABLE #Customers;
CREATE TABLE #Customers(CustomerID int PRIMARY KEY, Name varchar(50));
INSERT INTO #Customers VALUES (101,'Acme'),(102,'Globex'),(104,'Initrode');

-- INNER JOIN (only matches)
SELECT c.CustomerID, c.Name, s.SaleID
FROM #Customers AS c
JOIN #Sales AS s
  ON s.CustomerID = c.CustomerID;

-- LEFT JOIN (all customers, maybe no sales)
SELECT c.CustomerID, c.Name, s.SaleID
FROM #Customers AS c
LEFT JOIN #Sales AS s
  ON s.CustomerID = c.CustomerID
ORDER BY c.CustomerID, s.SaleID;

-- FULL JOIN (any side)
SELECT COALESCE(c.CustomerID, s.CustomerID) AS CustomerID, c.Name, s.SaleID
FROM #Customers AS c
FULL JOIN #Sales AS s ON s.CustomerID = c.CustomerID
ORDER BY CustomerID;
