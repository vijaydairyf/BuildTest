/****** Object:  StoredProcedure [dbo].[sp_D_dsLoadAllCountry]    Script Date: 07/24/2013 08:51:32 ******/
DROP PROCEDURE [dbo].[sp_D_dsLoadAllCountry]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_D_dsLoadAllCountry]
as 
SELECT TOP(1)'ALL' as CountryId, 
             'ALL' AS CountryName

UNION ALL
SELECT lOWER(Convert(nvarchar(50),id)) as CountryId,
                           Name as CountryName
FROM     tblCountry AS tblCountry_1
WHERE tblCountry_1.IM_Status = 1
--ORDER BY Name
GO
