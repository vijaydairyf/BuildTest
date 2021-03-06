/****** Object:  StoredProcedure [dbo].[GetOrders]    Script Date: 07/24/2013 08:51:31 ******/
DROP PROCEDURE [dbo].[GetOrders]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[GetOrders]
(

@startDate as date,
@endDate as date,
@distributorId AS NVARCHAR(50),
@salesmanId AS NVARCHAR(50),
@brandId AS NVARCHAR(50),
@subBrandId AS NVARCHAR(50),
@ordersRef AS NVARCHAR(50)

)

AS


if  @distributorId='ALL'  begin set @distributorId='%' end
if  @salesmanId='ALL'  begin set @salesmanId='%' end
if  @brandId='ALL'  begin set @brandId='%' end
if  @subBrandId='ALL'  begin set @subBrandId='%' end
if  @ordersRef='ALL'  begin set @ordersRef='%' end



SELECT        dbo.tblDocument.DocumentReference, dbo.tblDocument.Id, dbo.tblDocument.DocumentTypeId, dbo.tblDocument.OrderOrderTypeId,dbo.tblDocument.SendDateTime, dbo.tblLineItems.Value, 
                         dbo.tblLineItems.Quantity, dbo.tblLineItems.Vat, dbo.tblCostCentre.Id AS distributorId, tblCostCentre_1.Id AS salesmanId, dbo.tblCostCentre.Name AS distributor, 
                         tblCostCentre_1.Name AS salesman, dbo.tblCostCentre.CostCentreType AS ccdistributor, tblCostCentre_1.CostCentreType AS ccSaleman, 
                         dbo.tblProductBrand.name AS Brand, dbo.tblProductBrand.id AS BrandId, dbo.tblProductFlavour.name AS SubBrand, dbo.tblProductFlavour.id AS SubBrandId, 
                         dbo.tblProduct.Description AS Product, dbo.tblProduct.id AS ProductId
                         --, @startDate as startDate, @endDate as endDate

FROM            dbo.tblCostCentre AS tblCostCentre_1 INNER JOIN
                         dbo.tblLineItems INNER JOIN
                         dbo.tblDocument ON dbo.tblLineItems.DocumentID = dbo.tblDocument.Id INNER JOIN
                         dbo.tblCostCentre ON dbo.tblDocument.DocumentIssuerCostCentreId = dbo.tblCostCentre.Id INNER JOIN
                         dbo.tblProduct INNER JOIN
                         dbo.tblProductBrand ON dbo.tblProduct.BrandId = dbo.tblProductBrand.id ON dbo.tblLineItems.ProductID = dbo.tblProduct.id ON 
                         tblCostCentre_1.Id = dbo.tblDocument.DocumentRecipientCostCentre INNER JOIN
                         dbo.tblProductFlavour ON dbo.tblProduct.FlavourId = dbo.tblProductFlavour.id

WHERE        (dbo.tblDocument.DocumentTypeId = 1) AND (dbo.tblDocument.OrderOrderTypeId = 3) AND (dbo.tblCostCentre.CostCentreType = 2) AND 
                         (tblCostCentre_1.CostCentreType = 4)
                         AND (dbo.tblDocument.SendDateTime BETWEEN @startDate AND @endDate) 
                         AND(CONVERT(NVARCHAR(50),dbo.tblCostCentre.Id)LIKE ISNULL(@distributorId, N'%'))
                         AND(CONVERT(NVARCHAR(50),tblCostCentre_1.Id)LIKE ISNULL(@salesmanId, N'%'))
                         AND(CONVERT(NVARCHAR(50),dbo.tblProductBrand.id)LIKE ISNULL(@brandId, N'%'))
                         AND(CONVERT(NVARCHAR(50),dbo.tblProductFlavour.id)LIKE ISNULL(@subBrandId, N'%'))
                         AND(CONVERT(NVARCHAR(50), dbo.tblDocument.DocumentReference)LIKE ISNULL(@ordersRef, N'%'))
                         

UNION


SELECT     dbo.tblDocument.DocumentReference, dbo.tblDocument.Id, dbo.tblDocument.DocumentTypeId, dbo.tblDocument.OrderOrderTypeId,dbo.tblDocument.SendDateTime, dbo.tblLineItems.Value, 
                      dbo.tblLineItems.Quantity, dbo.tblLineItems.Vat, dbo.tblCostCentre.Id AS distributorId, tblCostCentre_1.Id AS salesmanId, dbo.tblCostCentre.Name AS distributor, 
                      tblCostCentre_1.Name AS salesman, dbo.tblCostCentre.CostCentreType AS ccdistributor, tblCostCentre_1.CostCentreType AS ccSaleman, 
                      dbo.tblProductBrand.name AS Brand, dbo.tblProductBrand.id AS BrandId, dbo.tblProductFlavour.name AS SubBrand, dbo.tblProductFlavour.id AS SubBrandId, 
                      dbo.tblProduct.Description AS Product, dbo.tblProduct.id AS ProductId
                      --,@startDate as startDate, @endDate as endDate

FROM         dbo.tblProductFlavour INNER JOIN
                      dbo.tblLineItems INNER JOIN
                      dbo.tblDocument ON dbo.tblLineItems.DocumentID = dbo.tblDocument.Id INNER JOIN
                      dbo.tblCostCentre ON dbo.tblDocument.DocumentRecipientCostCentre = dbo.tblCostCentre.Id INNER JOIN
                      dbo.tblProduct INNER JOIN
                      dbo.tblProductBrand ON dbo.tblProduct.BrandId = dbo.tblProductBrand.id ON dbo.tblLineItems.ProductID = dbo.tblProduct.id ON 
                      dbo.tblProductFlavour.id = dbo.tblProduct.FlavourId INNER JOIN
                      dbo.tblCostCentre AS tblCostCentre_1 ON dbo.tblDocument.DocumentIssuerCostCentreId = tblCostCentre_1.Id

WHERE     (dbo.tblDocument.DocumentTypeId = 1) AND (dbo.tblDocument.OrderOrderTypeId = 3) AND (dbo.tblCostCentre.CostCentreType = 2) AND 
                      (tblCostCentre_1.CostCentreType = 4) 
                         AND (dbo.tblDocument.SendDateTime BETWEEN @startDate AND @endDate) 
                         AND(CONVERT(NVARCHAR(50),dbo.tblCostCentre.Id)LIKE ISNULL(@distributorId, N'%'))
                         AND(CONVERT(NVARCHAR(50),tblCostCentre_1.Id)LIKE ISNULL(@salesmanId, N'%'))
                         AND(CONVERT(NVARCHAR(50),dbo.tblProductBrand.id)LIKE ISNULL(@brandId, N'%'))
                         AND(CONVERT(NVARCHAR(50),dbo.tblProductFlavour.id)LIKE ISNULL(@subBrandId, N'%'))
                         AND(CONVERT(NVARCHAR(50), dbo.tblDocument.DocumentReference)LIKE ISNULL(@ordersRef, N'%'))
GO
