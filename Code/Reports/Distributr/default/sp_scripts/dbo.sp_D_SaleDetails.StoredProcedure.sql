/****** Object:  StoredProcedure [dbo].[sp_D_SaleDetails]    Script Date: 07/24/2013 08:51:32 ******/
DROP PROCEDURE [dbo].[sp_D_SaleDetails]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_D_SaleDetails]
(
@startDate as date,
@endDate as date,
--@salesRef as nvarchar(50),
@docId as nvarchar(50)
)
as
if  @docId='ALL'  begin set @docId='%' end

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
       dbo.tblDocument.SendDateTime, 
       dbo.tblCostCentre.Name AS Salesman, 
       dbo.tblCostCentre.CostCentreType AS SalesmanTypeID, 
       dbo.tblCostCentre.ParentCostCentreId, 
       dbo.tblCostCentre.RouteId, 
       dbo.tblLineItems.DocumentID, 
       DocumentStatusId =CASE when dbo.tblDocument.DocumentStatusId = 99 then 'Closed'End, 
       tblCostCentre_1.Id AS DistributorID, 
       tblCostCentre_1.Name AS Distributor, 
       tblCostCentre_2.Name AS Producer, 
       tblCostCentre_2.CostCentreType AS ProducerID, 
       dbo.tblCostCentre.Id AS SalesManID, 
       dbo.tblProduct.Description AS Product, 
       dbo.tblProductBrand.name AS Brand, 
       dbo.tblLineItems.ProductDiscount, 
       dbo.tblDocument.DocumentReference, 
       dbo.tblProductType.name AS ProductType, 
       tblDocument.Longitude AS DocumentLongitude, 
       tblDocument.Latitude AS DocumentLatitude, 
       tblDocument.SaleDiscount,
       Outlet.Id AS OutletId,
       Outlet.Name as OutletName--,
       --InvoiceAmount = Case when DocumentTypeId = 1 then tblLineItems.Value  end,
       --CreditNoteAmount = Case when DocumentTypeId =10 then tblLineItems.Value end,
       --ReceivedAmt = Case when DocumentTypeId = 5 then tblLineItems.Value end
       
FROM  dbo.tblDocument INNER JOIN
               dbo.tblLineItems ON dbo.tblDocument.Id = dbo.tblLineItems.DocumentID INNER JOIN
               dbo.tblCostCentre ON dbo.tblDocument.DocumentRecipientCostCentre = dbo.tblCostCentre.Id INNER JOIN
               dbo.tblCostCentre AS tblCostCentre_1 ON dbo.tblCostCentre.ParentCostCentreId = tblCostCentre_1.Id INNER JOIN
               dbo.tblCostCentre AS tblCostCentre_2 ON tblCostCentre_1.ParentCostCentreId = tblCostCentre_2.Id INNER JOIN
               dbo.tblCostCentre AS Outlet on dbo.tblCostCentre.Id = Outlet.ParentCostCentreId INNER JOIN
               dbo.tblProduct ON dbo.tblLineItems.ProductID = dbo.tblProduct.id INNER JOIN
               dbo.tblProductBrand ON dbo.tblProduct.BrandId = dbo.tblProductBrand.id INNER JOIN
               dbo.tblProductType ON dbo.tblProduct.ProductTypeId = dbo.tblProductType.id
WHERE        (dbo.tblDocument.DocumentTypeId = 1) 
               -- (tblDocument.DocumentTypeId = 1 
               --OR tblDocument.DocumentTypeId = 5 
               --OR tblDocument.DocumentTypeId = 10)
           AND (dbo.tblDocument.OrderOrderTypeId = 1)-- OR dbo.tblDocument.OrderOrderTypeId = 3)
                AND Outlet.CostCentreType = 5
                AND (LOWER(CONVERT(VARCHAR(50),dbo.tblDocument.Id))like ISNULL(@docId,'%'))
                AND (CONVERT(VARCHAR(26), dbo.tblDocument.SendDateTime,23) BETWEEN @startDate AND @endDate)
             --   AND (CONVERT(NVARCHAR(50),dbo.tblDocument.DocumentReference) = @salesRef)

               --  AND 
               --(dbo.tblCostCentre.CostCentreType = 4)
               -- AND (dbo.tblProductBrand.name LIKE ISNULL(@Brand, N'%')) 
               -- AND (tblCostCentre_1.Id LIKE ISNULL(@distributorID, N'%')) 
               --AND (dbo.tblCostCentre.Id LIKE ISNULL(@salesManID, N'%'))
                --AND (dbo.tblProduct.Description LIKE ISNULL(@Product, N'%')) 
                --AND (dbo.tblDocument.DocumentStatusId = 99)
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
       tblDocument_1.SendDateTime, 
       tblCostCentre_3.Name AS Salesman, 
       tblCostCentre_3.CostCentreType AS SalesmanTypeID, 
       tblCostCentre_3.ParentCostCentreId, 
       tblCostCentre_3.RouteId, 
       tblLineItems_1.DocumentID, 
       DocumentStatusId = CASE when tblDocument_1.DocumentStatusId = 99 then 'Closed'End, 
       tblCostCentre_1.Id AS DistributorID, 
       tblCostCentre_1.Name AS Distributor, 
       tblCostCentre_2.Name AS Producer, 
       tblCostCentre_2.CostCentreType AS ProducerID, 
       tblCostCentre_3.Id AS SalesManID, 
       tblProduct_1.Description AS Product, 
       tblProductBrand_1.name AS Brand, 
       tblLineItems_1.ProductDiscount, 
       tblDocument_1.DocumentReference, 
       dbo.tblProductType.name AS ProductType, 
       tblDocument_1.Longitude AS DocumentLongitude, 
       tblDocument_1.Latitude AS DocumentLatitude, 
       tblDocument_1.SaleDiscount,
       Outlet.Id AS OutletId,
       Outlet.Name as OutletName
      -- InvoiceAmount = Case when DocumentTypeId = 1 then tblLineItems_1.Value  end,
      -- CreditNoteAmount = Case when DocumentTypeId =10 then tblLineItems_1.Value end,
      -- ReceivedAmt = Case when DocumentTypeId = 5 then tblLineItems_1.Value end
       
FROM  dbo.tblProductBrand AS tblProductBrand_1 INNER JOIN
               dbo.tblProduct AS tblProduct_1 ON tblProductBrand_1.id = tblProduct_1.BrandId INNER JOIN
               dbo.tblCostCentre AS tblCostCentre_1 INNER JOIN
               dbo.tblCostCentre AS tblCostCentre_3 ON tblCostCentre_1.Id = tblCostCentre_3.ParentCostCentreId INNER JOIN
               dbo.tblCostCentre AS tblCostCentre_2 ON tblCostCentre_1.ParentCostCentreId = tblCostCentre_2.Id INNER JOIN
               dbo.tblCostCentre AS Outlet on tblCostCentre_1.Id = Outlet.ParentCostCentreId INNER JOIN
               dbo.tblDocument AS tblDocument_1 INNER JOIN
               dbo.tblLineItems AS tblLineItems_1 ON tblDocument_1.Id = tblLineItems_1.DocumentID ON tblCostCentre_3.Id = tblDocument_1.DocumentIssuerCostCentreId ON 
               tblProduct_1.id = tblLineItems_1.ProductID INNER JOIN
               dbo.tblProductType ON tblProduct_1.ProductTypeId = dbo.tblProductType.id
WHERE            (tblDocument_1.DocumentTypeId = 1) 
               --  (tblDocument_1.DocumentTypeId = 1 
               --OR tblDocument_1.DocumentTypeId = 5 
               --OR tblDocument_1.DocumentTypeId = 10)
               AND (tblDocument_1.OrderOrderTypeId = 1)-- OR tblDocument_1.OrderOrderTypeId = 3)
               AND (Outlet.CostCentreType = 5)
               AND (LOWER(CONVERT(VARCHAR(50),tblDocument_1.Id))like ISNULL(@docId,'%'))
               AND (CONVERT(VARCHAR(26), tblDocument_1.SendDateTime,23) BETWEEN @startDate AND @endDate) 
              -- AND (CONVERT(NVARCHAR(50),tblDocument_1.DocumentReference) = @salesRef)

               --AND (tblProductBrand_1.name LIKE ISNULL(@Brand, N'%')) 
               --AND (tblCostCentre_1.Id LIKE ISNULL(@distributorID, N'%')) 
               --AND (tblProduct_1.Description LIKE ISNULL(@Product, N'%')) 
               --AND (tblCostCentre_3.CostCentreType = 4) 
               --AND (tblCostCentre_3.Id LIKE ISNULL(@salesManID, N'%')) 
               --AND (tblDocument_1.DocumentStatusId = 99)
GO
