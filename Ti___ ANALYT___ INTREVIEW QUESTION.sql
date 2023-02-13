--SQL Interview Question Asked in Ti*** Analyt*** | Data Analyst SQL Interview Problem

--Problem Statement 
--Write an SQL query to swap all 'f' and 'm' values (i.e., change all 'f' values to 'm' and vice versa) with a single update statement 
--and no intermediate temp table(s).

--Note that you must write a single update statement, DO NOT write any select statement for this problem.
USE [SSIS]
SELECT * FROM SALARY
GO 

update SALARY
set GENDER = CASE GENDER WHEN 'M' THEN 'F' ELSE 'M' END 
GO
SELECT * FROM SALARY


update SALARY
SET GENDER = IIF(GENDER='M','F','M')