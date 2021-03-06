
DROP PROCEDURE [dbo].[sp_D_Reconciliation_OutstandingPayment]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_D_Reconciliation_OutstandingPayment]
(
@startDate as Date,
@endDate as Date,
@distributorId AS NVARCHAR(50),
@salesmanId AS NVARCHAR(50),
@routeId AS NVARCHAR(50),
@outletId AS NVARCHAR(50)
)
AS 
if LTRIM(RTRIM(@distributorId))='ALL' begin set @distributorId='%' end
if LTRIM(RTRIM(@salesmanId))='ALL' begin set @salesmanId='%' end
if LTRIM(RTRIM(@routeId))='ALL' begin set @routeId='%' end
if LTRIM(RTRIM(@outletId))='ALL' begin set @outletId='%' end

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
           --Receipts.Id AS ReceiptDocId, 
           --Receipts.DocumentTypeId AS ReceiptDocTypeId, 
           --Receipts.DocumentReference AS ReceiptDocRef, 
           dbo.tblLineItems.Receipt_PaymentTypeId,
           
           Case
            when dbo.tblLineItems.Receipt_PaymentTypeId = 1 then value else 0 end AS Cash,
           Case
                when dbo.tblLineItems.Receipt_PaymentTypeId = 2 then value else 0 end AS Cheque,
           Case    
                when dbo.tblLineItems.Receipt_PaymentTypeId = 3 then value else 0 end AS Mmoney,
                
           dbo.tblLineItems.Quantity,     
           dbo.tblLineItems.Value AS PaymentValue, 
           0 as TotalAmtDue ,
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
           dbo.tblRoutes.Name as RouteName,
           Orders.SaleDiscount as SaleValueDiscount
FROM       dbo.tblDocument as Orders INNER JOIN
           dbo.tblDocument AS Invoice ON Orders.Id = Invoice.InvoiceOrderId INNER JOIN
           dbo.tblDocument AS Receipts ON Invoice.Id = Receipts.InvoiceOrderId INNER JOIN
           dbo.tblLineItems ON Receipts.Id = dbo.tblLineItems.DocumentID INNER JOIN
           dbo.tblCostCentre ON Orders.OrderIssuedOnBehalfOfCC = dbo.tblCostCentre.Id INNER JOIN
           
           dbo.tblCostCentre AS Distributors ON (Orders.DocumentIssuerCostCentreId = Distributors.Id or Orders.DocumentRecipientCostCentre = Distributors.Id ) INNER JOIN
           dbo.tblCostCentre AS Salesmen ON (Orders.DocumentRecipientCostCentre = Salesmen.Id or Orders.DocumentIssuerCostCentreId = Salesmen.Id )inner join
           
           dbo.tblRoutes  ON dbo.tblCostCentre.RouteId = dbo.tblRoutes.RouteID
WHERE     (Orders.DocumentTypeId = 1) 
          AND (Orders.OrderOrderTypeId = 1) 
          AND (Invoice.DocumentTypeId = 5) 
          AND (Receipts.DocumentTypeId = 8) 
          AND (Salesmen.CostCentreType = 4)
          AND (Distributors.CostCentreType = 2)
           AND (CONVERT(NVARCHAR(26),Orders.DocumentDateIssued,23)BETWEEN @startDate AND @endDate)
          AND (CONVERT(NVARCHAR(50),Distributors.Id)LIKE ISNULL(@distributorId,N'%'))
          AND (CONVERT(NVARCHAR(50),Salesmen.Id)LIKE ISNULL(@salesmanId,N'%'))
          AND (CONVERT(NVARCHAR(50), dbo.tblRoutes.RouteID)LIKE ISNULL(@routeId,N'%'))
          AND (CONVERT(NVARCHAR(50), dbo.tblCostCentre.Id)LIKE ISNULL(@outletId,N'%'))
           
union

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
           --'' AS ReceiptDocId, 
           --'' AS ReceiptDocTypeId, 
           --'' AS ReceiptDocRef, 
           dbo.tblLineItems.Receipt_PaymentTypeId,
           
           Case
            when dbo.tblLineItems.Receipt_PaymentTypeId = 1 then value else 0 end AS Cash,
           Case
                when dbo.tblLineItems.Receipt_PaymentTypeId = 2 then value else 0 end AS Cheque,
           Case    
                when dbo.tblLineItems.Receipt_PaymentTypeId = 3 then value else 0 end AS Mmoney,
                
           dbo.tblLineItems.Quantity,     
           0 AS PaymentValue,
           (dbo.tblLineItems.Quantity*(dbo.tblLineItems.Value+dbo.tblLineItems.Vat)) as TotalAmtDue ,
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
           dbo.tblRoutes.Name as RouteName,
           Orders.SaleDiscount as SaleValueDiscount
FROM       dbo.tblDocument as Orders INNER JOIN
           dbo.tblDocument AS Invoice ON Orders.Id = Invoice.InvoiceOrderId INNER JOIN           
           dbo.tblLineItems ON Invoice.Id = dbo.tblLineItems.DocumentID INNER JOIN
           dbo.tblCostCentre ON Orders.OrderIssuedOnBehalfOfCC = dbo.tblCostCentre.Id INNER JOIN
           
           dbo.tblCostCentre AS Distributors ON (Orders.DocumentIssuerCostCentreId = Distributors.Id or Orders.DocumentRecipientCostCentre = Distributors.Id ) INNER JOIN
           dbo.tblCostCentre AS Salesmen ON (Orders.DocumentRecipientCostCentre = Salesmen.Id or Orders.DocumentIssuerCostCentreId = Salesmen.Id )inner join
           
           dbo.tblRoutes  ON dbo.tblCostCentre.RouteId = dbo.tblRoutes.RouteID
WHERE     (Orders.DocumentTypeId = 1) 
          AND (Orders.OrderOrderTypeId = 1) 
          AND (Invoice.DocumentTypeId = 5) 
          AND (Salesmen.CostCentreType = 4)
          AND (Distributors.CostCentreType = 2)
          --AND (CONVERT(NVARCHAR(26),Orders.DocumentDateIssued,23)BETWEEN '2013-10-07' AND '2013-10-07')
          AND (CONVERT(NVARCHAR(26),Orders.DocumentDateIssued,23)BETWEEN @startDate AND @endDate)
          AND (CONVERT(NVARCHAR(50),Distributors.Id)LIKE ISNULL(@distributorId,N'%'))
          AND (CONVERT(NVARCHAR(50),Salesmen.Id)LIKE ISNULL(@salesmanId,N'%'))
          AND (CONVERT(NVARCHAR(50), dbo.tblRoutes.RouteID)LIKE ISNULL(@routeId,N'%'))
          AND (CONVERT(NVARCHAR(50), dbo.tblCostCentre.Id)LIKE ISNULL(@outletId,N'%'))
          
--   [dbo].[sp_D_Reconciliation_OutstandingPayment]     @startDate ='2013-01-01',@endDate ='2013-11-26',@distributorId='ALL',@salesmanId='ALL',@routeId='ALL',@outletId='ALL'
          
          
          GO
         