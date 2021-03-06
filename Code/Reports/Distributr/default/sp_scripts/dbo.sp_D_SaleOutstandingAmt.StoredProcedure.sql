/****** Object:  StoredProcedure [dbo].[sp_D_SaleOutstandingAmt]    Script Date: 07/24/2013 08:51:32 ******/
DROP PROCEDURE [dbo].[sp_D_SaleOutstandingAmt]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_D_SaleOutstandingAmt]
(

@docId as nvarchar(50)
)
as
if  @docId='ALL'  begin set @docId='%' end
BEGIN
DECLARE @TableSaleValueDiscount TABLE (
 SaleId nvarchar(50),
 SaleRef nvarchar(50),
 SaleDate date,
 GrossSaleValue decimal(18,2),
 NetSaleValue decimal(18,2),
 SaleValueDiscount decimal(18,2),
 PaidAmount decimal(18,2)
);
INSERT @TableSaleValueDiscount
  SELECT   sales.Id,
                   sales.DocumentReference  as SaleRef, 
                   sales.DocumentDateIssued as SaleDate,
                   case when sale.DocumentTypeId = 1 then SUM(Quantity * (Value + Vat)) else 0  end as OrderValue,
                  (case when sale.DocumentTypeId = 1 then SUM(Quantity * (Value + Vat)) - (coalesce(sale.SaleDiscount,0)) else 0 end) as NetValue,  
                  (coalesce(sale.SaleDiscount,0)) as SaleValueDiscount,
                   case when sale.DocumentTypeId = 8 then SUM(coalesce(Value ,0))  else 0 end as ReceivedValue          
FROM       dbo.tblDocument sale 
           INNER JOIN dbo.tblLineItems saleItem ON sale.Id = saleItem.DocumentID
           INNER JOIN tblDocument sales on sale.DocumentParentId = sales.Id
           INNER JOIN tblCostCentre outlet on sales.OrderIssuedOnBehalfOfCC = outlet.Id

WHERE convert(nvarchar(50),sales.Id) like ISNULL(@docId,'%')   
    AND  (sales.DocumentTypeId = 1) 
    AND ((sales.OrderOrderTypeId = 1) OR (sales.OrderOrderTypeId = 3 AND sales.DocumentStatusId = 99)) 
    AND(((sale.DocumentTypeId = 1)OR
              (sale.DocumentTypeId = 5) OR
              (sale.DocumentTypeId = 8) OR
              (sale.DocumentTypeId = 10)))
  
GROUP BY sales.Id,sales.DocumentReference,sales.DocumentDateIssued,outlet.Cost_Centre_Code,outlet.Name ,sale.DocumentReference,sale.DocumentTypeId,saleItem.Receipt_PaymentTypeId ,sale.SaleDiscount
ORDER BY sales.DocumentDateIssued desc
END;

select SaleId,SaleRef,SaleDate,
       SUM(GrossSaleValue) as GrossSaleValue,
       SUM(NetSaleValue) as NetSaleValue,
       SUM(SaleValueDiscount) as SaleValueDiscount,
       SUM(PaidAmount) as PaidAmount,
      ROUND((SUM(NetSaleValue) -  SUM(PaidAmount)),0,1) as OutstandingAmount
from @TableSaleValueDiscount
group by  SaleId,SaleRef,SaleDate
order by SaleDate desc
                      
                      
 --     exec [dbo].[sp_D_SaleOutstandingAmt] @docId='ALL'
 --     exec [dbo].[sp_D_SaleOutstandingAmt] @docId='3DF56F9A-F003-43AF-8A67-1D97B87D84E0'
 --     exec [dbo].[sp_D_SaleOutstandingAmt] @docId='a76feea5-05ef-49d1-9271-1f0f9386d0de'
 
 
GO
