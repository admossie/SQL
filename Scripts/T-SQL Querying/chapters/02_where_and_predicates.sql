-- Chapter 2: WHERE, Predicates, SARGability
-- Goal: write selective predicates that are SARGable (seek-friendly)

IF OBJECT_ID('tempdb..#Sales') IS NULL
BEGIN
    RAISERROR('Run 01_select_basics.sql first to create #Sales.',16,1);
    RETURN;
END

-- SARGable: column compared to constant/range
SELECT * FROM #Sales WHERE OrderDate >= '2024-02-01' AND OrderDate < '2024-03-01';

-- Non‑SARGable (avoid): function on column
-- SELECT * FROM #Sales WHERE MONTH(OrderDate) = 2; -- forces scan

-- Fix by moving function to constant/range (as above).

-- IN / BETWEEN / LIKE
SELECT * FROM #Sales WHERE CustomerID IN (101,103);
SELECT * FROM #Sales WHERE OrderDate BETWEEN '2024-02-01' AND '2024-02-29'; -- inclusive

-- Pattern matching (anchored for index use when possible)
SELECT * FROM #Sales WHERE CAST(UnitPrice AS varchar(20)) LIKE '15%'; -- demo only; casting harms SARGability
