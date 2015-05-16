DROP PROCEDURE [dbo].[sp_D_PaymentSummary_Per_DistributorSalesman_PerRouteOutlet]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_D_PaymentSummary_Per_DistributorSalesman_PerRouteOutlet]
(
@startDate as Date,
@endDate as Date,
@distributorId AS NVARCHAR(50),
@salesmanId AS NVARCHAR(50),
@routeId AS NVARCHAR(50),
@outletId AS NVARCHAR(50)
)
AS 
if  ltrim(rtrim(@distributorId))='ALL'  begin set @distributorId='%' end
if  ltrim(rtrim(@salesmanId))='ALL'  begin set @salesmanId='%' end
if  ltrim(rtrim(@routeId))='ALL'  begin set @routeId='%' end
if  ltrim(rtrim(@outletId))='ALL'  begin set @outletId='%' end

SELECT     Orders.Id AS OrderId, 
           Orders.DocumentReference AS OrderDocRef, 
           Orders.DocumentTypeId AS OrderDocType, 
           Orders.OrderOrderTypeId AS OrderOOType, 
           Orders.DocumentDateIssued,
           Invoice.Id AS InvDocId, 
           Invoice.DocumentReference AS InvDocRef, 
           Invoice.DocumentTypeId AS InvDocType, 
           Orders.OrderParentId, 
           Invoice.InvoiceOrderId AS InvOrderId, 
           Receipts.Id AS ReceiptDocId, 
           Receipts.DocumentTypeId AS ReceiptDocTypeId, 
           Receipts.DocumentReference AS ReceiptDocRef, 
           dbo.tblLineItems.Receipt_PaymentTypeId,
           case when dbo.tblLineItems.Receipt_PaymentTypeId = 1 then 'Cash'
                when dbo.tblLineItems.Receipt_PaymentTypeId = 2 then 'Cheque'
                when dbo.tblLineItems.Receipt_PaymentTypeId = 3 then 'Mmoney' end AS PaymenTypeName,
           dbo.tblLineItems.Quantity,     
           dbo.tblLineItems.Value AS PaymentValue, 
           dbo.tblCostCentre.Id AS OutletId, 
           dbo.tblCostCentre.Name AS OutletName, 
           dbo.tblCostCentre.CostCentreType AS OutletCCtype, 
           Distributors.Id AS DistributorId, 
           Distributors.Name AS DistributorName, 
           Distributors.CostCentreType AS DistributorCCtype, 
           Salesmen.Id AS SalesmanId, 
           Salesmen.Name AS SalemanName, 
           Salesmen.CostCentreType AS DistributorsCCtype,
           dbo.tblRoutes.RouteID as RouteId,
           dbo.tblRoutes.Name as RouteName
FROM       dbo.tblDocument as Orders INNER JOIN
           dbo.tblDocument AS Invoice ON Orders.Id = Invoice.InvoiceOrderId INNER JOIN
           dbo.tblDocument AS Receipts ON Invoice.Id = Receipts.InvoiceOrderId INNER JOIN
           dbo.tblLineItems ON Receipts.Id = dbo.tblLineItems.DocumentID INNER JOIN
           dbo.tblCostCentre ON Orders.OrderIssuedOnBehalfOfCC = dbo.tblCostCentre.Id INNER JOIN
           
           dbo.tblCostCentre AS Distributors ON (Orders.DocumentIssuerCostCentreId = Distributors.Id or Orders.DocumentRecipientCostCentre = Distributors.Id ) INNER JOIN
           dbo.tblCostCentre AS Salesmen ON (Orders.DocumentRecipientCostCentre = Salesmen.Id or Orders.DocumentIssuerCostCentreId = Salesmen.Id )inner join
           
           dbo.tblRoutes  ON dbo.tblCostCentre.RouteId = dbo.tblRoutes.RouteID
WHERE     (Orders.DocumentTypeId = 1) 
          --AND (Orders.OrderOrderTypeId = 1) 
          AND (Invoice.DocumentTypeId = 5) 
          AND (Receipts.DocumentTypeId = 8) 
          AND (Salesmen.CostCentreType = 4)
          AND (Distributors.CostCentreType = 2)
          AND (CONVERT(NVARCHAR(26),Receipts.DocumentDateIssued,23)BETWEEN @startDate AND @endDate)
          AND (CONVERT(NVARCHAR(50),Distributors.Id)LIKE ISNULL(@distributorId,N'%'))
          AND (CONVERT(NVARCHAR(50),Salesmen.Id)LIKE ISNULL(@salesmanId,N'%'))
          AND (CONVERT(NVARCHAR(50), dbo.tblRoutes.RouteID)LIKE ISNULL(@routeId,N'%'))
          AND (CONVERT(NVARCHAR(50), dbo.tblCostCentre.Id)LIKE ISNULL(@outletId,N'%'))
          
 -- EXEC     [dbo].[sp_D_PaymentSummary_Per_DistributorSalesman_PerRouteOutlet]    @startDate='1-Jan-2014',@endDate='10-April-2014',@distributorId=' ALL',@salesmanId=' ALL',@routeId=' ALL',@outletId=' ALL'

GO