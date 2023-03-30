USE SSIS 
--Restaurant Growth 7 Days Sales Average Problem Description –

--You are the restaurant owner and you want to analyze a possible expansion (there will be at least one customer every day).

--Write an SQL query to compute the moving average of how much the customer paid in a seven days window 
--(i.e., current day + 6 days before)

--Return result table ordered by visited_on in ascending order.
--DROP TABLE customer_tb
CREATE TABLE customer_tb(customer_id INT,name VARCHAR(25),visited_on DATE,amount INT)

insert into customer_tb values(1,'Krish',GETDATE()-360,100)
insert into customer_tb values(2,'John',GETDATE()-359,110)
insert into customer_tb values(3,'Jully',GETDATE()-358,120)
insert into customer_tb values(4,'Robert',GETDATE()-357,130)

insert into customer_tb values(5,'Ram',GETDATE()-356,130)
insert into customer_tb values(6,'Shyam',GETDATE()-355,140)
insert into customer_tb values(7,'Hari',GETDATE()-354,150)
insert into customer_tb values(8,'Sita',GETDATE()-353,160)
insert into customer_tb values(9,'Jodu',GETDATE()-352,170)


insert into customer_tb values(1,'Krish',GETDATE()-351,800)
insert into customer_tb values(3,'Jully',GETDATE()-351,820)
SELECT * FROM customer_tb



WITH CTE_A as 
(
SELECT t.visited_on,sum(t.amount) as 'Total_amount' FROM customer_tb t
GROUP BY t.visited_on
)
,
CTE_B as 
(
SELECT visited_on,sum(Total_amount) OVER (ORDER BY visited_on ROWS BETWEEN 6 PRECEDING AND  CURRENT ROW   ) as 'Last_7 Cumm_Days_Sales',
AVG(Total_amount) OVER (ORDER BY visited_on ROWS BETWEEN  6 PRECEDING  AND CURRENT ROW  ) as 'Last_7_Dyas_Moving_Avg_Sales',
DENSE_RANK() OVER (ORDER BY visited_on ) as 'Ranking'
FROM CTE_A
)

SELECT * FROM CTE_B where Ranking > 6