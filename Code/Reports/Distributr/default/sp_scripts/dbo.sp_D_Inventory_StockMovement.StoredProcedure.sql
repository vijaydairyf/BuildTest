/****** Object:  StoredProcedure [dbo].[sp_D_Inventory_StockMovement]    Script Date: 07/24/2013 08:51:32 ******/
SET STATISTICS TIME ON;
SET STATISTICS IO ON;
DROP PROCEDURE [dbo].[sp_D_Inventory_StockMovement]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_D_Inventory_StockMovement]
(
@startDate AS DATE,
@endDate AS DATE,
@productId AS NVARCHAR(50),
@distributorId AS NVARCHAR(50)
)
AS 
if  @productId='ALL'  begin set @productId='%' end
if  @distributorId='ALL'  begin set @distributorId='%' end

--STOCK MOVEMENT REPORT --START
/****** Object:  StoredProcedure [dbo].[sp_D_Inventory_StockMovement]    Script Date: 07/24/2013 08:51:32 ******/
--ISSUED STOCK QUERY, 
;WITH SM_CTE AS (
SELECT    inv.id DocumentId,
          inv.DocumentReference, 
          inv.DocumentTypeId,
          inv.OrderOrderTypeId, 
          inv.DocumentStatusId,
          invTrans.NoItems AS PurchaseQty,0 AS ReturnsQty,0 AS SalesQty,
          invTrans.NetValue AS PurchaseValue, 0 AS ReturnsValue,0 AS SalesValue,
          0  AS PurchaseVat,0 AS ReturnsVat,0 AS SalesVat, 
          invTrans.NoItems * prod.ExFactoryPrice AS PurchaseAmount,0 AS ReturnsAmount,0 AS SalesAmount,
		  '' Description,
          prod.id ProductId,
          prod.ProductCode,
          prod.Description ProductName, 
          dist.Id DistributorId, 
          dist.Name DistributorName,
          dist.CostCentreType DistributorCCtype,      
          invTrans.IM_DateCreated DocumentDateIssued   
          
FROM       dbo.tblInventoryTransaction invTrans
INNER JOIN dbo.tblDocument inv ON invTrans.DocumentId = inv.Id 
INNER JOIN dbo.tblCostCentre dist ON inv.DocumentIssuerCostCentreId = dist.Id 
INNER JOIN dbo.tblCostCentre  AS salesman ON inv.DocumentRecipientCostCentre = salesman.Id 
INNER JOIN dbo.tblInventory ON invTrans.InventoryId = dbo.tblInventory.id 
INNER JOIN dbo.tblProduct prod ON dbo.tblInventory.ProductId = prod.id
WHERE(invTrans.DocumentType = 4) 
 AND  dist.CostCentreType = 2
 AND (invTrans.NoItems > 0) 
 --AND CONVERT(NVARCHAR(26),invTrans.IM_DateCreated,23) BETWEEN @startDate AND @endDate

          
      UNION ALL
      
--RETURNS ORDER QUERY
SELECT     ret.Id AS DocumentId, 
           ret.DocumentReference, 
           ret.DocumentTypeId, 
           ret.OrderOrderTypeId, 
           ret.DocumentStatusId, 
           0 AS PurchaseQty  ,retItem.Quantity AS ReturnsQty, 0 AS SalesQty,
           0 AS PurchaseValue ,retItem.Value AS ReturnValue, 0 AS SalesValue,
           0 AS PurchaseVat, retItem.Vat AS ReturnsVat, 0 AS SalesVat,
           0 AS PurchaseAmount, (retItem.Quantity * (retItem.Value +  retItem.Vat))AS ReturnsAmount,0 AS SalesAmount,
           retItem.Description, 
           prod.id AS ProductId, 
           prod.ProductCode, 
           prod.Description AS ProductName, 
           dist.Id as DistributorId, 
           dist.Name AS DistributorName, 
           dist.CostCentreType AS DistributorCCtype, 
           ret.DocumentDateIssued

FROM       dbo.tblDocument ret 
INNER JOIN dbo.tblLineItems retItem ON ret.Id = retItem.DocumentID 
INNER JOIN dbo.tblProduct prod ON retItem.ProductID = prod.id 
INNER JOIN dbo.tblCostCentre salesman ON ret.DocumentIssuerCostCentreId = salesman.Id
INNER JOIN dbo.tblCostCentre dist on salesman.ParentCostCentreId = dist.Id
WHERE    (ret.DocumentTypeId = 7) 
   AND   (ret.OrderOrderTypeId = 1 or ret.OrderOrderTypeId = 2)
   AND   (salesman.CostCentreType = 4)
         

          
     UNION ALL
--SALES QUERY 

SELECT     sale.Id AS DocumentId, 
           sale.DocumentReference, 
           sale.DocumentTypeId, 
           sale.OrderOrderTypeId, 
           sale.DocumentStatusId, 
           0 AS PurchaseQty,0 AS ReturnsQty, saleItems.Quantity AS SalesQty, 
           0 AS PurchaseValue,0 AS ReturnsValue, saleItems.Value AS SalesValue, 
           0 AS PurchaseVat,0 AS ReturnsVat, saleItems.Vat AS SalesVat,
           0 AS PurchaseAmount,0 AS ReturnsAmount, (saleItems.Quantity * (saleItems.Value +  saleItems.Vat)) AS SalesAmount, 
           saleItems.Description, 
           prod.id AS ProductId, 
           prod.ProductCode, 
           prod.Description AS ProductName, 
           dist.Id AS DistributorId, 
           dist.Name AS DistributorName, 
           salesman.CostCentreType AS DistributorCCtype, 
           sale.DocumentDateIssued

FROM       dbo.tblDocument sale 
INNER JOIN dbo.tblLineItems saleItems ON sale.Id = saleItems.DocumentID 
INNER JOIN dbo.tblProduct prod ON saleItems.ProductID = prod.id 
INNER JOIN dbo.tblCostCentre salesman ON (sale.DocumentIssuerCostCentreId = salesman.Id or sale.DocumentRecipientCostCentre = salesman.Id)
INNER JOIN dbo.tblCostCentre dist on salesman.ParentCostCentreId = dist.Id
WHERE     (sale.Id = sale.OrderParentId) 
      AND (sale.DocumentTypeId = 1) 
      AND (dist.CostCentreType = 2) 
      AND ((sale.OrderOrderTypeId = 1) OR (sale.OrderOrderTypeId = 3 AND sale.DocumentStatusId = 99))
)
SELECT
           DocumentId, 
           DocumentReference, 
           SUM(PurchaseQty) PurchaseQty , 
		   SUM(ReturnsQty) ReturnsQty,
		   SUM(SalesQty) SalesQty,
           SUM(PurchaseValue) PurchaseValue,
		   SUM(ReturnsValue) ReturnsValue,
		   SUM(SalesValue) SalesValue,
           SUM(PurchaseVat) PurchaseVat, 
		   SUM(ReturnsVat) ReturnsVat,
		   SUM(SalesVat) SalesVat,
           SUM(PurchaseAmount) PurchaseAmount, 
		   SUM(ReturnsAmount) ReturnsAmount,
		   SUM(SalesAmount) SalesAmount,
		   SUM(PurchaseQty - (SalesQty + ReturnsQty)) VarianceQty,
  		   SUM(PurchaseAmount - (SalesAmount + ReturnsAmount)) VarianceAmount,
           Description, 
           ProductId, 
           ProductCode, 
           ProductName, 
           DistributorId, 
           DistributorName, 
           DistributorCCtype, 
           DocumentDateIssued
FROM SM_CTE
WHERE CONVERT(NVARCHAR(26),DocumentDateIssued,23) BETWEEN @startDate AND @endDate
  AND CONVERT(NVARCHAR(50),DistributorId)  LIKE ISNULL(@distributorId,'%')
  AND CONVERT(NVARCHAR(50),ProductId)  LIKE ISNULL(@productId,'%')
GROUP BY 
           DocumentId, 
           DocumentReference, 
           Description, 
           ProductId, 
           ProductCode, 
           ProductName, 
           DistributorId, 
           DistributorName, 
           DistributorCCtype, 
           DocumentDateIssued




-- EXEC  [dbo].[sp_D_Inventory_StockMovement] @startDate = '2014-01-01',@endDate = '2015-01-26',@productId = 'ALL',@distributorId = 'ALL'

GO
