/****** Object:  StoredProcedure [dbo].[sp_D_SalesBySalesman_ByBrand]    Script Date: 07/24/2013 08:51:32 ******/
DROP PROCEDURE [dbo].[sp_D_SalesBySalesman_ByBrand]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_D_SalesBySalesman_ByBrand]
(
@startDate as date,
@endDate as date,
@BrandId AS NVARCHAR(50),
@distributorID AS NVARCHAR(50),
@salesManID AS NVARCHAR(50),
@ProductId AS NVARCHAR(50),
@salesRef AS NVARCHAR(50)

)
as 
if LTRIM(RTRIM(@distributorID))='ALL' begin set @distributorID='%' end
if LTRIM(RTRIM(@salesManID))='ALL' begin set @salesManID='%' end
if LTRIM(RTRIM(@BrandId))='ALL' begin set @BrandId='%' end
if LTRIM(RTRIM(@ProductId))='ALL' begin set @ProductId='%' end
if LTRIM(RTRIM(@salesRef))='ALL' begin set @salesRef='%' end

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
      -- dbo.tblCostCentre.Id AS SalesmanId,
       dbo.tblCostCentre.Name AS Salesman, 
       dbo.tblCostCentre.CostCentreType AS SalesmanTypeID, 
       dbo.tblCostCentre.ParentCostCentreId, 
       dbo.tblCostCentre.RouteId, 
       dbo.tblLineItems.DocumentID, 
       dbo.tblDocument.DocumentStatusId, 
       tblCostCentre_1.Id AS DistributorID, 
       tblCostCentre_1.Name AS Distributor, 
       tblCostCentre_2.Name AS Producer, 
       tblCostCentre_2.CostCentreType AS ProducerID, 
       dbo.tblCostCentre.Id AS SalesManID, 
       dbo.tblProduct.id AS ProductId,
       dbo.tblProduct.Description AS Product, 
        dbo.tblProductBrand.id AS BrandId, 
       dbo.tblProductBrand.name AS Brand, 
       dbo.tblLineItems.ProductDiscount, 
       dbo.tblDocument.DocumentReference,
       dbo.tblDocument.SaleDiscount,
       (dbo.tblLineItems.ProductDiscount * dbo.tblLineItems.Quantity) as TotalProductDiscount,

	   ROUND(((dbo.tblLineItems.Quantity)*(dbo.tblLineItems.Value + dbo.tblLineItems.Vat)) +  (dbo.tblLineItems.ProductDiscount*dbo.tblLineItems.Quantity) ,2,1) as GrossAmount,
	   dbo.udf_D_RoundOff((dbo.tblLineItems.Quantity*dbo.tblLineItems.Value)) as NetRoundOff,
	   ROUND((dbo.tblLineItems.Quantity*dbo.tblLineItems.Value),2,1) as NetTruncate,
	   dbo.udf_D_RoundOff(((dbo.tblLineItems.Quantity)*(dbo.tblLineItems.Value + dbo.tblLineItems.Vat))) as GrossRoundOff
FROM   dbo.tblDocument INNER JOIN
       dbo.tblLineItems ON dbo.tblDocument.Id = dbo.tblLineItems.DocumentID INNER JOIN
       dbo.tblCostCentre ON (dbo.tblDocument.DocumentRecipientCostCentre = dbo.tblCostCentre.Id or  dbo.tblDocument.DocumentIssuerCostCentreId = dbo.tblCostCentre.Id) INNER JOIN
       dbo.tblCostCentre AS tblCostCentre_1 ON dbo.tblCostCentre.ParentCostCentreId = tblCostCentre_1.Id INNER JOIN
       dbo.tblCostCentre AS tblCostCentre_2 ON tblCostCentre_1.ParentCostCentreId = tblCostCentre_2.Id INNER JOIN
       dbo.tblProduct ON dbo.tblLineItems.ProductID = dbo.tblProduct.id INNER JOIN
       dbo.tblProductBrand ON dbo.tblProduct.BrandId = dbo.tblProductBrand.id
WHERE (dbo.tblDocument.DocumentTypeId = 1) 
       AND (dbo.tblDocument.OrderOrderTypeId = 1 OR (dbo.tblDocument.OrderOrderTypeId = 3 AND (dbo.tblDocument.DocumentStatusId = 99) )) 
       AND (CONVERT(VARCHAR(26), dbo.tblDocument.DocumentDateIssued,23) BETWEEN @startDate AND @endDate) 
       AND (dbo.tblCostCentre.CostCentreType = 4) 
       AND (CONVERT(NVARCHAR(50),dbo.tblProductBrand.id) LIKE ISNULL(@BrandId, N'%')) 
       AND (CONVERT(NVARCHAR(50),tblCostCentre_1.Id) LIKE ISNULL(@distributorID, N'%')) 
       AND (CONVERT(NVARCHAR(50),dbo.tblCostCentre.Id) LIKE ISNULL(@salesManID, N'%')) 
       AND (CONVERT(NVARCHAR(50),dbo.tblDocument.DocumentReference) LIKE ISNULL(@salesRef, N'%')) 
       AND (CONVERT(NVARCHAR(50),dbo.tblProduct.Description) LIKE ISNULL(@ProductId, N'%')) 
       
       
       
       --  Exec [dbo].[sp_D_SalesBySalesman_ByBrand] @startDate = '01-march-2014',@endDate = '11-march-2014',@distributorID ='ALL',@salesManID = 'ALL',@brandId='ALL',@salesRef='ALL',@ProductId='ALL' 


GO
