/****** Object:  StoredProcedure [dbo].[sp_D_Outlets]    Script Date: 07/24/2013 08:51:32 ******/
DROP PROCEDURE [dbo].[sp_D_Outlets]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_D_Outlets]
as 


SELECT    TOP (1) 'ALL' AS OutletId, 
                  'ALL' AS Outlet, 
                      0 AS ccOutlet


UNION ALL

SELECT    CONVERT(nvarchar(50), Id) AS OutletId, Name AS Outlet, CostCentreType AS ccOutlet
FROM        tblCostCentre
WHERE     (CostCentreType = 5) 
ORDER BY Outlet
GO
