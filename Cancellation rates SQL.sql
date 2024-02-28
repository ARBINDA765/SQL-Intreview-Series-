/* Cancellation rates
From the following table of user IDs, actions, and dates, write a
query to return the publication and cancellation rate for each user
*/

USE SSIS
CREATE TABLE Users_canl_tb (user_id INT, action VARCHAR(10), Date_Action DATE)
--------------------------Sample Table -------------------------------------------------------
INSERT INTO Users_canl_tb VALUES
(1,'start', CAST('01-01-20' AS date)),
(1,'cancel', CAST('01-02-20' AS date)),
(2,'start', CAST('01-03-20' AS date)),
(2,'publish', CAST('01-04-20' AS date)),
(3,'start', CAST('01-05-20' AS date)),
(3,'cancel', CAST('01-06-20' AS date)),
(1,'start', CAST('01-07-20' AS date)),
(1,'publish', CAST('01-08-20' AS date))----------------------Solution Starts-------------------------------------With sumUsers AS 
(
Select user_id,
Sum(case when action='start' then 1 else 0 end) as sumStart,
Sum(case when action='cancel' then 1 else 0 end) as sumCancel,
Sum(case when action='publish' then 1 else 0 end) as sumPublish
From Users_canl_tb
GROUP BY user_id
)
Select user_id, CAST (sumCancel AS FLOAT)/ CAST (sumStart AS float) as cancelRate, 
CAST (sumPublish AS float)/ CAST (sumStart AS FLOAT ) as
publishRate from sumUsers------------------------END OF SOLUTION --------------------------------------------------------------SELECT * FROM Users_canl_tb