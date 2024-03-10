USE SSIS

--Write a query to get the difference of amount between apples & oranges for each day.

---------------Sample Table Script----------------------


drop table if exists  sales_tb_t
CREATE TABLE sales_tb_t (
  Sales_date DATE,
  Fruits VARCHAR(255),
  sold_num INT
);
INSERT INTO sales_tb_t (Sales_date, Fruits, sold_num)
VALUES
  ('2020-05-01', 'apples', 10),
  ('2020-05-01', 'oranges', 8),
  ('2020-05-02', 'apples', 15),
  ('2020-05-02', 'oranges', 15),
  ('2020-05-03', 'apples', 20),
  ('2020-05-03', 'oranges', 0),
  ('2020-05-04', 'apples', 15),
  ('2020-05-04', 'oranges', 16);

  select * from sales_tb_t

  ----------------Solution Start------------------

  SELECT Sales_date,
  SUM(CASE WHEN Fruits='apples' then sold_num ELSE 0 END) 'Apple',
  SUM(CASE WHEN Fruits='oranges' then sold_num ELSE 0 END) 'Oranges',
  SUM(CASE WHEN Fruits='apples' then sold_num ELSE 0 END)- SUM(CASE WHEN Fruits='oranges' then sold_num ELSE 0 END) as 'Apple-Oranges-Diff'
FROM sales_tb_t
 GROUP BY Sales_date