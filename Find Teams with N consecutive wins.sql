---Find Teams with N consecutive wins--


USE SSIS
----------------Sample Table Script------------------------------------------
CREATE TABLE IPL_2022 
(
    matchnum	INT,
    team1	VARCHAR(512),
    team2	VARCHAR(512),
    winner	VARCHAR(512)
);

INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('1', 'CSK', 'KKR', 'KKR');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('2', 'MI', 'DC', 'DC');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('3', 'RCB', 'PBKS', 'PBKS');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('4', 'LSG', 'GT', 'GT');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('5', 'RR', 'SRH', 'RR');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('6', 'KKR', 'RCB', 'RCB');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('7', 'CSK', 'LSG', 'LSG');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('8', 'PBKS', 'KKR', 'KKR');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('9', 'RR', 'MI', 'RR');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('10', 'GT', 'DC', 'GT');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('11', 'PBKS', 'CSK', 'PBKS');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('12', 'LSG', 'SRH', 'LSG');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('13', 'RR', 'RCB', 'RCB');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('14', 'MI', 'KKR', 'KKR');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('15', 'DC', 'LSG', 'LSG');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('16', 'PBKS', 'GT', 'GT');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('17', 'CSK', 'SRH', 'SRH');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('18', 'MI', 'RCB', 'RCB');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('19', 'DC', 'KKR', 'DC');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('20', 'RR', 'LSG', 'RR');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('21', 'GT', 'SRH', 'SRH');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('22', 'CSK', 'RCB', 'CSK');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('23', 'PBKS', 'MI', 'PBKS');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('24', 'GT', 'RR', 'GT');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('25', 'KKR', 'SRH', 'SRH');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('26', 'LSG', 'MI', 'LSG');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('27', 'RCB', 'DC', 'RCB');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('28', 'PBKS', 'SRH', 'SRH');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('29', 'CSK', 'GT', 'GT');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('30', 'RR', 'KKR', 'RR');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('31', 'RCB', 'LSG', 'RCB');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('32', 'PBKS', 'DC', 'DC');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('33', 'MI', 'CSK', 'CSK');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('34', 'RR', 'DC', 'RR');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('35', 'GT', 'KKR', 'GT');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('36', 'RCB', 'SRH', 'SRH');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('37', 'LSG', 'MI', 'LSG');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('38', 'PBKS', 'CSK', 'PBKS');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('39', 'RR', 'RCB', 'RR');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('40', 'SRH', 'GT', 'GT');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('41', 'KKR', 'DC', 'DC');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('42', 'LSG', 'PBKS', 'LSG');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('43', 'RCB', 'GT', 'GT');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('44', 'RR', 'MI', 'MI');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('45', 'LSG', 'DC', 'LSG');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('46', 'CSK', 'SRH', 'CSK');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('47', 'RR', 'KKR', 'KKR');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('48', 'GT', 'PBKS', 'PBKS');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('49', 'RCB', 'CSK', 'RCB');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('50', 'DC', 'SRH', 'DC');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('51', 'MI', 'GT', 'MI');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('52', 'PBKS', 'RR', 'RR');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('53', 'LSG', 'KKR', 'LSG');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('54', 'RCB', 'SRH', 'RCB');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('55', 'CSK', 'DC', 'CSK');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('56', 'KKR', 'MI', 'KKR');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('57', 'GT', 'LSG', 'GT');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('58', 'RR', 'DC', 'DC');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('59', 'CSK', 'MI', 'MI');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('60', 'PBKS', 'RCB', 'PBKS');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('61', 'KKR', 'SRH', 'KKR');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('62', 'CSK', 'GT', 'GT');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('63', 'RR', 'LSG', 'RR');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('64', 'DC', 'PBKS', 'DC');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('65', 'SRH', 'MI', 'SRH');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('66', 'LSG', 'KKR', 'LSG');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('67', 'GT', 'RCB', 'RCB');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('68', 'CSK', 'RR', 'RR');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('69', 'DC', 'MI', 'MI');
INSERT INTO IPL_2022 (matchnum, team1, team2, winner) VALUES ('70', 'SRH', 'PBKS', 'PBKS');

-----------------------------------------Find Teams with N consecutive wins-----------------------
SELECT * FROM IPL_2022

------------------------------------------------------------Solution Start-------------------------------------------------
WITH CTE_A as 
(
SELECT matchnum,winner as team ,'win' as 'value'

FROM IPL_2022

UNION ALL
SELECT  matchnum,IIF(team1=winner,team2,team1) AS team,'Loss' as 'Value' FROM IPL_2022 
)
,CTE_B AS (

SELECT TEAM,STRING_AGG(value,',') WITHIN GROUP (ORDER BY matchnum) 'Strike'
FROM CTE_A
GROUP BY TEAM
)
SELECT * FROM CTE_B 
WHERE Strike like '%win,win,win%'

