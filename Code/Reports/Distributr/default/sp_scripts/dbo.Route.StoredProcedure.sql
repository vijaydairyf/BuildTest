/****** Object:  StoredProcedure [dbo].[Route]    Script Date: 07/24/2013 08:51:32 ******/
DROP PROCEDURE [dbo].[Route]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[Route]
(

@salesmanID as nvarchar(50),
@RDistributorID as nvarchar(50)
)
as 

if  @salesmanID='ALL'  begin set @salesmanID='%' end
if  @RDistributorID='ALL'  begin set @RDistributorID='%' end

SELECT TOP (100) PERCENT dbo.tblRoutes.Name, dbo.tblRoutes.RouteID, dbo.tblCostCentre.Name AS Salesman, dbo.tblCostCentre.Id AS SalesmanID, 
               tblCostCentre_1.Name AS Distributor, tblCostCentre_1.Id AS DistributorID
FROM  dbo.tblRoutes INNER JOIN
               dbo.tblSalemanRoute ON dbo.tblRoutes.RouteID = dbo.tblSalemanRoute.RouteId AND dbo.tblRoutes.RouteID = dbo.tblSalemanRoute.RouteId INNER JOIN
               dbo.tblCostCentre ON dbo.tblSalemanRoute.SalemanId = dbo.tblCostCentre.Id INNER JOIN
               dbo.tblCostCentre AS tblCostCentre_1 ON dbo.tblCostCentre.ParentCostCentreId = tblCostCentre_1.Id
WHERE (Convert(nvarchar(50),dbo.tblCostCentre.Id) LIKE ISNULL(@salesmanID, '%')) AND (tblCostCentre_1.Id LIKE ISNULL(@RDistributorID, '%'))
 
ORDER BY dbo.tblRoutes.Name
GO
