--USE [ag4]
--GO
/****** Object:  StoredProcedure [dbo].[SP_A_Centres_R]    Script Date: 11/27/2013 16:40:06 ******/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
--ALTER Procedure [dbo].[SP_A_Centres_R]


DROP PROCEDURE [dbo].[SP_A_Centres_R]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_A_Centres_R]

as

SELECT TOP (1) 'ALL' AS Id, 'ALL' AS name

UNION 

SELECT LOWER(CONVERT(nvarchar(50), Id)) AS Id, name
FROM   dbo.tblCentre
order by name

