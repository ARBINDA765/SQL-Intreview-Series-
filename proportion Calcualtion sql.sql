USE SSIS
---Find the relative proportions of prize money won

USE SSIS
------------------Sample Script------------------------

create table proportion1
(name varchar(50),
prize int);

insert into proportion1(name,prize)
values ('Ajay',200),
('Anish',300),
('Aakash',100),
('Ajesh',400)

SELECT * FROM proportion1

GO
------------Start of Solution -----------------------------
WITH CTE_A as 
(
SELECT *,SUM(prize) OVER (ORDER BY prize ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING) 'Total'
FROM proportion1
)

SELECT name, CAST (prize AS float) as 'Prize' , CONCAT (STR (prize/CAST (Total as float) * 100) , '%') as 'Total' 

FROM CTE_A

--------------End Of Solution ---------------------
