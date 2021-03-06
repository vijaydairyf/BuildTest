/****** Object:  StoredProcedure [dbo].[sp_D_Inventory_ProductCatalog]    Script Date: 07/24/2013 08:51:32 ******/
DROP PROCEDURE [dbo].[sp_D_Inventory_ProductCatalog]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_D_Inventory_ProductCatalog]
(
@startDate AS DATE,
@endDate AS DATE,
@brandId AS NVARCHAR(50),
@productId AS NVARCHAR(50),
@packagingId AS NVARCHAR(50),
@flavourId AS NVARCHAR(50),
@tierId AS NVARCHAR(50),
@distributorId AS NVARCHAR(50)
)
AS 
if  @brandId='ALL'  begin set @brandId='%' end
if  @productId='ALL'  begin set @productId='%' end
if  LTRIM(@packagingId)='ALL'  begin set @packagingId='%' end
if  @flavourId='ALL'  begin set @flavourId='%' end
if  LTRIM(@tierId)='ALL'  begin set @tierId='%' end
if  @distributorId='ALL'  begin set @distributorId='%' end
--SELECT     dbo.tblProduct.id AS ProductId, 
--           dbo.tblProduct.ProductCode, 
--           dbo.tblProduct.Description AS ProductName, 
--           dbo.tblProduct.ExFactoryPrice AS ProductValue, 
--           dbo.tblPricingTier.id AS TierId, 
--           dbo.tblPricingTier.Code AS TierCode, 
--           dbo.tblPricingTier.Name AS TierName, 
--           dbo.tblPricingItem.Exfactory AS BuyingPrice, 
--           dbo.tblPricingItem.SellingPrice, 
--           dbo.tblPricingItem.EffecitiveDate

--FROM       dbo.tblProduct INNER JOIN
--           dbo.tblPricing ON dbo.tblProduct.id = dbo.tblPricing.ProductRef INNER JOIN
--           dbo.tblPricingTier ON dbo.tblPricing.Tier = dbo.tblPricingTier.id INNER JOIN
--           dbo.tblPricingItem ON dbo.tblPricing.id = dbo.tblPricingItem.PricingId
SELECT     dbo.tblProduct.id AS ProductId, 
           dbo.tblProduct.ProductCode, 
           dbo.tblProduct.Description AS ProductName, 
           dbo.tblProduct.ExFactoryPrice AS ProductValue, 
           dbo.tblPricingTier.id AS TierId, 
           dbo.tblPricingTier.Code AS TierCode, 
           dbo.tblPricingTier.Name AS TierName,
           dbo.tblPricingItem.Exfactory AS BuyingPrice, 
           dbo.tblPricingItem.SellingPrice, 
           dbo.tblPricingItem.EffecitiveDate, 
           dbo.tblCostCentre.Id AS DistributorId, 
           dbo.tblCostCentre.Name AS DistributorName, 
           dbo.tblCostCentre.CostCentreType AS DistCCtype

FROM       dbo.tblProduct INNER JOIN
           dbo.tblPricing ON dbo.tblProduct.id = dbo.tblPricing.ProductRef INNER JOIN
           dbo.tblPricingTier ON dbo.tblPricing.Tier = dbo.tblPricingTier.id INNER JOIN
           dbo.tblPricingItem ON dbo.tblPricing.id = dbo.tblPricingItem.PricingId INNER JOIN
           dbo.tblInventory ON dbo.tblProduct.id = dbo.tblInventory.ProductId INNER JOIN
           dbo.tblCostCentre ON dbo.tblInventory.WareHouseId = dbo.tblCostCentre.Id

WHERE     (dbo.tblCostCentre.CostCentreType = 2)           
          -- AND(CONVERT(NVARCHAR(50), dbo.tblProduct.id) LIKE ISNULL(@productId,N'%'))
          -- AND(CONVERT(NVARCHAR(50),dbo.tblPricing.Tier))LIKE ISNULL(@tierId,N'%')
           AND(CONVERT(NVARCHAR(50), dbo.tblCostCentre.Id ) LIKE ISNULL(@distributorId,N'%'))
           AND(CONVERT(NVARCHAR(50), dbo.tblProduct.id) LIKE ISNULL (@productId,N'%'))
           AND(dbo.tblPricingItem.EffecitiveDate  BETWEEN @startDate AND @endDate)
GO
