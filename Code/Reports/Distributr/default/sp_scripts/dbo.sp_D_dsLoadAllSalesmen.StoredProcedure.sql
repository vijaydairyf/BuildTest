/****** Object:  StoredProcedure [dbo].[sp_D_dsLoadAllSalesmen]    Script Date: 07/24/2013 08:51:32 ******/
DROP PROCEDURE [dbo].[sp_D_dsLoadAllSalesmen]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_D_dsLoadAllSalesmen]
AS

SELECT  TOP (1) 'ALL' AS SalesmanId, 
                'ALL' AS Salesman, 
                    0 AS CostCentreType
UNION ALL
SELECT        CONVERT(nvarchar(50), Id) AS SalesmanId, 
                                   Name AS Salesman,
                                      CostCentreType
FROM       tblCostCentre AS tblCostCentre_1
WHERE        (CostCentreType = 4)and tblCostCentre_1.IM_Status = 1
ORDER BY Salesman
GO
