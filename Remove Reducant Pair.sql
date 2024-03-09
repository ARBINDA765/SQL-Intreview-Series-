USE SSIS

--- VIDEO_Q1 ---

/* Problem Statement:
- For pairs of brands in the same year (e.g. apple/samsung/2020 and samsung/apple/2020) 
    - if custom1 = custom3 and custom2 = custom4 : then keep only one pair

- For pairs of brands in the same year 
    - if custom1 != custom3 OR custom2 != custom4 : then keep both pairs

- For brands that do not have pairs in the same year : keep those rows as well
*/


DROP TABLE IF EXISTS brands;
CREATE TABLE brands 
(
    brand1      VARCHAR(20),
    brand2      VARCHAR(20),
    year        INT,
    custom1     INT,
    custom2     INT,
    custom3     INT,
    custom4     INT
);
INSERT INTO brands VALUES ('apple', 'samsung', 2020, 1, 2, 1, 2);
INSERT INTO brands VALUES ('samsung', 'apple', 2020, 1, 2, 1, 2);
INSERT INTO brands VALUES ('apple', 'samsung', 2021, 1, 2, 5, 3);
INSERT INTO brands VALUES ('samsung', 'apple', 2021, 5, 3, 1, 2);
INSERT INTO brands VALUES ('google', NULL, 2020, 5, 9, NULL, NULL);
INSERT INTO brands VALUES ('oneplus', 'nothing', 2020, 5, 9, 6, 3);

SELECT * FROM brands;
GO
------------------------------------------Solution 1-----------------------------------
SELECT REPLICATE('************************OUTPUT*******************************',1) 'Excepted OutPut'
GO
WITH CTE_Pair_Id as
(
SELECT *, CASE WHEN brand1 > brand2 THEN CONCAT(brand1,brand2,year) else CONCAT(brand2,brand1,year) END 'Pair_ID'

FROM brands
)
,CTE_RN as 
(
SELECT *,ROW_NUMBER() OVER(PARTITION BY CTE_Pair_Id.Pair_ID ORDER BY CTE_Pair_Id.year) 'Row_Number_Pair',
CASE WHEN custom1=custom3  AND custom2=custom4  THEN 'Cond-2-True'
WHEN custom1!=custom3  AND  custom2!=custom4 THEN 'Cond-3-True'
 else 'NoMatch' END 'Condition2&3'
FROM CTE_Pair_Id

)

SELECT brand1,brand2,year,custom1,custom2,custom3,custom4

FROM CTE_RN
WHERE (Row_Number_Pair=1) OR   ([Condition2&3]='Cond-3-True') OR  ([Condition2&3]='Cond-2-True' AND Row_Number_Pair=1 )
-----------------------------------------------------------END OF THE SOLUTION --------------------------------------------------

-----------------------------------------------------------Solution 2-----------------------------------------------------------
WITH cte_sol_2 as(
SELECT  *, 
CASE  WHEN  custom1 = custom3 and custom2 = custom4 then 1 else 0 end as custom_num_Flag,
row_number() over(order by year) as num from brands)

SELECT * FROM cte_sol_2

select brand1,brand2,year,custom1,custom2,custom3,custom4 from cte_sol_2 where num != 2 order by brand1;