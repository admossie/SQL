SELECT *
FROM #Sales
WHERE CustomerID = 101
  AND OrderDate >= '2024-02-01'
  AND OrderDate <  '2024-03-01';
