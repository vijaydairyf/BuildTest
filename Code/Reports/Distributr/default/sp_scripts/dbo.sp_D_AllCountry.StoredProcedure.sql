/****** Object:  StoredProcedure [dbo].[sp_D_AllCountry]    Script Date: 07/24/2013 08:51:32 ******/
DROP PROCEDURE [dbo].[sp_D_AllCountry]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_D_AllCountry]
as 
SELECT TOP(1)'ALL' as id, 'ALL' AS Name

UNION 
SELECT Convert(nvarchar(50),id) as id, Name
FROM     tblCountry AS tblCountry_1
WHERE tblCountry_1.IM_Status = 1
ORDER BY Name
GO
