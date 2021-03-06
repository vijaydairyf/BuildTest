
/****** Object:  StoredProcedure [dbo].[sp_D_PurchasesByProductType]    Script Date: 08/19/2013 10:48:41 ******/
DROP PROCEDURE [dbo].[sp_D_PurchasesByProductType]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_D_PurchasesByProductType]
(
@startDate as date,
@endDate as date,
@distributorId AS NVARCHAR(50),
@productType AS NVARCHAR(50),
@brandId AS NVARCHAR(50),
@subBrandId AS NVARCHAR(50),
@productId AS NVARCHAR(50),
@packagingId AS NVARCHAR(50)
)

AS
if  ltrim(rtrim(@distributorId))='ALL'  begin set @distributorId='%' end
if  ltrim(rtrim(@productType))='ALL'  begin set @productType='%' end
if  ltrim(rtrim(@brandId))='ALL'  begin set @brandId='%' end
if  ltrim(rtrim(@subBrandId))='ALL'  begin set @subBrandId='%' end
if  ltrim(rtrim(@productId))='ALL'  begin set @productId='%' end
if  ltrim(rtrim(@packagingId))='ALL'  begin set @packagingId='%' end

SELECT     dbo.tblDocument.Id AS DocId, dbo.tblCostCentre.Id AS DistributorId, dbo.tblCostCentre.Name AS Distributor, dbo.tblCostCentre.CostCentreType AS ccDistributor, 
                      dbo.tblLineItems.Quantity, dbo.tblLineItems.Value, dbo.tblLineItems.Vat, dbo.tblDocument.SendDateTime, dbo.tblDocument.OrderOrderTypeId, 
                      dbo.tblDocument.DocumentTypeId, dbo.tblDocument.DocumentStatusId, dbo.tblProduct.id AS ProductId, dbo.tblProduct.Description AS Product, 
                      dbo.tblLineItems.OrderLineItemType, dbo.tblDocument.DocumentReference, dbo.tblDocument.OrderParentId, dbo.tblProductBrand.id AS BrandId, 
                      dbo.tblProductBrand.name AS Brand, dbo.tblProductPackaging.Id AS PackagingId, dbo.tblProductPackaging.Name AS Packaging, 
                      dbo.tblProductFlavour.id AS SubBrandId, dbo.tblProductFlavour.name AS SubBrand, dbo.tblProductPackagingType.id AS ProductPackagingTypeId, 
                      dbo.tblProductPackagingType.name AS ProductPackagingType, dbo.tblProductType.id AS ProductTypeId, dbo.tblProductType.name AS ProductType
FROM         dbo.tblDocument INNER JOIN
                      dbo.tblLineItems ON dbo.tblDocument.Id = dbo.tblLineItems.DocumentID INNER JOIN
                      dbo.tblCostCentre ON dbo.tblDocument.DocumentIssuerCostCentreId = dbo.tblCostCentre.Id INNER JOIN
                      dbo.tblProduct ON dbo.tblLineItems.ProductID = dbo.tblProduct.id INNER JOIN
                      dbo.tblProductBrand ON dbo.tblProduct.BrandId = dbo.tblProductBrand.id INNER JOIN
                      dbo.tblProductPackaging ON dbo.tblProduct.PackagingId = dbo.tblProductPackaging.Id INNER JOIN
                      dbo.tblProductFlavour ON dbo.tblProduct.FlavourId = dbo.tblProductFlavour.id INNER JOIN
                      dbo.tblProductPackagingType ON dbo.tblProduct.PackagingTypeId = dbo.tblProductPackagingType.id INNER JOIN
                      dbo.tblProductType ON dbo.tblProduct.ProductTypeId = dbo.tblProductType.id
                      
WHERE     (dbo.tblCostCentre.CostCentreType = 2)
                       AND (dbo.tblDocument.OrderOrderTypeId = 2)
                       AND (dbo.tblDocument.DocumentTypeId = 1)
                       AND (dbo.tblDocument.DocumentStatusId = 99)
                       AND (dbo.tblDocument.Id = dbo.tblDocument.OrderParentId)
                       AND(Convert(nvarchar(26),dbo.tblDocument.SendDateTime,23) BETWEEN @startDate AND @endDate) 
					   AND(CONVERT(NVARCHAR(50), dbo.tblCostCentre.Id)LIKE ISNULL(@distributorId, N'%'))
					   AND(CONVERT(NVARCHAR(50), dbo.tblProductType.id)LIKE ISNULL(@productType, N'%'))
					   AND(CONVERT(NVARCHAR(50), dbo.tblProduct.id)LIKE ISNULL(@productId, N'%'))
						AND(CONVERT(NVARCHAR(50), dbo.tblProductBrand.id)LIKE ISNULL(@brandId, N'%'))
						 AND(CONVERT(NVARCHAR(50), dbo.tblProductPackaging.Id)LIKE ISNULL(@packagingId, N'%'))