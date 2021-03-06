/****** Object:  StoredProcedure [dbo].[ALLRoute]    Script Date: 07/24/2013 08:51:31 ******/
DROP PROCEDURE [dbo].[ALLRoute]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[ALLRoute]
(

@salesmanID as nvarchar(50),
@RDistributorID as nvarchar(50)
)
as 

if  @salesmanID='ALL'  begin set @salesmanID='%' end
if  @RDistributorID='ALL'  begin set @RDistributorID='%' end

select 'ALL' as Name,  'ALL' as RouteID, 'ALL' AS Salesman, 'ALL' AS SalesmanID, 
              'ALL' AS Distributor, 'ALL' AS DistributorID
               
union

SELECT TOP (100) PERCENT dbo.tblRoutes.Name, Convert(nvarchar(50),dbo.tblRoutes.RouteID) as RouteID, dbo.tblCostCentre.Name AS Salesman, Convert(nvarchar(50),dbo.tblCostCentre.Id) AS SalesmanID, 
               tblCostCentre_1.Name AS Distributor, Convert(nvarchar(50),tblCostCentre_1.Id) AS DistributorID
FROM  dbo.tblRoutes INNER JOIN
               dbo.tblSalemanRoute ON dbo.tblRoutes.RouteID = dbo.tblSalemanRoute.RouteId AND dbo.tblRoutes.RouteID = dbo.tblSalemanRoute.RouteId INNER JOIN
               dbo.tblCostCentre ON dbo.tblSalemanRoute.SalemanId = dbo.tblCostCentre.Id INNER JOIN
               dbo.tblCostCentre AS tblCostCentre_1 ON dbo.tblCostCentre.ParentCostCentreId = tblCostCentre_1.Id
WHERE (Convert(nvarchar(50),dbo.tblCostCentre.Id) LIKE ISNULL(@salesmanID, '%')) AND (tblCostCentre_1.Id LIKE ISNULL(@RDistributorID, '%'))
ORDER BY Name
GO
