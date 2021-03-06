/****** Object:  StoredProcedure [dbo].[sp_D_Distributor]    Script Date: 07/24/2013 08:51:32 ******/
DROP PROCEDURE [dbo].[sp_D_Distributor]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_D_Distributor]
as 
SELECT TOP (1) 'ALL' AS Name, 'ALL' AS ParentName, 'ALL' AS  Id

UNION 
SELECT TOP (100) PERCENT tblCostCentre_2.Name, tblCostCentre_1.Name AS ParentName, LOWER (CONVERT(nvarchar(50), tblCostCentre_2.Id)) AS Id
FROM     tblCostCentre AS tblCostCentre_2 LEFT OUTER JOIN
                  tblCostCentre AS tblCostCentre_1 ON tblCostCentre_2.ParentCostCentreId = tblCostCentre_1.Id
WHERE  (tblCostCentre_2.CostCentreType = 2) AND tblCostCentre_2.IM_Status = 1
ORDER BY Name
GO
