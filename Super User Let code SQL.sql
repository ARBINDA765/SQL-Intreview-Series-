USE SSIS

/* Super users
A company defines its super users as those who have made at least
two transactions. From the following table, write a query to return,
for each user, the date when they become a super user, ordered by
oldest super users first. Users who are not super users should also
be present in the table
*/

CREATE TABLE  users_trans (user_id INT, product_id VARCHAR(20), transaction_date DATE )

INSERT INTO users_trans VALUES 
(1, 101, CAST('2-12-20' AS date)),
(2, 105, CAST('2-13-20' AS date)),
(1, 111, CAST('2-14-20' AS date)),
(3, 121, CAST('2-15-20' AS date)),
(1, 101, CAST('2-16-20' AS date)),
(2, 105, CAST('2-17-20' AS date)),
(4, 101, CAST('2-16-20' AS date)),
(3, 105, CAST('2-15-20' AS date))--------------Solution Start------------------------------------------------------SELECT *, row_number() OVER (PARTITION by user_id ORDER BY transaction_date ASC) AS transaction_number FROM users_trans),CTE_T2 AS (SELECT * FROM CTE_T1  WHERE transaction_number=2)SELECT users_trans.user_id,MAX(CTE_T2.transaction_date) 'Super_User_Date' FROM users_trans LEFT OUTER JOIN  CTE_T2 ON users_trans.user_id=CTE_T2.user_id GROUP BY users_trans.user_idORDER BY users_trans.user_id