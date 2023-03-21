use SSIS
--Asked By AMAZON

--Write an SQL query to display the records with three or more rows with consecutive id‘s,
--and the number of people is greater than or equal to 100 for each.
--Return the result table ordered by visit_date in ascending order.

-----SAMPLE DATA---------------------------------Table script------------------
--DROP TABLE stadium
Create table  stadium (id int, date DATE NULL, people int);
Truncate table stadium;
insert into stadium (id, date, people) values ('1', '2017-01-01', '10');
insert into stadium (id, date, people) values ('2', '2017-01-02', '109');
insert into stadium (id, date, people) values ('3', '2017-01-03', '150');
insert into stadium (id, date, people) values ('4', '2017-01-04', '99');
insert into stadium (id, date, people) values ('5', '2017-01-05', '145');
insert into stadium (id, date, people) values ('6', '2017-01-06', '1455');
insert into stadium (id, date, people) values ('7', '2017-01-07', '199');
insert into stadium (id, date, people) values ('8', '2017-01-08', '188');

-----SOLUTION -------------------------------

SELECT * FROM stadium;

SELECT REPLICATE('*',100) as 'OUTPUT';

WITH CTE_A as 
(
SELECT *,ROW_NUMBER() OVER (ORDER BY s.date) as "Record ID",(id-ROW_NUMBER() OVER (ORDER BY s.date)) as 'Group_data' 
FROM stadium s WHERE s.people > 100
)

SELECT CTE_A.id,CTE_A.date,CTE_A.people FROM CTE_A  WHERE CTE_A.Group_data in 

(SELECT CTE_A.Group_data FROM CTE_A
WHERE CTE_A.Group_data=2
GROUP BY CTE_A.Group_data
HAVING COUNT(CTE_A.Group_data) >= 3
)

