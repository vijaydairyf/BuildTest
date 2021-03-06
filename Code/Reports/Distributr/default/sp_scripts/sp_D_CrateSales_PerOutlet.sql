---RETURNABLES SALES
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_D_CrateSales_PerOutlet]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_D_CrateSales_PerOutlet]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_D_CrateSales_PerOutlet]
(
@startDate as date,
@endDate as date,
@countryId AS NVARCHAR(50),
@regionId AS NVARCHAR(50),
@distributorId AS NVARCHAR(50),
@salesmanId AS NVARCHAR(50),
@routeId AS NVARCHAR(50),
@outletId AS NVARCHAR(50)
)
AS 
if  ltrim(rtrim(@countryId))='ALL'  begin set @countryId='%' end
if  ltrim(rtrim(@regionId))='ALL'  begin set @regionId='%' end
if  ltrim(rtrim(@distributorId))='ALL'  begin set @distributorId='%' end
if  ltrim(rtrim(@salesmanId))='ALL'  begin set @salesmanId='%' end
if  ltrim(rtrim(@routeId))='ALL'  begin set @routeId='%' end
if  ltrim(rtrim(@outletId))='ALL'  begin set @outletId='%' end


SELECT cntry.id as CountryId,cntry.Name as CountryName,
       reg.id as RegionId,reg.Name as RegionName,
       dist.Id as DistributorId,dist.Name as DistributorName,
       salesman.Id as SalesmanId,salesman.Name as SalesmanName,
	   rt.RouteID RouteId,rt.Name RouteName,
	   outlet.Id OutletId,outlet.Name OutletName,
	   sale.Id AS SaleId, 
       sale.DocumentReference AS SaleRef, 
       sale.DocumentDateIssued as SalesDate,       
       SUM(saleItems.Quantity) as TotalSales,
	   SUM(saleItems.Vat * saleItems.Quantity) TotalVat,
	   SUM(saleItems.ProductDiscount) ProductDiscount,
	   prod.id ProductId,
	   prod.Description ProductName,
	   prodPack.description PackagingName,
	   prod.Returnable ReturnableId,
	   retunable.Description ReturnableName,
	   retunablePack.Description ReturnablePack,
	   retunablePack.Capacity ReturnablePackCapacity,
	   CAST(ROUND((SUM(saleItems.Quantity) / retunablePack.Capacity),1) AS INT) NoOfCrates,
	   CAST((SUM(saleItems.Quantity) % retunablePack.Capacity) AS INT)  ExtraBottle,  
	   ROUND((SUM((saleItems.Quantity)*(saleItems.Value + saleItems.Vat))) +  SUM((saleItems.ProductDiscount*saleItems.Quantity)) ,2,1) as GrossAmount,
	   dbo.udf_D_RoundOff(SUM((saleItems.Quantity*saleItems.Value))) as NetRoundOff,
	   ROUND(SUM((saleItems.Quantity*saleItems.Value)),2,1) as NetTruncate,
	   dbo.udf_D_RoundOff((SUM((saleItems.Quantity)*(saleItems.Value + saleItems.Vat)))+ SUM((saleItems.ProductDiscount*saleItems.Quantity))) as GrossRoundOff

FROM  dbo.tblDocument sale
 JOIN dbo.tblLineItems saleItems ON sale.Id = saleItems.DocumentID
 JOIN dbo.tblProduct prod ON saleItems.ProductID = prod.id 
 JOIN dbo.tblCostCentre dist on sale.DocumentIssuerCostCentreId = dist.Id or sale.DocumentRecipientCostCentre = dist.Id
 JOIN dbo.tblCostCentre salesman  on sale.DocumentIssuerCostCentreId = salesman.Id or sale.DocumentRecipientCostCentre = salesman.Id
 JOIN dbo.tblCostCentre outlet ON sale.OrderIssuedOnBehalfOfCC = outlet.Id
 JOIN dbo.tblRoutes rt ON outlet.RouteId = rt.RouteID 
 JOIN dbo.tblRegion reg ON dist.Distributor_RegionId = reg.id 
 JOIN dbo.tblCountry cntry ON reg.Country = cntry.id 
 JOIN dbo.tblProductPackaging prodPack ON prod.PackagingId = prodPack.Id
 JOIN dbo.tblProduct retunable ON prod.Returnable = retunable.id
 JOIN dbo.tblProduct retunablePack ON retunable.Returnable = retunablePack.id
WHERE (sale.OrderOrderTypeId = 1) 
  AND ((sale.DocumentTypeId = 1)OR(sale.OrderOrderTypeId = 3) AND (sale.DocumentStatusId = 99))
  AND dist.CostCentreType = 2
  AND salesman.CostCentreType = 4
  AND CONVERT(NVARCHAR(50),cntry.id) LIKE ISNULL(@countryId,'%')
  AND CONVERT(NVARCHAR(50),reg.id) LIKE ISNULL(@regionId,'%')
  AND CONVERT(NVARCHAR(50),dist.id) LIKE ISNULL(@distributorId,'%')
  AND CONVERT(NVARCHAR(50),salesman.id) LIKE ISNULL(@salesmanId,'%')
  AND CONVERT(NVARCHAR(50),rt.RouteID) LIKE ISNULL(@routeId,'%')
  AND CONVERT(NVARCHAR(50),outlet.id) LIKE ISNULL(@outletId,'%')

  AND CONVERT(NVARCHAR(26),sale.DocumentDateIssued,23) BETWEEN @startDate AND @endDate
GROUP BY cntry.id,cntry.Name,
         reg.id,reg.Name,
		 dist.Id,dist.Name,
		 salesman.Id,salesman.Name,
		 rt.RouteID,rt.Name,
		 outlet.Id,outlet.Name,
		 sale.Id,sale.DocumentReference,sale.DocumentDateIssued,
		 prod.id, prod.Description,prodPack.description, prod.Returnable,saleItems.ProductDiscount,
		 retunable.Description,retunablePack.Description,retunablePack.Capacity,saleItems.Quantity,saleItems.Vat,saleItems.Value
ORDER BY sale.DocumentDateIssued DESC
  

-- EXEC [dbo].[sp_D_CrateSales_PerOutlet ] @startDate='2015-05-01',@endDate='2015-05-12',@countryId=' ALL',@regionId=' ALL',@distributorId=' ALL',@salesmanId=' ALL',@routeId=' ALL',@outletId=' ALL'
