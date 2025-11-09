SELECT c.CustomerID, c.Name, MAX(s.OrderDate) AS last_order
FROM #Customers AS c
LEFT JOIN #Sales AS s
  ON s.CustomerID = c.CustomerID
GROUP BY c.CustomerID, c.Name
ORDER BY c.CustomerID;
