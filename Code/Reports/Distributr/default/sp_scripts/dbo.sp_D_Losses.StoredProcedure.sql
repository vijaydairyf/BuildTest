/****** Object:  StoredProcedure [dbo].[sp_D_Losses]    Script Date: 07/24/2013 08:51:32 ******/
DROP PROCEDURE [dbo].[sp_D_Losses]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_D_Losses]
(

@startDate as datetime,
@endDate as datetime,
@OrderOrder as integer,
@distributorID as nvarchar(50),
@productID as nvarchar(50)
)
as 
if  @distributorID='ALL'  begin set @distributorID='%' end
if  @productID='ALL' begin set @productID='%' end

SELECT TOP (100) PERCENT 
               dbo.tblLineItems.id, 
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
               dbo.tblLineItems.DocumentID, 
               dbo.tblDocument.DocumentStatusId, 
               dbo.tblProduct.Description AS Product, 
               dbo.tblProductBrand.name AS Brand, 
               dbo.tblDocument.SaleDiscount, 
               dbo.tblLineItems.ReturnsNoteReason,
               dbo.tblCostCentre.Id, 
               dbo.tblCostCentre.Name, 
               dbo.tblCostCentre.CostCentreType, 
               dbo.tblLineItems.Receipt_PaymentTypeId, 
               dbo.tblLineItems.OrderLineItemType,
               
               CASE
                       WHEN OrderLineItemType = 11 THEN 'Stolen'        
                       WHEN OrderLineItemType = 12 THEN 'Expired'
                       WHEN OrderLineItemType = 13 THEN 'Breakage'
                       WHEN OrderLineItemType = 14 THEN 'Sub_Standard'
                       WHEN OrderLineItemType = 15 THEN 'Swap'
                       WHEN OrderLineItemType = 16 THEN 'Other'
                    
               END  as Reason
               
               
               
               
FROM  dbo.tblDocument INNER JOIN
      dbo.tblLineItems ON dbo.tblDocument.Id = dbo.tblLineItems.DocumentID INNER JOIN
      dbo.tblProduct ON dbo.tblLineItems.ProductID = dbo.tblProduct.id INNER JOIN
      dbo.tblProductBrand ON dbo.tblProduct.BrandId = dbo.tblProductBrand.id INNER JOIN
      dbo.tblCostCentre ON dbo.tblDocument.DocumentIssuerCostCentreId = dbo.tblCostCentre.Id
WHERE (dbo.tblDocument.DocumentTypeId = 7) 
       
      AND (dbo.tblCostCentre.CostCentreType = 4)
      AND (dbo.tblLineItems.OrderLineItemType <> 0)
      AND (CONVERT(NVARCHAR(50), tblCostCentre.ParentCostCentreId) LIKE ISNULL(@distributorID, N'%')) 
      AND CONVERT(VARCHAR(26), dbo.tblDocument.DocumentDateIssued, 23) between @startDate and  @endDate
      AND CONVERT(VARCHAR(50), dbo.tblLineItems.ProductID) LIKE ISNULL(@productID, N'%')
ORDER BY dbo.tblDocument.DocumentDateIssued
GO
