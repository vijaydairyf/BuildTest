/****** Object:  StoredProcedure [dbo].[sp_D_SalesSubReport]    Script Date: 07/24/2013 08:51:32 ******/
DROP PROCEDURE [dbo].[sp_D_SalesSubReport]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
-- =============================================
-- Author:		<Author,,Name>
-- Create date: <Create Date,,>
-- Description:	<Description,,>
-- =============================================
CREATE PROCEDURE [dbo].[sp_D_SalesSubReport] 
(
@docId as nvarchar(50)
)
AS
if  rtrim(ltrim(@docId))='ALL'  begin set @docId='%' end

SELECT     tblLineItems_1.id, 
           tblLineItems_1.ProductID, 
           tblLineItems_1.Description, 
           tblDocument_1.DocumentTypeId, 
           tblLineItems_1.Quantity, 
           tblLineItems_1.Value, 
           tblLineItems_1.Vat, 
           tblDocument_1.DocumentIssuerCostCentreId, 
           tblDocument_1.DocumentIssuerUserId, 
           tblDocument_1.DocumentDateIssued, 
           tblDocument_1.DocumentRecipientCostCentre, 
           tblDocument_1.DocumentIssuerCostCentreApplicationId, 
           tblDocument_1.OrderIssuedOnBehalfOfCC, 
           tblDocument_1.OrderOrderTypeId, 
           tblDocument_1.SendDateTime, 
           tblDocument_1.Note SaleComment, 
           tblCostCentre_3.Name AS Salesman, 
           tblCostCentre_3.CostCentreType AS SalesmanTypeID, 
           tblCostCentre_3.RouteId, 
           tblLineItems_1.DocumentID, 
           CASE WHEN tblDocument_1.DocumentStatusId = 99 THEN 'Closed' END AS DocumentStatusId, 
           tblCostCentre_1.Id AS DistributorID, 
           tblCostCentre_1.Name AS Distributor, 
           tblCostCentre_3.Id AS SalesManID, 
           tblProduct_1.Description AS Product, 
           tblProduct_1.ProductCode AS ProductCode, 
           tblProductBrand_1.name AS Brand, 
           tblLineItems_1.ProductDiscount, 
           tblDocument_1.DocumentReference, 
           case when  tblProduct_1.ProductTypeId = dbo.tblProductType.id then 'Sale'
                when  dbo.tblProductType.id IS Null then 'Returnable' end ProductType,
           --dbo.tblProductType.name AS ProductType, 
           tblDocument_1.Longitude AS DocumentLongitude, 
           tblDocument_1.Latitude AS DocumentLatitude, 
           tblDocument_1.SaleDiscount, 
           Outlet.Id AS OutletId, 
           Outlet.Name AS OutletName,
           Outlet.StandardWH_Latitude as OutletLatitude,
           Outlet.StandardWH_Longtitude as OutletLongitude
FROM    dbo.tblCostCentre AS tblCostCentre_1 
 JOIN   dbo.tblCostCentre AS Outlet 
 JOIN   dbo.tblProductBrand AS tblProductBrand_1 
 JOIN   dbo.tblProduct AS tblProduct_1 ON tblProductBrand_1.id = tblProduct_1.BrandId 
 JOIN   dbo.tblDocument AS tblDocument_1 
 JOIN   dbo.tblLineItems AS tblLineItems_1 ON tblDocument_1.Id = tblLineItems_1.DocumentID ON tblProduct_1.id = tblLineItems_1.ProductID 
 JOIN   dbo.tblProductType ON( tblProduct_1.ProductTypeId = dbo.tblProductType.id or tblProduct_1.ProductTypeId is null) ON Outlet.Id = tblDocument_1.OrderIssuedOnBehalfOfCC 
 JOIN   dbo.tblCostCentre AS tblCostCentre_3 ON tblDocument_1.DocumentRecipientCostCentre = tblCostCentre_3.Id ON tblCostCentre_1.Id = tblDocument_1.DocumentIssuerCostCentreId
WHERE     (tblDocument_1.DocumentTypeId = 1)    
        AND tblLineItems_1.DocumentID like isnull(@docId,'%')
       -- and tblDocument_1.DocumentReference like 'S_kamba_CKO4932_20141009_115926_00046'
 --   exec [dbo].[sp_D_SalesSubReport]  @docId='764efcc2-255e-48df-bb15-370f5373f31f'

 --   exec [dbo].[sp_D_SalesSubReport]  @docId='ALL'

  --   exec [dbo].[sp_D_SalesSubReport]  @docId='8e4b3494-4509-4d72-898f-63e1342260ff'

GO
