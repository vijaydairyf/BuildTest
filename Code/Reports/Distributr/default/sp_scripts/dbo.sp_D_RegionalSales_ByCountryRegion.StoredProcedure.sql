/****** Object:  StoredProcedure [dbo].[sp_D_RegionalSales_ByCountryRegion]    Script Date: 07/24/2013 08:51:32 ******/
DROP PROCEDURE [dbo].[sp_D_RegionalSales_ByCountryRegion]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_D_RegionalSales_ByCountryRegion]
(
@startDate as datetime,
@endDate as datetime, 
@distributorID as nvarchar(50),
@countryId as nvarchar(50),
@regionId as nvarchar(100)
)
as 
if  rtrim(ltrim(@distributorID))='ALL'  begin set @distributorID='%' end
if  rtrim(ltrim(@regionId))='ALL'   begin set @regionId='%' end
if  rtrim(ltrim(@countryId))='ALL'  begin set @countryId='%' end

SELECT dbo.tblLineItems.id, 
       dbo.tblLineItems.ProductID, 
       dbo.tblLineItems.Description, 
       dbo.tblDocument.DocumentTypeId, 
       dbo.tblLineItems.Quantity, 
       dbo.tblLineItems.Value, 
       dbo.tblLineItems.Vat, 
       dbo.tblDocument.DocumentIssuerCostCentreId, 
       dbo.tblDocument.DocumentIssuerUserId, 
       dbo.tblDocument.DocumentDateIssued, 
       dbo.tblDocument.DocumentRecipientCostCentre, 
       dbo.tblDocument.DocumentIssuerCostCentreApplicationId, 
       dbo.tblDocument.OrderIssuedOnBehalfOfCC, 
       dbo.tblDocument.OrderOrderTypeId, 
       dbo.tblDocument.DocumentDateIssued as SendDateTime, 
       dbo.tblCostCentre.Name AS Salesman, 
       dbo.tblCostCentre.CostCentreType AS SalesmanTypeID, 
       dbo.tblCostCentre.ParentCostCentreId, 
       dbo.tblCostCentre.RouteId, dbo.tblLineItems.DocumentID, 
       dbo.tblDocument.DocumentStatusId, 
       tblCostCentre_1.Id AS DistributorID, 
       tblCostCentre_1.Name AS Distributor, 
       tblCostCentre_2.Name AS Producer, 
       tblCostCentre_2.CostCentreType AS ProducerID, 
       dbo.tblCostCentre.Id AS SalesManID, 
       dbo.tblProduct.Description AS Product, 
       dbo.tblProductBrand.name AS Brand, 
       dbo.tblLineItems.ProductDiscount, 
       tblCostCentre_1.Distributor_RegionId,
       dbo.tblRegion.id AS RegionId, 
       dbo.tblRegion.Name AS Region,
       dbo.tblCountry.id AS CountryId, 
       dbo.tblCountry.Name AS Country, 
       dbo.tblDocument.SaleDiscount,
       (dbo.tblLineItems.ProductDiscount * dbo.tblLineItems.Quantity) as TotalProductDiscount,

	   ROUND(((dbo.tblLineItems.Quantity)*(dbo.tblLineItems.Value + dbo.tblLineItems.Vat)) +  (dbo.tblLineItems.ProductDiscount*dbo.tblLineItems.Quantity) ,2,1) as GrossAmount,
	   dbo.udf_D_RoundOff((dbo.tblLineItems.Quantity*dbo.tblLineItems.Value)) as NetRoundOff,
	   ROUND((dbo.tblLineItems.Quantity*dbo.tblLineItems.Value),2,1) as NetTruncate,
	   dbo.udf_D_RoundOff(((dbo.tblLineItems.Quantity)*(dbo.tblLineItems.Value + dbo.tblLineItems.Vat))) as GrossRoundOff

FROM   dbo.tblDocument INNER JOIN
       dbo.tblLineItems ON dbo.tblDocument.Id = dbo.tblLineItems.DocumentID INNER JOIN
       dbo.tblCostCentre ON dbo.tblDocument.DocumentRecipientCostCentre = dbo.tblCostCentre.Id INNER JOIN
       dbo.tblCostCentre AS tblCostCentre_1 ON dbo.tblCostCentre.ParentCostCentreId = tblCostCentre_1.Id INNER JOIN
       dbo.tblCostCentre AS tblCostCentre_2 ON tblCostCentre_1.ParentCostCentreId = tblCostCentre_2.Id INNER JOIN
       dbo.tblProduct ON dbo.tblLineItems.ProductID = dbo.tblProduct.id INNER JOIN
       dbo.tblProductBrand ON dbo.tblProduct.BrandId = dbo.tblProductBrand.id INNER JOIN
       dbo.tblRegion ON tblCostCentre_1.Distributor_RegionId = dbo.tblRegion.id INNER JOIN
       dbo.tblCountry ON dbo.tblRegion.Country = dbo.tblCountry.id
WHERE (dbo.tblDocument.DocumentTypeId = 1) 
       AND (dbo.tblDocument.OrderOrderTypeId = 1 OR (dbo.tblDocument.OrderOrderTypeId = 3 AND (dbo.tblDocument.DocumentStatusId = 99)
)) 
       AND (CONVERT(VARCHAR(26), dbo.tblDocument.DocumentDateIssued,23) BETWEEN @startDate AND @endDate) 
       AND (dbo.tblCostCentre.CostCentreType = 4) 
       AND (convert(nvarchar(50),dbo.tblRegion.id) like isnull(@regionId, '%')) 
       AND (convert(nvarchar(50),dbo.tblCountry.id) like isnull(@countryId,'%'))
       AND (convert(nvarchar(50),tblCostCentre_1.Id) like isnull(@distributorID,'%'))        
               
               
UNION ALL


SELECT tblLineItems_1.id, 
       tblLineItems_1.ProductID, 
       tblLineItems_1.Description, 
       tblDocument_1.DocumentTypeId, 
       tblLineItems_1.Quantity, 
       tblLineItems_1.Value, 
       tblLineItems_1.Vat, 
       tblDocument_1.DocumentIssuerCostCentreId, 
       tblDocument_1.DocumentIssuerUserId, 
       tblDocument_1.DocumentDateIssued, 
       tblDocument_1.DocumentRecipientCostCentre, 
       tblDocument_1.DocumentIssuerCostCentreApplicationId, 
       tblDocument_1.OrderIssuedOnBehalfOfCC, 
       tblDocument_1.OrderOrderTypeId, 
       tblDocument_1.DocumentDateIssued as SendDateTime, 
       tblCostCentre_3.Name AS Salesman, 
       tblCostCentre_3.CostCentreType AS SalesmanTypeID, 
       tblCostCentre_3.ParentCostCentreId, 
       tblCostCentre_3.RouteId, 
       tblLineItems_1.DocumentID, 
       tblDocument_1.DocumentStatusId, 
       tblCostCentre_1.Id AS DistributorID, 
       tblCostCentre_1.Name AS Distributor, 
       tblCostCentre_2.Name AS Producer, 
       tblCostCentre_2.CostCentreType AS ProducerID, 
       tblCostCentre_3.Id AS SalesManID, 
       tblProduct_1.Description AS Product, 
       tblProductBrand_1.name AS Brand, 
       tblLineItems_1.ProductDiscount, 
       tblCostCentre_1.Distributor_RegionId, 
       dbo.tblRegion.id AS RegionId, 
       dbo.tblRegion.Name AS Region,
       dbo.tblCountry.id AS CountryId, 
       dbo.tblCountry.Name AS Country,  
       tblDocument_1.SaleDiscount,
       ( tblLineItems_1.ProductDiscount *  tblLineItems_1.Quantity) as TotalProductDiscount,

	   ROUND(((tblLineItems_1.Quantity)*(tblLineItems_1.Value + tblLineItems_1.Vat)) +  (tblLineItems_1.ProductDiscount*tblLineItems_1.Quantity) ,2,1) as GrossAmount,
	   dbo.udf_D_RoundOff((tblLineItems_1.Quantity*tblLineItems_1.Value)) as NetRoundOff,
	   ROUND((tblLineItems_1.Quantity*tblLineItems_1.Value),2,1) as NetTruncate,
	   dbo.udf_D_RoundOff(((tblLineItems_1.Quantity)*(tblLineItems_1.Value + tblLineItems_1.Vat))) as GrossRoundOff


FROM   dbo.tblProductBrand AS tblProductBrand_1 INNER JOIN
       dbo.tblProduct AS tblProduct_1 ON tblProductBrand_1.id = tblProduct_1.BrandId INNER JOIN
       dbo.tblCostCentre AS tblCostCentre_1 INNER JOIN
       dbo.tblCostCentre AS tblCostCentre_3 ON tblCostCentre_1.Id = tblCostCentre_3.ParentCostCentreId INNER JOIN
       dbo.tblCostCentre AS tblCostCentre_2 ON tblCostCentre_1.ParentCostCentreId = tblCostCentre_2.Id INNER JOIN
       dbo.tblDocument AS tblDocument_1 INNER JOIN
       dbo.tblLineItems AS tblLineItems_1 ON tblDocument_1.Id = tblLineItems_1.DocumentID ON tblCostCentre_3.Id = tblDocument_1.DocumentIssuerCostCentreId ON 
       tblProduct_1.id = tblLineItems_1.ProductID INNER JOIN
       dbo.tblRegion ON tblCostCentre_1.Distributor_RegionId = dbo.tblRegion.id INNER JOIN
       dbo.tblCountry ON dbo.tblRegion.Country = dbo.tblCountry.id
WHERE (tblDocument_1.DocumentTypeId = 1) 
               AND (tblDocument_1.OrderOrderTypeId = 1 OR (tblDocument_1.OrderOrderTypeId = 3 AND (tblDocument_1.DocumentStatusId = 99))) 
               AND (CONVERT(VARCHAR(26), tblDocument_1.DocumentDateIssued,23) BETWEEN @startDate AND @endDate) 
               AND (tblCostCentre_3.CostCentreType = 4)                  
               AND (convert(nvarchar(50),dbo.tblRegion.id) like isnull(@regionId, '%')) 
               AND (convert(nvarchar(50),dbo.tblCountry.id) like isnull(@countryId,'%'))
               AND (convert(nvarchar(50), tblCostCentre_1.Id) like isnull(@distributorID,'%'))
               
 --  Exec  [dbo].[sp_D_RegionalSales_ByCountryRegion] @distributorID='ALL',@regionId='ALL' ,@countryId='ALL',@startDate = '01-march-2014',@endDate = '11-march-2014'
   
GO
