USE SSIS
---Question Find the Missing Numbers-----------------------------
--Using Recursive CTE

SELECT * FROM numbers
------------------------Solution -1------------------------------------
--Step 1 Find the Minmum numbers from the column
--Step 2 Create a Recusrive CTE from  where Union with max number with max_number-1 till the minimum number of the column
--Step 3 After createing a sequence from minimum to maximum number
--Step 4 join the table and find the missing numbers  

SELECT * FROM  numbers
WITH CTE_Min as 
(
SELECT MIN(n) as 'Min_Num' FROM numbers
)
,
CTE_Row_number as
(
SELECT MAX(n) as n from numbers
UNION ALL
SELECT (n-1) as n FROM CTE_Row_number WHERE n-1>=(SELECT Min_Num FROM CTE_Min)
)
SELECT n1.n as "Missing_Numbers"
FROM CTE_Row_number n1 LEFT JOIN numbers n2 on n1.n=n2.n where n2.n is null

--------------Solution 2----------------------------------
--Without recusrive
--
--Step-1 Create a Row number based on exiting table
--Step 2 Left join and filter the null value only
--Step 3 Restrict the to maximum number only

SELECT  Sequence_Number as "Missisng_Numbers"  FROM (
SELECT ROW_NUMBER() OVER(ORDER BY(SELECT NULL)) as 'Sequence_Number' from sys.all_columns 
)
A
LEFT JOIN  numbers n2 on Sequence_Number=n2.n where n2.n is null and Sequence_Number <=(SELECT MAX(n) from numbers)







