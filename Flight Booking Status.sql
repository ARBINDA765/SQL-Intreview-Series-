
----Track the status of flight ticket Asked by Boeing SQL interview questions 

USE SSIS

Create table Flights
(flight_id int,capacity int);
Create table  Passengers 
(passenger_id int,flight_id int,booking_time datetime);

Truncate table Flights;
insert into Flights (flight_id, capacity) values 
('1', '2')
,('2', '2')
,('3', '1');

Truncate table Passengers;
insert into Passengers (passenger_id, flight_id, booking_time) values 
 (101, 1, '2023-07-10 16:30:00')
,(102, 1, '2023-07-10 17:45:00')
,(103, 1, '2023-07-10 12:00:00')
,(104, 2, '2023-07-05 13:23:00')
,(105, 2, '2023-07-05 09:00:00')
,(106, 3, '2023-07-08 11:10:00')
,(107, 3, '2023-07-08 09:10:00');

-------------------------------Solution 1------------------------------------------------------------------
WITH BOOKING_T as
(
SELECT  * ,DENSE_RANK() OVER(PARTITION BY flight_id ORDER BY booking_time) "Ranking" FROM Passengers
)

SELECT BOOKING_T.passenger_id,
CASE WHEN BOOKING_T.Ranking <= Flights.capacity then 'Confirmed' else 'Waiting_List' END  as 'Status'

FROM Flights INNER JOIN BOOKING_T 
ON Flights.flight_id=BOOKING_T.flight_id
ORDER BY BOOKING_T.passenger_id 

---------------Solution 2----------------------------Without Window Function--------------

with all_booking as (
SELECT 
    p.passenger_id,
    p.flight_id,
    p.booking_time,
    COUNT(p_before.passenger_id)+1  AS 'Cumulative_Booking_Count'
FROM 
    Passengers p
LEFT JOIN 
    Passengers p_before ON p.flight_id = p_before.flight_id
    AND p.booking_time > p_before.booking_time
GROUP BY 
    p.passenger_id, p.flight_id, p.booking_time
)
select a.passenger_id
      ,case when a.Cumulative_Booking_Count <= f.capacity then 'Confirmed' else 'Waitinglist' end as Tickt_Status
      from all_booking as a 
inner join Flights f 
        on f.flight_id = a.flight_id 
  order by 1; 









