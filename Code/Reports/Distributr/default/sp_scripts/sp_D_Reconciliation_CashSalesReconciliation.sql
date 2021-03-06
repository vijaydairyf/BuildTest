
DROP PROCEDURE [dbo].[sp_D_Reconciliation_CashSalesReconciliation]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [sp_D_Reconciliation_CashSalesReconciliation]

(
@startDate as Date,
@endDate as Date,
@countryId as NVARCHAR(50),
@regionId as NVARCHAR(50),
@distributorId AS NVARCHAR(50),
@salesmanId AS NVARCHAR(50),
@routeId AS NVARCHAR(50),
@outletId AS NVARCHAR(50),
@brandId AS NVARCHAR(50),
@targetPeriod AS NVARCHAR(50)

)


AS

if LTRIM(RTRIM(@countryId))='ALL' begin set @countryId='%' end
if LTRIM(RTRIM(@regionId))='ALL' begin set @regionId='%' end
if LTRIM(RTRIM(@distributorId))='ALL' begin set @distributorId='%' end
if LTRIM(RTRIM(@salesmanId))='ALL' begin set @salesmanId='%' end
if LTRIM(RTRIM(@routeId))='ALL' begin set @routeId='%' end
if LTRIM(RTRIM(@outletId))='ALL' begin set @outletId='%' end
if LTRIM(RTRIM(@brandId))='ALL' begin set @brandId='%' end
if LTRIM(RTRIM(@targetPeriod))='ALL' begin set @targetPeriod='%' end


DECLARE @SaleId nvarchar(50),
        @SaleRef nvarchar(50),
        @RouteName nvarchar(50),
        @OutletName nvarchar(50),
        @SaleDate date,
        @TotalQuantity decimal(18,2),
        @SoldReturnables decimal(18,2),
        @ReturnedReturnables decimal(18,2),
        @GrossSaleValue decimal(18,2),
        @NetSaleValue decimal(18,2),
        @SaleValueDiscount decimal(18,2),
        @ProductDiscount decimal(18,2),
        @PaidAmount decimal(18,2)
        
DECLARE @Table_CashSales TABLE (
        SaleId nvarchar(50),
        SaleRef nvarchar(50),
        RouteName nvarchar(50),
        OutletName nvarchar(50),
        SaleDate date,
        TotalQuantity decimal(18,2),
        SoldReturnables decimal(18,2),
        ReturnedReturnables decimal(18,2),
        GrossSaleValue decimal(18,2),
        NetSaleValue decimal(18,2),
        SaleValueDiscount decimal(18,2),
        ProductDiscount decimal(18,2),
        PaidAmount decimal(18,2)
 );
        
 DECLARE sales_cursor CURSOR FOR
 SELECT DISTINCT   sales.Id,
                   sales.DocumentReference  as SaleRef,
                   route.Name as RouteName, 
                   outlet.Name as OutletName, 
                   sales.DocumentDateIssued as SaleDate,
                   case when sale.DocumentTypeId = 1 then SUM(saleItem.Quantity) else 0  end as TotalQuantity,
                   case when prod.DomainTypeId = 3 and prod.id <> prod.Returnable then SUM(saleItem.Quantity) end as SoldReturnables,
                   case when sale.DocumentTypeId = 1 and prod.DomainTypeId=1 and prod.Returnable <> null then SUM(saleItem.Quantity) else 0  end as ReturnedReturnables,
                   case when sale.DocumentTypeId = 1 then SUM(saleItem.Quantity * (saleItem.Value + saleItem.Vat)) else 0  end as OrderValue,
                  (case when sale.DocumentTypeId = 1 then SUM(saleItem.Quantity * (saleItem.Value + saleItem.Vat))else 0 end ) as NetValue,
                   (coalesce(sale.SaleDiscount,0)) as SaleValueDiscount,
                   saleItem.ProductDiscount as ProductDiscount
                   
FROM       dbo.tblDocument sale 
           INNER JOIN dbo.tblLineItems saleItem ON sale.Id = saleItem.DocumentID
           INNER JOIN tblDocument sales on sale.DocumentParentId = sales.Id
           INNER JOIN tblCostCentre outlet on sales.OrderIssuedOnBehalfOfCC = outlet.Id  
           INNER JOIN tblCostCentre distributr on (sales.DocumentIssuerCostCentreId = distributr.Id or sales.DocumentIssuerCostCentreId = distributr.Id )    
           INNER JOIN tblRegion reg on distributr.Distributor_RegionId = reg.id
           INNER JOIN tblRoutes route on outlet.RouteId = route.RouteID
           INNER JOIN tblProduct prod on saleItem.ProductID = prod.id

WHERE   CONVERT(NVARCHAR(26),sale.DocumentDateIssued,23) between  @startDate and @endDate
    AND convert(nvarchar(50),sale.OrderIssuedOnBehalfOfCC) like isnull(@outletId,'%')    
    AND convert(nvarchar(50),distributr.Distributor_RegionId) like isnull(@regionId,'%')
    AND convert(nvarchar(50),reg.Country) like isnull(@countryId,'%')
    AND (convert(nvarchar(50),sales.DocumentIssuerCostCentreId) like ISNULL(@salesmanId,'%') or convert(nvarchar(50),sales.DocumentRecipientCostCentre) like ISNULL(@salesmanId,'%'))
    AND (convert(nvarchar(50),sales.DocumentIssuerCostCentreId) like ISNULL(@distributorId,'%') or convert(nvarchar(50),sales.DocumentRecipientCostCentre) like ISNULL(@distributorId,'%'))
    AND convert(nvarchar(50),route.RouteID) like isnull(@routeId ,'%')
    AND (sales.DocumentTypeId = 1) 
    AND distributr.CostCentreType = 2
    AND ((sales.OrderOrderTypeId = 1) OR (sales.OrderOrderTypeId = 3 AND sales.DocumentStatusId = 99)) 
    AND(((sale.DocumentTypeId = 1)OR(sale.DocumentTypeId = 5)OR(sale.DocumentTypeId = 8)OR(sale.DocumentTypeId = 10)))
  
GROUP BY sales.Id,sales.DocumentReference,prod.DomainTypeId,prod.id,prod.Returnable,sales.DocumentDateIssued,outlet.Cost_Centre_Code,outlet.Name ,sale.DocumentReference,sale.DocumentTypeId,saleItem.Receipt_PaymentTypeId ,sale.SaleDiscount,route.Name,prod.Description,saleItem.ProductDiscount
ORDER BY sales.DocumentDateIssued desc  

OPEN sales_cursor
FETCH NEXT FROM sales_cursor
INTO    @SaleId ,
        @SaleRef ,
        @RouteName ,
        @OutletName ,
        @SaleDate ,
        @TotalQuantity ,
        @SoldReturnables ,
        @ReturnedReturnables ,
        @GrossSaleValue ,
        @NetSaleValue ,
        @SaleValueDiscount ,
        @ProductDiscount  
     
WHILE @@FETCH_STATUS = 0  
BEGIN
SELECT @PaidAmount = SUM(receiptItems.Value) 
                     FROM    dbo.tblDocument receipt
                     INNER JOIN   dbo.tblLineItems receiptItems ON receipt.Id = receiptItems.DocumentID
                     WHERE receipt.DocumentTypeId=8
                     AND @SaleId = receipt.DocumentParentId
                     AND  CONVERT(nvarchar(26),receipt.DocumentDateIssued,23) BETWEEN @startDate AND @endDate
                     GROUP BY receipt.DocumentParentId
INSERT INTO @Table_CashSales VALUES(@SaleId ,
                                           @SaleRef ,
										   @RouteName ,
                                           @OutletName ,
                                           @SaleDate ,
                                           @TotalQuantity ,
                                           @SoldReturnables ,
                                           @ReturnedReturnables ,
                                           @GrossSaleValue ,
                                           @NetSaleValue ,
                                           @SaleValueDiscount ,
                                           @ProductDiscount,
                                           @PaidAmount )
FETCH NEXT FROM sales_cursor
INTO @SaleId ,
     @SaleRef ,
     @RouteName ,
     @OutletName ,
     @SaleDate ,
     @TotalQuantity ,
     @SoldReturnables ,
     @ReturnedReturnables ,
     @GrossSaleValue ,
     @NetSaleValue ,
     @SaleValueDiscount ,
     @ProductDiscount
END;        
CLOSE  sales_cursor ;      
DEALLOCATE sales_cursor;

SELECT SaleId,SaleRef,RouteName,OutletName,SaleDate,
       SUM(TotalQuantity) AS TotalQuantity,
       (SoldReturnables) AS SoldReturnables,
       SUM(ReturnedReturnables) AS ReturnedReturnables,
       SUM(GrossSaleValue) AS GrossSaleValue,
       SUM(NetSaleValue) AS NetSaleValue,
       SaleValueDiscount,
       SUM(ProductDiscount) AS ProductDiscount,
       PaidAmount
FROM @Table_CashSales     
GROUP BY  SaleId,SaleRef,RouteName,OutletName,SaleDate,SaleValueDiscount,PaidAmount,SoldReturnables    
        
        
-- Exec [dbo].[sp_D_Reconciliation_CashSalesReconciliation] @startDate='2013-12-18',@endDate='2013-12-18',@countryId='ALL',@regionId='ALL',@distributorId='ALL',@salesmanId='ALL',@routeId='ALL',@outletId='ALL',@brandId='ALL',@targetPeriod='ALL'
        
