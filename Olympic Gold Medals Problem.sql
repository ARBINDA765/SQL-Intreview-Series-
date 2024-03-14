USE SSIS

--Gold Medal per swimmer who won only golds 

-------------------------------------------------------------Sample Script-------------------------------
SELECT * FROM events
CREATE TABLE events_t (
ID int,
event varchar(255),
YEAR INt,
GOLD varchar(255),
SILVER varchar(255),
BRONZE varchar(255)
);

delete from events_t;

INSERT INTO events_t VALUES (1,'100m',2016, 'Amthhew Mcgarray','donald','barbara');
INSERT INTO events_t VALUES (2,'200m',2016, 'Nichole','Alvaro Eaton','janet Smith');
INSERT INTO events_t VALUES (3,'500m',2016, 'Charles','Nichole','Susana');
INSERT INTO events_t VALUES (4,'100m',2016, 'Ronald','maria','paula');
INSERT INTO events_t VALUES (5,'200m',2016, 'Alfred','carol','Steven');
INSERT INTO events_t VALUES (6,'500m',2016, 'Nichole','Alfred','Brandon');
INSERT INTO events_t VALUES (7,'100m',2016, 'Charles','Dennis','Susana');
INSERT INTO events_t VALUES (8,'200m',2016, 'Thomas','Dawn','catherine');
INSERT INTO events_t VALUES (9,'500m',2016, 'Thomas','Dennis','paula');
INSERT INTO events_t VALUES (10,'100m',2016, 'Charles','Dennis','Susana');
INSERT INTO events_t VALUES (11,'200m',2016, 'jessica','Donald','Stefeney');
INSERT INTO events_t VALUES (12,'500m',2016,'Thomas','Steven','Catherine');

SELECT * FROM events_t

--------------------------------------------------Solution ---------------------


-------------------Solution 1-----------------------------------------------------

SELECT GOLD,COUNT(1) 'Player_Name'  FROM events_t
WHERE GOLD NOT IN (SELECT SILVER FROM events_t) AND  GOLD NOT IN (SELECT BRONZE FROM events_t)
GROUP BY GOLD

----------------------------Solution 2--------------------------------------------------------------


WITH CTE_A as
(
SELECT GOLD as 'Player_Name'  ,'Gold' as 'Medal_Type'  FROM events_t
UNION ALL
SELECT SILVER as 'Player_Name'  ,'Silver' as 'Medal_Type'  FROM events_t
UNION ALL
SELECT BRONZE as 'Player_Name'  ,'Bronze' as 'Medal_Type'  FROM events_t
)

SELECT Player_Name,COUNT(1) as 'No_Of_Gold_Medals'  FROM CTE_A
GROUP BY Player_Name
HAVING COUNT(DISTINCT Medal_Type)=1 AND MAX(Medal_Type)='Gold'


--------------------------------------------------End of Solution ----------------------

