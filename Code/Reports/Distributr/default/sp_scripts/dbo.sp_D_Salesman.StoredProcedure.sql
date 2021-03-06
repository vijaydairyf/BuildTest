/****** Object:  StoredProcedure [dbo].[sp_D_Salesman]    Script Date: 07/24/2013 08:51:32 ******/
DROP PROCEDURE [dbo].[sp_D_Salesman]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_D_Salesman]
as 
SELECT  ' ALL' AS  Name, 'ALL' AS  ParentName, 'ALL' AS Id

union all

SELECT TOP (100) PERCENT tblCostCentre.Name, tblCostCentre_1.Name AS ParentName, LOWER (CONVERT(nvarchar(50),tblCostCentre.Id)) Id
FROM     tblCostCentre LEFT OUTER JOIN
                  tblCostCentre AS tblCostCentre_1 ON tblCostCentre.ParentCostCentreId = tblCostCentre_1.Id
WHERE  (tblCostCentre.CostCentreType =4)
ORDER BY Name
GO
