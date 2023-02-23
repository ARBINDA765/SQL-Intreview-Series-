
----SQL Data Analyst intreview question
---Average distance between source and destination  on multiple route 
--Asked by a leading Bank 

USE [SSIS]
GO

/****** Object:  Table [dbo].[source_dest_distance]    Script Date: 23-02-2023 18:43:45 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[source_dest_distance](
	[source] [varchar](20) NULL,
	[destination] [varchar](20) NULL,
	[distance] [int] NULL
) ON [PRIMARY]
GO


INSERT INTO source_dest_distance values('Bangalore','Hyderbad',575)
INSERT INTO source_dest_distance values('Hyderbad','Bangalore',580)
INSERT INTO source_dest_distance values('Hyderbad','Bangalore',590)

INSERT INTO source_dest_distance values('Mumbai','Delhi',1400)
INSERT INTO source_dest_distance values('Mumbai','Delhi',1500)
INSERT INTO source_dest_distance values('Delhi','Mumbai',1480)

INSERT INTO source_dest_distance values('Chennai','Pune',1200)

INSERT INTO source_dest_distance values('Pune','Chennai',1400)

------------------SOLUTION  START -------------------------------

USE SSIS
SELECT * FROM source_dest_distance

WITH CTE_A AS (

SELECT source,destination,sum(distance) as 'total_dist',count(1) as 'No of route',row_number() over (ORDER BY source) id

FROM source_dest_distance
group by source,destination
)

SELECT T1.source,T1.destination ,((T1.total_dist+T2.total_dist)/(T1.[No of route]+T2.[No of route])) as 'Avg_distance'
FROM CTE_A T1 INNER JOIN CTE_A T2 ON 
T1.source=T2.destination AND T1.id <T2.id 


------------------END OF SOLUTION-----------------------


    