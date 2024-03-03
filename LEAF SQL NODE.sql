
USE SSIS
-----------------Find the Leaf,Root and Inner Nodes--------------------------
--If there is no parent there is root
--if there is parent & it has children then called inner
--if there is only one parent its leaf

----------------Sample Script-------------------
create table node
(id int,
p_id int);

insert into node(id)
values(1);

insert into node(id,p_id)
values(2,1),(3,1),(4,2),(5,2);

------------------Solution Start-----------------------------------------
SELECT* FROM node


SELECT *,CASE when p_id is NULL Then 'root' 
WHEN p_id is not null and id IN	(SELECT  DISTINCT p_id from node ) THEN 'inner'
WHEN p_id is not null AND p_id in (SELECT DISTINCT p_id from node ) THEN 'Leaf'

End as 'Type'
FROM node


