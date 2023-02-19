
--SQL Intreview Question Series Video -8
---Missing Sequence Number in SQL (Dynamically way)


USE SSIS
--DROP TABLE tblEmployee1
CREATE TABLE tblEmployee1 (EmpID INT)
INSERT tblEmployee1 values (100),(102),(104),(109),(113),(117),(120),(125),(126)
SELECT * FROM tblEmployee1

-------------------SOLUTION------------------------
---Anchor Query: Think of this as the starting point for the query. The anchor provides the initial result set. 
--Recursive Query: Following the anchor query, the Recursive query runs iteratively until a condition is met. 
--The result set from each iteration serves as input into the next
--LEFT JOIN=LEFT OUTER JOIN

DECLARE @MAX_SEQ INT,@MIN_SEQ INT;
SELECT @MAX_SEQ= MAX(EmpID) FROM tblEmployee1
SELECT @MIN_SEQ= MIN(EmpID) FROM tblEmployee1
;
WITH CTE_A (ID) AS

(
SELECT @MIN_SEQ--Anchory query 
UNION ALL
SELECT ID+1 FROM CTE_A WHERE ID < @MAX_SEQ--Recusrive Query 
)

SELECT CTE_A.ID as 'Missing_Emp_ID' FROM CTE_A
LEFT OUTER JOIN tblEmployee1 ON CTE_A.ID=tblEmployee1.EmpID
WHERE tblEmployee1.EmpID IS NULL

---------------------------------END OF THE SOLUTION------------------------
