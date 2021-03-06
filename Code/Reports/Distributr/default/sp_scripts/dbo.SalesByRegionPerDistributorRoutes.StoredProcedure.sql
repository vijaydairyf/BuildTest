/****** Object:  StoredProcedure [dbo].[SalesByRegionPerDistributorRoutes]    Script Date: 07/24/2013 08:51:32 ******/
DROP PROCEDURE [dbo].[SalesByRegionPerDistributorRoutes]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SalesByRegionPerDistributorRoutes]
(
@startDate as datetime,
 @endDate as datetime,

 
@Country as nvarchar(50),
@Region as nvarchar(100),
@DistributorID as nvarchar(50)
)
as 
if  @Region='ALL'   begin set @Region='%' end
if  @Country='ALL'  begin set @Country='%' end
if  @DistributorID='ALL'  begin set @DistributorID='%' end
--sales by saleman
--JION ON dbo.tblDocument.DocumentRecipientCostCentre = dbo.tblCostCentre.Id 

SELECT dbo.tblLineItems.id, dbo.tblDocument.DocumentParentId, dbo.tblLineItems.ProductID, dbo.tblLineItems.Description, dbo.tblDocument.DocumentTypeId, 
               dbo.tblLineItems.Quantity, dbo.tblLineItems.Value, dbo.tblLineItems.Vat, dbo.tblLineItems.IAN_Actual, dbo.tblDocument.DocumentReference, 
               dbo.tblDocument.DocumentIssuerCostCentreId, dbo.tblDocument.DocumentIssuerUserId, dbo.tblDocument.DocumentDateIssued, 
               dbo.tblDocument.DocumentRecipientCostCentre, dbo.tblDocument.OrderDateRequired, dbo.tblDocument.DocumentIssuerCostCentreApplicationId, 
               dbo.tblDocument.OrderIssuedOnBehalfOfCC, dbo.tblDocument.InvoiceOrderId, dbo.tblDocument.OrderOrderTypeId, dbo.tblDocument.SendDateTime, 
               dbo.tblDocument.PaymentDocId, dbo.tblCostCentre.Name AS Salesman, dbo.tblCostCentre.CostCentreType AS SalesmanTypeID, 
               dbo.tblCostCentre.ParentCostCentreId, dbo.tblLineItems.DocumentID, dbo.tblDocument.DocumentStatusId, dbo.tblLineItems.ApprovedQuantity, 
               dbo.tblLineItems.LostSaleQuantity, dbo.tblLineItems.BackOrderQuantity, dbo.tblLineItems.DispatchedQuantity, tblCostCentre_1.Distributor_RegionId, 
               tblCostCentre_1.Id AS DistributorID, tblCostCentre_1.Name AS Distributor, dbo.tblCostCentre.Id AS SalesManID, dbo.tblRoutes.Name AS Route, 
               dbo.tblRegion.Name AS Region, dbo.tblRoutes.RouteID, dbo.tblCountry.Name AS Country, dbo.tblLineItems.ProductDiscount,dbo.tblDocument.SaleDiscount
FROM  dbo.tblRoutes INNER JOIN
               dbo.tblSalemanRoute ON dbo.tblRoutes.RouteID = dbo.tblSalemanRoute.RouteId AND dbo.tblRoutes.RouteID = dbo.tblSalemanRoute.RouteId INNER JOIN
               dbo.tblDocument INNER JOIN
               dbo.tblLineItems ON dbo.tblDocument.Id = dbo.tblLineItems.DocumentID INNER JOIN
               dbo.tblCostCentre ON dbo.tblDocument.DocumentRecipientCostCentre = dbo.tblCostCentre.Id INNER JOIN
               dbo.tblCostCentre AS tblCostCentre_1 ON dbo.tblCostCentre.ParentCostCentreId = tblCostCentre_1.Id ON 
               dbo.tblSalemanRoute.SalemanId = dbo.tblCostCentre.Id INNER JOIN
               dbo.tblRegion ON dbo.tblRoutes.RegionId = dbo.tblRegion.id INNER JOIN
               dbo.tblCountry ON dbo.tblRegion.Country = dbo.tblCountry.id
WHERE (dbo.tblDocument.DocumentTypeId = 1)
 AND (dbo.tblDocument.OrderOrderTypeId = 1 OR
               dbo.tblDocument.OrderOrderTypeId = 3)
                AND (dbo.tblCostCentre.CostCentreType = 4)
                 AND (dbo.tblDocument.DocumentStatusId = 99) AND 
               (dbo.tblCountry.Name LIKE ISNULL(@Country, N'%'))
                AND (dbo.tblRegion.Name LIKE ISNULL(@Region, N'%'))
                 AND (CONVERT(NVARCHAR(50), tblCostCentre_1.Id) 
               LIKE ISNULL(@DistributorID, N'%')) 
               AND (CONVERT(VARCHAR(26), dbo.tblDocument.DocumentDateIssued,23) BETWEEN @startDate AND @endDate)               
               
UNION ALL

--JONIN ON  dbo.tblCostCentre.Id = dbo.tblDocument.DocumentIssuerCostCentreId
SELECT dbo.tblLineItems.id, dbo.tblDocument.DocumentParentId, dbo.tblLineItems.ProductID, dbo.tblLineItems.Description, dbo.tblDocument.DocumentTypeId, 
               dbo.tblLineItems.Quantity, dbo.tblLineItems.Value, dbo.tblLineItems.Vat, dbo.tblLineItems.IAN_Actual, dbo.tblDocument.DocumentReference, 
               dbo.tblDocument.DocumentIssuerCostCentreId, dbo.tblDocument.DocumentIssuerUserId, dbo.tblDocument.DocumentDateIssued, 
               dbo.tblDocument.DocumentRecipientCostCentre, dbo.tblDocument.OrderDateRequired, dbo.tblDocument.DocumentIssuerCostCentreApplicationId, 
               dbo.tblDocument.OrderIssuedOnBehalfOfCC, dbo.tblDocument.InvoiceOrderId, dbo.tblDocument.OrderOrderTypeId, dbo.tblDocument.SendDateTime, 
               dbo.tblDocument.PaymentDocId, dbo.tblCostCentre.Name AS Salesman, dbo.tblCostCentre.CostCentreType AS SalesmanTypeID, 
               dbo.tblCostCentre.ParentCostCentreId, dbo.tblLineItems.DocumentID, dbo.tblDocument.DocumentStatusId, dbo.tblLineItems.ApprovedQuantity, 
               dbo.tblLineItems.LostSaleQuantity, dbo.tblLineItems.BackOrderQuantity, dbo.tblLineItems.DispatchedQuantity, tblCostCentre_1.Distributor_RegionId, 
               tblCostCentre_1.Id AS DistributorID, tblCostCentre_1.Name AS Distributor, dbo.tblCostCentre.Id AS SalesManID, dbo.tblRoutes.Name AS Route, 
               dbo.tblRegion.Name AS Region, dbo.tblRoutes.RouteID, dbo.tblCountry.Name AS Country, dbo.tblLineItems.ProductDiscount, tblDocument.SaleDiscount
FROM  dbo.tblRegion INNER JOIN
               dbo.tblCostCentre AS tblCostCentre_1 INNER JOIN
               dbo.tblCostCentre ON tblCostCentre_1.Id = dbo.tblCostCentre.ParentCostCentreId INNER JOIN
               dbo.tblRoutes INNER JOIN
               dbo.tblSalemanRoute ON dbo.tblRoutes.RouteID = dbo.tblSalemanRoute.RouteId AND dbo.tblRoutes.RouteID = dbo.tblSalemanRoute.RouteId ON 
               dbo.tblCostCentre.Id = dbo.tblSalemanRoute.SalemanId ON dbo.tblRegion.id = dbo.tblRoutes.RegionId INNER JOIN
               dbo.tblCountry ON dbo.tblRegion.Country = dbo.tblCountry.id INNER JOIN
               dbo.tblDocument INNER JOIN
               dbo.tblLineItems ON dbo.tblDocument.Id = dbo.tblLineItems.DocumentID ON dbo.tblCostCentre.Id = dbo.tblDocument.DocumentIssuerCostCentreId
WHERE (dbo.tblDocument.DocumentTypeId = 1) 
AND (dbo.tblDocument.OrderOrderTypeId = 1 OR
               dbo.tblDocument.OrderOrderTypeId = 3)
                AND (dbo.tblCostCentre.CostCentreType = 4) 
                AND (dbo.tblDocument.DocumentStatusId = 99) AND 
               (dbo.tblCountry.Name LIKE ISNULL(@Country, N'%')) 
               AND (dbo.tblRegion.Name LIKE ISNULL(@Region, N'%'))
                AND (CONVERT(NVARCHAR(50), tblCostCentre_1.Id) 
               LIKE ISNULL(@DistributorID, N'%')) 
               AND (CONVERT(VARCHAR(26), dbo.tblDocument.DocumentDateIssued,23) BETWEEN @startDate AND @endDate)
GO
