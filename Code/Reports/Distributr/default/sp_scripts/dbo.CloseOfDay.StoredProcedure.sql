/****** Object:  StoredProcedure [dbo].[CloseOfDay]    Script Date: 07/24/2013 08:51:31 ******/
DROP PROCEDURE [dbo].[CloseOfDay]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[CloseOfDay]
(

@startDate as datetime,
@endDate as datetime,
@distributorID AS NVARCHAR(50),

@OrderOrder as integer


)
as 
if LTRIM(RTRIM(@distributorID))='ALL' begin set @distributorID='%' end

SELECT TOP (100) PERCENT dbo.tblLineItems.id, dbo.tblLineItems.ProductID, dbo.tblLineItems.Description, dbo.tblDocument.DocumentTypeId, dbo.tblLineItems.Quantity, 
               dbo.tblLineItems.Value, dbo.tblLineItems.Vat, dbo.tblDocument.DocumentIssuerCostCentreId, dbo.tblDocument.DocumentIssuerUserId, 
               dbo.tblDocument.DocumentDateIssued, dbo.tblDocument.DocumentRecipientCostCentre, dbo.tblDocument.DocumentIssuerCostCentreApplicationId, 
               dbo.tblDocument.OrderIssuedOnBehalfOfCC, dbo.tblDocument.OrderOrderTypeId, dbo.tblDocument.SendDateTime, dbo.tblLineItems.DocumentID, 
               dbo.tblDocument.DocumentStatusId, dbo.tblProduct.Description AS Product, dbo.tblProductBrand.name AS Brand, dbo.tblDocument.SaleDiscount, 
               dbo.tblLineItems.ReturnsNoteReason, dbo.tblCostCentre.Name, dbo.tblCostCentre.CostCentreType, dbo.tblLineItems.OrderLineItemType, 
               tblCostCentre_1.Name AS Distributor, dbo.tblCostCentre.ParentCostCentreId AS DistributorID
FROM  dbo.tblDocument INNER JOIN
               dbo.tblLineItems ON dbo.tblDocument.Id = dbo.tblLineItems.DocumentID INNER JOIN
               dbo.tblProduct ON dbo.tblLineItems.ProductID = dbo.tblProduct.id INNER JOIN
               dbo.tblProductBrand ON dbo.tblProduct.BrandId = dbo.tblProductBrand.id INNER JOIN
               dbo.tblCostCentre ON dbo.tblDocument.DocumentIssuerCostCentreId = dbo.tblCostCentre.Id INNER JOIN
               dbo.tblCostCentre AS tblCostCentre_1 ON dbo.tblCostCentre.ParentCostCentreId = tblCostCentre_1.Id
WHERE (dbo.tblDocument.DocumentTypeId = 7) 
 AND (dbo.tblCostCentre.CostCentreType = 4) 
 AND (dbo.tblDocument.OrderOrderTypeId = 1)  
AND (CONVERT(VARCHAR(26), dbo.tblDocument.DocumentDateIssued, 23) BETWEEN @startDate AND @endDate) 
AND (dbo.tblLineItems.OrderLineItemType = 0)
AND CONVERT(NVARCHAR(50),dbo.tblCostCentre.ParentCostCentreId) like @distributorID
ORDER BY dbo.tblDocument.SendDateTime
GO
