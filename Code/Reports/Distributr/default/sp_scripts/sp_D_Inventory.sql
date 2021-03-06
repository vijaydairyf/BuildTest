
DROP PROCEDURE [dbo].[sp_D_Inventory]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_D_Inventory]
(
@brandId AS NVARCHAR(50),
@productId AS NVARCHAR(50),
@packagingId AS NVARCHAR(50),
@distributorId AS NVARCHAR(50),
@salesManId AS NVARCHAR(50),
@Brand AS NVARCHAR(50),
@Product AS NVARCHAR(50)
)
AS 
if  ltrim(rtrim(@distributorId))='ALL'  begin set @distributorId='%' end
if  ltrim(rtrim(@brandId))='ALL'  begin set @brandId='%' end
if  ltrim(rtrim(@salesManId))='ALL'  begin set @salesManId='%' end
if  ltrim(rtrim(@productId))='ALL'  begin set @productId='%' end
if  ltrim(rtrim(@packagingId))='ALL'  begin set @packagingId='%' end
if  ltrim(rtrim(@Brand))='ALL'  begin set @Brand='%' end
if  ltrim(rtrim(@Product))='ALL'  begin set @Product='%' end


SELECT     CONVERT(NVARCHAR(50), dbo.tblCostCentre.Id) AS DistributorId, 
           dbo.tblCostCentre.Name AS DistributorName, 
           dbo.tblProduct.id AS ProductId, 
           dbo.tblProduct.Description AS ProductName, 
           dbo.tblProductBrand.id AS BrandId, 
           dbo.tblProductBrand.name AS BrandName, 
           dbo.tblInventory.Balance AS InvBalance, 
           dbo.tblInventory.Value AS InvValue, 
           dbo.tblInventory.IM_DateCreated, 
           dbo.tblInventory.UnavailableBalance, 
           dbo.tblProduct.ExFactoryPrice
FROM       dbo.tblProductBrand INNER JOIN
           dbo.tblProduct INNER JOIN
           dbo.tblCostCentre INNER JOIN
           dbo.tblInventory ON dbo.tblCostCentre.Id = dbo.tblInventory.WareHouseId ON dbo.tblProduct.id = dbo.tblInventory.ProductId ON dbo.tblProductBrand.id = dbo.tblProduct.BrandId
WHERE     (dbo.tblInventory.Balance >= 0) 
           AND (dbo.tblCostCentre.CostCentreType = 2)
           AND (dbo.tblProductBrand.name LIKE ISNULL(@Brand, N'%')) 
           AND(CONVERT(NVARCHAR(50), tblProductBrand.id) LIKE ISNULL(@brandId,N'%'))
           AND(CONVERT(NVARCHAR(50),tblCostCentre.Id) LIKE ISNULL(@distributorId, N'%')) 
           AND(CONVERT(NVARCHAR(50),dbo.tblCostCentre.Id) LIKE ISNULL(@salesManID, N'%')) 
           AND(CONVERT(NVARCHAR(50),dbo.tblProduct.id) LIKE ISNULL(@productId, N'%')) 
           AND(dbo.tblProduct.Description LIKE ISNULL(@Product, N'%'))
           AND dbo.tblProduct.IM_Status = 1 --Only Active Product


union all
SELECT     CONVERT(NVARCHAR(50), tblCostCentre_1.Id) AS DistributorId,  
           tblCostCentre_1.Name AS DistributorName, 
           dbo.tblProduct.id AS ProductId, 
           dbo.tblProduct.Description AS ProductName, 
           dbo.tblProductBrand.id AS BrandId,            
           dbo.tblProductBrand.name AS BrandName, 
           dbo.tblInventory.Balance AS InvBalance, 
           dbo.tblInventory.Value AS InvValue, 
           dbo.tblInventory.IM_DateCreated, 
           dbo.tblInventory.UnavailableBalance, 
           dbo.tblProduct.ExFactoryPrice

FROM       dbo.tblProductBrand INNER JOIN
           dbo.tblProduct INNER JOIN
           dbo.tblCostCentre INNER JOIN
           dbo.tblInventory ON dbo.tblCostCentre.Id = dbo.tblInventory.WareHouseId ON dbo.tblProduct.id = dbo.tblInventory.ProductId ON dbo.tblProductBrand.id = dbo.tblProduct.BrandId INNER JOIN
           dbo.tblCostCentre AS tblCostCentre_1 ON dbo.tblCostCentre.ParentCostCentreId = tblCostCentre_1.Id
WHERE     (dbo.tblInventory.Balance >= 0) 
           AND (dbo.tblCostCentre.CostCentreType = 4)
           AND (dbo.tblProductBrand.name LIKE ISNULL(@Brand, N'%')) 
           AND(CONVERT(NVARCHAR(50), tblProductBrand.id) LIKE ISNULL(@brandId,N'%'))
           AND(CONVERT(NVARCHAR(50),tblCostCentre_1.Id) LIKE ISNULL(@distributorId, N'%')) 
           AND(CONVERT(NVARCHAR(50),dbo.tblCostCentre.Id) LIKE ISNULL(@salesManID, N'%')) 
           AND(CONVERT(NVARCHAR(50),dbo.tblProduct.id) LIKE ISNULL(@productId, N'%')) 
           AND(dbo.tblProduct.Description LIKE ISNULL(@Product, N'%'))
           AND dbo.tblProduct.IM_Status = 1 --Only Active Product

           
  -- Exec    [dbo].[sp_D_Inventory]  @brandId='9BB2BB36-CFBC-4B47-8337-C3AA9481F932', @distributorId='E8C61376-8FD2-46B8-B293-952D7B86F54F',@salesManId='ALL',@productId='13572765-3FF4-44E1-9926-E6A19F95BF73',@packagingId='ALL',@Brand='ALL',@Product='ALL'

-- 9BB2BB36-CFBC-4B47-8337-C3AA9481F932 Ectoparaciticides BRAND
-- E8C61376-8FD2-46B8-B293-952D7B86F54F INTERLINK         DISTRIBUTOR
-- 13572765-3FF4-44E1-9926-E6A19F95BF73 DECATIX 20ml      PRODUCT 

-- 