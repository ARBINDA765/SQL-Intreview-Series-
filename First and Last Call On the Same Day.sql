USE SSIS

--Problem Description –
--Ask by Subex
--SQL Interview Questions – First and Last Call On the Same Day
--Write an SQL query to report the  Callerid,Recipientid  of the users whose first and last calls on any day were with the 
--same personalong with  Datecalled column





CREATE TABLE cdr_log (
   Callerid INT,
   Recipientid INT,
   Datecalled  datetime
);

--drop table cdr_log

insert into cdr_log(Callerid, Recipientid, Datecalled)
values (1, 2, '2019-01-01 09:00:00.000'),
       (1, 3, '2019-01-01 17:00:00.000'),
       (1, 4, '2019-01-01 23:00:00.000'),
       (2, 5, '2019-07-05 09:00:00.000'),
       (2, 3, '2019-07-05 17:00:00.000'),
       (2, 3, '2019-07-05 17:20:00.000'),
       (2, 5, '2019-07-05 23:00:00.000'),
       (2, 3, '2019-08-01 09:00:00.000'),
       (2, 3, '2019-08-01 17:00:00.000'),
       (2, 5, '2019-08-01 19:30:00.000'),
       (2, 4, '2019-08-02 09:00:00.000'),
       (2, 5, '2019-08-02 10:00:00.000'),
       (2, 5, '2019-08-02 10:45:00.000'),
       (2, 4, '2019-08-02 11:00:00.000'),
	   (10, 11, '2020-08-02 11:00:00.000');

---SQL Interview Questions – First and Last Call On the Same Day
--Write an SQL query to report the IDs of the users whose first and last calls on any day were with the same person. 
--Calls are counted regardless of being the caller or the recipient.

SELECT * FROM cdr_log 

WITH CTE_First_Call as 
(
SELECT Callerid,Recipientid,Datecalled,
DENSE_RANK() OVER (PARTITION BY Callerid, CAST (Datecalled as date) ORDER BY Datecalled ) as 'First_Call_Rank'
FROM cdr_log cdr
),
CTE_Last_call as 
(

SELECT Callerid,Recipientid,Datecalled,
DENSE_RANK() OVER (PARTITION BY Callerid, CAST (Datecalled as date) ORDER BY Datecalled DESC ) as 'Last_Call_Rank'
FROM cdr_log cdr
)

SELECT CTE_First_Call.Callerid,CTE_First_Call.Recipientid,CAST (CTE_First_Call.Datecalled as date) as Datecalled
FROM CTE_First_Call INNER JOIN CTE_Last_call
ON CTE_First_Call.Callerid=CTE_Last_call.Callerid AND
CTE_First_Call.Recipientid=CTE_Last_call.Recipientid AND
CAST (CTE_First_Call.Datecalled as date)=CAST (CTE_Last_call.Datecalled as date) AND 
CTE_First_Call.First_Call_Rank=1 AND CTE_Last_call.Last_Call_Rank=1




