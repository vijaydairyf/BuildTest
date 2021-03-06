/****** Object:  StoredProcedure [dbo].[sp_D_OrderSubreportProd]    Script Date: 07/24/2013 08:51:32 ******/
DROP PROCEDURE [dbo].[sp_D_OrderSubreportProd]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_D_OrderSubreportProd]
(@documentId AS NVARCHAR(50))
AS
if  @documentId='ALL'  begin set @documentId='%' end

SELECT    
            dbo.tblDocument.DocumentReference, 
            dbo.tblDocument.Id   , 
            dbo.tblProduct.id AS ProductId, 
            dbo.tblProduct.Description AS ProductName, 
            dbo.tblDocument.DocumentTypeId,            
            dbo.tblDocument.OrderOrderTypeId, 
            dbo.tblLineItems.OrderLineItemType, 
            dbo.tblProduct.Returnable, 
            dbo.tblProduct.ReturnableType, 
            dbo.tblProduct.DomainTypeId, 
            CASE WHEN DomainTypeId = 1 THEN 'Sale' 
                 WHEN DomainTypeId = 2 THEN 'Consolidated' 
                 WHEN DomainTypeId = 3 THEN 'Returnable' 
                 WHEN DomainTypeId = 7 THEN 'Discount' END AS ProductType, 
            dbo.tblLineItems.Quantity, 
            dbo.tblLineItems.Value,
            dbo.tblLineItems.Vat, 
            dbo.tblDocument.SaleDiscount, 
            dbo.tblLineItems.ProductDiscount,
            dbo.tblProduct.ProductCode AS ProductCode 
FROM        dbo.tblDocument INNER JOIN
            dbo.tblLineItems ON dbo.tblDocument.Id = dbo.tblLineItems.DocumentID INNER JOIN
            dbo.tblProduct ON dbo.tblLineItems.ProductID = dbo.tblProduct.id 
           
WHERE      (dbo.tblDocument.DocumentTypeId = 1) AND 
           (dbo.tblDocument.OrderOrderTypeId = 3) AND
           (CONVERT(NVARCHAR(50), dbo.tblDocument.Id)LIKE ISNULL(@documentId, N'%'))
           
 --  Exec  [dbo].[sp_D_OrderSubreportProd]     @documentId='764efcc2-255e-48df-bb15-370f5373f31f'  
           

GO
