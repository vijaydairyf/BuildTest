/****** Object:  StoredProcedure [dbo].[sp_D_Inventory]    Script Date: 07/24/2013 08:51:32 ******/
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
if  rtrim(ltrim(@brandId))='ALL'  begin set @brandId='%' end
if  rtrim(ltrim(@distributorId))='ALL'  begin set @distributorId='%' end
if  rtrim(ltrim(@salesManId))='ALL'  begin set @salesManId='%' end
if  rtrim(ltrim(@productId))='ALL'  begin set @productId='%' end
if  rtrim(ltrim(@packagingId))='ALL'  begin set @packagingId='%' end
if  rtrim(ltrim(@Brand))='ALL'  begin set @Brand='%' end
if  rtrim(ltrim(@Product))='ALL'  begin set @Product='%' end

SELECT     COUNT(dbo.tblProductBrand.name) NoOfBrands,
           CONVERT(NVARCHAR(50), dbo.tblCostCentre.Id) AS DistributorId,           
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
FROM       dbo.tblProductBrand 
 JOIN      dbo.tblProduct 
 JOIN      dbo.tblCostCentre 
 JOIN      dbo.tblInventory ON dbo.tblCostCentre.Id = dbo.tblInventory.WareHouseId ON dbo.tblProduct.id = dbo.tblInventory.ProductId ON dbo.tblProductBrand.id = dbo.tblProduct.BrandId
WHERE     (dbo.tblInventory.Balance >= 0) AND (dbo.tblCostCentre.CostCentreType = 2)
           AND dbo.tblProduct.IM_Status = 1 --Only Active Product
           AND (dbo.tblProductBrand.name LIKE ISNULL(@Brand, N'%')) 
           AND(CONVERT(NVARCHAR(50), tblProductBrand.id) LIKE ISNULL(@brandId,N'%'))
           AND(CONVERT(NVARCHAR(50),tblCostCentre.Id) LIKE ISNULL(@distributorId, N'%')) 
           AND(CONVERT(NVARCHAR(50),dbo.tblCostCentre.Id) LIKE ISNULL(@salesManID, N'%')) 
           AND(CONVERT(NVARCHAR(50),dbo.tblProduct.id) LIKE ISNULL(@productId, N'%')) 
           AND(dbo.tblProduct.Description LIKE ISNULL(@Product, N'%'))
GROUP BY   dbo.tblCostCentre.Id,           
           dbo.tblCostCentre.Name, 
           dbo.tblProduct.id , 
           dbo.tblProduct.Description , 
           dbo.tblProductBrand.id , 
           dbo.tblProductBrand.name , 
           dbo.tblInventory.Balance  , 
           dbo.tblInventory.Value  , 
           dbo.tblInventory.IM_DateCreated, 
           dbo.tblInventory.UnavailableBalance, 
           dbo.tblProduct.ExFactoryPrice


union all
SELECT     COUNT(dbo.tblProductBrand.name) NoOfBrands,
           CONVERT(NVARCHAR(50), tblCostCentre_1.Id) AS DistributorId,  
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
WHERE     (dbo.tblInventory.Balance >= 0) AND (dbo.tblCostCentre.CostCentreType = 4)
           AND dbo.tblProduct.IM_Status = 1 --Only Active Product
           AND (dbo.tblProductBrand.name LIKE ISNULL(@Brand, N'%')) 
           AND(CONVERT(NVARCHAR(50), tblProductBrand.id) LIKE ISNULL(@brandId,N'%'))
           AND(CONVERT(NVARCHAR(50),tblCostCentre_1.Id) LIKE ISNULL(@distributorId, N'%')) 
           AND(CONVERT(NVARCHAR(50),dbo.tblCostCentre.Id) LIKE ISNULL(@salesManID, N'%')) 
           AND(CONVERT(NVARCHAR(50),dbo.tblProduct.id) LIKE ISNULL(@productId, N'%')) 
           AND(dbo.tblProduct.Description LIKE ISNULL(@Product, N'%'))
    GROUP BY   tblCostCentre_1.Id,           
           tblCostCentre_1.Name, 
           dbo.tblProduct.id , 
           dbo.tblProduct.Description , 
           dbo.tblProductBrand.id , 
           dbo.tblProductBrand.name , 
           dbo.tblInventory.Balance  , 
           dbo.tblInventory.Value  , 
           dbo.tblInventory.IM_DateCreated, 
           dbo.tblInventory.UnavailableBalance, 
           dbo.tblProduct.ExFactoryPrice
       
           
   --  Exec    [dbo].[sp_D_Inventory]  @brandId='3eded5d4-ac22-48ed-973b-faec34dead19', @distributorId='ALL',@salesManId='ALL',@productId='ALL',@packagingId='ALL',@Brand='ALL',@Product='ALL'

GO
