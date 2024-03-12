USE SSIS

drop table if exists job_skills;
create table job_skills
(
	row_id		int,
	job_role	varchar(20),
	skills		varchar(20)
);
insert into job_skills values (1, 'Data Engineer', 'SQL');
insert into job_skills values (2, null, 'Python');
insert into job_skills values (3, null, 'AWS');
insert into job_skills values (4, null, 'Snowflake');
insert into job_skills values (5, null, 'Apache Spark');
insert into job_skills values (6, 'Web Developer', 'Java');
insert into job_skills values (7, null, 'HTML');
insert into job_skills values (8, null, 'CSS');
insert into job_skills values (9, 'Data Scientist', 'Python');
insert into job_skills values (10, null, 'Machine Learning');
insert into job_skills values (11, null, 'Deep Learning');
insert into job_skills values (12, null, 'Tableau');

select * from job_skills;


----------------Solution 1-----------------------------------------
WITH CTE_A as
(
SELECT *,SUM(CASE WHEN job_role IS null then 0 else 1 End) OVER (Order BY row_id )'Segment'
 
from job_skills
)

SELECT *,MAX(job_role) OVER(PARTITION BY Segment ORDER BY row_id) 'Filled_Job_Role'
FROM CTE_A

----------------  Solution 2-----------------------------------------------------------
WITH CTE_Recursv as 
(
SELECT row_id,job_role,skills FROM job_skills where row_id =1 
UNION ALL
SELECT  CTE_Recursv.row_id,COALESCE(job_skills.job_role,CTE_Recursv.job_role) as job_role ,CTE_Recursv.skills FROM 

CTE_Recursv INNER JOIN job_skills ON job_skills.row_id=CTE_Recursv.row_id+1 
GROUP BY row_id,job_role,skills 
HAVING MAX(row_id) <9

)
SELECT * FROM CTE_Recursv 
;

