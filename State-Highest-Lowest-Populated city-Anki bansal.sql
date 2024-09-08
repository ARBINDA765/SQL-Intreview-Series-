USE SSIS

CREATE TABLE city_population (
    state VARCHAR(50),
    city VARCHAR(50),
    population INT
);

-- Insert the data
INSERT INTO city_population (state, city, population) VALUES ('haryana', 'ambala', 100);
INSERT INTO city_population (state, city, population) VALUES ('haryana', 'panipat', 200);
INSERT INTO city_population (state, city, population) VALUES ('haryana', 'gurgaon', 300);
INSERT INTO city_population (state, city, population) VALUES ('punjab', 'amritsar', 150);
INSERT INTO city_population (state, city, population) VALUES ('punjab', 'ludhiana', 400);
INSERT INTO city_population (state, city, population) VALUES ('punjab', 'jalandhar', 250);
INSERT INTO city_population (state, city, population) VALUES ('maharashtra', 'mumbai', 1000);
INSERT INTO city_population (state, city, population) VALUES ('maharashtra', 'pune', 600);
INSERT INTO city_population (state, city, population) VALUES ('maharashtra', 'nagpur', 300);
INSERT INTO city_population (state, city, population) VALUES ('karnataka', 'bangalore', 900);
INSERT INTO city_population (state, city, population) VALUES ('karnataka', 'mysore', 400);
INSERT INTO city_population (state, city, population) VALUES ('karnataka', 'mangalore', 200);

SELECT * FROM city_population
--------------Solution 1-------------------------------------
--using Window Function


SELECT state,
MAX(CASE WHEN population=Max_Populated_City THEN city else null END) AS "Highest_Populated_City",
MIN(CASE WHEN population=Min_Populated_City THEN city else null END) AS "Lowest_Populated_City"
FROM 
(
SELECT *,MAX(population) OVER(PARTITION BY state) as "Max_Populated_City",
MIN(population) OVER(PARTITION BY state) as "Min_Populated_City"

 FROM city_population
 )A
 GROUP BY state














