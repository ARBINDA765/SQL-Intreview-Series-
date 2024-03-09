USE SSIS
drop table if exists mountain_huts;
create table mountain_huts 
(
	id 			integer not null unique,
	name 		varchar(40) not null unique,
	altitude 	integer not null
);
insert into mountain_huts values (1, 'Dakonat', 1900);
insert into mountain_huts values (2, 'Natisa', 2100);
insert into mountain_huts values (3, 'Gajantut', 1600);
insert into mountain_huts values (4, 'Rifat', 782);
insert into mountain_huts values (5, 'Tupur', 1370);

drop table if exists trails;
create table trails 
(
	hut1 		integer not null,
	hut2 		integer not null
);
insert into trails values (1, 3);
insert into trails values (3, 2);
insert into trails values (3, 5);
insert into trails values (4, 5);
insert into trails values (1, 5);

select * from mountain_huts;
select * from trails;

WITH CTE_Hut1 as
(
SELECT * FROM trails t
INNER JOIN mountain_huts m 
ON t.hut1=m.id
),
CTE_HUT_Summary as 
(
SELECT CTE_Hut1.id 'Start_Id',CTE_Hut1.name 'Start_Hut',CTE_Hut1.altitude as 'Start_Attitude',
mountain_huts.id 'End_Id',mountain_huts.name 'End_Hut',mountain_huts.altitude as 'End_Attitude'
FROM CTE_Hut1 INNER JOIN mountain_huts ON mountain_huts.id=CTE_Hut1.hut2
)

,CTE_Attitude_Summary as 
(
SELECT *,CASE WHEN CTE_HUT_Summary.Start_Attitude > CTE_HUT_Summary.End_Attitude then 1 else 0 END 'Attitude_Flag'
FROM CTE_HUT_Summary
)

,CTE_Final_Data as 
(SELECT 
CASE WHEN CTE_Attitude_Summary.Attitude_Flag=1 THEN CTE_Attitude_Summary.Start_Id ELSE  CTE_Attitude_Summary.End_Id END Start_Hut_ID,
CASE WHEN CTE_Attitude_Summary.Attitude_Flag=1 THEN CTE_Attitude_Summary.Start_Hut ELSE  CTE_Attitude_Summary.End_Hut END Start_Hut_Name,
CASE WHEN CTE_Attitude_Summary.Attitude_Flag=0 THEN CTE_Attitude_Summary.Start_Id ELSE  CTE_Attitude_Summary.End_Id END End_Hut_ID,
CASE WHEN CTE_Attitude_Summary.Attitude_Flag=0 THEN CTE_Attitude_Summary.Start_Hut ELSE  CTE_Attitude_Summary.End_Hut END End_Hut_Name

FROM CTE_Attitude_Summary 
)



SELECT CF_1.Start_Hut_Name,CF_1.End_Hut_Name 'Middle_Hut',CF_2.End_Hut_Name 
FROM CTE_Final_Data CF_1
INNER JOIN CTE_Final_Data CF_2 ON CF_1.End_Hut_ID=CF_2.Start_Hut_ID








