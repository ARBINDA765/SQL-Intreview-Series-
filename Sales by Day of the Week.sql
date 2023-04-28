 --Sales by Day of the Week
 --ASK BY walmart tech india
 --You are the business owner and would like to obtain a sales report for category items and day of the week.
 --Write an SQL query to report how many units in each category have been ordered on each day of the week.


USE SSIS

Create table  Orders (order_id int, customer_id int, order_date date, item_id varchar(30), quantity int);

Create table  Items_T (item_id varchar(30), item_name varchar(30), item_category varchar(30));
--Truncate table Orders;
insert into Orders (order_id, customer_id, order_date, item_id, quantity) values ('1', '1', '2020-06-01', '1', '10');
insert into Orders (order_id, customer_id, order_date, item_id, quantity) values ('2', '1', '2020-06-08', '2', '10');
insert into Orders (order_id, customer_id, order_date, item_id, quantity) values ('3', '2', '2020-06-02', '1', '5');
insert into Orders (order_id, customer_id, order_date, item_id, quantity) values ('4', '3', '2020-06-03', '3', '5');
insert into Orders (order_id, customer_id, order_date, item_id, quantity) values ('5', '4', '2020-06-04', '4', '1');
insert into Orders (order_id, customer_id, order_date, item_id, quantity) values ('6', '4', '2020-06-05', '5', '5');
insert into Orders (order_id, customer_id, order_date, item_id, quantity) values ('7', '5', '2020-06-05', '1', '10');
insert into Orders (order_id, customer_id, order_date, item_id, quantity) values ('8', '5', '2020-06-14', '4', '5');
insert into Orders (order_id, customer_id, order_date, item_id, quantity) values ('9', '5', '2020-06-21', '3', '5');
--Truncate table Items;
insert into Items_T (item_id, item_name, item_category) values ('1', 'LC Alg. Book', 'Book');
insert into Items_T (item_id, item_name, item_category) values ('2', 'LC DB. Book', 'Book');
insert into Items_T (item_id, item_name, item_category) values ('3', 'LC SmarthPhone', 'Phone');
insert into Items_T (item_id, item_name, item_category) values ('4', 'LC Phone 2020', 'Phone');
insert into Items_T (item_id, item_name, item_category) values ('5', 'LC SmartGlass', 'Glasses');
insert into Items_T (item_id, item_name, item_category) values ('6', 'LC T-Shirt XL', 'T-shirt');

SELECT * FROM Orders

SELECT * FROM Items_T

SELECT  I.item_category,
SUM(CASE WHEN DATEPART(WEEKDAY,O.order_date)=2 THEN quantity ELSE 0 END ) as 'Monday',
SUM(CASE WHEN DATEPART(WEEKDAY,O.order_date)=3 THEN quantity ELSE 0 END ) as 'Tuesday',
SUM(CASE WHEN DATEPART(WEEKDAY,O.order_date)=4 THEN quantity ELSE 0 END ) as 'Wednssday',
SUM(CASE WHEN DATEPART(WEEKDAY,O.order_date)=5 THEN quantity ELSE 0 END ) as 'Thursday',
SUM(CASE WHEN DATEPART(WEEKDAY,O.order_date)=6 THEN quantity ELSE 0 END ) as 'Friday',
SUM(CASE WHEN DATEPART(WEEKDAY,O.order_date)=7 THEN quantity ELSE 0 END ) as 'Saturday',
SUM(CASE WHEN DATEPART(WEEKDAY,O.order_date)=1 THEN quantity ELSE 0 END ) as 'Sunday'

 FROM Items_T I 
LEFT JOIN Orders O ON O.item_id=I.item_id
GROUP BY I.item_category

SELECT DATEPART(dw,getdate()) 