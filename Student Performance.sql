USE SSIS
/*
PROBLEM STATEMENT:
You are given a table having the marks of one student in every test. 
You have to output the tests in which the student has improved his performance. 
For a student to improve his performance he has to score more than the previous test.
Provide 2 solutions, one including the first test score and second excluding it.
*/
-------------------------------------------------Sample Table Script---------------------------------
drop table if exists  student_tests;
create table student_tests
(
	test_id		int,
	marks		int
);
insert into student_tests values(100, 55);
insert into student_tests values(101, 55);
insert into student_tests values(102, 60);
insert into student_tests values(103, 58);
insert into student_tests values(104, 40);
insert into student_tests values(105, 50);


---------------Solution --------------------------------------------------------------------
WITH CTE_A as
(
select *,LAG(marks,1,0) OVER(ORDER BY TEST_ID )'Previous_Mark'
from student_tests
),_CTE_Marks_Flag as (
SELECT *,CASE WHEN marks > Previous_Mark THEN 1 ELSE 0 END 'Marks_Flag'
FROM CTE_A
)

Select * FROM _CTE_Marks_Flag 
WHERE Marks_Flag=1


--------------------End of Solution ----------------------------------------------------------
