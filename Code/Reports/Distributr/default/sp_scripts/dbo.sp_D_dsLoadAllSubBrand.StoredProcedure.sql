/****** Object:  StoredProcedure [dbo].[sp_D_dsLoadAllSubBrand]    Script Date: 07/24/2013 08:51:32 ******/
DROP PROCEDURE [dbo].[sp_D_dsLoadAllSubBrand]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_D_dsLoadAllSubBrand]
AS
SELECT TOP (1) 'ALL' AS subBrandId, 
               'ALL' AS SubBrand
UNION all
SELECT DISTINCT CONVERT(nvarchar(50), tblProductFlavour_1.id) AS subBrandId, 
                                     tblProductFlavour_1.name AS SubBrand
FROM            tblProductFlavour AS tblProductFlavour_1 INNER JOIN
                       tblProduct AS tblProduct_1 ON tblProductFlavour_1.id = tblProduct_1.FlavourId
WHERE tblProductFlavour_1.IM_Status = 1
ORDER BY SubBrand
GO
