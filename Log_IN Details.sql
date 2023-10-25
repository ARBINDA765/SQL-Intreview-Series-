USE SSIS
-------------PayPal Intreview Question -------------------------------
--WAQ to get each employeeid's Total_Entry,phone_number,total_login,total_logout,latest_login,latest_logout
--Fetach the only default number if default number is not avaiable then get the latest added number 


CREATE TABLE employee_checkin_details 
(
    employeeid int ,entry_details nvarchar(512), timestamp_details datetime
);

INSERT INTO employee_checkin_details (employeeid ,entry_details, timestamp_details ) VALUES
	('1000', 'login', '2023-06-16 01:00:15.34'),
	('1000', 'login', '2023-06-16 02:00:15.34'),
	('1000', 'login', '2023-06-16 03:00:15.34'),
	('1000', 'logout', '2023-06-16 12:00:15.34'),
	('1001', 'login', '2023-06-16 01:00:15.34'),
	('1001', 'login', '2023-06-16 02:00:15.34'),
	('1001', 'login', '2023-06-16 03:00:15.34'),
	('1001', 'logout', '2023-06-16 12:00:15.34');

	SELECT * FROM employee_checkin_details

	SELECT * FROM employee_data_details

	CREATE  TABLE employee_data_details
(
    employeeid INT, phone_number INT , isdefault VARCHAR(200),dateadd_on date
);

INSERT INTO employee_data_details (employeeid , phone_number , isdefault,dateadd_on) VALUES
	('1001','9999', 'false','2023-01-03'),
	('1001','1111', 'false','2023-01-21'),
	('1001','2222', 'true','2023-01-24'),
	('1000','3333', 'false','2023-01-25'),
	('1000','3333990', 'false','2023-03-03'),
	('1000','3333999', 'false','2023-04-04')


WITH CTE_A as (
select * from (
(SELECT *,ROW_NUMBER( ) OVER (PARTITION BY employeeid order by dateadd_on desc) as rn from employee_data_details
WHERE isdefault='false'
))A WHERE rn=1
)

SELECT emp_check.employeeid,count(*) as Total_Entry,COALESCE (emp_data.phone_number ,emp_data_1.phone_number) as phone_number,
count(CASE WHEN entry_details='login' then timestamp_details else null end) as total_login,
count(CASE WHEN entry_details='logout' then timestamp_details else null end) as total_logout,

max(CASE WHEN entry_details='login' then timestamp_details else null end) as latest_login,
max(CASE WHEN entry_details='logout' then timestamp_details else null end) as latest_logout

from employee_checkin_details emp_check
left join employee_data_details emp_data on emp_check.employeeid=emp_data.employeeid and emp_data.isdefault='true'
left join CTE_A  emp_data_1 on emp_check.employeeid=emp_data_1.employeeid 
GROUP BY emp_check.employeeid,emp_data.phone_number,emp_data_1.phone_number





