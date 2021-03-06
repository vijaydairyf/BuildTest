/****** Object:  StoredProcedure [dbo].[sp_D_InventoryReceipt]    Script Date: 07/24/2013 08:51:32 ******/
DROP PROCEDURE [dbo].[sp_D_InventoryReceipt]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_D_InventoryReceipt]
(
@startDate AS DATE,
@endDate AS DATE,
@brandId AS NVARCHAR(50),
@productId AS NVARCHAR(50),
@packagingId AS NVARCHAR(50),
@flavourId AS NVARCHAR(50),
@distributorId AS NVARCHAR(50),
@salesManId AS NVARCHAR(50),
@Brand AS NVARCHAR(50),
@Product AS NVARCHAR(50)
)
AS 
if  @brandId='ALL'  begin set @brandId='%' end
if  @distributorId='ALL'  begin set @distributorId='%' end
if  @salesManId='ALL'  begin set @salesManId='%' end
if  @productId='ALL'  begin set @productId='%' end
if  @packagingId='ALL'  begin set @packagingId='%' end
if  @flavourId='ALL'  begin set @flavourId='%' end
if  @Brand='ALL'  begin set @Brand='%' end
if  @Product='ALL'  begin set @Product='%' end

SELECT     dbo.tblDocument.Id AS DocumentId, 
           dbo.tblDocument.DocumentReference, 
           dbo.tblLineItems.Quantity, 
           dbo.tblLineItems.Value, 
           dbo.tblDocument.DocumentDateIssued, 
           dbo.tblProduct.id AS ProductId, 
           dbo.tblProduct.Description AS ProductName, 
           dbo.tblProductBrand.id AS BrandId, 
           dbo.tblProductBrand.name AS BrandName, 
           dbo.tblProductFlavour.id AS FlavourId, 
           dbo.tblProductFlavour.name AS FlavourName, 
           dbo.tblProductPackaging.Id AS PackagingId, 
           dbo.tblProductPackaging.Name AS PackagingName, 
           dbo.tblCostCentre.Id AS DistributorId, 
           dbo.tblCostCentre.Name AS DistributorName, 
           dbo.tblCostCentre.CostCentreType

FROM       dbo.tblDocument INNER JOIN
           dbo.tblLineItems ON dbo.tblDocument.Id = dbo.tblLineItems.DocumentID INNER JOIN
           dbo.tblProduct ON dbo.tblLineItems.ProductID = dbo.tblProduct.id INNER JOIN
           dbo.tblProductBrand ON dbo.tblProduct.BrandId = dbo.tblProductBrand.id INNER JOIN
           dbo.tblProductFlavour ON dbo.tblProduct.FlavourId = dbo.tblProductFlavour.id INNER JOIN
           dbo.tblProductPackaging ON dbo.tblProduct.PackagingId = dbo.tblProductPackaging.Id INNER JOIN
           dbo.tblCostCentre ON dbo.tblDocument.DocumentIssuerCostCentreId = dbo.tblCostCentre.Id

WHERE     (dbo.tblDocument.DocumentTypeId = 3)       
            AND(CONVERT(NVARCHAR(50),dbo.tblCostCentre.Id) LIKE ISNULL(@distributorId, N'%'))        
            AND(CONVERT(NVARCHAR(50),dbo.tblProduct.id) LIKE ISNULL(@product, N'%'))  
            AND(CONVERT(NVARCHAR(50),dbo.tblProductBrand.id) LIKE ISNULL(@brandId, N'%')) 
            AND(CONVERT(NVARCHAR(50), dbo.tblProductFlavour.id) LIKE ISNULL(@flavourId, N'%')) 
            AND(CONVERT(NVARCHAR(50), dbo.tblProductPackaging.Id) LIKE ISNULL(@packagingId, N'%')) 
            AND(CONVERT(VARCHAR(26), dbo.tblDocument.DocumentDateIssued,23)  BETWEEN @startDate AND @endDate)
            
     -- Exec [dbo].[sp_D_InventoryReceipt] @brandId='ALL',@distributorId='ALL',@salesManId='ALL',@productId='ALL',@packagingId='ALL',@flavourId='ALL',@Brand='ALL',@Product='ALL',@startDate='1-Jan-2013',@endDate='1-Dec-2013'

GO
