USE SSIS
DROP TABLE BOWLING_DATA

---SQL intreview Question Series-12
--Cricket Score board design by SQL
--Asked by Facts*** Analyt***

CREATE TABLE BOWLING_DATA
(
 PLAYER_NAME VARCHAR(100),
 MATCH    VARCHAR(5),
 OVERS    NUMERIC(14,1),
 RUN     INT,
 WICKETS    INT
)

INSERT BOWLING_DATA VALUES('A','M1',5.5,10,2),('B','M2',3.4,13,3),('C','M3',5.3,11,1),
           ('A','M1',4.1,54,2),('B','M2',7.2,10,1),('C','M3',1.5,19,0),
       ('A','M1',2.3,10,3),('B','M2',2.4,19,2),('C','M3',2.4,56,2)

SELECT * FROM BOWLING_DATA

WITH CTE_A as 
(
SELECT PLAYER_NAME,COUNT(MATCH) as 'MATCH',SUM(RUN) as 'RUN',SUM(WICKETS) as 'WICKETS',

SUM (CAST(OVERS AS INT)*6 + PARSENAME(OVERS,1) ) 'Total_Ball'  FROM BOWLING_DATA
GROUP BY PLAYER_NAME
)

SELECT * ,CASE WHEN (RUN > 50) THEN 1  else 0 END  as '50''s',

(CAST (Total_Ball/6 as VARCHAR(10)) +'.'+CAST (Total_Ball%6 as VARCHAR(10)) )as 'OVER' FROM CTE_A
