USE SSIS
--Remove the reverse pair 
--

drop table tb1;
create table tb1(n int , m int);
insert into tb1 
values(1,2),(2,3),(3,4),(2,1),(3,2),(5,6);
select * from tb1;

----Solution Start-------------

WITH CTE_A AS 
(SELECT * ,LEAD(n,1) OVER(ORDER BY n,m) 'Next_n'
FROM tb1
)

SELECT n,m FROM CTE_A
WHERE m <>Next_n OR Next_n is null



