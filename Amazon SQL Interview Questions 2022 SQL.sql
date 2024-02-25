USE SSIS
CREATE TABLE  CUSTOMER
(
    Customer_ID      VARCHAR(20) 
  , Customer_Name    VARCHAR(250)
  , Customer_City    VARCHAR(100)
  , Customer_DOB     DATE
  , Customer_Pin_Code VARCHAR(100)
);

CREATE TABLE CUSTOMER_TERRITORY
(
    Customer_ID      VARCHAR(20) 
  , TERRITORY_ID    VARCHAR(250)
  , Customer_City    VARCHAR(100)
  , Customer_Pin_Code VARCHAR(100)
);

CREATE TABLE MAP_EMPLOYEE_TERRITORY
(
    Employee_ID      VARCHAR(20) 
  , Territory_ID    VARCHAR(250)
  , Product_SubCategory VARCHAR(250) 
);
 --DROP TABLE CUSTOMER

--INSERT SCRIPTS

INSERT INTO CUSTOMER VALUES
        ('CUSTOMER1','Lindy','SanJose',CONVERT(DATE,'1988-02-24',20), '94088'),
		
        ('CUSTOMER2','Madison','Atlanta',CONVERT(DATE,'1984-05-28', 20),30305),
  ('CUSTOMER3','Kiara','Austin',CONVERT(DATE,'1989-04-19', 20),73301),
  ('CUSTOMER4','Beth','Ohio',CONVERT(DATE,'1992-08-18', 20),43123),
  ('CUSTOMER5','Beth','SanAntonio',CONVERT(DATE,'1992-08-18', 20),73504),
  ('CUSTOMER6','Beth','LasVegas',CONVERT(DATE,'1992-08-18', 20),95403),
  ('CUSTOMER7','Lindy','LosAngeles',CONVERT(DATE,'1987-07-12', 20),73504);

INSERT INTO CUSTOMER_TERRITORY VALUES
        ('CUSTOMER1','CA','SanJose', '94088'),
  ('CUSTOMER2','AZ','Atlanta','30305'),
  ('CUSTOMER3','UT','Austin','73301'),
  ('CUSTOMER4','OH','Ohio','43123'),
    ('CUSTOMER5','AZ','Phoenix', '85027'),
  ('CUSTOMER6','NV','LasVegas','95024');

INSERT INTO MAP_EMPLOYEE_TERRITORY VALUES
        ('EMP1','AZ', 'CLOTHES'),
  ('EMP2','CA', 'MENSWEAR'),
  ('EMP3','MA', 'WOMENWEAR'),
  ('EMP4','NM', 'ACCESSORIES'),
     ('EMP5','CA', 'JEWELERY'),
     ('EMP6','UT', 'KIDS');




SELECT * FROM MAP_EMPLOYEE_TERRITORY
SELECT * FROM CUSTOMER_TERRITORY

--QN1 - Write a Query to display those customer names and their occurrences when customer names appears more then once---

SELECT C.Customer_Name,COUNT( C.Customer_Name) as 'Occurrences'

FROM CUSTOMER C
GROUP BY C.Customer_Name
HAVING COUNT(C.Customer_Name) > 1

--QN2 - Write a Query to get the employees who are responsible for maximum number of customers

SELECT TOP 1 MET.Employee_ID,   COUNT(C.Customer_ID) 'OCccurances'
FROM CUSTOMER C 
INNER JOIN  CUSTOMER_TERRITORY CT ON C.Customer_ID=CT.Customer_ID
INNER JOIN MAP_EMPLOYEE_TERRITORY MET ON MET.Territory_ID=CT.TERRITORY_ID
GROUP BY MET.Employee_ID
ORDER BY COUNT(C.Customer_ID) DESC


---- QN3 - Write a Query to get those employees having no customers------------
SELECT  MET.Employee_ID,   COUNT(C.Customer_ID) 'OCccurances'
FROM CUSTOMER C 
INNER JOIN  CUSTOMER_TERRITORY CT ON C.Customer_ID=CT.Customer_ID
RIGHT  JOIN MAP_EMPLOYEE_TERRITORY MET ON MET.Territory_ID=CT.TERRITORY_ID
GROUP BY MET.Employee_ID
HAVING COUNT(C.Customer_ID) =0









