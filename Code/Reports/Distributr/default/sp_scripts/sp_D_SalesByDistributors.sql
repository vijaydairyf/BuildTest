
/****** Object:  StoredProcedure [dbo].[sp_D_SalesByDistributors]    Script Date: 09/09/2013 10:15:28 ******/
DROP PROCEDURE [dbo].[sp_D_SalesByDistributors]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_D_SalesByDistributors]
(
@startDate as datetime,
@endDate as datetime,
@distributorID AS NVARCHAR(50),
--@Country AS NVARCHAR(50)
@salesManID AS NVARCHAR(50)
--@Product AS NVARCHAR(50),
--@salesRef AS NVARCHAR(50),
--@PackagingID AS NVARCHAR(50)
)
as 


if  @distributorID='ALL'  begin set @distributorID='%' end
--if  @Country='ALL'  begin set @Country='%' end
if  @salesManID='ALL'  begin set @salesManID='%' end
--if  @Product='ALL'  begin set @Product='%' end
--if  @salesRef='ALL'  begin set @salesRef='%' end
--if  Ltrim(@PackagingID)='ALL'  begin set @PackagingID='%' end



                      SELECT dbo.tblLineItems.id, 
                             dbo.tblDocument.DocumentParentId, 
                             dbo.tblLineItems.ProductID, 
                             dbo.tblLineItems.Description, 
                             dbo.tblDocument.DocumentTypeId, 
                             dbo.tblLineItems.Quantity, 
                             dbo.tblLineItems.Value, 
                             dbo.tblLineItems.Vat, 
                             dbo.tblLineItems.IAN_Actual, 
                             dbo.tblDocument.DocumentReference, 
                             dbo.tblDocument.DocumentIssuerCostCentreId, 
                             dbo.tblDocument.DocumentIssuerUserId, 
                             dbo.tblDocument.DocumentDateIssued, 
                             dbo.tblDocument.DocumentRecipientCostCentre, 
                             dbo.tblDocument.OrderDateRequired, 
                             dbo.tblDocument.DocumentIssuerCostCentreApplicationId, 
                             dbo.tblDocument.OrderIssuedOnBehalfOfCC, 
                             dbo.tblDocument.InvoiceOrderId, 
                             dbo.tblDocument.OrderOrderTypeId, 
                             dbo.tblDocument.SendDateTime, 
                             dbo.tblDocument.PaymentDocId, 
                             dbo.tblCostCentre.Name AS Salesman, 
                             dbo.tblCostCentre.CostCentreType AS SalesmanTypeID, 
                             dbo.tblCostCentre.ParentCostCentreId, 
                             dbo.tblCostCentre.RouteId, 
                             dbo.tblLineItems.DocumentID,
                             dbo.tblDocument.OrderParentId,  
                             dbo.tblDocument.DocumentStatusId, 
                             dbo.tblLineItems.ApprovedQuantity, 
                             dbo.tblLineItems.LostSaleQuantity, 
                             dbo.tblLineItems.BackOrderQuantity, 
                             dbo.tblLineItems.DispatchedQuantity, 
                             tblCostCentre_1.Distributor_RegionId, 
                             tblCostCentre_1.Id AS DistributorID, 
                             tblCostCentre_1.Name AS Distributor, 
                             tblCostCentre_2.Name AS Producer, 
                             tblCostCentre_2.CostCentreType AS ProducerID, 
                             dbo.tblCostCentre.Id AS SalesManID, 
                             dbo.tblProduct.Description AS Product, 
                             dbo.tblProductBrand.name AS Brand, 
                             dbo.tblLineItems.ProductDiscount,
                             dbo.tblDocument.SaleDiscount,
                             (select top(1) dbo.tblDocument.SaleDiscount)as SaleValueDiscount
                      FROM    dbo.tblDocument INNER JOIN
                              dbo.tblLineItems ON dbo.tblDocument.Id = dbo.tblLineItems.DocumentID INNER JOIN
                              dbo.tblCostCentre ON dbo.tblDocument.DocumentRecipientCostCentre = dbo.tblCostCentre.Id INNER JOIN
                              dbo.tblCostCentre AS tblCostCentre_1 ON dbo.tblCostCentre.ParentCostCentreId = tblCostCentre_1.Id INNER JOIN
                              dbo.tblCostCentre AS tblCostCentre_2 ON tblCostCentre_1.ParentCostCentreId = tblCostCentre_2.Id INNER JOIN
                              dbo.tblProduct ON dbo.tblLineItems.ProductID = dbo.tblProduct.id INNER JOIN
                              dbo.tblProductBrand ON dbo.tblProduct.BrandId = dbo.tblProductBrand.id
                      WHERE  (CONVERT(VARCHAR(26), dbo.tblDocument.DocumentDateIssued, 23) BETWEEN @startDate AND @endDate) 
                      AND (dbo.tblCostCentre.CostCentreType = 4) 
                      AND (dbo.tblDocument.DocumentTypeId = 1) 
                      AND (dbo.tblDocument.OrderOrderTypeId = 1 OR( dbo.tblDocument.OrderOrderTypeId = 3 AND dbo.tblDocument.DocumentStatusId = 99)) 
                      AND (tblCostCentre_1.Id LIKE ISNULL(@distributorID, '%')) 
                      AND (dbo.tblCostCentre.Id LIKE ISNULL(@salesManID, '%')) 
UNION ALL
SELECT tblLineItems_1.id, 
       tblDocument_1.DocumentParentId,
       tblLineItems_1.ProductID, 
       tblLineItems_1.Description, 
       tblDocument_1.DocumentTypeId, 
       tblLineItems_1.Quantity, 
       tblLineItems_1.Value, 
       tblLineItems_1.Vat, 
       tblLineItems_1.IAN_Actual, 
       tblDocument_1.DocumentReference, 
       tblDocument_1.DocumentIssuerCostCentreId, 
       tblDocument_1.DocumentIssuerUserId, 
       tblDocument_1.DocumentDateIssued,       
       tblDocument_1.DocumentRecipientCostCentre, 
       tblDocument_1.OrderDateRequired, 
       tblDocument_1.DocumentIssuerCostCentreApplicationId, 
       tblDocument_1.OrderIssuedOnBehalfOfCC, 
       tblDocument_1.InvoiceOrderId, 
       tblDocument_1.OrderOrderTypeId, 
       tblDocument_1.SendDateTime, 
       tblDocument_1.PaymentDocId, 
       tblCostCentre_3.Name AS Salesman, 
       tblCostCentre_3.CostCentreType AS SalesmanTypeID, 
       tblCostCentre_3.ParentCostCentreId, 
       tblCostCentre_3.RouteId, 
       tblLineItems_1.DocumentID,
       tblDocument_1.OrderParentId, 
       tblDocument_1.DocumentStatusId, 
       tblLineItems_1.ApprovedQuantity, 
       tblLineItems_1.LostSaleQuantity, 
       tblLineItems_1.BackOrderQuantity, 
       tblLineItems_1.DispatchedQuantity, 
       tblCostCentre_1.Distributor_RegionId, 
       tblCostCentre_1.Id AS DistributorID, 
       tblCostCentre_1.Name AS Distributor, 
       tblCostCentre_2.Name AS Producer, 
       tblCostCentre_2.CostCentreType AS ProducerID, 
       tblCostCentre_3.Id AS SalesManID, 
       tblProduct_1.Description AS Product, 
       tblProductBrand_1.name AS Brand, 
       tblLineItems_1.ProductDiscount,
       tblDocument_1.SaleDiscount, 
       (select top(1) tblDocument_1.SaleDiscount) as SaleValueDiscount
FROM  dbo.tblProductBrand AS tblProductBrand_1 INNER JOIN
               dbo.tblProduct AS tblProduct_1 ON tblProductBrand_1.id = tblProduct_1.BrandId INNER JOIN
               dbo.tblCostCentre AS tblCostCentre_1 INNER JOIN
               dbo.tblCostCentre AS tblCostCentre_3 ON tblCostCentre_1.Id = tblCostCentre_3.ParentCostCentreId INNER JOIN
               dbo.tblCostCentre AS tblCostCentre_2 ON tblCostCentre_1.ParentCostCentreId = tblCostCentre_2.Id INNER JOIN
               dbo.tblDocument AS tblDocument_1 INNER JOIN
               dbo.tblLineItems AS tblLineItems_1 ON tblDocument_1.Id = tblLineItems_1.DocumentID ON tblCostCentre_3.Id = tblDocument_1.DocumentIssuerCostCentreId ON 
               tblProduct_1.id = tblLineItems_1.ProductID
WHERE (tblDocument_1.DocumentTypeId = 1) 
       AND (tblDocument_1.OrderOrderTypeId = 1 OR (tblDocument_1.OrderOrderTypeId = 3 AND tblDocument_1.DocumentStatusId = 99))
                AND (CONVERT(VARCHAR(26), tblDocument_1.DocumentDateIssued, 23) BETWEEN @startDate AND @endDate) 
                AND (tblCostCentre_1.Id LIKE ISNULL(@distributorID, '%')) 
                AND (tblCostCentre_3.CostCentreType = 4) 
                AND (tblCostCentre_3.Id LIKE ISNULL(@salesManID, '%')) 
                