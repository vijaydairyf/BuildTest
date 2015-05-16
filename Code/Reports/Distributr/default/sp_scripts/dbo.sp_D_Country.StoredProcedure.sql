/****** Object:  StoredProcedure [dbo].[sp_D_Country]    Script Date: 07/24/2013 08:51:32 ******/
DROP PROCEDURE [dbo].[sp_D_Country]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_D_Country]
as 
SELECT TOP (1) id, 'ALL' AS Name
FROM     tblCountry
UNION ALL
SELECT id, Name
FROM     tblCountry AS tblCountry_1
WHERE tblCountry_1.IM_Status = 1
ORDER BY Name
GO
