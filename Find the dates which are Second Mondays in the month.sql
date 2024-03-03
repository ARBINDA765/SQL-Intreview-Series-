USE SSIS

--Find the dates which are Second Mondays in the month

--------------------------Sample Super Store Dataset ---------------------

----------------------Start of Solution -----------------------------

SELECT a.Order_Date,DATEPART(WEEKDAY,a.Order_Date) 'Days Of WEEK',

CEILING (CAST (DATEPART(DAY,a.Order_Date) AS float)/7 )'WEEK_MONTH'



FROM [Sample - Superstore_Orders] a
WHERE CEILING (CAST (DATEPART(DAY,a.Order_Date) AS float)/7 )=2 AND DATEPART(WEEKDAY,a.Order_Date) =2

-----------------------Solution End-----------------------
---------------------------

