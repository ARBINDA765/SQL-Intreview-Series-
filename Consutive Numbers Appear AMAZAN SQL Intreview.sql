
--Write a SQL Query to identify the consecutive numbers in the table:Asked by amazon

-------------------------------------Sample Table----------------------

USE SSIS
CREATE TABLE logs 
(
    ID	INT,
    Value	INT
);

INSERT INTO logs (ID, Value) VALUES ('1', '10');
INSERT INTO logs (ID, Value) VALUES ('2', '12');
INSERT INTO logs (ID, Value) VALUES ('3', '12');
INSERT INTO logs (ID, Value) VALUES ('4', '12');
INSERT INTO logs (ID, Value) VALUES ('5', '10');
INSERT INTO logs (ID, Value) VALUES ('6', '10');
-------------end of Table---------------------------------------------------
SELECT * FROM logs
------------------------Solution 1--------------------------
SELECT A.ID,A.Value FROM
(
SELECT ID,Value,LEAD(Value,1) OVER(ORDER BY ID)as 'Next_Cell',LEAD(Value,2) OVER(ORDER BY ID)as 'Next_to_Next_Cell'
FROM logs
) A
WHERE Value=Next_Cell AND Next_Cell = Next_To_Next_Cell

------------------------------Solution 2--------------------------------------------
SELECT  L1.ID,L2.ID,L3.ID,L3.Value as 'Consutive Number'FROM logs L1

--INNER JOIN logs L2 ON L1.ID=L2.ID-1 AND L1.Value=L2.Value
--INNER JOIN logs L3 ON L2.ID=L3.ID-1 AND L2.Value=L3.Value

INNER JOIN logs L2 ON L1.ID=L2.ID+1 AND L1.Value=L2.Value
INNER JOIN logs L3 ON L2.ID=L3.ID+1 AND L2.Value=L3.Value

------------------------------Solution 3--------------------------------------------

SELECT A.ID,A.Value FROM
(
SELECT ID,Value,LEAD(Value,1) OVER(ORDER BY ID)as 'Next_Cell',LAG(Value,1) OVER(ORDER BY ID)as 'Previous_Cell'
FROM logs
) A
WHERE A.Value=A.Next_Cell
GROUP BY A.Value
HAVING COUNT(*)>1

UNION

SELECT A.Value FROM
(
SELECT ID,Value,LEAD(Value,1) OVER(ORDER BY ID)as 'Next_Cell',LAG(Value,1) OVER(ORDER BY ID)as 'Previous_Cell'
FROM logs
) A
WHERE Value=A.Previous_Cell
GROUP BY A.Value
HAVING COUNT(*) > 1





