/****** Object:  StoredProcedure [dbo].[sp_D_Inventory_StockSummary_PerProductType]    Script Date: 07/24/2013 08:51:32 ******/
DROP PROCEDURE [dbo].[sp_D_Inventory_StockSummary_PerProductType]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_D_Inventory_StockSummary_PerProductType]
(
@brandId AS NVARCHAR(50),
@productId AS NVARCHAR(50),
--@packagingId AS NVARCHAR(50),
@distributorId AS NVARCHAR(50),
@salesmanId AS NVARCHAR(50),
@productTypeId as nvarchar(50)
)
AS
if  ltrim(rtrim(@distributorId))='ALL'  begin set @distributorId='%' end
if  ltrim(rtrim(@salesmanId))='ALL'  begin set @salesmanId='%' end
if  ltrim(rtrim(@brandId))='ALL'  begin set @brandId='%' end
if  ltrim(rtrim(@productId))='ALL'  begin set @productId='%' end
--if  ltrim(rtrim(@packagingId))='ALL'  begin set @packagingId='%' end
if  ltrim(rtrim(@productTypeId))='ALL'  begin set @productTypeId='%' end

SELECT     CONVERT(NVARCHAR(50), dbo.tblCostCentre.Id) AS DistributorId, 
           dbo.tblCostCentre.Name AS DistributorName, 
           dbo.tblProduct.id AS ProductId, 
           dbo.tblProduct.Description AS ProductName, 
           dbo.tblProductBrand.id AS BrandId, 
           dbo.tblProductBrand.name AS BrandName, 
           dbo.tblProduct.FlavourId AS SubBrandId, 
           dbo.tblInventory.Balance AS InvBalance, 
           dbo.tblInventory.Value AS InvValue, 
           dbo.tblInventory.IM_DateCreated, 
           dbo.tblInventory.UnavailableBalance, 
           dbo.tblProduct.ExFactoryPrice,
           dbo.tblProductType.id as productTypeId,
           dbo.tblProductType.name as productTypeName

FROM       dbo.tblProductBrand 
INNER JOIN dbo.tblProduct 
INNER JOIN dbo.tblCostCentre 
INNER JOIN dbo.tblInventory ON dbo.tblCostCentre.Id = dbo.tblInventory.WareHouseId ON dbo.tblProduct.id = dbo.tblInventory.ProductId ON dbo.tblProductBrand.id = dbo.tblProduct.BrandId 
LEFT OUTER JOIN dbo.tblProductType on dbo.tblProduct.ProductTypeId = dbo.tblProductType.id
            
WHERE     (dbo.tblInventory.Balance >= 0) AND (dbo.tblCostCentre.CostCentreType = 2)
           AND dbo.tblProduct.IM_Status = 1 --Only Active Product
           AND(CONVERT(NVARCHAR(50), tblProductBrand.id) LIKE ISNULL(@brandId,N'%'))
           AND(CONVERT(NVARCHAR(50),tblCostCentre.Id) LIKE ISNULL(@distributorId, N'%')) 
           AND(CONVERT(NVARCHAR(50),dbo.tblCostCentre.Id) LIKE ISNULL(@salesmanId, N'%')) 
           AND(CONVERT(NVARCHAR(50),dbo.tblProduct.id) LIKE ISNULL(@productId, N'%')) 
           AND((CONVERT(NVARCHAR(50),dbo.tblProductType.id) LIKE ISNULL(@productTypeId, N'%')) OR dbo.tblProductType.id IS NULL)


union all

SELECT     CONVERT(NVARCHAR(50), tblCostCentre_1.Id) AS DistributorId,  
           tblCostCentre_1.Name AS DistributorName, 
           dbo.tblProduct.id AS ProductId, 
           dbo.tblProduct.Description AS ProductName, 
           dbo.tblProductBrand.id AS BrandId,            
           dbo.tblProductBrand.name AS BrandName, 
           dbo.tblProduct.FlavourId AS SubBrandId, 
           dbo.tblInventory.Balance AS InvBalance, 
           dbo.tblInventory.Value AS InvValue, 
           dbo.tblInventory.IM_DateCreated, 
           dbo.tblInventory.UnavailableBalance, 
           dbo.tblProduct.ExFactoryPrice,
           dbo.tblProductType.id as productTypeId,
           dbo.tblProductType.name as productTypeName


FROM       dbo.tblProductBrand 
INNER JOIN dbo.tblProduct 
INNER JOIN dbo.tblCostCentre 
INNER JOIN dbo.tblInventory ON dbo.tblCostCentre.Id = dbo.tblInventory.WareHouseId ON dbo.tblProduct.id = dbo.tblInventory.ProductId ON dbo.tblProductBrand.id = dbo.tblProduct.BrandId 
INNER JOIN dbo.tblCostCentre AS tblCostCentre_1 ON dbo.tblCostCentre.ParentCostCentreId = tblCostCentre_1.Id 
LEFT OUTER JOIN dbo.tblProductType on dbo.tblProduct.ProductTypeId = dbo.tblProductType.id
           
WHERE     (dbo.tblInventory.Balance >= 0) AND (dbo.tblCostCentre.CostCentreType = 4)
		   AND dbo.tblProduct.IM_Status = 1 --Only Active Product
           AND(CONVERT(NVARCHAR(50), tblProductBrand.id) LIKE ISNULL(@brandId,N'%'))
           AND(CONVERT(NVARCHAR(50),tblCostCentre_1.Id) LIKE ISNULL(@distributorId, N'%')) 
           AND(CONVERT(NVARCHAR(50),dbo.tblCostCentre.Id) LIKE ISNULL(@salesmanId, N'%')) 
           AND(CONVERT(NVARCHAR(50),dbo.tblProduct.id) LIKE ISNULL(@productId, N'%')) 
           AND((CONVERT(NVARCHAR(50),dbo.tblProductType.id) LIKE ISNULL(@productTypeId, N'%'))  OR dbo.tblProductType.id IS NULL)
   
  --   Exec    [dbo].[sp_D_Inventory_StockSummary_PerProductType]  @brandId='ALL', @distributorId=' ALL',@salesmanId='ALL',@productId='ALL',@productTypeId='ALL'

           
 GO          