USE SSIS
------------------------------

----------------Sample Script-------------------------

/*The LinkedIn Creator team is looking for power creators who use their personal profile as a company 
--or influencer page. 
--This means that if someone's Linkedin page has more followers than all the company they work for, 
--we can safely assume that person is a Power Creator.

--Write a query to return the IDs of these LinkedIn power creators in ascending order.

--Assumptions:

--A person can work at multiple companies.
--In the case of multiple companies, WE NEED TO DO SUM OF ALL THE COMPANY'S FOLLOWERS.'''*/

DROP TABLE IF EXISTS personal_profiles
CREATE TABLE personal_profiles(
Profile_id int,
Name varchar(255),
Followers int
);
INSERT INTO personal_profiles (Profile_id, Name, Followers)
VALUES
('1','Nick Singh','92000'),
('2','Zach Wilson','199000'),
('3','Daliana Liu','171000'),
('4','Ravit Jain','107000'),
('5','Vin Vashistha','139000'),
('6','Susan Wojcicki','39000'),
('7','Arabinda Wojcicki','60909');

--------------------------------------------------
DROP TABLE IF EXISTS employee_company
CREATE TABLE employee_company(
Personal_profile_id int,
Company_id int);
INSERT INTO employee_company (Personal_profile_id,Company_id)
VALUES
('1','4'),
('1','9'),
('2','2'),
('3','1'),
('4','3'),
('5','6'),
('6','5');

---------------------------------------------------------------------------------
DROP TABLE IF EXISTS company_pages
CREATE TABLE company_pages(
Company_id int,
Name varchar(255),
Followers NVARCHAR(255) 
);

INSERT INTO company_pages (Company_id ,Name, Followers)
VALUES
('1','The Data Science Podcast','8000'),
('2','Airbnb','700000'),
('3','The Ravit Show','6000'),
('4','DataLemur','200'),
('5','YouTube','1600000'),
('6','The Data Science Vin','4500'),
('9','Ace The Data Science Interview','4479');

---------------------------------------------------------------------------------------
SELECT * FROM personal_profiles
SELECT * FROM employee_company
SELECT * FROM company_pages

---------------------------------------------------------------------

SELECT * FROM personal_profiles
--------------------------------Solution 1------------------------------
GO
WITH CTE_A AS (
SELECT ec.Personal_profile_id, MAX(cp.Followers) AS max_followers FROM employee_company ec
INNER JOIN company_pages cp ON ec.Company_id = cp.Company_id
GROUP BY ec.Personal_profile_id
) 

SELECT pp.Profile_id
FROM  personal_profiles pp 
INNER JOIN CTE_A ON pp.Profile_id = CTE_A.Personal_profile_id
WHERE pp.Followers > CTE_A.max_followers
-------------------------------Solution 2-----------------

WITH CTE_A_B as 
(
SELECT employee_company.Personal_profile_id,MAX(company_pages.Followers) 'Company_Max_Followers'    FROM employee_company
INNER   JOIN company_pages ON 
employee_company.Company_id=company_pages.Company_id

GROUP BY employee_company.Personal_profile_id
)
SELECT * FROM CTE_A_B
INNER   JOIN personal_profiles ON personal_profiles.Profile_id=CTE_A_B.Personal_profile_id
AND personal_profiles.Followers>CTE_A_B.Company_Max_Followers

