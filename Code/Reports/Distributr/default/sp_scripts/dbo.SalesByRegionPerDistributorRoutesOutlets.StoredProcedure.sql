/****** Object:  StoredProcedure [dbo].[SalesByRegionPerDistributorRoutesOutlets]    Script Date: 07/24/2013 08:51:32 ******/
DROP PROCEDURE [dbo].[SalesByRegionPerDistributorRoutesOutlets]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SalesByRegionPerDistributorRoutesOutlets]
(
@startDate as datetime,
@endDate as datetime,
@RouteID as nvarchar(100),
@DistributorID as nvarchar(50),
@countryId as nvarchar(50),
@regionId as nvarchar(50),
@outletId as nvarchar(50)
)
as 
if ltrim(rtrim(@RouteID))='ALL'  begin set @RouteID='%' end
if ltrim(rtrim(@DistributorID))='ALL'  begin set @DistributorID='%' end
if ltrim(rtrim(@countryId))='ALL'  begin set @countryId='%' end
if ltrim(rtrim(@regionId))='ALL'  begin set @regionId='%' end
if ltrim(rtrim(@outletId))='ALL'  begin set @outletId='%' end

SELECT dbo.tblLineItems.id, dbo.tblDocument.DocumentParentId, dbo.tblLineItems.ProductID, dbo.tblLineItems.Description, dbo.tblDocument.DocumentTypeId, 
               dbo.tblLineItems.Quantity, dbo.tblLineItems.Value, dbo.tblLineItems.Vat, dbo.tblDocument.DocumentReference, dbo.tblDocument.DocumentIssuerUserId, 
               dbo.tblDocument.DocumentDateIssued, dbo.tblDocument.OrderDateRequired, dbo.tblDocument.DocumentIssuerCostCentreApplicationId, 
               dbo.tblDocument.OrderIssuedOnBehalfOfCC, dbo.tblDocument.OrderOrderTypeId, dbo.tblDocument.SendDateTime, dbo.tblCostCentre.Name AS Outlet, 
               dbo.tblCostCentre.CostCentreType AS OutletTypeID, dbo.tblCostCentre.ParentCostCentreId, dbo.tblCostCentre.RouteId, dbo.tblLineItems.DocumentID, 
               dbo.tblLineItems.ApprovedQuantity, tblCostCentre_1.Id AS DistributorID, tblCostCentre_1.Name AS Distributor, dbo.tblRoutes.Name AS Route, 
               dbo.tblDocument.DocumentIssuerCostCentreId, dbo.tblDocument.DocumentRecipientCostCentre, tblCostCentre_3.Name AS Salesman, 
               tblCostCentre_3.CostCentreType AS SalesmanTypeID, dbo.tblRoutes.RouteID AS RouteIDroutesTable, dbo.tblLineItems.ProductDiscount, 
               dbo.tblRegion.Name AS Region, dbo.tblCountry.Name AS Country, tblDocument.SaleDiscount
FROM  dbo.tblCostCentre AS tblCostCentre_1 INNER JOIN
               dbo.tblCostCentre ON tblCostCentre_1.Id = dbo.tblCostCentre.ParentCostCentreId INNER JOIN
               dbo.tblDocument INNER JOIN
               dbo.tblLineItems ON dbo.tblDocument.Id = dbo.tblLineItems.DocumentID ON dbo.tblCostCentre.Id = dbo.tblDocument.OrderIssuedOnBehalfOfCC INNER JOIN
               dbo.tblRoutes ON dbo.tblCostCentre.RouteId = dbo.tblRoutes.RouteID INNER JOIN
               dbo.tblCostCentre AS tblCostCentre_3 ON dbo.tblDocument.DocumentRecipientCostCentre = tblCostCentre_3.Id INNER JOIN
               dbo.tblRegion ON dbo.tblRoutes.RegionId = dbo.tblRegion.id INNER JOIN
               dbo.tblCountry ON dbo.tblRegion.Country = dbo.tblCountry.id
WHERE (dbo.tblDocument.DocumentTypeId = 1) 
AND (dbo.tblDocument.OrderOrderTypeId = 1 OR dbo.tblDocument.OrderOrderTypeId = 3) 
AND (dbo.tblCostCentre.CostCentreType = 5) 
AND (dbo.tblDocument.DocumentStatusId = 99) 
AND (CONVERT(VARCHAR(26), dbo.tblDocument.DocumentDateIssued,23) BETWEEN @startDate AND @endDate)
AND (CONVERT(NVARCHAR(50), tblCostCentre_1.Id) LIKE ISNULL(@DistributorID, N'%')) 
AND (CONVERT(NVARCHAR(50), dbo.tblRoutes.RouteID) LIKE ISNULL(@RouteID, N'%'))
AND (CONVERT(NVARCHAR(50), dbo.tblCountry.id) LIKE ISNULL(@countryId, N'%'))
AND CONVERT(NVARCHAR(50), dbo.tblRegion.id) LIKE ISNULL(@regionId, '%')
AND CONVERT(NVARCHAR(50), dbo.tblCostCentre.Id) LIKE ISNULL(@outletId, '%')
GO

-- Exec [dbo].[SalesByRegionPerDistributorRoutesOutlets]  @startDate = '2015-02-01',@endDate = '2015-02-12', @distributorID='ALL', @routeId='ALL',@countryId ='ALL', @outletId='ALL',@regionId='ALL'
