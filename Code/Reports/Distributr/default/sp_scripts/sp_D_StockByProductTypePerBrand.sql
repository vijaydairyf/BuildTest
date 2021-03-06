--
DROP PROCEDURE [dbo].[sp_D_StockByProductTypePerBrand]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_D_StockByProductTypePerBrand]
(
@brandId AS NVARCHAR(50),
@productId AS NVARCHAR(50),
@packagingId AS NVARCHAR(50),
@distributorId AS NVARCHAR(50),
@salesManId AS NVARCHAR(50),
@Brand AS NVARCHAR(50),
@subBrandID as nvarchar(50),
@Product AS NVARCHAR(50),
@productTypeID as nvarchar(50)
)
AS 
if  RTRIM(Ltrim(@brandId))='ALL'  begin set @brandId='%' end
if  RTRIM(Ltrim(@distributorId))='ALL'  begin set @distributorId='%' end
if  RTRIM(Ltrim(@salesManId))='ALL'  begin set @salesManId='%' end
if  RTRIM(Ltrim(@productId))='ALL'  begin set @productId='%' end
if  RTRIM(Ltrim(@packagingId))='ALL'  begin set @packagingId='%' end
if  RTRIM(Ltrim(@Brand))='ALL'  begin set @Brand='%' end
if  RTRIM(Ltrim(@subBrandID))='ALL'  begin set @subBrandID='%' end
if  RTRIM(Ltrim(@Product))='ALL'  begin set @Product='%' end
if  RTRIM(Ltrim(@productTypeID))='ALL'  begin set @productTypeID='%' END

SELECT     CONVERT(NVARCHAR(50), dbo.tblCostCentre.Id) AS DistributorId, dbo.tblCostCentre.Name AS DistributorName, dbo.tblProduct.id AS ProductId, 
                      dbo.tblProduct.Description AS ProductName, dbo.tblProductBrand.id AS BrandId, dbo.tblProductBrand.name AS BrandName, dbo.tblInventory.Balance AS InvBalance, 
                      dbo.tblInventory.Value AS InvValue, dbo.tblInventory.IM_DateCreated, dbo.tblInventory.UnavailableBalance, dbo.tblProduct.ExFactoryPrice, 
                      dbo.tblProductType.id AS productTypeId, dbo.tblProductType.name AS productTypeName, dbo.tblProductFlavour.name AS SubBrandName, 
                      dbo.tblProductPackaging.Id AS PackageId, dbo.tblProductPackaging.Name AS PackageName
FROM         dbo.tblProductBrand INNER JOIN
                      dbo.tblProduct INNER JOIN
                      dbo.tblCostCentre INNER JOIN
                      dbo.tblInventory ON dbo.tblCostCentre.Id = dbo.tblInventory.WareHouseId ON dbo.tblProduct.id = dbo.tblInventory.ProductId ON 
                      dbo.tblProductBrand.id = dbo.tblProduct.BrandId INNER JOIN
                      dbo.tblProductType ON dbo.tblProduct.ProductTypeId = dbo.tblProductType.id INNER JOIN
                      dbo.tblProductFlavour ON dbo.tblProduct.FlavourId = dbo.tblProductFlavour.id INNER JOIN
                      dbo.tblProductPackaging ON dbo.tblProduct.PackagingId = dbo.tblProductPackaging.Id
WHERE     (dbo.tblInventory.Balance >= 0) AND (dbo.tblCostCentre.CostCentreType = 2)
           AND (dbo.tblProductBrand.name LIKE ISNULL(@Brand, N'%')) 
           AND(CONVERT(NVARCHAR(50), tblProductBrand.id) LIKE ISNULL(@brandId,N'%'))
           AND(CONVERT(NVARCHAR(50),tblCostCentre.Id) LIKE ISNULL(@distributorId, N'%')) 
           AND(CONVERT(NVARCHAR(50),dbo.tblCostCentre.Id) LIKE ISNULL(@salesManID, N'%')) 
           AND(CONVERT(NVARCHAR(50),dbo.tblProduct.id) LIKE ISNULL(@productId, N'%')) 
           AND(CONVERT(NVARCHAR(50),dbo.tblProductFlavour.id ) LIKE ISNULL(@subBrandID, N'%'))
           AND(CONVERT(NVARCHAR(50),dbo.tblProductType.id) LIKE ISNULL(@productTypeID, N'%')) 
           AND(dbo.tblProduct.Description LIKE ISNULL(@Product, N'%'))
           AND dbo.tblProduct.IM_Status = 1 --Only Active Product


union all

SELECT     CONVERT(NVARCHAR(50), tblCostCentre_1.Id) AS DistributorId, tblCostCentre_1.Name AS DistributorName, dbo.tblProduct.id AS ProductId, 
                      dbo.tblProduct.Description AS ProductName, dbo.tblProductBrand.id AS BrandId, dbo.tblProductBrand.name AS BrandName, dbo.tblInventory.Balance AS InvBalance, 
                      dbo.tblInventory.Value AS InvValue, dbo.tblInventory.IM_DateCreated, dbo.tblInventory.UnavailableBalance, dbo.tblProduct.ExFactoryPrice, 
                      dbo.tblProductType.id AS productTypeId, dbo.tblProductType.name AS productTypeName, dbo.tblProductFlavour.name AS SubBrandName,
                       dbo.tblProductPackaging.Id AS PackageId, dbo.tblProductPackaging.Name AS PackageName
FROM         dbo.tblProductBrand INNER JOIN
                      dbo.tblProduct INNER JOIN
                      dbo.tblCostCentre INNER JOIN
                      dbo.tblInventory ON dbo.tblCostCentre.Id = dbo.tblInventory.WareHouseId ON dbo.tblProduct.id = dbo.tblInventory.ProductId ON 
                      dbo.tblProductBrand.id = dbo.tblProduct.BrandId INNER JOIN
                      dbo.tblCostCentre AS tblCostCentre_1 ON dbo.tblCostCentre.ParentCostCentreId = tblCostCentre_1.Id INNER JOIN
                      dbo.tblProductType ON dbo.tblProduct.ProductTypeId = dbo.tblProductType.id INNER JOIN
                      dbo.tblProductFlavour ON dbo.tblProduct.FlavourId = dbo.tblProductFlavour.id INNER JOIN
                      dbo.tblProductPackaging ON dbo.tblProduct.PackagingId = dbo.tblProductPackaging.Id
           
WHERE     (dbo.tblInventory.Balance >= 0) AND (dbo.tblCostCentre.CostCentreType = 4)
           AND (dbo.tblProductBrand.name LIKE ISNULL(@Brand, N'%')) 
           AND(CONVERT(NVARCHAR(50), tblProductBrand.id) LIKE ISNULL(@brandId,N'%'))
           AND(CONVERT(NVARCHAR(50),tblCostCentre_1.Id) LIKE ISNULL(@distributorId, N'%')) 
           AND(CONVERT(NVARCHAR(50),dbo.tblCostCentre.Id) LIKE ISNULL(@salesManID, N'%')) 
           AND(CONVERT(NVARCHAR(50),dbo.tblProduct.id) LIKE ISNULL(@productId, N'%')) 
           AND(CONVERT(NVARCHAR(50),dbo.tblProductFlavour.id ) LIKE ISNULL(@subBrandID, N'%'))
           AND(CONVERT(NVARCHAR(50),dbo.tblProductType.id) LIKE ISNULL(@productTypeID, N'%')) 
           AND(dbo.tblProduct.Description LIKE ISNULL(@Product, N'%'))
           AND dbo.tblProduct.IM_Status = 1 --Only Active Product