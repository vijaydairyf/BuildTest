/****** Object:  StoredProcedure [dbo].[sp_D_Purchases]    Script Date: 07/24/2013 08:51:32 ******/
DROP PROCEDURE [dbo].[sp_D_Purchases]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_D_Purchases]
(
@startDate as date,
@endDate as date,
@distributorId AS NVARCHAR(50),
@brandId AS NVARCHAR(50),
@productId AS NVARCHAR(50),
@packagingId AS NVARCHAR(50)


)
AS
if ltrim(rtrim(@distributorId))='ALL'  begin set @distributorId='%' end
if ltrim(rtrim(@productId))='ALL'  begin set @productId='%' end
if ltrim(rtrim(@brandId))='ALL'  begin set @brandId='%' end
if ltrim(rtrim(@packagingId))='ALL'  begin set @packagingId='%' end

SELECT     dbo.tblDocument.Id AS DocId, 
           dbo.tblCostCentre.Id AS DistributorId, 
           dbo.tblCostCentre.Name AS Distributor, 
           dbo.tblCostCentre.CostCentreType AS ccDistributor, 
           dbo.tblLineItems.Quantity, 
           dbo.tblLineItems.Value, 
           dbo.tblLineItems.Vat, 
           dbo.tblDocument.SendDateTime, 
           dbo.tblDocument.OrderOrderTypeId, 
           dbo.tblDocument.DocumentTypeId, 
           dbo.tblDocument.DocumentStatusId, 
           dbo.tblProduct.id AS ProductId, 
           dbo.tblProduct.Description AS Product, 
           dbo.tblLineItems.OrderLineItemType, 
           dbo.tblDocument.DocumentReference, 
           dbo.tblDocument.OrderParentId,
           @startDate as startDate, 
           @endDate as endDate,
           dbo.tblProductBrand.id AS BrandId, 
           dbo.tblProductBrand.name AS Brand, 
           dbo.tblProductPackaging.Id AS PackagingId, 
           dbo.tblProductPackaging.Name AS Packaging


FROM         dbo.tblDocument INNER JOIN
                      dbo.tblLineItems ON dbo.tblDocument.Id = dbo.tblLineItems.DocumentID INNER JOIN
                      dbo.tblCostCentre ON dbo.tblDocument.DocumentIssuerCostCentreId = dbo.tblCostCentre.Id INNER JOIN
                      dbo.tblProduct ON dbo.tblLineItems.ProductID = dbo.tblProduct.id INNER JOIN
                      dbo.tblProductBrand ON dbo.tblProduct.BrandId = dbo.tblProductBrand.id  INNER JOIN
                      dbo.tblProductPackaging ON dbo.tblProduct.PackagingId = dbo.tblProductPackaging.Id


                      
WHERE     (dbo.tblCostCentre.CostCentreType = 2)
          AND (dbo.tblDocument.OrderOrderTypeId = 2) 
          AND (dbo.tblDocument.DocumentTypeId = 1) 
          AND (dbo.tblDocument.DocumentStatusId = 99)
          AND (dbo.tblDocument.Id = dbo.tblDocument.OrderParentId)
          AND(Convert(nvarchar(26),dbo.tblDocument.SendDateTime,23) BETWEEN @startDate AND @endDate) 
          AND(CONVERT(NVARCHAR(50), dbo.tblCostCentre.Id)LIKE ISNULL(@distributorId, N'%'))
          AND(CONVERT(NVARCHAR(50), dbo.tblProduct.id)LIKE ISNULL(@productId, N'%'))
          AND(CONVERT(NVARCHAR(50), dbo.tblProductBrand.id)LIKE ISNULL(@brandId, N'%'))
          AND(CONVERT(NVARCHAR(50), dbo.tblProductPackaging.Id)LIKE ISNULL(@packagingId, N'%'))
          
  -- EXEC  [dbo].[sp_D_Purchases] @distributorId='ALL' ,@productId='ALL',@brandId='ALL',@packagingId='ALL',@startDate='1-Jan-2013',@endDate='1-Dec-2014'

GO
