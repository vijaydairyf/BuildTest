
/****** Object:  StoredProcedure [dbo].[SP_D_Sales_By_Salesman_ref]    Script Date: 09/11/2013 17:38:17 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[SP_D_Sales_By_Salesman_ref]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[SP_D_Sales_By_Salesman_ref]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_D_Sales_By_Salesman_ref]
(
@startDate as date,
@endDate as date,
@BrandId AS NVARCHAR(50),
@distributorID AS NVARCHAR(50),
@salesManID AS NVARCHAR(50),
@ProductId AS NVARCHAR(50),
@salesRef AS NVARCHAR(50),
@outletId as nvarchar(50)
)
as
if  RTRIM(LTRIM(@BrandId))='ALL'  begin set @BrandId='%' end
if  RTRIM(LTRIM(@distributorID))='ALL'  begin set @distributorID='%' end
if  RTRIM(LTRIM(@salesManID))='ALL'  begin set @salesManID='%' end
if  RTRIM(LTRIM(@ProductId))='ALL'  begin set @ProductId='%' end
if  RTRIM(LTRIM(@salesRef))='ALL'  begin set @salesRef='%' end
if  RTRIM(LTRIM(@outletId))='ALL'  begin set @outletId='%' end


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
       dbo.tblDocument.DocumentDateIssued as SendDateTime, 
      -- dbo.tblCostCentre.Id AS SalesmanId,
       sm.Name AS Salesman, 
       sm.CostCentreType AS SalesmanTypeID, 
       sm.ParentCostCentreId, 
       sm.RouteId, 
       dbo.tblLineItems.DocumentID, 
       dbo.tblDocument.DocumentStatusId, 
       dist.Id AS DistributorID, 
       dist.Name AS Distributor,
     --   outlet.Id OutletId, 
     -- outlet.Name Outlet,
       hq.Name AS Producer, 
       hq.CostCentreType AS ProducerID, 
       sm.Id AS SalesManID, 
       dbo.tblProduct.id AS ProductId,
       dbo.tblProduct.Description AS Product, 
        dbo.tblProductBrand.id AS BrandId, 
       dbo.tblProductBrand.name AS Brand, 
       dbo.tblLineItems.ProductDiscount, 
       dbo.tblDocument.DocumentReference,
       dbo.tblDocument.SaleDiscount,
       (dbo.tblLineItems.ProductDiscount*dbo.tblLineItems.Quantity) as TotalProductDiscount,
	   ROUND(((dbo.tblLineItems.Quantity)*(dbo.tblLineItems.Value + dbo.tblLineItems.Vat)) +  (dbo.tblLineItems.ProductDiscount*dbo.tblLineItems.Quantity) ,2,1) as GrossAmount,
	   dbo.udf_D_RoundOff((dbo.tblLineItems.Quantity*dbo.tblLineItems.Value)) as NetRoundOff,
	   ROUND((dbo.tblLineItems.Quantity*dbo.tblLineItems.Value),2,1) as NetTruncate,
	   dbo.udf_D_RoundOff(((dbo.tblLineItems.Quantity)*(dbo.tblLineItems.Value + dbo.tblLineItems.Vat)) + (dbo.tblLineItems.ProductDiscount*dbo.tblLineItems.Quantity)) as GrossRoundOff
       
FROM       dbo.tblDocument 
INNER JOIN dbo.tblLineItems ON dbo.tblDocument.Id = dbo.tblLineItems.DocumentID 
INNER JOIN dbo.tblCostCentre as sm ON (dbo.tblDocument.DocumentRecipientCostCentre =sm.Id or  dbo.tblDocument.DocumentIssuerCostCentreId = sm.Id) 
INNER JOIN dbo.tblCostCentre AS dist ON sm.ParentCostCentreId = dist.Id 
INNER JOIN dbo.tblCostCentre AS hq ON dist.ParentCostCentreId = hq.Id 
INNER JOIN dbo.tblCostCentre outlet  on dbo.tblDocument.OrderIssuedOnBehalfOfCC = outlet.Id
INNER JOIN dbo.tblProduct ON dbo.tblLineItems.ProductID = dbo.tblProduct.id 
INNER JOIN dbo.tblProductBrand ON dbo.tblProduct.BrandId = dbo.tblProductBrand.id

WHERE (dbo.tblDocument.DocumentTypeId = 1) 
       AND (dbo.tblDocument.OrderOrderTypeId = 1 OR (dbo.tblDocument.OrderOrderTypeId = 3  AND (dbo.tblDocument.DocumentStatusId = 99))) 
       AND (CONVERT(VARCHAR(26), dbo.tblDocument.DocumentDateIssued,23) BETWEEN @startDate AND @endDate) 
       AND (sm.CostCentreType = 4) 
       AND (CONVERT(NVARCHAR(50),dbo.tblProductBrand.id) LIKE ISNULL(@BrandId, N'%')) 
       AND (CONVERT(NVARCHAR(50),dist.Id) LIKE ISNULL(@distributorID, N'%')) 
       AND (CONVERT(NVARCHAR(50),sm.Id) LIKE ISNULL(@salesManID, N'%')) 
       AND (CONVERT(NVARCHAR(50),dbo.tblDocument.DocumentReference) LIKE ISNULL(@salesRef, N'%')) 
       AND (CONVERT(NVARCHAR(50),dbo.tblProduct.id) LIKE ISNULL(@ProductId, N'%')) 
       AND (CONVERT(NVARCHAR(50),outlet.Id) LIKE ISNULL(@outletId, N'%')) 
     
       
       
--   Exec [dbo].[SP_D_Sales_By_Salesman_ref] @BrandId='ALL' ,@distributorID=' ALL',@salesManID='253C4BCB-FDA6-426E-A1ED-6518A155A517',@ProductId=' ALL',@salesRef=' ALL',@startDate='08-December-2014' ,@endDate='08-December-2014',@outletId='ALL'

go