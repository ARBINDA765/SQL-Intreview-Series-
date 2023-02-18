----Sql Query to generate a match schedule for a list of countries
--Asked by H*L for the position of BI Developer
--Suffle the team in between them to play the CRICKET match
---Make sure that match should not repeat in between two team

USE SSIS
--DROP TABLE TEAM

CREATE TABLE TEAM (TEAM_NAME VARCHAR(100))

INSERT INTO TEAM VALUES('INDIA')
INSERT INTO TEAM VALUES('Australia')
INSERT INTO TEAM VALUES('West Indies')
INSERT INTO TEAM VALUES('Afghanistan')
INSERT INTO TEAM VALUES('South Africa')

SELECT * FROM TEAM

SELECT REPLICATE('*',100) as 'outPut Should be below'

SELECT  CONCAT(A.TEAM_NAME,'-',B.TEAM_NAME) 'MATCH_Played'
FROM TEAM A
INNER JOIN TEAM B ON A.TEAM_NAME < B.TEAM_NAME
ORDER BY A.TEAM_NAME


