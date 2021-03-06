/****** Object:  StoredProcedure [dbo].[sp_D_GetOrderBySubBrand]    Script Date: 07/24/2013 08:51:32 ******/
DROP PROCEDURE [dbo].[sp_D_GetOrderBySubBrand]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_D_GetOrderBySubBrand]

(

@startDate as date,
@endDate as date,
@distributorId AS NVARCHAR(50),
@salesmanId AS NVARCHAR(50),
@routeId AS NVARCHAR(50),
@outletId AS NVARCHAR(50),
@brandId AS NVARCHAR(50),
@productId AS NVARCHAR(50),
@subBrandId AS NVARCHAR(50),
@packagingId AS NVARCHAR(50),
@ordersRef AS NVARCHAR(50)

)


AS

if ltrim(rtrim(@distributorId))='ALL'  begin set @distributorId='%' end
if ltrim(rtrim(@salesmanId))='ALL'  begin set @salesmanId='%' end
if ltrim(rtrim(@routeId))='ALL'  begin set @routeId='%' end
if ltrim(rtrim(@outletId))='ALL'  begin set @outletId='%' end
if ltrim(rtrim(@brandId))='ALL'  begin set @brandId='%' end
if ltrim(rtrim(@productId))='ALL'  begin set @productId='%' end
if ltrim(rtrim(@subBrandId))='ALL'  begin set @subBrandId='%' end
if ltrim(rtrim(@packagingId))='ALL'  begin set @packagingId='%' end
if ltrim(rtrim(@ordersRef))='ALL'  begin set @ordersRef='%' end

SELECT     dbo.tblDocument.DocumentReference, 
           dbo.tblDocument.Id, 
		   dbo.tblDocument.DocumentTypeId,
		   dbo.tblDocument.OrderOrderTypeId, 
		   dbo.tblDocument.SendDateTime, 
           dbo.tblLineItems.Value, 
		   dbo.tblLineItems.Quantity, 
		   dbo.tblLineItems.Vat, 
		   dbo.tblCostCentre.Id AS distributorId, 
		   tblCostCentre_1.Id AS salesmanId, 
           dbo.tblCostCentre.Name AS distributor, 
		   tblCostCentre_1.Name AS salesman, 
		   dbo.tblCostCentre.CostCentreType AS ccdistributor, 
           tblCostCentre_1.CostCentreType AS ccSaleman, 
		   dbo.tblProductBrand.name AS Brand, 
		   dbo.tblProductBrand.id AS BrandId, 
		   dbo.tblProductFlavour.name AS SubBrand, 
           dbo.tblProductFlavour.id AS SubBrandId, 
		   dbo.tblProduct.Description AS Product, 
		   dbo.tblProduct.id AS ProductId, 
		   dbo.tblProductPackaging.Id AS PackagingId, 
           dbo.tblProductPackaging.Name AS Packaging, 
		   tblCostCentre_2.Id AS OutletId, 
		   tblCostCentre_2.Name AS Outlet, 
		   tblCostCentre_2.CostCentreType AS ccOutlet, 
           dbo.tblRoutes.RouteID AS RouteId, 
		   dbo.tblRoutes.Name AS Route, 
		   @startDate as startDate, 
		   @endDate as endDate,
           CASE
                       WHEN DocumentStatusId = 0 THEN 'New'        
                       WHEN DocumentStatusId = 1 THEN 'Confirmed'
                       WHEN DocumentStatusId = 2 THEN 'Submitted'
                       WHEN DocumentStatusId = 3 THEN 'Cancelled'
                       WHEN DocumentStatusId = 4 THEN 'Approved'
                       WHEN DocumentStatusId = 5 THEN 'Rejected'
                       WHEN DocumentStatusId = 99 THEN 'Closed'
                      END,
            dbo.tblDocument.DocumentDateIssued,
			ROUND(((dbo.tblLineItems.Quantity)*(dbo.tblLineItems.Value + dbo.tblLineItems.Vat)) +  (dbo.tblLineItems.ProductDiscount*dbo.tblLineItems.Quantity) ,2,1) as GrossAmount,
		    dbo.udf_D_RoundOff((dbo.tblLineItems.Quantity*dbo.tblLineItems.Value)) as NetRoundOff,
		    ROUND((dbo.tblLineItems.Quantity*dbo.tblLineItems.Value),2,1) as NetTruncate,
		    dbo.udf_D_RoundOff(((dbo.tblLineItems.Quantity)*(dbo.tblLineItems.Value + dbo.tblLineItems.Vat))) as GrossRoundOff

                           
FROM         dbo.tblCostCentre AS tblCostCentre_1 INNER JOIN
                      dbo.tblLineItems INNER JOIN
                      dbo.tblDocument ON dbo.tblLineItems.DocumentID = dbo.tblDocument.Id INNER JOIN
                      dbo.tblCostCentre ON dbo.tblDocument.DocumentIssuerCostCentreId = dbo.tblCostCentre.Id INNER JOIN
                      dbo.tblProduct INNER JOIN
                      dbo.tblProductBrand ON dbo.tblProduct.BrandId = dbo.tblProductBrand.id ON dbo.tblLineItems.ProductID = dbo.tblProduct.id ON 
                      tblCostCentre_1.Id = dbo.tblDocument.DocumentRecipientCostCentre INNER JOIN
                      dbo.tblProductFlavour ON dbo.tblProduct.FlavourId = dbo.tblProductFlavour.id INNER JOIN
                      dbo.tblProductPackaging ON dbo.tblProduct.PackagingId = dbo.tblProductPackaging.Id INNER JOIN
                      dbo.tblCostCentre AS tblCostCentre_2 ON dbo.tblCostCentre.Id = tblCostCentre_2.ParentCostCentreId AND 
                      dbo.tblDocument.OrderIssuedOnBehalfOfCC = tblCostCentre_2.Id INNER JOIN
                      dbo.tblRoutes ON tblCostCentre_2.RouteId = dbo.tblRoutes.RouteID

WHERE     (dbo.tblDocument.DocumentTypeId = 1) 
      AND (dbo.tblDocument.OrderOrderTypeId = 3) 
	  AND (dbo.tblCostCentre.CostCentreType = 2) 
      AND (tblCostCentre_1.CostCentreType = 4)
	  AND (tblCostCentre_2.CostCentreType = 5)
      AND  DocumentStatusId = 4 
	  AND dbo.tblDocument.DocumentParentId = dbo.tblDocument.Id
                         AND(Convert(nvarchar(26),dbo.tblDocument.DocumentDateIssued,23) BETWEEN @startDate AND @endDate) 
                         AND(CONVERT(NVARCHAR(50),dbo.tblCostCentre.Id)LIKE ISNULL(@distributorId, N'%'))
                         AND(CONVERT(NVARCHAR(50),tblCostCentre_1.Id)LIKE ISNULL(@salesmanId, N'%'))
                         AND(CONVERT(NVARCHAR(50),dbo.tblRoutes.RouteID)LIKE ISNULL(@routeId, N'%'))
                         AND(CONVERT(NVARCHAR(50),tblCostCentre_2.Id)LIKE ISNULL(@outletId, N'%'))
                         AND(CONVERT(NVARCHAR(50),dbo.tblProductBrand.id)LIKE ISNULL(@brandId, N'%'))
                         AND(CONVERT(NVARCHAR(50),dbo.tblProduct.id)LIKE ISNULL(@productId, N'%'))
                         AND(CONVERT(NVARCHAR(50),dbo.tblProductFlavour.id)LIKE ISNULL(@subBrandId, N'%'))
                         AND(CONVERT(NVARCHAR(50),dbo.tblProductPackaging.Id)LIKE ISNULL(@packagingId, N'%'))
                         AND(CONVERT(NVARCHAR(50), dbo.tblDocument.DocumentReference)LIKE ISNULL(@ordersRef, N'%'))

UNION


SELECT     dbo.tblDocument.DocumentReference, dbo.tblDocument.Id, dbo.tblDocument.DocumentTypeId, dbo.tblDocument.OrderOrderTypeId, dbo.tblDocument.SendDateTime, 
                      dbo.tblLineItems.Value, dbo.tblLineItems.Quantity, dbo.tblLineItems.Vat, dbo.tblCostCentre.Id AS distributorId, tblCostCentre_1.Id AS salesmanId, 
                      dbo.tblCostCentre.Name AS distributor, tblCostCentre_1.Name AS salesman, dbo.tblCostCentre.CostCentreType AS ccdistributor, 
                      tblCostCentre_1.CostCentreType AS ccSaleman, dbo.tblProductBrand.name AS Brand, dbo.tblProductBrand.id AS BrandId, dbo.tblProductFlavour.name AS SubBrand, 
                      dbo.tblProductFlavour.id AS SubBrandId, dbo.tblProduct.Description AS Product, dbo.tblProduct.id AS ProductId, dbo.tblProductPackaging.Id AS PackagingId, 
                      dbo.tblProductPackaging.Name AS Packaging,tblCostCentre_2.Id AS OutletId, tblCostCentre_2.Name AS Outlet, tblCostCentre_2.CostCentreType AS ccOutlet, 
                      dbo.tblRoutes.RouteID AS RouteId, dbo.tblRoutes.Name AS Route, @startDate as startDate, @endDate as endDate,
                      CASE
                       WHEN DocumentStatusId = 0 THEN 'New'        
                       WHEN DocumentStatusId = 1 THEN 'Confirmed'
                       WHEN DocumentStatusId = 2 THEN 'Submitted'
                       WHEN DocumentStatusId = 3 THEN 'Cancelled'
                       WHEN DocumentStatusId = 4 THEN 'Approved'
                       WHEN DocumentStatusId = 5 THEN 'Rejected'
                       WHEN DocumentStatusId = 99 THEN 'Closed'
                      END,
                      dbo.tblDocument.DocumentDateIssued,
					  ROUND(((dbo.tblLineItems.Quantity)*(dbo.tblLineItems.Value + dbo.tblLineItems.Vat)) +  (dbo.tblLineItems.ProductDiscount*dbo.tblLineItems.Quantity) ,2,1) as GrossAmount,
					   dbo.udf_D_RoundOff((dbo.tblLineItems.Quantity*dbo.tblLineItems.Value)) as NetRoundOff,
					   ROUND((dbo.tblLineItems.Quantity*dbo.tblLineItems.Value),2,1) as NetTruncate,
					   dbo.udf_D_RoundOff(((dbo.tblLineItems.Quantity)*(dbo.tblLineItems.Value + dbo.tblLineItems.Vat))) as GrossRoundOff

                           
FROM         dbo.tblProductFlavour 
 JOIN        dbo.tblLineItems 
 JOIN        dbo.tblDocument ON dbo.tblLineItems.DocumentID = dbo.tblDocument.Id 
 JOIN        dbo.tblCostCentre ON dbo.tblDocument.DocumentRecipientCostCentre = dbo.tblCostCentre.Id INNER JOIN
                      dbo.tblProduct INNER JOIN
                      dbo.tblProductBrand ON dbo.tblProduct.BrandId = dbo.tblProductBrand.id ON dbo.tblLineItems.ProductID = dbo.tblProduct.id ON 
                      dbo.tblProductFlavour.id = dbo.tblProduct.FlavourId INNER JOIN
                      dbo.tblProductPackaging ON dbo.tblProduct.PackagingId = dbo.tblProductPackaging.Id INNER JOIN
                      dbo.tblCostCentre AS tblCostCentre_1 ON dbo.tblDocument.DocumentIssuerCostCentreId = tblCostCentre_1.Id INNER JOIN
                      dbo.tblCostCentre AS tblCostCentre_2 ON dbo.tblCostCentre.Id = tblCostCentre_2.ParentCostCentreId 
                      AND 
                      dbo.tblDocument.OrderIssuedOnBehalfOfCC = tblCostCentre_2.Id INNER JOIN
                      dbo.tblRoutes ON tblCostCentre_2.RouteId = dbo.tblRoutes.RouteID
WHERE      (dbo.tblDocument.DocumentTypeId = 1) 
       AND (dbo.tblDocument.OrderOrderTypeId = 3)
       AND (dbo.tblCostCentre.CostCentreType = 2) 
       AND (tblCostCentre_1.CostCentreType = 4)
       AND (tblCostCentre_2.CostCentreType = 5)
	   AND  DocumentStatusId = 4 
	   AND dbo.tblDocument.DocumentParentId = dbo.tblDocument.Id
                         AND(Convert(nvarchar(26),dbo.tblDocument.DocumentDateIssued,23) BETWEEN @startDate AND @endDate) 
                         AND(CONVERT(NVARCHAR(50),dbo.tblCostCentre.Id)LIKE ISNULL(@distributorId, N'%'))
                         AND(CONVERT(NVARCHAR(50),tblCostCentre_1.Id)LIKE ISNULL(@salesmanId, N'%'))
                         AND(CONVERT(NVARCHAR(50),dbo.tblRoutes.RouteID)LIKE ISNULL(@routeId, N'%'))
                         AND(CONVERT(NVARCHAR(50),tblCostCentre_2.Id)LIKE ISNULL(@outletId, N'%'))
                         AND(CONVERT(NVARCHAR(50),dbo.tblProductBrand.id)LIKE ISNULL(@brandId, N'%'))
                         AND(CONVERT(NVARCHAR(50),dbo.tblProduct.id)LIKE ISNULL(@productId, N'%'))
                         AND(CONVERT(NVARCHAR(50),dbo.tblProductFlavour.id)LIKE ISNULL(@subBrandId, N'%'))
                         AND(CONVERT(NVARCHAR(50), dbo.tblDocument.DocumentReference)LIKE ISNULL(@ordersRef, N'%'))
                         AND(CONVERT(NVARCHAR(50),dbo.tblProductPackaging.Id)LIKE ISNULL(@packagingId, N'%'))
                         
 --  Exec    [dbo].[sp_D_GetOrderBySubBrand]   @distributorId='ALL', @salesmanId='ALL',@routeId='ALL',@outletId='ALL',@brandId='ALL',@productId='ALL',@subBrandId='ALL',@packagingId='ALL',@ordersRef='ALL', @startDate='2015-03-17',@endDate='2015-03-17'          


GO
