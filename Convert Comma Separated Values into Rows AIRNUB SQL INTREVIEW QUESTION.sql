------------------------------script--------------
---------Find the room type that searched most no of times & output the room type with the no of searchs for it------
---------------------------------------------START----------------------------------
USE SSIS 
create table airbnb_searches 
(
user_id int,
date_searched date,
filter_room_types varchar(200)
);
delete from airbnb_searches;
insert into airbnb_searches values
(1,'2022-01-01','entire home,private room')
,(2,'2022-01-02','entire home,shared room')
,(3,'2022-01-02','private room,shared room')
,(4,'2022-01-03','private room')


SELECT * FROM airbnb_searches 

-------TABLE CREATED WITH SAMPLE DATA-----------------------------


select A.value as "Room Type",count(A.value) as "No of times Search" from
(

select * from airbnb_searches Airnub
CROSS APPLY string_split (Airnub.filter_room_types,',')  
)A
GROUP BY A.value

SELECT string_split (Airnub.filter_room_types,',')   FROM airbnb_searches Airnub
ORDER BY count(A.value) DESC;


--------------------END-------------------------------------------------