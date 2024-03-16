USE SSIS
---Return the employee whose salay is same in the depatment---
DROP TABLE [emp_salary]

CREATE TABLE [emp_salary]
(
    [emp_id] INTEGER  NOT NULL,
    [name] NVARCHAR(20)  NOT NULL,
    [salary] NVARCHAR(30),
    [dept_id] INTEGER
);


INSERT INTO emp_salary
(emp_id, name, salary, dept_id)
VALUES(101, 'sohan', '3000', '11'),
(102, 'rohan', '4000', '12'),
(103, 'mohan', '5000', '13'),
(104, 'cat', '3000', '11'),
(105, 'suresh', '4000', '12'),
(109, 'mahesh', '7000', '12'),
(110, 'Creta', '8000', '11'),
(111, 'Hari', '8000', '11'),
(112, 'kamal', '8000', '11'),
(113, 'Polo', '7000', '12'),
(114, 'Jadu', '7000', '12');

SELECT * FROM emp_salary ORDER BY dept_id

-----------------------------------------------Solution - 1-----------------------------------------------
--WindowFunction

WITH CTE_A AS
(
SELECT A.emp_id,A.name,A.salary,A.dept_id,COUNT(A.emp_id) OVER(PARTITION BY A.dept_id,A.salary) 'Count_Rabk'
FROM [emp_salary] A
INNER JOIN [emp_salary] B ON A.dept_id=B.dept_id AND A.salary=B.salary AND A.emp_id=B.emp_id

)

SELECT *

FROM CTE_A WHERE Count_Rabk >=2

--------------------Solution 2---------------------------------------------------------

WITH CTE_X as(

SELECT X.dept_id,X.salary FROM [emp_salary] X
GROUP BY X.dept_id,X.salary
HAVING COUNT(1) > 1
) 
SELECT [emp_salary]. *  FROM CTE_X
INNER JOIN [emp_salary] ON [emp_salary].dept_id=CTE_X.dept_id AND [emp_salary].salary=CTE_X.salary
ORDER BY [emp_salary].dept_id

