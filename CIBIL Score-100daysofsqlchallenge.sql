USE SSIS
-- Create a table named 'Customer' with columns 'customer_id' and 'credit_limit'
CREATE TABLE Customer_ns (
    customer_id INT PRIMARY KEY,
    credit_limit INT
);

-- Insert data into the 'Customer' table
INSERT INTO Customer_ns (customer_id, credit_limit)
VALUES
    (1, 80000),
    (2, 75000);

-- Create a table named 'Loan' with columns 'customer_id', 'loan_id', and 'loan_due_date'
CREATE TABLE Loan_ns (
    customer_id INT,
    loan_id INT,
    loan_due_date DATE,
    PRIMARY KEY (customer_id, loan_id) -- Define a composite primary key on 'customer_id' and 'loan_id'
);

-- Insert data into the 'Loan' table
INSERT INTO Loan_ns (customer_id, loan_id, loan_due_date)
VALUES
    (1, 101, '2022-05-10'),
    (1, 102, '2023-06-30'),
    (2, 103, '2023-08-15');



-- Create a table named 'Bill' with columns 'customer_id', 'bill_id', 'bill_due_date', and 'balance_amount'
CREATE TABLE credit_card_bills_ns (
    customer_id INT,
    bill_id INT,
    bill_due_date DATE,
    balance_amount DECIMAL(10, 2),
    PRIMARY KEY (customer_id, bill_id) -- Define a composite primary key on 'customer_id' and 'bill_id'
);

-- Insert data into the 'Bill' table
INSERT INTO credit_card_bills_ns (customer_id, bill_id, bill_due_date, balance_amount)
VALUES
    (1, 201, '2023-03-17', 8000),
    (1, 202, '2023-03-15', 12000),
    (2, 301, '2023-03-20', 15000),
    (2, 302, '2023-03-22', 13000);

-- Create a table named 'Transaction' with columns 'loan_bill_id', 'transaction_type', and 'transaction_date'
CREATE TABLE customer_transactions_ns (
    loan_bill_id INT PRIMARY KEY,
    transaction_type VARCHAR(10),
    transaction_date DATE
);

-- Insert data into the 'Transaction' table
INSERT INTO customer_transactions_ns (loan_bill_id, transaction_type, transaction_date)
VALUES
    (101, 'loan', '2022-04-12'),
    (102, 'loan', '2023-07-05'),
    (201, 'payment', '2023-03-17'),
    (202, 'payment', '2023-03-01'),
    (103, 'loan', '2023-08-10'),
    (301, 'payment', '2023-03-05'),
    (302, 'payment', '2023-03-05');

WITH CTE_all_bills AS (
    SELECT 
        customer_id,
        loan_id AS bill_id,
        loan_due_date AS due_date,
        0 AS balance_amount 
    FROM 
        Loan_ns

    UNION ALL

    SELECT 
        customer_id,
        bill_id,
        bill_due_date AS due_date,
        balance_amount 
    FROM 
        credit_card_bills_ns
),
on_time_calc AS (
    SELECT 
        b.customer_id,
        SUM(b.balance_amount) AS balance_amount,
        COUNT(*) AS total_bills,
        SUM(CASE WHEN ct.transaction_date <= b.due_date THEN 1 ELSE 0 END) AS on_time_payments
    FROM 
        CTE_all_bills b
    INNER JOIN 
        customer_transactions_ns ct ON b.bill_id = ct.loan_bill_id
    GROUP BY 
        b.customer_id
)

SELECT 
    c.customer_id, 
    ((ot.on_time_payments * 1.0 / ot.total_bills) * 70) +
    (CASE 
        WHEN ot.balance_amount * 1.0 / c.credit_limit < 0.3 THEN 1 
        WHEN ot.balance_amount * 1.0 / c.credit_limit < 0.5 THEN 0.7 
        ELSE 0.5 
     END) * 30 AS cibil_score 
FROM 
    Customer_ns c 
INNER JOIN 
    on_time_calc ot ON c.customer_id = ot.customer_id;


	