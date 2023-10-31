create table icc_world_cup
(
match_no int,
team_1 Varchar(20),
team_2 Varchar(20),
winner Varchar(20)
);
INSERT INTO icc_world_cup values(1,'ENG','NZ','NZ');
INSERT INTO icc_world_cup values(2,'PAK','NED','PAK');
INSERT INTO icc_world_cup values(3,'AFG','BAN','BAN');
INSERT INTO icc_world_cup values(4,'SA','SL','SA');
INSERT INTO icc_world_cup values(5,'AUS','IND','IND');
INSERT INTO icc_world_cup values(6,'NZ','NED','NZ');
INSERT INTO icc_world_cup values(7,'ENG','BAN','ENG');
INSERT INTO icc_world_cup values(8,'SL','PAK','PAK');
INSERT INTO icc_world_cup values(9,'AFG','IND','IND');
INSERT INTO icc_world_cup values(10,'SA','AUS','SA');
INSERT INTO icc_world_cup values(11,'BAN','NZ','NZ');
INSERT INTO icc_world_cup values(12,'PAK','IND','IND');
INSERT INTO icc_world_cup values(12,'SA','IND','DRAW');


SELECT TEAM,SUM(Matches_Played) Matches_Played,SUM(win_flag) Wins ,SUM(Matches_Played) - SUM(win_flag) as "Loss" ,(SUM(win_flag) *2) "Points" FROM (
SELECT team_1 as "Team",COUNT(*) "Matches_Played" , 
sum(CASE WHEN team_1=winner THEN 1 ELSE 0 END) as win_flag from icc_world_cup
group by team_1

union all

select team_2 as "Team",COUNT(*) "Matches Played" , sum(CASE WHEN team_2=winner THEN 1 ELSE 0 END) as win_flag from icc_world_cup
group by team_2) A
GROUP BY Team



