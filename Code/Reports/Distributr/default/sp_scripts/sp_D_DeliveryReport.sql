IF  EXISTS (SELECT * FROM sys.views WHERE object_id = OBJECT_ID(N'[dbo].[sp_D_DeliveryReport]'))
DROP PROCEDURE [dbo].[sp_D_DeliveryReport]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_D_DeliveryReport]

(

@startDate as date,
@endDate as date,
@distributorId AS NVARCHAR(50),
@salesmanId AS NVARCHAR(50),
@routeId AS NVARCHAR(50),
@outletId AS NVARCHAR(50),
@brandId AS NVARCHAR(50),
@deliveryRef AS NVARCHAR(50)

)

AS
if ltrim(rtrim(@distributorId))='ALL'  begin set @distributorId='%' end
if ltrim(rtrim(@salesmanId))='ALL'  begin set @salesmanId='%' end
if ltrim(rtrim(@routeId))='ALL'  begin set @routeId='%' end
if ltrim(rtrim(@outletId))='ALL'  begin set @outletId='%' end
if ltrim(rtrim(@brandId))='ALL'  begin set @brandId='%' end
if ltrim(rtrim(@deliveryRef))='ALL'  begin set @deliveryRef='%' end	

SELECT     dbo.tblDocument.Id AS DocId,
           dbo.tblDocument.DocumentTypeId, 
           dbo.tblDocument.DocumentReference,
           dbo.tblDocument.OrderOrderTypeId, 
           dbo.tblLineItems.Quantity,
           dbo.tblLineItems.Value,
           dbo.tblLineItems.Vat,
           dbo.tblCostCentre.Id AS SalesmanId,
           dbo.tblCostCentre.Name AS Salesman, 
           dbo.tblCostCentre.CostCentreType AS CCsalesman,
           tblCostCentre_1.Id AS DistributorId,
           tblCostCentre_1.Name AS Distributor, 
           tblCostCentre_1.CostCentreType AS CCdistributor,
           dbo.tblProductBrand.id AS BrandId,
           dbo.tblProductBrand.name AS Brand,
           dbo.tblDocument.DocumentParentId, 
           tblDocument_1.DocumentReference AS DeliveryDoc,
           tblDocument_1.Id AS DeliveryId,
           tblCostCentre_2.Name AS Outlet,
           tblCostCentre_2.Id AS OutletId, 
           tblCostCentre_2.CostCentreType AS CCoutlet,
           dbo.tblRoutes.RouteID AS RouteId,
           dbo.tblRoutes.Name AS Route,
           dbo.tblDocument.SendDateTime
           
FROM         dbo.tblDocument INNER JOIN
                      dbo.tblLineItems ON dbo.tblDocument.Id = dbo.tblLineItems.DocumentID INNER JOIN
                      dbo.tblCostCentre ON dbo.tblDocument.DocumentIssuerCostCentreId = dbo.tblCostCentre.Id INNER JOIN
                      dbo.tblCostCentre AS tblCostCentre_1 ON dbo.tblDocument.DocumentRecipientCostCentre = tblCostCentre_1.Id INNER JOIN
                      dbo.tblProduct ON dbo.tblLineItems.ProductID = dbo.tblProduct.id INNER JOIN
                      dbo.tblProductBrand ON dbo.tblProduct.BrandId = dbo.tblProductBrand.id INNER JOIN
                      dbo.tblDocument AS tblDocument_1 ON dbo.tblDocument.DocumentParentId = tblDocument_1.Id INNER JOIN
                      dbo.tblCostCentre AS tblCostCentre_2 ON tblDocument_1.OrderIssuedOnBehalfOfCC = tblCostCentre_2.Id INNER JOIN
                      dbo.tblRoutes ON tblCostCentre_2.RouteId = dbo.tblRoutes.RouteID
                      
WHERE     (dbo.tblDocument.DocumentTypeId = 2)
           AND (dbo.tblDocument.OrderOrderTypeId = 2)
           AND (dbo.tblCostCentre.CostCentreType = 4)
           AND (tblCostCentre_1.CostCentreType = 2)
           AND(Convert(nvarchar(26),dbo.tblDocument.SendDateTime,23) BETWEEN @startDate AND @endDate)
           AND(CONVERT(NVARCHAR(50),tblCostCentre_1.Id)LIKE ISNULL(@distributorId, N'%'))
           AND(CONVERT(NVARCHAR(50),dbo.tblCostCentre.Id)LIKE ISNULL(@salesmanId, N'%'))
           AND(CONVERT(NVARCHAR(50),dbo.tblRoutes.RouteID)LIKE ISNULL(@routeId, N'%'))
           AND(CONVERT(NVARCHAR(50),tblCostCentre_2.Id)LIKE ISNULL(@outletId, N'%'))
           AND(CONVERT(NVARCHAR(50),dbo.tblProductBrand.id)LIKE ISNULL(@brandId, N'%'))
           AND(CONVERT(NVARCHAR(50),tblDocument_1.DocumentReference)LIKE ISNULL(@deliveryRef, N'%'))
  
  -- Exec   [dbo].[sp_D_DeliveryReport] @distributorId='ALL',@salesmanId='ALL',@routeId='ALL',@outletId='ALL',@brandId='ALL',@startDate='1-Jan-2013',@endDate='1-Dec-2014',@deliveryRef='ALL'
  
       
          Go
                   