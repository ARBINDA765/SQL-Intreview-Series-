--- Zsca**r Product base intreview question
--Mention the output.
--YOUTUBE VIDEO DAY-2

---Please  Findout the below question & answer--------------------------------------------------
USE [SSIS]

SELECT 1+NULL as 'OutPut' --NULL

SELECT '1'+NULL as 'OutPut' --NULL

SELECT '1'+'NULL' as 'OutPut' --1NULL

SELECT 1+'NULL' as 'OutPut' --Conversion failed when converting the varchar value 'NULL' to data type int.

SELECT 1 'Output'

--How to print *********************************************************************(100 times Horizantly)
SELECT REPLICATE('*',100) 'STAR' 

--Sample Employee Table
SELECT * FROM [dbo].[EMP]

SELECT 6 'Output' FROM [dbo].[EMP]--No of rows in the table with the mentioned value 

SELECT  SUM (6)  FROM [dbo].[EMP]---No of rows * 6

SELECT * FROM [dbo].[EMP]
ORDER BY 1  DESC

SELECT DEPTNO,SUM(SAL) 'Salary_Total' FROM [dbo].[EMP]
GROUP BY DEPTNO ---GROUP BY 1 is not valid in SQL SERVER
ORDER BY 1 

--How to generate the random rows 

SELECT TOP 1 *    FROM [dbo].[EMP]
ORDER BY NEWID() DESC 

select newid() as uniqId

-----------------------------------------END -------------------------------------------------------------------------------------