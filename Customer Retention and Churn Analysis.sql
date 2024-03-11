USE SSIS

--Customer Retention and Churn Analysis | Part 1 | SQL Intermediate Question 5


--DDL Script :-
drop table transactions
create table transactions(
order_id int,
cust_id int,
order_date date,
amount int
);
delete from transactions;
insert into transactions values 
(1,1,'2020-01-15',150)
,(2,1,'2020-02-10',150)
,(3,2,'2020-01-16',150)
,(4,2,'2020-02-25',150)
,(5,3,'2020-01-10',150)
,(6,3,'2020-02-20',150)
,(7,4,'2020-01-20',150)
,(8,5,'2020-02-20',150);

SELECT * FROM transactions

-----------Start of the Solution ----------------------------------------
WITH CTE_A as 
(
SELECT *,LAG(order_date) OVER (PARTITION  BY cust_id ORDER BY order_date) 'Prev_Date'
FROM transactions
)

SELECT MONTH(order_date) 'Month',SUM(CASE WHEN Prev_Date IS NOT NULL THEN 1 ELSE 0 END )'Retained Custm'

FROM CTE_A 
GROUP BY MONTH(order_date)
