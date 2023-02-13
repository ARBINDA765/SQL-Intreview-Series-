--SQL query to find employee who  got hike for consucutively  2 years
--BIG 4 Accountimg Firms SQL Data Analyst intreview question

USE [SSIS]
--DROP TABLE [EMP_EY]
GO

/****** Object:  Table [dbo].[EMP_EY]    Script Date: 13-02-2023 15:47:24 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

DELETE  EMP_EY WHERE emp_ID='EMP_3'AND salary=65000

CREATE TABLE [dbo].[EMP_EY](
	[emp_ID] [varchar](10) NULL,

	[salary] [int] NULL,
	[Increment_Date] [date] NULL
) ON [PRIMARY]
GO

INSERT INTO [dbo].[EMP_EY] VALUES ('EMP_1',60000,GETDATE()-1099)
INSERT INTO [dbo].[EMP_EY] VALUES ('EMP_1',70000,GETDATE()-739)
INSERT INTO [dbo].[EMP_EY] VALUES ('EMP_1',80000,GETDATE()-365)

INSERT INTO [dbo].[EMP_EY] VALUES ('EMP_2',60000,GETDATE()-1090)
INSERT INTO [dbo].[EMP_EY] VALUES ('EMP_2',65000,GETDATE()-749)
INSERT INTO [dbo].[EMP_EY] VALUES ('EMP_2',65000,GETDATE()-369)


INSERT INTO [dbo].[EMP_EY] VALUES ('EMP_3',60000,GETDATE()-1097)
INSERT INTO [dbo].[EMP_EY] VALUES ('EMP_3',65000,GETDATE()-739)
INSERT INTO [dbo].[EMP_EY] VALUES ('EMP_3',65000,GETDATE()-379)

---Solution-----------------------------
SELECT * FROM EMP_EY
GO
SELECT DISTINCT emp_ID FROM
(
SELECT *,LAG (YEAR(Increment_Date),1) OVER (PARTITION BY emp_id ORDER BY (YEAR(Increment_Date)) ) 'Last_Year',
LAG (YEAR(Increment_Date),2) OVER (PARTITION BY emp_id ORDER BY (YEAR(Increment_Date)) ) 'Last_to_Last_Year',

LAG (salary,1) OVER (PARTITION BY emp_id ORDER BY salary ) 'Last_Salary',
LAG (salary,2) OVER (PARTITION BY emp_id ORDER BY salary ) 'Last_to_Last_Salary'

FROM  EMP_EY
)Salary_Data
WHERE (salary >Last_Salary AND Last_Year=YEAR(Increment_Date)-1 )
AND(Last_Salary >Last_to_Last_Salary AND  Last_to_Last_Year=YEAR(Increment_Date)-2)


