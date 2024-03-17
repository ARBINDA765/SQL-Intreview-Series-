USE SSIS

/*
PROBLEM STATEMENT: In the given input table, there are hotel ratings which are either too high or too low compared to the standard ratings the hotel receives each year. Write a query to identify and exclude these outlier records as shown in expected output below. 
Your output should follow the same order of records as shown.
*/

----Sample Table---------------------
drop table if exists hotel_ratings;
create table hotel_ratings
(
	hotel 		varchar(30),
	year		int,
	rating 		decimal
);
insert into hotel_ratings values('Radisson Blu', 2020, 4.8);
insert into hotel_ratings values('Radisson Blu', 2021, 3.5);
insert into hotel_ratings values('Radisson Blu', 2022, 3.2);
insert into hotel_ratings values('Radisson Blu', 2023, 3.8);
insert into hotel_ratings values('InterContinental', 2020, 4.2);
insert into hotel_ratings values('InterContinental', 2021, 4.5);
insert into hotel_ratings values('InterContinental', 2022, 1.5);
insert into hotel_ratings values('InterContinental', 2023, 3.8);

select * from hotel_ratings;

--------------------Solution 1----------------------------------------------------------



WITH CTE_Avg_Rating AS (
    SELECT hotel,year,rating, CAST(AVG(rating) OVER(PARTITION BY hotel ORDER BY hotel) AS DECIMAL(9,1)) AS avg_rating 
    FROM  hotel_ratings
),
CTE_Rating_Diff AS (
    SELECT  * ,ABS(rating - avg_rating) AS 'Rating-Avg_Ratting' from CTE_Avg_Rating

),CTE_Outlier as
(
select *,max([Rating-Avg_Ratting]) over(partition by hotel order by hotel) as 'Max_Outlier' from CTE_Rating_Diff
)
(select Hotel,year,rating from  CTE_Outlier 
where [Rating-Avg_Ratting] <> [Max_Outlier])
ORDER BY hotel DESC

--------------------------Solution End----------------------------------------------