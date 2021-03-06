/****** Object:  StoredProcedure [dbo].[sp_D_dsLoadSalesmen]    Script Date: 07/24/2013 08:51:32 ******/
DROP PROCEDURE [dbo].[sp_D_dsLoadSalesmen]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_D_dsLoadSalesmen]
AS
SELECT        Id AS salesmanId,
            Name AS salesman, 
                   CostCentreType
FROM            tblCostCentre
WHERE        (CostCentreType = 4)
AND tblCostCentre.IM_Status = 1 
ORDER BY salesman
GO
