USE SSIS

--Question - Find 3rd highest salary of each dept if there are less than 3 employee then return salary of lowest employee.

--Table Create Query :-
-------------------------------------------------Sample Script ----------------------------------------
create table employees_tb_t(
emp_id int primary key, 
emp_name varchar(20),
emp_salary int, 
dep_id int,
)
insert into employees_tb_t
values(1,'Raj',15000,100),
(2,'Rohan',25000,100),
(3,'Ankit',25690,100),
(4,'Puja',20000,100),
(5,'Arun',58000,200),
(6,'Tarun',65000,200),
(7,'Pintu',45800,200),
(8,'Ankur',25000,300),
(9,'Ajay',17000,300),
(10,'Amrin',37500,400);
---------------------Solution Start---------------------------------
SELECT *  FROM employees_tb_t

WITH CTE_A as
(
SELECT *,DENSE_RANK() OVER( PARTITION BY dep_id ORDER BY  emp_salary DESC) 'Ranking_Dept_Salary_Desc',
DENSE_RANK() OVER( PARTITION BY dep_id ORDER BY  emp_salary ) 'Ranking_Dept_Salary_Asc',
COUNT(emp_id) OVER(PARTITION BY dep_id ) 'No_of_Emp'
FROM employees_tb_t
)
SELECT emp_id,emp_name,emp_salary,dep_id FROM CTE_A 
WHERE Ranking_Dept_Salary_Desc=3

UNION 
SELECT emp_id,emp_name,emp_salary,dep_id  FROM CTE_A 
WHERE  No_Of_Emp<3 AND Ranking_Dept_Salary_Asc=1
