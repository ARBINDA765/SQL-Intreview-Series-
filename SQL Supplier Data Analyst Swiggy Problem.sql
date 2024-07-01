USE SSIS
--Write a SQL query to find the supplier_id, product_id, no of records,starting date of redord_date foer which stock quanity is less than 50 for 
--two or more consecutive days


--Create the table script----------
CREATE TABLE stock (
    supplier_id INT,
    product_id INT,
    stock_quantity INT,
    record_date DATE
);

-- Insert the data-------------
delete from stock;
INSERT INTO stock (supplier_id, product_id, stock_quantity, record_date)
VALUES
    (1, 1, 60, '2022-01-01'),
    (1, 1, 40, '2022-01-02'),
    (1, 1, 35, '2022-01-03'),
    (1, 1, 45, '2022-01-04'),
 (1, 1, 51, '2022-01-06'),
 (1, 1, 55, '2022-01-09'),
 (1, 1, 25, '2022-01-10'),
    (1, 1, 48, '2022-01-11'),
 (1, 1, 45, '2022-01-15'),
    (1, 1, 38, '2022-01-16'),
    (1, 2, 45, '2022-01-08'),
    (1, 2, 40, '2022-01-09'),
    (2, 1, 45, '2022-01-06'),
    (2, 1, 55, '2022-01-07'),
    (2, 2, 45, '2022-01-08'),
 (2, 2, 48, '2022-01-09'),
    (2, 2, 35, '2022-01-10'),
 (2, 2, 52, '2022-01-15'),
    (2, 2, 23, '2022-01-16');

select * from stock
-----------------------------------------Solution Start----------------------------------------------

---Solution-1-----------------------AAM Zindagi 
-----------------------------------
WITH CTE_1 as
(
SELECT supplier_id,product_id,record_date,
LAG(record_date,1,record_date) OVER(PARTITION BY supplier_id,product_id ORDER BY record_date) as 'Previous_Record_Date',
DATEDIFF(DAY,LAG(record_date,1,record_date) OVER(PARTITION BY supplier_id,product_id ORDER BY record_date),record_date) as 'Days_Diff'
FROM stock
WHERE stock_quantity <50
),
CTE_2 as (

SELECT *,CASE WHEN Days_Diff <=1 THEN 0 ELSE 1 END as 'Group_Flag',
SUM(CASE WHEN Days_Diff <=1 THEN 0 ELSE 1 END) OVER(PARTITION BY supplier_id,product_id ORDER BY record_date) as 'Group_Flag_Id'
FROM CTE_1
)


SELECT supplier_id,product_id,MIN(record_date) as 'First_Date',COUNT(*) as 'No_Of_Records'
FROM CTE_2
GROUP BY supplier_id,product_id,Group_Flag_Id
HAVING COUNT(*) >=2







---Solution-2-------Mentos Zindgi
------------------------------------------------------------------------------------------------------------------
with CTE_Stock as(select *,dateadd(day,-1*row_number()over(partition by supplier_id,product_id order by record_date),record_date) as date_group_id
            from stock
			where stock_quantity<50)
select supplier_id,product_id,count(*) as no_of_days,min(record_date) as first_date
from CTE_Stock
group by supplier_id,product_id,date_group_id
having count(*)>=2;

