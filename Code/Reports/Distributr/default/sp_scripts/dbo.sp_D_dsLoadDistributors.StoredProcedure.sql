/****** Object:  StoredProcedure [dbo].[sp_D_dsLoadDistributors]    Script Date: 07/24/2013 08:51:32 ******/
DROP PROCEDURE [dbo].[sp_D_dsLoadDistributors]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_D_dsLoadDistributors]
AS

SELECT TOP(1) 
        'ALL' AS DistributorId,
        'ALL' AS Distributor, 
            0 AS  CostCentreType

UNION ALL

SELECT    LOWER(CONVERT(nvarchar(50), Id)) AS DistributorId,
                                       Name AS Distributor, 
                                       CostCentreType
FROM        tblCostCentre
WHERE        (CostCentreType = 2) AND tblCostCentre.IM_Status = 1
ORDER BY Distributor

--   Exec  [dbo].[sp_D_dsLoadDistributors]




GO
