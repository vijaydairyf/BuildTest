/****** Object:  StoredProcedure [dbo].[sp_D_RegionalSales_PerDistributorRoutesOutlets]    Script Date: 07/24/2013 08:51:32 ******/
DROP PROCEDURE [dbo].[sp_D_RegionalSales_PerDistributorRoutesOutlets]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_D_RegionalSales_PerDistributorRoutesOutlets]
(
@startDate as datetime,
@endDate as datetime,
@RouteID as nvarchar(100),
@distributorID as nvarchar(50),
@outletId as nvarchar(50)

)
as 

if  @RouteID='ALL'  begin set @RouteID='%' end
if  @distributorID='ALL'  begin set @distributorID='%' end
if  @outletId='ALL'  begin set @outletId='%' end


SELECT dbo.tblLineItems.id, 
       dbo.tblDocument.DocumentParentId, 
       dbo.tblLineItems.ProductID, 
       dbo.tblLineItems.Description, 
       dbo.tblDocument.DocumentTypeId, 
       dbo.tblLineItems.Quantity, 
       dbo.tblLineItems.Value, 
       dbo.tblLineItems.Vat, 
       dbo.tblDocument.DocumentReference, 
       dbo.tblDocument.DocumentIssuerUserId, 
       dbo.tblDocument.DocumentDateIssued, 
       dbo.tblDocument.OrderDateRequired, 
       dbo.tblDocument.DocumentIssuerCostCentreApplicationId, 
       dbo.tblDocument.OrderIssuedOnBehalfOfCC, 
       dbo.tblDocument.OrderOrderTypeId, 
       dbo.tblDocument.SendDateTime, 
       dbo.tblCostCentre.id AS OutletId,
       dbo.tblCostCentre.Name AS Outlet, 
       dbo.tblCostCentre.CostCentreType AS OutletTypeID, 
       dbo.tblCostCentre.ParentCostCentreId, 
       dbo.tblCostCentre.RouteId, 
       dbo.tblLineItems.DocumentID, 
       dbo.tblLineItems.ApprovedQuantity, 
       tblCostCentre_1.Id AS DistributorID, 
       tblCostCentre_1.Name AS Distributor, 
       dbo.tblRoutes.Name AS Route, 
       dbo.tblDocument.DocumentIssuerCostCentreId, 
       dbo.tblDocument.DocumentRecipientCostCentre, 
       tblCostCentre_3.Name AS Salesman, 
       tblCostCentre_3.CostCentreType AS SalesmanTypeID, 
       dbo.tblRoutes.RouteID AS RouteIDroutesTable, 
       dbo.tblLineItems.ProductDiscount, 
       dbo.tblRegion.Name AS Region, 
       dbo.tblCountry.Name AS Country, 
       tblDocument.SaleDiscount,
       (dbo.tblLineItems.ProductDiscount * dbo.tblLineItems.Quantity) as TotalProductDiscount,
	   ROUND(((dbo.tblLineItems.Quantity)*(dbo.tblLineItems.Value + dbo.tblLineItems.Vat)) +  (dbo.tblLineItems.ProductDiscount*dbo.tblLineItems.Quantity) ,2,1) as GrossAmount,
	   dbo.udf_D_RoundOff((dbo.tblLineItems.Quantity*dbo.tblLineItems.Value)) as NetRoundOff,
	   ROUND((dbo.tblLineItems.Quantity*dbo.tblLineItems.Value),2,1) as NetTruncate,
	   dbo.udf_D_RoundOff(((dbo.tblLineItems.Quantity)*(dbo.tblLineItems.Value + dbo.tblLineItems.Vat))) as GrossRoundOff

FROM  dbo.tblCostCentre AS tblCostCentre_1 INNER JOIN
      dbo.tblCostCentre ON tblCostCentre_1.Id = dbo.tblCostCentre.ParentCostCentreId INNER JOIN
      dbo.tblDocument INNER JOIN
      dbo.tblLineItems ON dbo.tblDocument.Id = dbo.tblLineItems.DocumentID ON dbo.tblCostCentre.Id = dbo.tblDocument.OrderIssuedOnBehalfOfCC INNER JOIN
      dbo.tblRoutes ON dbo.tblCostCentre.RouteId = dbo.tblRoutes.RouteID INNER JOIN
      dbo.tblCostCentre AS tblCostCentre_3 ON dbo.tblDocument.DocumentRecipientCostCentre = tblCostCentre_3.Id INNER JOIN
      dbo.tblRegion ON dbo.tblRoutes.RegionId = dbo.tblRegion.id INNER JOIN
      dbo.tblCountry ON dbo.tblRegion.Country = dbo.tblCountry.id
WHERE (dbo.tblDocument.DocumentTypeId = 1) 
AND (dbo.tblDocument.OrderOrderTypeId = 1 OR (dbo.tblDocument.OrderOrderTypeId = 3 AND (dbo.tblDocument.DocumentStatusId = 99) )) 
               AND (dbo.tblCostCentre.CostCentreType = 5)                
               AND  (CONVERT(VARCHAR(26), dbo.tblDocument.DocumentDateIssued,23) BETWEEN @startDate AND @endDate)
               AND (CONVERT(NVARCHAR(50), tblCostCentre_1.Id) LIKE ISNULL(@distributorID, N'%')) 
               AND (CONVERT(NVARCHAR(50), tblCostCentre.Id) LIKE ISNULL(@outletId, N'%'))
               AND (CONVERT(NVARCHAR(50), dbo.tblRoutes.RouteID) LIKE ISNULL(@RouteID, N'%'))
               
 -- Exec [dbo].[sp_D_RegionalSales_PerDistributorRoutesOutlets]  @distributorID='ALL',@outletId='ALL',@RouteID='ALL',@startDate = '01-march-2014',@endDate = '11-march-2014'
            
GO
