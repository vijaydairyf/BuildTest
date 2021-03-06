/****** Object:  StoredProcedure [dbo].[sp_D_dsLoadAllBrand]    Script Date: 07/24/2013 08:51:32 ******/
DROP PROCEDURE [dbo].[sp_D_dsLoadAllBrand]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_D_dsLoadAllBrand]
AS
SELECT        TOP(1) 
              'ALL' AS RouteId, 
              'ALL' AS Route


UNION ALL

SELECT       LOWER (CONVERT(nvarchar(50), RouteID)) AS RouteId, Name AS Route
FROM            tblRoutes AS tblRoutes_1
WHERE tblRoutes_1.IM_Status = 1
ORDER BY Route
GO
