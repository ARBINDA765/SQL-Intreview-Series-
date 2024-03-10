
USE SSIS
--Question - Find total transactions through Cash and Online mode. 
-----------------Sample Table  Script=-----------------------------

CREATE TABLE Merchent_Tb 
(
    Merchant_Id	VARCHAR(512),
    Type	VARCHAR(512),
    Amount	INT
);

INSERT INTO Merchent_Tb (Merchant_Id, Type, Amount) VALUES ('m1', 'online', '100');
INSERT INTO Merchent_Tb (Merchant_Id, Type, Amount) VALUES ('m1', 'cash', '20');
INSERT INTO Merchent_Tb (Merchant_Id, Type, Amount) VALUES ('m2', 'online', '120');
INSERT INTO Merchent_Tb (Merchant_Id, Type, Amount) VALUES ('m2', 'cash', '20');
INSERT INTO Merchent_Tb (Merchant_Id, Type, Amount) VALUES ('m3', 'online', '30');
INSERT INTO Merchent_Tb (Merchant_Id, Type, Amount) VALUES ('m4', 'cash', '40');
INSERT INTO Merchent_Tb (Merchant_Id, Type, Amount) VALUES ('m5', 'online', '40');

------------------------------------------------
-------------------------------Solution 1---------------------------------
 SELECT * FROM Merchent_Tb
 GO
 SELECT REPLICATE('*',20) AS'OUTPUT'
 GO
WITH CTE_A as
(
SELECT Merchant_Id,

CASE WHEN Type ='online' then Amount ELSE 0 END 'Online',
CASE WHEN Type ='cash' then Amount ELSE 0 END 'Cash'

FROM Merchent_Tb
)

SELECT Merchant_Id,SUM(Online) as'Online_Amount' ,SUM(Cash) as'Cash_Amount' 
FROM CTE_A
GROUP BY Merchant_Id

