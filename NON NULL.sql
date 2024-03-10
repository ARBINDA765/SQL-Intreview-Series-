USE SSIS

DROP TABLE IF EXISTS FOOTER;
CREATE TABLE FOOTER 
(
	id 			INT PRIMARY KEY,
	car 		VARCHAR(20), 
	length 		INT, 
	width 		INT, 
	height 		INT
);

INSERT INTO FOOTER VALUES (1, 'Hyundai Tucson', 15, 6, NULL);
INSERT INTO FOOTER VALUES (2, NULL, NULL, NULL, 20);
INSERT INTO FOOTER VALUES (3, NULL, 12, 8, 15);
INSERT INTO FOOTER VALUES (4, 'Toyota Rav4', NULL, 15, NULL);
INSERT INTO FOOTER VALUES (5, 'Kia Sportage', NULL, NULL, 18); 

SELECT * FROM FOOTER;

-------------------Solution 1------------------------
SELECT * FROM 
(SELECT  TOP 1  car from FOOTER WHERE car is not null  ORDER BY id desc )  Car_New CROSS JOIN 
(SELECT  TOP 1  length from FOOTER WHERE length is not null  ORDER BY id desc ) Length_New CROSS JOIN
(SELECT  TOP 1  width from FOOTER WHERE width is not null  ORDER BY id desc ) Width_New CROSS JOIN
(SELECT  TOP 1  height from FOOTER WHERE height is not null  ORDER BY id desc ) Height_New






WITH CTE_A as 
(
SELECT *,

SUM(CASE WHEN car IS not null then 1 else 0 END) OVER (ORDER BY id) AS 'Car_Segment',
SUM(CASE WHEN length IS not null then 1 else 0 END) OVER (ORDER BY id) AS 'length_Segment',
SUM(CASE WHEN width IS not null then 1 else 0 END) OVER (ORDER BY id) AS 'width_Segment',
SUM(CASE WHEN height IS not null then 1 else 0 END) OVER (ORDER BY id) AS 'height_Segment'
FROM FOOTER
)
SELECT TOP 1 id,FIRST_VALUE (car ) OVER (PARTITION BY Car_Segment ORDER BY id ) 'New_Car_Column' ,
FIRST_VALUE (length ) OVER (PARTITION BY length_Segment ORDER BY id ) 'New_legth_Column' ,
FIRST_VALUE (width ) OVER (PARTITION BY width_Segment ORDER BY id ) 'New_width_Column' ,
FIRST_VALUE (height ) OVER (PARTITION BY height_Segment ORDER BY id ) 'New_heigth_Column' 

FROM CTE_A
ORDER BY id desc 


