
DROP PROCEDURE [dbo].[sp_D_SalesByProductType]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_D_SalesByProductType]
(

@startDate as datetime,
@endDate as datetime,
@distributorID AS NVARCHAR(50),
@salesManID AS NVARCHAR(50),
@brandId AS NVARCHAR(50),
@productTypeId as nvarchar(50),
@subBrandId as nvarchar(50),
@packagingId as nvarchar(50),
@packagingTypeId as nvarchar(50),
@productId as nvarchar(50)


)
as 
if LTRIM(RTRIM(@distributorID))='ALL' begin set @distributorID='%' end
if LTRIM(RTRIM(@salesManID))='ALL' begin set @salesManID='%' end
if LTRIM(RTRIM(@productTypeId))='ALL' begin set @productTypeId='%' end
if LTRIM(RTRIM(@brandId))='ALL' begin set @brandId='%' end
if LTRIM(RTRIM(@subBrandId))='ALL' begin set @subBrandId='%'  end
if LTRIM(RTRIM(@packagingId))='ALL' begin set @packagingId='%' end
if LTRIM(RTRIM(@packagingTypeId))='ALL' begin set @packagingTypeId='%' end
if LTRIM(RTRIM(@productId))='ALL' begin set @productId='%' end


SELECT    distinct saleItem.ProductID, 
           saleItem.Description, 
           saleItem.Quantity, 
           saleItem.ProductDiscount, 
           (saleItem.ProductDiscount * saleItem.Quantity) as TotalProductDiscount,
           saleItem.Value, 
           saleItem.Vat, 
           sale.DocumentReference, 
           salesman.Id AS SalesManID, 
           salesman.Name AS Salesman, 
           distributor.Id AS DistributorID, 
           distributor.Name AS Distributor,
           HQ.Name AS Producer, 
           product.Description AS Product, 
           brand.name AS Brand,
           brand.Id as BrandId,
          (SELECT     TOP (1) sale.SaleDiscount) AS SaleValueDiscount, 
           sale.DocumentDateIssued, 
           outlet.Id AS OutletId, 
           outlet.Name AS Outlet, 
           country.id AS CountryId, 
           country.Name AS Country, 
           region.id AS RegionId, 
           region.Name AS Region, 
           route.RouteID AS RouteId, 
           route.Name AS Route, 
           productType.id as productTypeId, 
           productType.name as productTypeName, 
           case when product.FlavourId IS NULL then cast(CAST(0 as binary) as uniqueidentifier) else subBrand.id end as SubBrandId, 
           case when product.FlavourId IS NULL then 'No Flavour' else subBrand.name end as SubBrandName, 
           productPack.Id  as ProductPackId, 
           productPack.Name AS  ProductPackName, 
           productPackType.id AS ProductPackTypeId, 
           productPackType.name AS ProductPackTypeName,
		   ROUND(((saleItem.Quantity)*(saleItem.Value + saleItem.Vat)) +  (saleItem.ProductDiscount*saleItem.Quantity) ,2,1) as GrossAmount,
			dbo.udf_D_RoundOff((saleItem.Quantity*saleItem.Value)) as NetRoundOff,
			ROUND((saleItem.Quantity*saleItem.Value),2,1) as NetTruncate,
			dbo.udf_D_RoundOff(((saleItem.Quantity)*(saleItem.Value + saleItem.Vat))) as GrossRoundOff

           
FROM         dbo.tblDocument AS sale 
INNER JOIN   dbo.tblLineItems AS saleItem ON sale.Id = saleItem.DocumentID 

INNER JOIN   dbo.tblCostCentre AS salesman ON (sale.DocumentRecipientCostCentre = salesman.Id OR sale.DocumentIssuerCostCentreId = salesman.Id) 
INNER JOIN   dbo.tblCostCentre AS distributor ON salesman.ParentCostCentreId = distributor.Id 
INNER JOIN   dbo.tblCostCentre AS HQ ON distributor.ParentCostCentreId = HQ.Id 

INNER JOIN   dbo.tblProduct AS product ON saleItem.ProductID = product.id 
INNER JOIN   dbo.tblProductBrand AS brand ON product.BrandId = brand.id 
INNER JOIN   dbo.tblCostCentre AS outlet ON sale.OrderIssuedOnBehalfOfCC = outlet.Id 
INNER JOIN   dbo.tblRoutes AS route ON outlet.RouteId = route.RouteID 
INNER JOIN   dbo.tblRegion AS region ON distributor.Distributor_RegionId = region.id 
INNER JOIN   dbo.tblCountry AS country ON region.Country = country.id 
LEFT OUTER JOIN   dbo.tblProductType productType ON product.ProductTypeId = productType.id 
INNER JOIN   dbo.tblProductPackaging productPack ON product.PackagingId = productPack.Id 
INNER JOIN   dbo.tblProductPackagingType productPackType ON product.PackagingTypeId = productPackType.id,
 --LEFT OUTER JOIN
             dbo.tblProductFlavour subBrand --ON (product.FlavourId = subBrand.id  )
WHERE   --( (product.ProductTypeId = productType.id) or ( product.ProductTypeId is null)) 
        ((product.FlavourId = subBrand.id ) or (product.FlavourId is null))   
       AND (sale.DocumentTypeId = 1)
       AND (sale.OrderOrderTypeId = 1 or (sale.OrderOrderTypeId = 3 AND (sale.DocumentStatusId = 99) )) 
       AND (salesman.CostCentreType = 4) 

 AND (CONVERT(VARCHAR(26),sale.DocumentDateIssued,23) BETWEEN @startDate AND @endDate)
 AND (CONVERT(NVARCHAR(50),distributor.Id) LIKE ISNULL(@distributorID, '%')) 
 AND (CONVERT(NVARCHAR(50),salesman.Id) LIKE ISNULL(@salesManID, '%')) 
 AND (CONVERT(NVARCHAR(50),brand.id) LIKE ISNULL(@brandId, '%'))
 AND ((CONVERT(NVARCHAR(50),productType.id ) LIKE ISNULL(@productTypeId, '%')) or productType.id is null )
 AND (CONVERT(NVARCHAR(50),subBrand.id) LIKE ISNULL(@subBrandId, '%'))
 AND (CONVERT(NVARCHAR(50),productPack.Id) LIKE ISNULL(@packagingId, '%'))
 AND (CONVERT(NVARCHAR(50),productPackType.id) LIKE ISNULL(@packagingTypeId, '%'))
 AND (CONVERT(NVARCHAR(50),product.id) LIKE ISNULL(@productId, '%'))
 

 
 
--  Exec  [dbo].[sp_D_SalesByProductType] @startDate='1-March-2014',@endDate='15-March-2014',@distributorID='ALL',@salesManID='ALL',@brandId='ALL',@productTypeId='ALL',@subBrandId='ALL',@packagingId='ALL',@packagingTypeId='ALL',@productId='ALL'

 
 Go