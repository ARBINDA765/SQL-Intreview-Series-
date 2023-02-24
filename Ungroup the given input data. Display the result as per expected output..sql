---SQL Intreview Series Question Video-9
-- Ungroup the given grouped data. Display the result as per expected output.

----Sample Table Script-----
USE SSIS
DROP TABLE home_garage
create table  home_garage
(
id              int,
garage_item      varchar(50),
total_count     int
);
insert into home_garage values
(1, 'bike', 4),
(2, 'suv', 2),
(3, 'bicycle', 1);

-------------------Start of the solution----------------------------

WITH CTE_A as 
(
SELECT id,garage_item,total_count,1 as 'Level'FROM home_garage--Base query

UNION ALL

SELECT id,garage_item,total_count-1,(Level+10) AS 'Level' FROM CTE_A WHERE CTE_A.total_count>1--Recursive query

)
--1st Iteration---total_count=4-------------------------------------------------Base Query
--2nd iteration--total_count=4-1=3 ---------(Condition is 4>1)---------------------------------------Recursive query
--3rd iteration--total_count=3-1=2------(condition is 3>1)--------------------------------------------Recursive query
--4th iteration --total_count=2-1=1------condition is  2>1)-------------------------------------------Recursive query
--5th iteration ---Condition does not meet ,Loop terminated ------(condition  is  1>1)-false-----------------Recursive query

SELECT id, garage_item, count(garage_item) over (PARTITION BY garage_item) as 'total_count' FROM CTE_A
ORDER BY id,Level


---------------END OF THE SOLUTION-------------------------------------------------