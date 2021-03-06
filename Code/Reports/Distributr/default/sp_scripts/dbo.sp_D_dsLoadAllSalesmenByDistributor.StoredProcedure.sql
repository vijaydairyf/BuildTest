/****** Object:  StoredProcedure [dbo].[sp_D_dsLoadAllSalesmenByDistributor]    Script Date: 07/24/2013 08:51:32 ******/
DROP PROCEDURE [dbo].[sp_D_dsLoadAllSalesmenByDistributor]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_D_dsLoadAllSalesmenByDistributor]
AS

SELECT  TOP (1)  'ALL' AS SalesmanId, 
                ' ALL' AS Salesman, 
                     0 AS CostCentreType,
                ' ALL' AS DistributorId, 
                ' ALL' AS DistributorName, 
                     0 AS DistributorCCtype 
UNION ALL
SELECT     CONVERT(nvarchar(50), sm.Id) AS SalesmanId, 
                                                  sm.Name AS Salesman, 
                                                  sm.CostCentreType, 
              CONVERT(nvarchar(50),dbo.tblCostCentre.Id) AS DistributorId, 
                                    dbo.tblCostCentre.Name AS DistributorName, 
                      dbo.tblCostCentre.CostCentreType AS DistributorCCtype
FROM         dbo.tblCostCentre AS sm INNER JOIN
              dbo.tblCostCentre ON sm.ParentCostCentreId = dbo.tblCostCentre.Id
WHERE     (sm.CostCentreType = 4) AND (dbo.tblCostCentre.CostCentreType = 2) AND sm.IM_Status = 1
ORDER BY Salesman
GO
