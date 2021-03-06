/****** Object:  StoredProcedure [dbo].[sp_D_SaleDetailsSummary]    Script Date: 07/24/2013 08:51:32 ******/
DROP PROCEDURE [dbo].[sp_D_SaleDetailsSummary]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_D_SaleDetailsSummary]
(
@startDate as date,
@endDate as date,
@salesRef as nvarchar(50)
)
as
SELECT tblLineItems_1.id, 
       tblLineItems_1.ProductID, 
       tblLineItems_1.Description, 
       tblDocument_1.DocumentTypeId, 
       tblLineItems_1.Quantity, 
       tblLineItems_1.Value, 
       tblLineItems_1.Vat, 
       tblDocument_1.Id as DocId,
       tblDocument_1.DocumentIssuerCostCentreId, 
       tblDocument_1.DocumentIssuerUserId, 
       tblDocument_1.DocumentDateIssued, 
       tblDocument_1.DocumentRecipientCostCentre, 
       tblDocument_1.DocumentIssuerCostCentreApplicationId, 
       tblDocument_1.OrderIssuedOnBehalfOfCC, 
       tblDocument_1.OrderOrderTypeId, 
       tblDocument_1.SendDateTime, 
       tblDocument_1.DocumentReference,
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
       Outlet.Name as OutletName,
       InvoiceAmount = Case when DocumentTypeId = 1 then Value  end,
       CreditNoteAmount = Case when DocumentTypeId =10 then Value end,
       ReceivedAmt = Case when DocumentTypeId = 5 then Value end
       
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
WHERE          (tblDocument_1.OrderParentId = tblDocument_1.Id) AND
                (tblDocument_1.DocumentTypeId = 1 
               OR tblDocument_1.DocumentTypeId = 5 
               OR tblDocument_1.DocumentTypeId = 10) AND 
               (tblDocument_1.OrderOrderTypeId = 1 OR
               tblDocument_1.OrderOrderTypeId = 3) 
               AND (CONVERT(VARCHAR(26), tblDocument_1.SendDateTime,23) BETWEEN @startDate AND @endDate) 
                AND Outlet.CostCentreType = 5
               --AND (tblProductBrand_1.name LIKE ISNULL(@Brand, N'%')) 
               --AND (tblCostCentre_1.Id LIKE ISNULL(@distributorID, N'%')) 
              AND (Convert(nvarchar(50),tblDocument_1.DocumentReference) LIKE ISNULL(@salesRef, N'%'))
GO
