/****** Object:  StoredProcedure [dbo].[SalesByPackaging]    Script Date: 07/24/2013 08:51:32 ******/
DROP PROCEDURE [dbo].[SalesByPackaging]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SalesByPackaging]
(
@startDate as datetime,
@endDate as datetime,
@Brand AS NVARCHAR(50),
@distributorID AS NVARCHAR(50),
@salesManID AS NVARCHAR(50),
@Product AS NVARCHAR(50),
@salesRef AS NVARCHAR(50),
@PackagingID AS NVARCHAR(50)
)
as 
if LTRIM(RTRIM(@distributorID))='ALL' begin set @distributorID='%' end
if LTRIM(RTRIM(@Brand))='ALL' begin set @Brand='%' end
if LTRIM(RTRIM(@salesManID))='ALL' begin set @salesManID='%' end
if LTRIM(RTRIM(@Product))='ALL' begin set @Product='%' end
if LTRIM(RTRIM(@salesRef))='ALL' begin set @salesRef='%' end
if LTRIM(RTRIM(@PackagingID))='ALL' begin set @PackagingID='%' end

SELECT dbo.tblLineItems.id, dbo.tblLineItems.ProductID, dbo.tblLineItems.Description, dbo.tblDocument.DocumentTypeId, dbo.tblLineItems.Quantity, 
               dbo.tblLineItems.Value, dbo.tblLineItems.Vat, dbo.tblDocument.DocumentIssuerCostCentreId, dbo.tblDocument.DocumentIssuerUserId, 
               dbo.tblDocument.DocumentDateIssued, dbo.tblDocument.DocumentRecipientCostCentre, dbo.tblDocument.DocumentIssuerCostCentreApplicationId, 
               dbo.tblDocument.OrderIssuedOnBehalfOfCC, dbo.tblDocument.OrderOrderTypeId, dbo.tblDocument.SendDateTime, dbo.tblCostCentre.Name AS Salesman, 
               dbo.tblCostCentre.CostCentreType AS SalesmanTypeID, dbo.tblCostCentre.ParentCostCentreId, dbo.tblCostCentre.RouteId, dbo.tblLineItems.DocumentID, 
               dbo.tblDocument.DocumentStatusId, tblCostCentre_1.Id AS DistributorID, tblCostCentre_1.Name AS Distributor, tblCostCentre_2.Name AS Producer, 
               tblCostCentre_2.CostCentreType AS ProducerID, dbo.tblCostCentre.Id AS SalesManID, dbo.tblProduct.Description AS Product, 
               dbo.tblProductBrand.name AS Brand, dbo.tblLineItems.ProductDiscount, dbo.tblDocument.DocumentReference, dbo.tblProductPackaging.Name AS Packaging, 
               dbo.tblProduct.PackagingId,dbo.tblDocument.SaleDiscount
FROM  dbo.tblDocument INNER JOIN
               dbo.tblLineItems ON dbo.tblDocument.Id = dbo.tblLineItems.DocumentID INNER JOIN
               dbo.tblCostCentre ON dbo.tblDocument.DocumentRecipientCostCentre = dbo.tblCostCentre.Id INNER JOIN
               dbo.tblCostCentre AS tblCostCentre_1 ON dbo.tblCostCentre.ParentCostCentreId = tblCostCentre_1.Id INNER JOIN
               dbo.tblCostCentre AS tblCostCentre_2 ON tblCostCentre_1.ParentCostCentreId = tblCostCentre_2.Id INNER JOIN
               dbo.tblProduct ON dbo.tblLineItems.ProductID = dbo.tblProduct.id INNER JOIN
               dbo.tblProductBrand ON dbo.tblProduct.BrandId = dbo.tblProductBrand.id INNER JOIN
               dbo.tblProductPackaging ON dbo.tblProduct.PackagingId = dbo.tblProductPackaging.Id
WHERE (dbo.tblDocument.DocumentTypeId = 1) AND (dbo.tblDocument.OrderOrderTypeId = 1 OR
               dbo.tblDocument.OrderOrderTypeId = 3) 
               AND (CONVERT(VARCHAR(26), dbo.tblDocument.DocumentDateIssued,23) BETWEEN @startDate AND @endDate) AND 
               (dbo.tblCostCentre.CostCentreType = 4) AND 
               (dbo.tblDocument.DocumentStatusId = 99)
               
               --AND (dbo.tblProductBrand.name LIKE ISNULL(@Brand, N'%')) AND (CONVERT(NVARCHAR(50), tblCostCentre_1.Id) 
               --LIKE ISNULL(@distributorID, N'%')) AND (CONVERT(NVARCHAR(50), dbo.tblCostCentre.Id) LIKE ISNULL(@salesManID, N'%')) AND (CONVERT(NVARCHAR(50), 
               --dbo.tblDocument.DocumentReference) LIKE ISNULL(@salesRef, N'%')) AND (dbo.tblProduct.Description LIKE ISNULL(@Product, N'%')) 
               ---- AND (CONVERT(NVARCHAR(50),dbo.tblProduct.PackagingId) LIKE ISNULL(@PackagingID, N'%'))
               
               
UNION ALL
SELECT tblLineItems_1.id, tblLineItems_1.ProductID, tblLineItems_1.Description, tblDocument_1.DocumentTypeId, tblLineItems_1.Quantity, tblLineItems_1.Value, 
               tblLineItems_1.Vat, tblDocument_1.DocumentIssuerCostCentreId, tblDocument_1.DocumentIssuerUserId, tblDocument_1.DocumentDateIssued, 
               tblDocument_1.DocumentRecipientCostCentre, tblDocument_1.DocumentIssuerCostCentreApplicationId, tblDocument_1.OrderIssuedOnBehalfOfCC, 
               tblDocument_1.OrderOrderTypeId, tblDocument_1.SendDateTime, tblCostCentre_3.Name AS Salesman, tblCostCentre_3.CostCentreType AS SalesmanTypeID, 
               tblCostCentre_3.ParentCostCentreId, tblCostCentre_3.RouteId, tblLineItems_1.DocumentID, tblDocument_1.DocumentStatusId, 
               tblCostCentre_1.Id AS DistributorID, tblCostCentre_1.Name AS Distributor, tblCostCentre_2.Name AS Producer, tblCostCentre_2.CostCentreType AS ProducerID, 
               tblCostCentre_3.Id AS SalesManID, tblProduct_1.Description AS Product, tblProductBrand_1.name AS Brand, tblLineItems_1.ProductDiscount, 
               tblDocument_1.DocumentReference, dbo.tblProductPackaging.Name AS Packaging, tblProduct_1.PackagingTypeId, tblDocument_1.SaleDiscount
FROM  dbo.tblProductBrand AS tblProductBrand_1 INNER JOIN
               dbo.tblProduct AS tblProduct_1 ON tblProductBrand_1.id = tblProduct_1.BrandId INNER JOIN
               dbo.tblCostCentre AS tblCostCentre_1 INNER JOIN
               dbo.tblCostCentre AS tblCostCentre_3 ON tblCostCentre_1.Id = tblCostCentre_3.ParentCostCentreId INNER JOIN
               dbo.tblCostCentre AS tblCostCentre_2 ON tblCostCentre_1.ParentCostCentreId = tblCostCentre_2.Id INNER JOIN
               dbo.tblDocument AS tblDocument_1 INNER JOIN
               dbo.tblLineItems AS tblLineItems_1 ON tblDocument_1.Id = tblLineItems_1.DocumentID ON tblCostCentre_3.Id = tblDocument_1.DocumentIssuerCostCentreId ON 
               tblProduct_1.id = tblLineItems_1.ProductID INNER JOIN
               dbo.tblProductPackaging ON tblProduct_1.PackagingId = dbo.tblProductPackaging.Id
WHERE (tblDocument_1.DocumentTypeId = 1) 
AND (tblDocument_1.OrderOrderTypeId = 1 OR
               tblDocument_1.OrderOrderTypeId = 3) 
               AND (CONVERT(VARCHAR(26), tblDocument_1.DocumentDateIssued,23) BETWEEN @startDate AND @endDate) AND
                (tblDocument_1.DocumentStatusId = 99)
               
               --AND 
               --(tblProductBrand_1.name LIKE ISNULL(@Brand, N'%')) AND (CONVERT(NVARCHAR(50), tblCostCentre_1.Id) LIKE ISNULL(@distributorID, N'%')) AND 
               --(CONVERT(NVARCHAR(50), tblDocument_1.DocumentReference) LIKE ISNULL(@salesRef, N'%')) AND (tblProduct_1.Description LIKE ISNULL(@Product, N'%'))  AND (tblCostCentre_3.CostCentreType = 4) AND (CONVERT(NVARCHAR(50), tblCostCentre_3.Id) 
               --LIKE ISNULL(@salesManID, N'%'))
               
               -- AND (CONVERT(NVARCHAR(50),tblProduct_1.PackagingTypeId) LIKE ISNULL(@PackagingID, N'%'))
GO
