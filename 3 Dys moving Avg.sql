---Find out Moing Average --------------------------------

USE SSIS

USE SSIS


CREATE TABLE Trade_tb (Trade_Day VARCHAR(10),Amount INT,Company VARCHAR(10) )


INSERT INTO Trade_tb VALUES('Day 1',100,'A')

INSERT INTO Trade_tb VALUES('Day 2',140,'A')

INSERT INTO Trade_tb VALUES('Day 3',110,'A')
INSERT INTO Trade_tb VALUES('Day 4',140,'A')

INSERT INTO Trade_tb VALUES('Day 5',110,'A')



INSERT INTO Trade_tb VALUES('Day 1',1000,'B')

INSERT INTO Trade_tb VALUES('Day 2',1450,'B')

INSERT INTO Trade_tb VALUES('Day 3',140,'B')

INSERT INTO Trade_tb VALUES('Day 4',110,'B')


INSERT INTO Trade_tb VALUES('Day 1',140,'C')

INSERT INTO Trade_tb VALUES('Day 2',110,'C')

INSERT INTO Trade_tb VALUES('Day 3',1100,'C')



SELECT * ,AVG(Amount) OVER (PARTITION BY Company ORDER BY Trade_Day ROWS BETWEEN 2 PRECEDING AND CURRENT ROW ) '3 Days Moving Avg'

FROM Trade_tb

