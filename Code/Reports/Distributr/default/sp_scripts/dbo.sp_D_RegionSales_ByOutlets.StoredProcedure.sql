/****** Object:  StoredProcedure [dbo].[sp_D_RegionSales_ByOutlets]    Script Date: 07/24/2013 08:51:32 ******/
DROP PROCEDURE [dbo].[sp_D_RegionSales_ByOutlets]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_D_RegionSales_ByOutlets]
(
@startDate as datetime,
@endDate as datetime,
@countryId as nvarchar(50),
@regionId as nvarchar(50),
@distributorId as nvarchar(50),
@salesmanId as nvarchar(50),
@routeId as nvarchar(50),
@outletId as nvarchar(50)

)
as 
if  ltrim(rtrim(@countryId))='ALL' begin set @countryId='%' end
if  ltrim(rtrim(@regionId))='ALL'  begin set @regionId='%' end
if  ltrim(rtrim(@distributorId))='ALL'  begin set @distributorId='%' end
if  ltrim(rtrim(@salesmanId))='ALL'  begin set @salesmanId='%' end
if  ltrim(rtrim(@routeId))='ALL'  begin set @routeId='%' end
if  ltrim(rtrim(@outletId))='ALL'  begin set @outletId='%' end

SELECT saleItems.id, 
       sale.DocumentParentId, 
	   saleItems.ProductID, 
	   saleItems.Description, 
	   sale.DocumentTypeId, 
       saleItems.Quantity, 
	   saleItems.Value, 
	   saleItems.Vat, 
	   sale.DocumentReference, 
       sale.DocumentDateIssued, 
	   sale.DocumentDateIssued as SendDateTime, 
	   dbo.tblCostCentre.Name AS Outlet, 
       dbo.tblCostCentre.CostCentreType AS OutletTypeID, 
	   dbo.tblCostCentre.ParentCostCentreId, 
	   dbo.tblCostCentre.RouteId, 
	   saleItems.DocumentID, 
       dist.Id AS DistributorID, 
	   dist.Name AS Distributor, 
	   dbo.tblRoutes.Name AS Route, 
	   sm.id SalesmanId,
	   sm.Name AS Salesman, 
	   sm.CostCentreType AS SalesmanTypeID, 
       dbo.tblRoutes.RouteID AS RouteID, 
	   saleItems.ProductDiscount, 
	   dbo.tblRegion.Name AS Region, 
	   dbo.tblCountry.Name AS Country,                
       dbo.tblProduct.Description AS Product, 
	   dbo.tblProductBrand.name AS Brand, 
	   dbo.tblCostCentre.Id AS OutLetID,
	   sale.SaleDiscount,
      (saleItems.ProductDiscount * saleItems.Quantity) AS TotalProductDiscount,
		ROUND(((saleItems.Quantity)*(saleItems.Value + saleItems.Vat)) +  (saleItems.ProductDiscount * saleItems.Quantity) ,2,1) as GrossAmount,
		dbo.udf_D_RoundOff((saleItems.Quantity * saleItems.Value)) as NetRoundOff,
		ROUND((saleItems.Quantity * saleItems.Value),2,1) as NetTruncate,
		dbo.udf_D_RoundOff(((saleItems.Quantity)*(saleItems.Value + saleItems.Vat))) as GrossRoundOff

FROM       dbo.tblCostCentre AS dist 
INNER JOIN dbo.tblCostCentre ON dist.Id = dbo.tblCostCentre.ParentCostCentreId 
INNER JOIN dbo.tblDocument sale
INNER JOIN dbo.tblLineItems saleItems ON sale.Id = saleItems.DocumentID ON dbo.tblCostCentre.Id = sale.OrderIssuedOnBehalfOfCC 
INNER JOIN dbo.tblRoutes ON dbo.tblCostCentre.RouteId = dbo.tblRoutes.RouteID 
INNER JOIN dbo.tblCostCentre AS sm ON (sale.DocumentRecipientCostCentre = sm.Id or sale.DocumentIssuerCostCentreId = sm.Id )
INNER JOIN dbo.tblRegion ON dbo.tblRoutes.RegionId = dbo.tblRegion.id 
INNER JOIN dbo.tblCountry ON dbo.tblRegion.Country = dbo.tblCountry.id 
INNER JOIN dbo.tblProduct ON saleItems.ProductID = dbo.tblProduct.id 
INNER JOIN dbo.tblProductBrand ON dbo.tblProduct.BrandId = dbo.tblProductBrand.id
WHERE (sale.DocumentTypeId = 1)
AND (sale.OrderOrderTypeId = 1 OR sale.OrderOrderTypeId = 3) 
AND (sale.OrderOrderTypeId = 1 OR  (sale.OrderOrderTypeId = 3 AND sale.DocumentStatusId = 99))
AND sm.CostCentreType = 4
--AND dist.CostCentreType = 2
AND (dbo.tblCostCentre.CostCentreType = 5) 
 AND (CONVERT(VARCHAR(26), sale.DocumentDateIssued,23) BETWEEN @startDate AND @endDate) 
 AND CONVERT(NVARCHAR(50), dbo.tblCountry.id) LIKE ISNULL(@countryId, '%')
 AND CONVERT(NVARCHAR(50), dbo.tblRegion.id) LIKE ISNULL(@regionId, '%')
 AND CONVERT(NVARCHAR(50), sm.id) LIKE ISNULL(@salesmanId, '%')
 AND CONVERT(NVARCHAR(50), dist.Id) LIKE ISNULL(@distributorId, '%')
 AND CONVERT(NVARCHAR(50), dbo.tblRoutes.RouteID) LIKE ISNULL(@routeId, '%')
 AND CONVERT(NVARCHAR(50), dbo.tblCostCentre.Id) LIKE ISNULL(@outletId, '%')
               
                
 -- Exec [dbo].[sp_D_RegionSales_ByOutlets]  @startDate = '2015-02-01',@endDate = '2015-02-12',@countryId='ALL',@regionId='ALL',@distributorId='ALL',@salesmanId='ALL',@routeId='ALL',@outletId='ALL'

GO
