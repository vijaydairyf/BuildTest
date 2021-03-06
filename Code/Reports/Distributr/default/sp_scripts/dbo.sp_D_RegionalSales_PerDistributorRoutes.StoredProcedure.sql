/****** Object:  StoredProcedure [dbo].[sp_D_RegionalSales_PerDistributorRoutes]    Script Date: 07/24/2013 08:51:32 ******/
DROP PROCEDURE [dbo].[sp_D_RegionalSales_PerDistributorRoutes]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_D_RegionalSales_PerDistributorRoutes]
(
@startDate as datetime,
@endDate as datetime,

 
@countryId as nvarchar(50),
@regionId as nvarchar(100),
@distributorID as nvarchar(50),
@salesmanId as nvarchar(50),
@routeId as nvarchar(50)

)
as
if  ltrim(rtrim(@regionId))='ALL'  begin set @regionId='%' end
if  ltrim(rtrim(@countryId))='ALL'  begin set @countryId='%' end
if  ltrim(rtrim(@distributorID))='ALL'  begin set @distributorID='%' end
if  ltrim(rtrim(@salesmanId))='ALL'  begin set @salesmanId='%' end
if  ltrim(rtrim(@routeId))='ALL'  begin set @routeId='%' end

SELECT saleItems.ProductID, 
       saleItems.Description, 
       saleItems.Quantity, 
       saleItems.Value, 
       saleItems.Vat, 
       sale.DocumentReference, 
       sale.DocumentDateIssued, 
       oulet.id AS OutletId,
       oulet.Name AS Outlet, 
       oulet.CostCentreType AS OutletTypeID, 
       oulet.ParentCostCentreId, 
       oulet.RouteId, 
       saleItems.DocumentID, 
       dist.Id AS DistributorID, 
       dist.Name AS Distributor, 
       dbo.tblRoutes.Name AS Route, 
	   sm.id SalesmanId,
       sm.Name AS Salesman, 
       sm.CostCentreType AS SalesmanTypeID, 
       dbo.tblRoutes.RouteID AS RouteIDroutesTable, 
       saleItems.ProductDiscount, 
       dbo.tblRegion.Name AS Region, 
       dbo.tblCountry.Name AS Country, 
       sale.SaleDiscount,
       (saleItems.ProductDiscount * saleItems.Quantity) as TotalProductDiscount,

	   ROUND(((saleItems.Quantity)*(saleItems.Value + saleItems.Vat)) +  (saleItems.ProductDiscount*saleItems.Quantity) ,2,1) as GrossAmount,
	   dbo.udf_D_RoundOff((saleItems.Quantity*saleItems.Value)) as NetRoundOff,
	   ROUND((saleItems.Quantity*saleItems.Value),2,1) as NetTruncate,
	   dbo.udf_D_RoundOff((saleItems.Quantity)*(saleItems.Value + saleItems.Vat)) as GrossRoundOff

FROM  dbo.tblCostCentre AS dist 
 JOIN  dbo.tblCostCentre oulet ON dist.Id = oulet.ParentCostCentreId 
 JOIN  dbo.tblDocument sale
 JOIN  dbo.tblLineItems saleItems ON sale.Id = saleItems.DocumentID ON oulet.Id = sale.OrderIssuedOnBehalfOfCC 
 JOIN  dbo.tblRoutes ON oulet.RouteId = dbo.tblRoutes.RouteID 
 JOIN  dbo.tblCostCentre AS sm ON (sale.DocumentRecipientCostCentre = sm.Id or sale.DocumentIssuerCostCentreId = sm.Id )
 JOIN  dbo.tblRegion ON dbo.tblRoutes.RegionId = dbo.tblRegion.id 
 JOIN  dbo.tblCountry ON dbo.tblRegion.Country = dbo.tblCountry.id
WHERE   (sale.DocumentTypeId = 1) 
    AND (sale.OrderOrderTypeId = 1 OR (sale.OrderOrderTypeId = 3 AND (sale.DocumentStatusId = 99))) 
    AND (oulet.CostCentreType = 5)  
	AND sm.CostCentreType = 4
	AND dist.CostCentreType = 2               
    AND  (CONVERT(VARCHAR(26), sale.DocumentDateIssued,23) BETWEEN @startDate AND @endDate)
    AND (CONVERT(NVARCHAR(50), dbo.tblCountry.id) LIKE ISNULL(@countryId, N'%'))
    AND (CONVERT(NVARCHAR(50), dbo.tblRegion.id) LIKE ISNULL(@regionId, N'%'))
    AND (CONVERT(NVARCHAR(50), dist.Id) LIKE ISNULL(@distributorID, N'%')) 
    AND (CONVERT(NVARCHAR(50), sm.Id) LIKE ISNULL(@salesmanId, N'%')) 
    AND (CONVERT(NVARCHAR(50), dbo.tblRoutes.RouteID) LIKE ISNULL(@routeId, N'%'))

       
       -- Exec sp_D_RegionalSales_PerDistributorRoutes @regionId='ALL',@countryId='ALL', @distributorID='ALL',@salesmanId='ALL',@routeId='ALL',@startDate = '01-march-2014',@endDate = '11-Aug-2015'


GO
