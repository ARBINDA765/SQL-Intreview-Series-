USE SSIS

/*
Namastekart, an e-commerce company want to start special reward program for their premium customers.  The customers who have placed more number of orders than the average number of orders placed by each customers are considered as premium customers.

Write an SQL to find the list of premium customers along with the number of orders placed by each of them. 
*/

CREATE TABLE Namastekart_Orders_3 (
    order_id INT,
    order_date DATE,
    customer_name VARCHAR(50),
    sales INT
);

-- Insert data into the orders table
INSERT INTO Namastekart_Orders_3  (order_id, order_date, customer_name, sales)
VALUES 
    (1, '2023-01-01', 'Alexa', 1239),
    (2, '2023-01-02', 'Alexa', 1239),
    (3, '2023-01-03', 'Alexa', 1239),
    (4, '2023-01-03', 'Alexa', 1239),
    (5, '2023-01-01', 'Ramesh', 1239),
    (6, '2023-01-02', 'Ramesh', 1239),
    (7, '2023-01-03', 'Ramesh', 1239),
    (8, '2023-01-03', 'Neha', 1200),
    (9, '2023-01-03', 'Subhash', 100),
    (10, '2023-01-03', 'Subhash', 23);


WITH CTE_AVG_ORDER AS (
    SELECT 
        CAST(COUNT(order_id) * 1.0 / COUNT(DISTINCT customer_name) AS decimal(4, 2)) AS Avg_Order
    FROM 
        Namastekart_Orders_3
),
Customer_Avg_Order AS (
    SELECT 
        customer_name,
        COUNT(order_id) AS Cust_Each_Order
    FROM 
        Namastekart_Orders_3
    GROUP BY 
        customer_name
)
SELECT 
    Customer_Avg_Order.*
FROM 
    Customer_Avg_Order
WHERE 
    Customer_Avg_Order.Cust_Each_Order > (SELECT Avg_Order FROM CTE_AVG_ORDER);

