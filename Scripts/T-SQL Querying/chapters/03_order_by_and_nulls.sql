-- Chapter 3: ORDER BY, NULL handling, ANSI NULLS
SET ANSI_NULLS ON;
-- Create demo for NULLs
IF OBJECT_ID('tempdb..#Notes') IS NOT NULL DROP TABLE #Notes;
CREATE TABLE #Notes(NoteID int PRIMARY KEY, CustomerID int, Tag varchar(20) NULL);
INSERT INTO #Notes VALUES (1,101,'vip'),(2,101,NULL),(3,102,'promo');

-- ORDER BY multiple expressions
SELECT * FROM #Notes ORDER BY CustomerID ASC, Tag DESC;

-- NULL comparisons must use IS NULL / IS NOT NULL
SELECT * FROM #Notes WHERE Tag IS NULL;

-- COALESCE / ISNULL
SELECT NoteID, COALESCE(Tag,'(none)') AS TagLabel FROM #Notes ORDER BY TagLabel;
