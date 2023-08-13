---We have Student Marks & Grade  Table 
USE SSIS

DROP TABLE Students_Mark
CREATE TABLE Students_Mark(
ID int,
Name varchar(20),
TotalMarks int);
 DROP TABLE  Students_Mark
INSERT INTO  Students_Mark VALUES (1,'Neha',98);
INSERT INTO  Students_Mark VALUES (10,'Alekhya',93);
INSERT INTO Students_Mark VALUES (2,'Sahil',50);
INSERT INTO Students_Mark VALUES (3,'Rohan',70);
INSERT INTO Students_Mark VALUES (4,'Ankita',80);
INSERT INTO Students_Mark VALUES (5,'Rahul',65);
INSERT INTO Students_Mark VALUES (8,'Virat',69);
INSERT INTO Students_Mark VALUES (6,'Swati',55);
INSERT INTO Students_Mark VALUES (7,'Alka',75);

CREATE TABLE Grade(
Grade int,
Min_Marks int,
Max_Marks int);


INSERT INTO  Grade VALUES (0,0,9);
INSERT INTO  Grade VALUES (1,10,19);
INSERT INTO  Grade VALUES (2,20,29);
INSERT INTO  Grade VALUES (3,30,39);
INSERT INTO  Grade VALUES (4,40,49);
INSERT INTO  Grade VALUES (5,50,59);
INSERT INTO  Grade VALUES (6,60,69);
INSERT INTO  Grade VALUES (7,70,79);
INSERT INTO  Grade VALUES (8,80,89);
INSERT INTO  Grade VALUES (9,90,99);


SELECT * FROM Students_Mark
SELECT * FROM Grade

WITH CTE_A as
(
SELECT (CASE WHEN G.Grade >= 7 THEN S.Name ELSE NULL END) "Name",S.TotalMarks,G.Grade FROM Students_Mark S inner join Grade G 
ON S.TotalMarks between G.Min_Marks AND G.Max_Marks
ORDER BY G.Grade DESC,
CASE WHEN G.Grade <8 THEN S.TotalMarks else -1 END ASC,S.Name ASC
)

SELECT * FROM CTE_A



