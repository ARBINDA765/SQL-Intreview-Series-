----------Write a SQL Query who all are present inside the hospital-----------------------------------------

USE SSIS
-----------------------------Sample Script-------------------------------------------
create table hospital ( emp_id int
, action varchar(10)
, time datetime);

insert into hospital values ('1', 'in', '2019-12-22 09:00:00');
insert into hospital values ('1', 'out', '2019-12-22 09:15:00');
insert into hospital values ('2', 'in', '2019-12-22 09:00:00');
insert into hospital values ('2', 'out', '2019-12-22 09:15:00');
insert into hospital values ('2', 'in', '2019-12-22 09:30:00');
insert into hospital values ('3', 'out', '2019-12-22 09:00:00');
insert into hospital values ('3', 'in', '2019-12-22 09:15:00');
insert into hospital values ('3', 'out', '2019-12-22 09:30:00');
insert into hospital values ('3', 'in', '2019-12-22 09:45:00');
insert into hospital values ('4', 'in', '2019-12-22 09:45:00');
insert into hospital values ('5', 'out', '2019-12-22 09:40:00');

SELECT * FROM hospital 
-----------------------Solution Start-------------------------------
with CTE1 as 
(SELECT emp_id,
max(case when action='in' then time END )as 'LoginTime',
max(case when action='out' then time END )as 'LogOUTTime'
FROM hospital 
group by emp_id
)

SELECT emp_id,LoginTime, LogOUTTime from CTE1 
WHERE LoginTime > LogOUTTime OR LogOUTTime IS NULL


------------END-----------------------