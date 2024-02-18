USE SSIS
---------------------------Sample Table-------------------------
Create table  Triangle (x int, y int, z int)
Truncate table Triangle
insert into Triangle (x, y, z) values ('13', '15', '30')
insert into Triangle (x, y, z) values ('10', '20', '15')

--------------Question -------------------------------------------
--In SQL, (x, y, z) is the primary key column for this table.
---Each row of this table contains the lengths of three line segments

--Ask is Report for every three line segments whether they can form a triangle.

----------------------------------------Solution 1-----------------------------------------------------------------------------

SELECT *,
CASE WHEN x+y>z AND x+z>y AND y+z>x THEN 'Yes'ELSE 'No' END as 'Triangle_Status'
FROM  Triangle