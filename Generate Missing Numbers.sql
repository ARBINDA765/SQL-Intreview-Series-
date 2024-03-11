USE SSIS--

--Find the missing numbers 

---Sample Table-----------------

create table list(number int);
insert into list 
values(1),(2),(3),(5),(6),(7),(10);
select * from list;

-----Solution Start-----------------

WITH CTE_Highest as
(
SELECT MAX(number) 'Highest' FROM list
)
,CTE_recuvs as
(
SELECT MIN(number) 'num' FROM list---Base Condition
UNION ALL
SELECT num+1 FROM CTE_recuvs
INNER JOIN CTE_Highest ON CTE_recuvs.num <CTE_Highest.Highest
)

select CTE_recuvs.num as 'missing Numbers' from CTE_recuvs
LEFT JOIN list on CTE_recuvs.num=list.number
where list.number is null


---Solution End---------------------

