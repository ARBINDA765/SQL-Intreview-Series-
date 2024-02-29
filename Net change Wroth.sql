USE SSIS

/* Changes in net worth
From the following table of transactions between two users, write
a query to return the change in net worth for each user, ordered by
decreasing net change
*/

CREATE TABLE  transactions_tb (sender VARCHAR(10), receiver VARCHAR(20), amount INT, transaction_date DATE)
INSERT INTO transactions_tb VALUES
(5, 2, 10, CAST('2-12-20' AS date)),
(1, 3, 15, CAST('2-13-20' AS date)),
(2, 1, 20, CAST('2-13-20' AS date)),
(2, 3, 25, CAST('2-14-20' AS date)),
(3, 1, 20, CAST('2-15-20' AS date)),
(3, 2, 15, CAST('2-15-20' AS date)) 
USE SSIS
SELECT * FROM transactions_tb
-----------------------------Solution Starts ---------------------------------------------------------
-- sum amounts for each sender (debits) and receiver
WITH debits AS (
SELECT sender, sum(amount) AS debited
FROM transactions_tb
GROUP BY sender ),
credits AS (
SELECT receiver, sum(amount) AS credited
FROM transactions_tb
GROUP BY receiver )-- 

--full (outer) join debits and credits tables
--on user id, taking net change as difference between credits and debits, coercing nulls to zeros with coalesce()

SELECT COALESCE(sender,receiver) as 'User_id' ,

coalesce(credited, 0) - coalesce(debited, 0) AS net_change
FROM debits d
FULL JOIN credits c
ON d.sender = c.receiver
order by 2 desc