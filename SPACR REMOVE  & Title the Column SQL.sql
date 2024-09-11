--Question - Segregate the name into first name and last name and keep them in correct order of caps. 
--Table Creation Query :-
USE SSIS
create table names_t( 
name varchar(30));

insert into names_t
values('aNkiT DhAR'),
('RahUL BhaTIYa');

--------
SELECT REPLICATE('*',20) AS "INPUT"
GO
SELECT * FROM names_t
GO
SELECT REPLICATE('*',20) AS "OUPUT"
GO
WITH CTE_A as
(
SELECT * 
,CHARINDEX(' ',name) 'Space_Index',SUBSTRING(name,1,CHARINDEX(' ',name)) 'Fname',
SUBSTRING(name,CHARINDEX(' ',name)+1,LEN(name)) as 'Lname'

FROM names_t
)

SELECT CONCAT(UPPER(SUBSTRING(Fname,1,1)),LOWER(SUBSTRING(Fname,2,LEN(Fname)))) AS 'First_Name',
 CONCAT(UPPER(SUBSTRING(Lname,1,1)),LOWER(SUBSTRING(Lname,2,LEN(Fname)))) AS 'Last_Name'


FROM CTE_A