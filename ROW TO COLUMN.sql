USE SSIS
------------Auto Repair Summary Report-----------Row to column Transpose --------------------------------

drop table if exists auto_repair;
create table auto_repair
(
	client			varchar(20),
	auto			varchar(20),
	repair_date		int,
	indicator		varchar(20),
	value			varchar(20)
);

insert into auto_repair values('c1','a1',2022,'level','good');
insert into auto_repair values('c1','a1',2022,'velocity','90');
insert into auto_repair values('c1','a1',2023,'level','regular');
insert into auto_repair values('c1','a1',2023,'velocity','80');
insert into auto_repair values('c1','a1',2024,'level','wrong');
insert into auto_repair values('c1','a1',2024,'velocity','70');
insert into auto_repair values('c2','a1',2022,'level','good');
insert into auto_repair values('c2','a1',2022,'velocity','90');
insert into auto_repair values('c2','a1',2023,'level','wrong');
insert into auto_repair values('c2','a1',2023,'velocity','50');
insert into auto_repair values('c2','a2',2024,'level','good');
insert into auto_repair values('c2','a2',2024,'velocity','80');
--------------------Solution 1---------------------------------------------------
USE SSIS
WITH CTE_A as 
(
SELECT v.value as 'value',l.value as 'Level' FROM auto_repair v
INNER JOIN auto_repair l  ON v.indicator='velocity' AND l.indicator='level'AND v.repair_date=l.repair_date
AND v.client=l.client AND v.auto=l.auto
)
SELECT value,
 SUM(CASE WHEN Level='good' THEN 1 ELSE 0 END) 'Good',
SUM(CASE WHEN Level='wrong' THEN 1 ELSE 0 END) 'Wrong',
SUM(CASE WHEN Level='regular' THEN 1 ELSE 0 END) 'Regular'
FROM CTE_A
GROUP BY value 

--------------------Solution 2-----------------------------------------------------

--BY USING PIVOT--


SELECT * FROM (
SELECT v.value as 'value',l.value as 'Level' FROM auto_repair v
INNER JOIN auto_repair l  ON v.indicator='velocity' AND l.indicator='level'AND v.repair_date=l.repair_date
AND v.client=l.client AND v.auto=l.auto
)BQ
PIVOT
(
COUNT(Level) 
FOR Level IN ([Good],[Wrong],[Regular])
)PQ

------------------------------------------------------------------------








--where indicator='velocity'

SELECT * FROM auto_repair l --where indicator='level'
