/****** Object:  StoredProcedure [dbo].[sp_D_InventoryByFlavourANDByPackaging]    Script Date: 07/24/2013 08:51:32 ******/
DROP PROCEDURE [dbo].[sp_D_InventoryByFlavourANDByPackaging]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_D_InventoryByFlavourANDByPackaging]
(
@brandId AS NVARCHAR(50),
@productId AS NVARCHAR(50),
@packagingId AS NVARCHAR(50),
@flavourId AS NVARCHAR(50),
@distributorId AS NVARCHAR(50),
@salesManId AS NVARCHAR(50)
)
AS 
if  @brandId='ALL'  begin set @brandId='%' end
if  @distributorId='ALL'  begin set @distributorId='%' end
if  @salesManId='ALL'  begin set @salesManId='%' end
if  @productId='ALL'  begin set @productId='%' end
if  @packagingId='ALL'  begin set @packagingId='%' end
if  @flavourId='ALL'  begin set @flavourId='%' end



SELECT     CONVERT(NVARCHAR(50), dbo.tblCostCentre.Id) AS DistributorId, 
           dbo.tblCostCentre.Name AS DistributorName, 
           
           dbo.tblProduct.id AS ProductId, 
           dbo.tblProduct.Description AS ProductName, 
           
           dbo.tblProductBrand.id AS BrandId, 
           dbo.tblProductBrand.name AS BrandName, 
           
           flav.id FlavourId,
           flav.name FlavourName,
           
           dbo.tblProductPackaging.Id PackagingId,
           dbo.tblProductPackaging.Name PackagingName,
           
           dbo.tblCostCentre.CostCentreType ,
           dbo.tblInventory.Balance AS InvBalance, 
           dbo.tblInventory.Value AS InvValue, 
           dbo.tblInventory.IM_DateCreated, 
           dbo.tblInventory.UnavailableBalance, 
           dbo.tblProduct.ExFactoryPrice
           
FROM        dbo.tblProductBrand
 INNER JOIN dbo.tblProduct 
 LEFT OUTER JOIN dbo.tblProductPackaging ON dbo.tblProduct.PackagingId = dbo.tblProductPackaging.Id
 INNER JOIN dbo.tblProductFlavour flav ON flav.id = dbo.tblProduct.FlavourId 
 inner join dbo.tblCostCentre 
 INNER JOIN dbo.tblInventory ON dbo.tblCostCentre.Id = dbo.tblInventory.WareHouseId ON dbo.tblProduct.id = dbo.tblInventory.ProductId ON dbo.tblProductBrand.id = dbo.tblProduct.BrandId
 
WHERE     (dbo.tblInventory.Balance >= 0) 
      AND (dbo.tblCostCentre.CostCentreType = 2)
      AND(CONVERT(NVARCHAR(50), tblProductBrand.id) LIKE ISNULL(@brandId,N'%'))
      AND(CONVERT(NVARCHAR(50),tblCostCentre.Id) LIKE ISNULL(@distributorId, N'%')) 
      AND(CONVERT(NVARCHAR(50),dbo.tblCostCentre.Id) LIKE ISNULL(@salesManID, N'%')) 
      AND(CONVERT(NVARCHAR(50),dbo.tblProduct.id) LIKE ISNULL(@productId, N'%')) 


union all
SELECT     CONVERT(NVARCHAR(50), tblCostCentre_1.Id) AS DistributorId,  
           tblCostCentre_1.Name AS DistributorName, 
           
           dbo.tblProduct.id AS ProductId, 
           dbo.tblProduct.Description AS ProductName, 
           
           dbo.tblProductBrand.id AS BrandId,            
           dbo.tblProductBrand.name AS BrandName, 
           
           flav.id FlavourId,
           flav.name FlavourName,  
                    
           dbo.tblProductPackaging.Id PackagingId,
           dbo.tblProductPackaging.Name PackagingName,  
           
           dbo.tblCostCentre.CostCentreType ,    
           dbo.tblInventory.Balance AS InvBalance, 
           dbo.tblInventory.Value AS InvValue, 
           dbo.tblInventory.IM_DateCreated, 
           dbo.tblInventory.UnavailableBalance, 
           dbo.tblProduct.ExFactoryPrice

FROM       dbo.tblProductBrand 
INNER JOIN dbo.tblProduct 
LEFT OUTER JOIN dbo.tblProductPackaging ON dbo.tblProduct.PackagingId = dbo.tblProductPackaging.Id
INNER JOIN dbo.tblProductFlavour flav ON flav.id = dbo.tblProduct.FlavourId 
inner join dbo.tblCostCentre 
INNER JOIN dbo.tblInventory ON dbo.tblCostCentre.Id = dbo.tblInventory.WareHouseId ON dbo.tblProduct.id = dbo.tblInventory.ProductId ON dbo.tblProductBrand.id = dbo.tblProduct.BrandId 
INNER JOIN dbo.tblCostCentre AS tblCostCentre_1 ON dbo.tblCostCentre.ParentCostCentreId = tblCostCentre_1.Id

WHERE     (dbo.tblInventory.Balance >= 0) 
      AND (dbo.tblCostCentre.CostCentreType = 4)
      AND(CONVERT(NVARCHAR(50), tblProductBrand.id) LIKE ISNULL(@brandId,N'%'))
      AND(CONVERT(NVARCHAR(50),tblCostCentre_1.Id) LIKE ISNULL(@distributorId, N'%')) 
      AND(CONVERT(NVARCHAR(50),dbo.tblCostCentre.Id) LIKE ISNULL(@salesManID, N'%')) 
      AND(CONVERT(NVARCHAR(50),dbo.tblProduct.id) LIKE ISNULL(@productId, N'%')) 
           
           


       
 --  EXEC [dbo].[sp_D_InventoryByFlavourANDByPackaging] @brandId='ALL',@distributorId='ALL',@salesManId='ALL',@productId='ALL',@packagingId='ALL',@flavourId='ALL'   
       
           
           
GO
