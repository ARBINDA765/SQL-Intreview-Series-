--LinkedIn is a professional social networking app.
--They want to give top voice badge to their best creators to encourage them to create more quality content.
--A creator qualifies for the badge if he/she satisfies following criteria. 
--1- Creator should have more then 50k followers.
--2- Creator should have more than 100k impressions on the posts that they published in the month of Dec-2023.
--3- Creator should have published atleast 3 posts in Dec-2023.
--Write a SQL to get the list of top voice creators name along with no of posts and impressions by them in the month of Dec-2023.

USE SSIS
CREATE TABLE Creators (
    creator_id INT PRIMARY KEY,
    creator_name VARCHAR(255),
    followers INT
);

INSERT INTO Creators (creator_id, creator_name, followers)
VALUES 
    (1, 'Pavitra Nataraj', 900),
    (2, 'Ankit Bansal', 150000),
    (3, 'Rahul Gupta', 70000),
    (4, 'Shomil Sharma', 45000);
CREATE TABLE Posts (
    creator_id INT,
    post_id VARCHAR(50),
    publish_date DATE,
    impressions INT
);

INSERT INTO Posts (creator_id, post_id, publish_date, impressions)
VALUES 
    (1, 'p1', '2023-12-03', 120000),
    (2, 'p2', '2023-12-02', 51000),
    (2, 'p3', '2023-12-09', 39000),
    (2, 'p4', '2023-12-20', 42000),
    (3, 'p5', '2023-11-20', 22000),
    (3, 'p6', '2023-12-04', 32000),
    (3, 'p7', '2023-12-10', 22000),
    (3, 'p8', '2023-12-21', NULL);


SELECT * FROM creators
SELECT * FROM posts

SELECT c.creator_name,COUNT(p.post_id) AS no_of_posts, SUM(p.impressions) AS total_impressions
--,CONCAT(DATE_PART('MONTH',publish_date),'-',DATE_PART('YEAR',publish_date)) AS month_year
FROM creators c LEFT OUTER JOIN posts p
ON c.creator_id = p.creator_id
WHERE CONCAT(DATEPART(MONTH,publish_date),'-',DATEPART(YEAR,publish_date))='12-2023'
GROUP BY c.creator_name
HAVING COUNT(p.post_id)>=3 AND SUM(p.impressions)>= 100000 AND MAX(followers)>=50000;

---Approach-2

WITH FilteredPosts AS (
    SELECT 
        creator_id,
        COUNT(post_id) AS no_of_posts,
        SUM(impressions) AS total_impressions
    FROM 
        posts
    WHERE 
        MONTH(publish_date) = 12 AND YEAR(publish_date) = 2023
    GROUP BY 
        creator_id
    HAVING 
        COUNT(post_id) >= 3 AND SUM(impressions) >= 100000
)
SELECT 
    c.creator_name,
    fp.no_of_posts,
    fp.total_impressions
FROM 
    creators c
JOIN 
    FilteredPosts fp ON c.creator_id = fp.creator_id
WHERE 
    EXISTS (
        SELECT 1 
        FROM creators 
        WHERE creator_id = c.creator_id AND followers >= 50000
    );

/*
Subquery: The subquery SELECT 1 FROM creators WHERE creator_id = c.creator_id AND followers >= 50000 is used to filter the creators table based
on the following conditions:

creator_id = c.creator_id: This condition ensures that we're only considering rows from the creators table where the creator_id matches the creator_id from the outer query (c.creator_id). This links the rows in the outer query to the rows in the subquery.

followers >= 50000: This condition filters the rows based on the followers column, ensuring that only rows with followers greater than or equal to 50,000 are considered.
Usage: 
The EXISTS keyword is typically used in the WHERE clause of a query to filter rows from the outer query based on the existence of rows returned by the subquery. In this case, it ensures that only rows from the creators table where the followers count is greater than or equal to 50,000 are included in the final result set.
Efficiency: The EXISTS clause is efficient because it stops processing the subquery as soon as it finds the first matching row.

It doesn't need to retrieve all matching rows; it just needs to determine if at least one row exists. This can be beneficial for performance, 
especially in cases where the subquery returns a large number of rows.
In summary, the EXISTS clause is used to filter rows from the outer query based on the existence of rows returned by the subquery, and it can help improve query performance by efficiently checking for the existence of matching rows.
*/


