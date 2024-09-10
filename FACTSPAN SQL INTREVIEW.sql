----------------Factspan ----------------------SQL Intreview Question --------------------------------

USE SSIS

CREATE TABLE source_db (id int,name VARCHAR(10))
insert  into source_db values (1,'A')
insert  into source_db values (2,'B')
insert  into source_db values (3,'C')
insert  into source_db values (4,'D')

CREATE TABLE target_db (id_t int,name_t VARCHAR(10))
insert  into target_db values (1,'A')
insert  into target_db values (2,'B')
insert  into target_db values (4,'X')
insert  into target_db values (5,'F')

-------------------------------------Solution------------------------------------------------

WITH full_outer AS (
    SELECT
        COALESCE(source_db.id, target_db.id_t) AS id,
        source_db.name AS source_name,
        target_db.name_t AS target_name
    FROM source_db
    FULL OUTER JOIN target_db
    ON source_db.id = target_db.id_t
)

SELECT
    id,
    CASE
        WHEN source_name IS NULL THEN 'new in target'
        WHEN target_name IS NULL THEN 'new in source'
        WHEN source_name != target_name THEN 'mismatch'
		 WHEN source_name = target_name THEN  'match' ELSE 'TBD'
    END AS comment
FROM full_outer;


------------------------------------Solution 2-----------------------------------------------------------
WITH Data_Quality as 
(

SELECT source_db.id AS "id",   'new in source' as 'Comment' 
FROM source_db LEFT JOIN target_db
ON source_db.id=target_db.id_t 
WHERE target_db.id_t is null

UNION ALL

SELECT target_db.id_t  AS "id", 'new in target' as 'Comment' 
FROM target_db LEFT JOIN source_db
ON source_db.id=target_db.id_t 
WHERE source_db.id is null

UNION ALL

SELECT source_db.id  AS "id",   'mismatch' as 'Comment' 
FROM source_db INNER JOIN target_db
ON source_db.id=target_db.id_t and source_db.name!=target_db.name_t

UNION ALL

SELECT source_db.id  AS "id",   'match' as 'Comment' 
FROM source_db INNER JOIN target_db
ON source_db.id=target_db.id_t and source_db.name=target_db.name_t


)
SELECT * FROM Data_Quality
ORDER BY id 












