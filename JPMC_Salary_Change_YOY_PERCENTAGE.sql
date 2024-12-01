USE SSIS
--Write a SQL Code to write an yoy_percentage_change for each employee,each year

CREATE TABLE employee_salaries (
    emp_id INT,
    emp_name VARCHAR(255),
    salary DECIMAL(10, 2),
    DOJ DATE,
    SALARY_CHANGE_DATE DATE
);

-- Insert sample data
INSERT INTO employee_salaries (emp_id, emp_name, salary, DOJ, SALARY_CHANGE_DATE) VALUES
(1, 'Alice', 50000, '2015-01-01', '2016-01-01'),
(1, 'Alice', 55000, '2015-01-01', '2017-01-01'),
(1, 'Alice', 60000, '2015-01-01', '2018-01-01'),
(2, 'Bob', 60000, '2016-02-01', '2017-02-01'),
(2, 'Bob', 65000, '2016-02-01', '2018-02-01'),
(2, 'Bob', 70000, '2016-02-01', '2019-02-01');


WITH salary_changes AS (
  SELECT
    emp_id,
    emp_name,
    salary,
    SALARY_CHANGE_DATE,
    LAG(salary,1) OVER (PARTITION BY emp_id ORDER BY SALARY_CHANGE_DATE) AS previous_salary,
    YEAR(SALARY_CHANGE_DATE) AS change_year
  FROM
    employee_salaries
)
SELECT
  emp_id,
  emp_name,
  change_year,
  salary AS current_salary,
  previous_salary,
  CAST (ROUND((salary - previous_salary) / previous_salary * 100, 2) AS decimal(6,2)) AS yoy_percentage_change
FROM
  salary_changes
WHERE
  previous_salary IS NOT NULL
ORDER BY
  emp_id,
  change_year;

