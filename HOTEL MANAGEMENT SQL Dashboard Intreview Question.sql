USE SSIS
---HOTEL MANAGEMENT SQL Dashboard Intreview Question
--Video 13

-------Table Creation-------------------------------
---user_tb table--

---DROP table user_tb
CREATE TABLE user_tb(user_id nvarchar(30),name varchar(30),phone_number nvarchar(20),mail_id varchar(20),billing_address varchar(50))
insert into user_tb values('21wrcxucy','John Doe', 99171234,'john.doe@abc.com','NY Street,ABC City')
insert into user_tb values('22wrcxucy','Shyam Sharma', 99171235,'shyam.sharma@abc.com','Texas Street,ABC City')
insert into user_tb values('23wrcxucy','Shiva Raju', 99171231,'john.doe@abc.com','Times square  Street,ABC City')
insert into user_tb values('24wrcxucy','Kamal Khan', 99171239,'Kamal.Khan@abc.com','Sydeny Street,ABC City')
insert into user_tb values('25wrcxucy','Sunny M', 99171238,'Sunny.M@abc.com','Delhi Street,ABC City')

insert into user_tb values('210wrcxucy','Tri Singh', 99171280,'Tri.Singh@abc.com','AP Street,ABC City')
insert into user_tb values('211wrcxucy','Raj Reddy', 99171281,'Raj.Reddy@abc.com','Bhubaneswar Street,ABC City')
insert into user_tb values('220wrcxucy','Satish M', 99171282,'Satish.M@abc.com','London Street,ABC City')
insert into user_tb values('221wrcxucy','Suhana Pal', 99171283,'Suhana.Pal@abc.com','Bangalore Street,ABC City')
insert into user_tb values('241wrcxucy','Shansank B', 99171284,'Shansank.B@abc.com','Bohpal Street,ABC City')
SELECT * FROM user_tb
--------------booking Table----------------------------------

CREATE TABLE booking(booking_id nvarchar(30),booking_date DATE,room_number nvarchar(20),user_id nvarchar(30))
DROP table booking
insert into booking values('bk-09f32-1',GETDATE()-523 ,'rn-bhfn-aerjn-1','21wrcxucy')
insert into booking values('bk-09f32-10',GETDATE()-529 ,'rn-bhfn-aerjn-11','21wrcxucy')--
insert into booking values('bk-09f32-11',GETDATE()-533 ,'rn-bhfn-aerjn-12','21wrcxucy')--


insert into booking values('bk-09f32-2',GETDATE()-553 ,'rn-bhfn-aerjn-2','22wrcxucy')
insert into booking values('bk-09f32-22',GETDATE()-559 ,'rn-bhfn-aerjn-21','22wrcxucy')--
insert into booking values('bk-09f32-23',GETDATE()-562 ,'rn-bhfn-aerjn-22','22wrcxucy')--

insert into booking values('bk-09f32-3',GETDATE()-583 ,'rn-bhfn-aerjn-3','23wrcxucy')

insert into booking values('bk-09f32-4',GETDATE()-493 ,'rn-bhfn-aerjn-4','24wrcxucy')
insert into booking values('bk-09f32-44',GETDATE()-499 ,'rn-bhfn-aerjn-41','24wrcxucy')--

insert into booking values('bk-09f32-5',GETDATE()-599,'rn-bhfn-aerjn-5','25wrcxucy')

SELECT * FROM booking

----------------------booking_commerical table----------------

--DROP table booking_commerical
CREATE TABLE booking_commerical(id nvarchar(30),booking_id nvarchar(30),bill_id nvarchar(20),bill_date DATE,item_id nvarchar(30),item_quanity int)

insert into booking_commerical values('q34r-3q408-q1','bk-09f32-1','bl-0a087y-1',GETDATE()-523,'itm-a9e8-8fu-1',23)
insert into booking_commerical values('q34r-3q408-q2','bk-09f32-1','bl-0a087y-1',GETDATE()-523,'itm-a9e8-8fu-2',2)
insert into booking_commerical values('q34r-3q408-q24','bk-09f32-12','bl-0a087y-12',GETDATE()-529,'itm-a9e8-8fu-1',3)
insert into booking_commerical values('q34r-3q408-q24','bk-09f32-12','bl-0a087y-12',GETDATE()-529,'itm-a9e8-8fu-1',3)

insert into booking_commerical values('q34r-3q408-q25','bk-09f32-13','bl-0a087y-13',GETDATE()-531,'itm-a9e8-8fu-11',3)
insert into booking_commerical values('q34r-3q408-q26','bk-09f32-13','bl-0a087y-14',GETDATE()-531,'itm-a9e8-8fu-111',31)

insert into booking_commerical values('q34r-3q408-q13','bk-09f32-11','bl-0a087y-1',GETDATE()-525,'itm-a9e8-8fu-111',230)--
insert into booking_commerical values('q34r-3q408-q23','bk-09f32-11','bl-0a087y-1',GETDATE()-529,'itm-a9e8-8fu-211',20)--


insert into booking_commerical values('q34r-3q408-q3','bk-09f32-2','bl-0a087y-2',GETDATE()-553,'itm-a9e8-8fu-3',23)
insert into booking_commerical values('q34r-3q408-q4','bk-09f32-2','bl-0a087y-2',GETDATE()-553,'itm-a9e8-8fu-4',29)
insert into booking_commerical values('q34r-3q408-q5','bk-09f32-2','bl-0a087y-2',GETDATE()-553,'itm-a9e8-8fu-5',33)
insert into booking_commerical values('q34r-3q408-q6','bk-09f32-2','bl-0a087y-2',GETDATE()-553,'itm-a9e8-8fu-6',26)

insert into booking_commerical values('q34r-3q408-q7','bk-09f32-3','bl-0a087y-3',GETDATE()-583,'itm-a9e8-8fu-7',0)
insert into booking_commerical values('q34r-3q408-q8','bk-09f32-3','bl-0a087y-3',GETDATE()-583,'itm-a9e8-8fu-8',1)
insert into booking_commerical values('q34r-3q408-q9','bk-09f32-3','bl-0a087y-3',GETDATE()-583,'itm-a9e8-8fu-9',1)

insert into booking_commerical values('q34r-3q408-q10','bk-09f32-4','bl-0a087y-4',GETDATE()-493,'itm-a9e8-8fu-10',10)
insert into booking_commerical values('q34r-3q408-q11','bk-09f32-4','bl-0a087y-4',GETDATE()-493,'itm-a9e8-8fu-11',11)

insert into booking_commerical values('q34r-3q408-q12','bk-09f32-5','bl-0a087y-5',GETDATE()-599,'itm-a9e8-8fu-12',1)


SELECT * FROM booking_commerical

-----------------items table-------------------------------
CREATE TABLE items(item_id nvarchar(30),item_name varchar(30),item_rate int)
--DROP table items
insert into items values('itm-a9e8-8fu-1','Tawa-Paratha',10)
insert into items values('itm-a9e8-8fu-2','Mix veg',120)
insert into items values('itm-a9e8-8fu-3','Egg - Omlet',40)
insert into items values('itm-a9e8-8fu-4','Biryani',130)
insert into items values('itm-a9e8-8fu-5','Allu Paratha',50)
insert into items values('itm-a9e8-8fu-6','Gobi-Paratha',40)
insert into items values('itm-a9e8-8fu-7','Chicken chilly',190)
insert into items values('itm-a9e8-8fu-8','Gobi -Chilly',90)

insert into items values('itm-a9e8-8fu-9','Manchirian',110)
insert into items values('itm-a9e8-8fu-10','Tadka daal',110)
insert into items values('itm-a9e8-8fu-11','Fish curry',190)
insert into items values('itm-a9e8-8fu-12','Mutton',210)
insert into items values('itm-a9e8-8fu-111','Bread',43)
insert into items values('itm-a9e8-8fu-211','ice',41)



SELECT * FROM items

--Que 1>>>>---For every user in the system get, the user id ,Name  and last booked room no


WITH CTE_Last_Booked as
(
SELECT b.user_id,MAX(b.booking_date) as 'Last_Booked_Date'
FROM booking b
GROUP BY b.user_id
)
SELECT booking.user_id,user_tb.name,CTE_Last_Booked.Last_Booked_Date,booking.room_number FROM CTE_Last_Booked
INNER JOIN booking  ON booking.user_id=CTE_Last_Booked.user_id AND  booking.booking_date=CTE_Last_Booked.Last_Booked_Date
INNER JOIN user_tb ON user_tb.user_id=CTE_Last_Booked.user_id


---Que 2>>>>------------GET booking id & total bill amount of every booking created in OCT 2021-------

SELECT booking_id,sum(bk_c.item_quanity * i.item_rate) as 'total_bill'
FROM booking_commerical bk_c inner join  items i
ON i.item_id=bk_c.item_id AND (YEAR(bk_c.bill_date)=2021 AND MONTH (bk_c.bill_date)=10)
GROUP BY booking_id

--Que 3>>>>Get the bill id & bill amount of all the bills raised in SEP 2021 and bill amount > 1000

SELECT bk_c.booking_id,bk_c.bill_id,SUM (bk_c.item_quanity* i.item_rate)  as 'Total_Bill' FROM booking_commerical bk_c 
INNER JOIN items i ON bk_c.item_id=i.item_id AND (YEAR(bk_c.bill_date)= 2021  AND MONTH(bk_c.bill_date)=10)
GROUP BY bk_c.booking_id,bk_c.bill_id
HAVING SUM (bk_c.item_quanity * i.item_rate) > 1000

--Que 4>>Determine the least order & most order item of each month of the year 2021
WITH CTE_4 as 
(
SELECT DATENAME (month,bk_c.bill_date )+'21' as 'Month-21', bk_c.item_id,    SUM(bk_c.item_quanity) 'Total_Quanity'
FROM booking_commerical bk_c
GROUP BY DATENAME (month,bk_c.bill_date ),bk_c.item_id
)
,CTE_Most_Ordered as 
(

SELECT *,DENSE_RANK() OVER (PARTITION BY [Month-21] ORDER BY Total_Quanity DESC) as 'Most_Ordered' FROM CTE_4
)
,
CTE_Least_Order as 
(
SELECT *,DENSE_RANK() OVER (PARTITION BY [Month-21] ORDER BY Total_Quanity ) as 'Least_Ordered' FROM CTE_4
)
,
CTE_Most_Lowest_Order as 
(
SELECT * FROM CTE_Least_Order WHERE Least_Ordered=1 
UNION ALL
SELECT * FROM CTE_Most_Ordered WHERE Most_Ordered=1 
)

SELECT * FROM CTE_Most_Lowest_Order ORDER BY [Month-21] ,Total_Quanity  desc


--Que 5>>Find the customer with 2nd highest bill value of each month in 2021

WITH CTE_5 as 
(
SELECT DATENAME(month,bk_c.bill_date) as 'Month-21',  bk_c.bill_id,SUM (bk_c.item_quanity* i.item_rate)  as 'Total_Bill' FROM booking_commerical bk_c 
INNER JOIN items i ON bk_c.item_id=i.item_id 
GROUP BY DATENAME(month,bk_c.bill_date),bk_c.bill_id
),
CTE_Highest_Total_Bill as 
(

SELECT *,DENSE_RANK() OVER (PARTITION BY [Month-21] ORDER BY Total_Bill DESC ) as 'Highest_Bill' FROM CTE_5
)

SELECT CTE_Highest_Total_Bill .[Month-21],
booking.user_id,user_tb.name,booking_commerical.booking_id,
CTE_Highest_Total_Bill.bill_id,CTE_Highest_Total_Bill .Total_Bill 
FROM CTE_Highest_Total_Bill 
INNER JOIN booking_commerical ON booking_commerical.bill_id=CTE_Highest_Total_Bill.bill_id AND CTE_Highest_Total_Bill .Highest_Bill=2
INNER JOIN booking ON booking.booking_id=booking_commerical.booking_id
INNER JOIN user_tb ON user_tb.user_id=booking.user_id
ORDER BY CTE_Highest_Total_Bill.Total_Bill DESC


















