--Write a query to find workaholics employees.  
--Workaholics employees are those who satisfy atleast one of the given criterion:

--1- Employees who work for more than 8 hours a day for atleast 3 days in a week. 

--2- Employees who work for more than 10 hours a day for atleast 2 days in a week. 

--Write a SQL to find all the workaholic employees along with the criterion that they are satisfying (1,2 or both).

use SSIS

CREATE TABLE employee_work 
(
    emp_id	INT,
    login	DATETIME,
    logout 	DATETIME
);

INSERT INTO employee_work (emp_id, login, logout ) VALUES
	('100', '2024-02-19 09:15:00', '2024-02-19 18:20:00'),
	('100','2024-02-20 09:05:00','2024-02-20 17:00:00'),
	('100', '2024-02-21 09:00:00', '2024-02-21 17:10:00 '),
	('100', '2024-02-22 10:00:00', '2024-02-22 16:55:00 '),
	('100', '2024-02-23 10:30:00', '2024-02-23 19:15:00 '),
	('200', '2024-02-19 08:00:00', '2024-02-19 18:20:00 '),
	('200', '2024-02-20 09:00:00', '2024-02-20 16:30:00 '),
	('200', '2024-02-21 09:15:00', '2024-02-21 19:20:00 '),
	('200', '2024-02-22 11:00:00', '2024-02-22 17:05:00 '),
	('200', '2024-02-23 09:30:00', '2024-02-23 17:20:00 '),
    ('300', '2024-02-19 07:00:00', '2024-02-19 18:15:00 '),
    ('300', '2024-02-20 09:00:00',	'2024-02-20 19:10:00'),
    ('300', '2024-02-21 09:15:00',	'2024-02-21 18:20:00'),
    ('300', '2024-02-22 11:00:00',	'2024-02-22 17:00:00'),
    ('300', '2024-02-23 09:30:00',	'2024-02-23 16:30:00');

USE SSIS
WITH CTE_A AS (
    SELECT 
        *, 
        DATEDIFF(MINUTE, login, logout) AS 'Logout-Login',
        CASE 
            WHEN DATEDIFF(DAY, login, logout) = 0 THEN DATEPART(WEEK, login) 
            ELSE NULL 
        END AS 'WKNUMBER',
        CASE 
            WHEN DATEDIFF(MINUTE, login, logout) > =10*60 THEN 10 
            ELSE NULL 
        END AS "10+Hours",
        CASE 
            WHEN DATEDIFF(MINUTE, login, logout) >= 8*60 THEN 8 
            ELSE NULL 
        END AS "8+WorkHolic"
    FROM 
        employee_work
)


SELECT 
    emp_id,
    CASE 
        WHEN COUNT([8+WorkHolic]) >= 3 AND COUNT([10+Hours]) >= 2 THEN 'Both'
        WHEN COUNT([8+WorkHolic]) >= 3 THEN '1' 
        WHEN COUNT([10+Hours]) >= 2 THEN '2' 
        ELSE '0' 
    END AS [WorkHolic]
FROM CTE_A
GROUP BY emp_id



--Approach-2


WITH CTE_A AS (
    SELECT 
        emp_id, 
        DATEDIFF(MINUTE, login, logout) AS 'Logout-Login',
        CASE 
            WHEN DATEDIFF(DAY, login, logout) = 0 THEN DATEPART(WEEK, login) 
            ELSE NULL 
        END AS 'WKNUMBER'
    FROM 
        employee_work
),
CTE_B AS (
    SELECT 
        emp_id,
        CASE 
            WHEN 'Logout-Login' > = 10*60 THEN 10 
            ELSE NULL 
        END AS "10+Hours",
        CASE 
            WHEN 'Logout-Login' >= 8*60 THEN 8 
            ELSE NULL 
        END AS "8+WorkHolic"
    FROM 
        CTE_A
)

SELECT 
    emp_id,
    CASE 
        WHEN SUM(CASE WHEN [8+WorkHolic] = 8 THEN 1 ELSE 0 END) >= 3 AND SUM(CASE WHEN [10+Hours] = 10 THEN 1 ELSE 0 END) >= 2 THEN 'Both'
        WHEN SUM(CASE WHEN [8+WorkHolic] = 8 THEN 1 ELSE 0 END) >= 3 THEN '1' 
        WHEN SUM(CASE WHEN [10+Hours] = 10 THEN 1 ELSE 0 END) >= 2 THEN '2' 
        ELSE '0' 
    END AS [WorkHolic]
FROM 
    CTE_B
GROUP BY 
    emp_id;
