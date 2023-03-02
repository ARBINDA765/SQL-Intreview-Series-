USE SSIS
---SQL INTREVIEW Question Series video-10


--Concat & group the row based on even and odd no of records in the table by SQL
--If the no of records is even then will add the first and second rows , third & forth 
--If the no of records is odd then the last row will not concrete with any other row


-- Dataset-------------------
--drop table emp_merge
create table emp_merge
(
DOB_YEAR      int,
name    varchar(40)
);
insert into emp_merge values (2000, 'Emp0');
insert into emp_merge values (2001, 'Emp1');
insert into emp_merge values (2002, 'Emp2');
insert into emp_merge values (2003, 'Emp3');
insert into emp_merge values (2004, 'Emp4');
insert into emp_merge values (2005, 'Emp5');
insert into emp_merge values (2006, 'Emp6');
insert into emp_merge values (2007, 'Emp7');
insert into emp_merge values (2008, 'Emp8');

select * from emp_merge


-- Solution in  Microsoft SQL Server:--------START-----------------
WITH CTE_A as 
(
SELECT CONCAT(DOB_YEAR,'-',name) 'DOB_Year_Name' ,NTILE(5) OVER (ORDER BY DOB_YEAR) as 'Grouping_col' from emp_merge
)
SELECT STRING_AGG(DOB_Year_Name,',') 'Final_column' FROM CTE_A
GROUP BY Grouping_col
ORDER BY 1

----------------------------------END OF SOLUTION------------