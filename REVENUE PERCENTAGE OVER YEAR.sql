USE SSIS
------------Query to generate Revenue Percentage Year over Year 	-----------									
										

---------------------------------------Sample Script-----------------
CREATE TABLE AmazOn_Sales(Year INT,Vendor VARCHAR(70),Amount INT)

INSERT INTO AmazOn_Sales VALUES  (2001,'A',100)
INSERT INTO AmazOn_Sales VALUES  (2002,'A',80)

INSERT INTO AmazOn_Sales VALUES  (2001,'B',70)
INSERT INTO AmazOn_Sales VALUES  (2002,'B',120)


INSERT INTO AmazOn_Sales VALUES  (2001,'C',110)
INSERT INTO AmazOn_Sales VALUES  (2002,'C',110)

INSERT INTO AmazOn_Sales VALUES  (2001,'D',120)
INSERT INTO AmazOn_Sales VALUES  (2002,'D',190)

SELECT * FROM AmazOn_Sales

---------------------------Solution Start---------------------------------------------

WITH Revenue_Summary as (
SELECT *,LAG(Amount) OVER (PARTITION BY Vendor ORDER BY Year) 'Previous_Amount',
Amount- LAG(Amount) OVER (PARTITION BY Vendor ORDER BY Year)  as 'Amount-Previous'

FROM Amazan_Sales
)
SELECT TRIM (CONCAT
(STR(Revenue_Summary.Year-1),'-',TRIM(STR( Revenue_Summary.Year))) )AS 'FY-Year',
Revenue_Summary.Vendor, 
CONCAT(
STR(
 ROUND(CAST ([Amount-Previous] AS FLOAT)/ ( CAST (Previous_Amount AS FLOAT)) * 100,2)),'%') as 'Revenue_Percentage'
 FROM Revenue_Summary
WHERE Previous_Amount IS NOT NULL
---------------------------Solution End--------------------------------------------

