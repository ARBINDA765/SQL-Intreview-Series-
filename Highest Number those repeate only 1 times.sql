USE SSIS
---------------Sample Script------------------------------------------------
Create table MynumTb (Col_A int)

insert into MynumTb (Col_A) values ('-1')
insert into MynumTb (Col_A) values ('0')
insert into MynumTb (Col_A) values ('2')
insert into MynumTb (Col_A) values ('-2')
insert into MynumTb (Col_A) values ('2')
insert into MynumTb (Col_A) values ('9')
insert into MynumTb (Col_A) values ('9')

------------Question------Biggest Single Number those are repeat only 1 time-------------------------------

-----------------Solution 1-----------------------------------------------------------------

SELECT CASE WHEN  COUNT(*) >0 THEN MAX(WW.Col_A) ELSE NULL  END as'Bigest Number' FROM
(
SELECT  Col_A,COUNT(*)  as 'Count'
FROM MynumTb
Group by Col_A
HAVING COUNT(*) < 2

) WW