USE SSIS

---We have a lift weight table ,need the information the person who entered last & 
--Maximum capacity is 400KG of the lift
CREATE TABLE Lift_Weight_tb(
Name VARCHAR(70),
Weight INT,
Timestamp_lift DATETIME)

SELECT GETDATE()-365

DROP TABLE Lift_Weight_tb

INSERT into  Lift_Weight_tb VALUES('Taniya' ,71,'2023-02-25 07:45:54.957')

INSERT into  Lift_Weight_tb VALUES('Soniya' ,70,'2023-02-25 07:45:55.957')
INSERT into  Lift_Weight_tb VALUES('Sopiya' ,51,'2023-02-25 07:45:56.957')
INSERT into  Lift_Weight_tb VALUES('Arabinda' ,91,'2023-02-25 07:45:57.957')
INSERT into  Lift_Weight_tb VALUES('Ram' ,60,'2023-02-25 07:45:58.957')

INSERT into  Lift_Weight_tb VALUES('Shyam' ,81,'2023-02-25 07:45:59.957')
INSERT into  Lift_Weight_tb VALUES('TT' ,91,'2023-02-25 07:45:59.959')

WITH LIFT_Weith_Summary as 
(
SELECT *,SUM(Weight) OVER(ORDER BY Timestamp_lift ) 'Running_Weight'
FROM Lift_Weight_tb
)
SELECT TOP 1 * FROM LIFT_Weith_Summary
WHERE Running_Weight <=400
ORDER BY Running_Weight DESC;