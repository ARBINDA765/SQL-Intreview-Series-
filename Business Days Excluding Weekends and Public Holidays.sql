----Write a SQL Query to find the business date between created date and resolved date by excluding holiday & weekend /....

--------------------SAMPLE DATA-----------------------------------------------

create table tickets
(
ticket_id varchar(10),
create_date date,
resolved_date date
);
delete from tickets;
insert into tickets values
(1,'2022-08-01','2022-08-03')
,(2,'2022-08-01','2022-08-12')
,(3,'2022-08-01','2022-08-16');
create table holidays
(
holiday_date date
,reason varchar(100)
);
delete from holidays;
insert into holidays values
('2022-08-11','Rakhi'),('2022-08-15','Independence day');

SELECT * FROM tickets

---------------------START---------------------------------------------
select *
,datediff(day,create_date,resolved_date) 'No_of_total_days',
datediff(week,create_date,resolved_date) 'WEEKEND'
,datediff(day,create_date,resolved_date) - 2*datediff(week,create_date,resolved_date) - no_of_holidays as 'No_of_business_days'
from 
(select ticket_id,create_date,resolved_date,count(holiday_date) 'No_of_holidays'
from tickets t
left join holidays h on h.holiday_date between t.create_date and t.resolved_date 
and datepart(weekday,holiday_date) NOT IN (6,7)
group by ticket_id,create_date,resolved_date) a


-----------------------------END--------------------------------------------