
DROP PROCEDURE [dbo].[sp_D_Reconciliation_BrandSalesReconciliation]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [sp_D_Reconciliation_BrandSalesReconciliation]

(
@startDate as Date,
@endDate as Date,
@countryId as NVARCHAR(50),
@regionId as NVARCHAR(50),
@distributorId AS NVARCHAR(50),
@salesmanId AS NVARCHAR(50),
@routeId AS NVARCHAR(50),
@outletId AS NVARCHAR(50),
@brandId AS NVARCHAR(50),
@targetPeriod AS NVARCHAR(50)

)


AS

if LTRIM(RTRIM(@countryId))='ALL' begin set @countryId='%' end
if LTRIM(RTRIM(@regionId))='ALL' begin set @regionId='%' end
if LTRIM(RTRIM(@distributorId))='ALL' begin set @distributorId='%' end
if LTRIM(RTRIM(@salesmanId))='ALL' begin set @salesmanId='%' end
if LTRIM(RTRIM(@routeId))='ALL' begin set @routeId='%' end
if LTRIM(RTRIM(@outletId))='ALL' begin set @outletId='%' end
if LTRIM(RTRIM(@brandId))='ALL' begin set @brandId='%' end
if LTRIM(RTRIM(@targetPeriod))='ALL' begin set @targetPeriod='%' end

SELECT     dbo.tblLineItems.id, 
           dbo.tblDocument.DocumentParentId, 
           dbo.tblLineItems.ProductID, 
           dbo.tblLineItems.Description, 
               CASE WHEN dbo.tblLineItems.Description = 'Returnable' THEN value else 0 END AS EmptiesSold, 
           dbo.tblDocument.DocumentTypeId, 
           dbo.tblLineItems.Quantity, 
           dbo.tblLineItems.Value, 
           dbo.tblLineItems.Vat, 
           dbo.tblDocument.DocumentReference, 
           dbo.tblDocument.DocumentIssuerUserId, 
           dbo.tblDocument.DocumentDateIssued, 
           dbo.tblDocument.OrderDateRequired, 
           dbo.tblDocument.DocumentIssuerCostCentreApplicationId, 
           dbo.tblDocument.OrderIssuedOnBehalfOfCC, 
           dbo.tblDocument.OrderOrderTypeId, 
           dbo.tblDocument.DocumentDateIssued AS SendDateTime, 
           dbo.tblCostCentre.Name AS Outlet, 
           dbo.tblCostCentre.CostCentreType AS OutletTypeID, 
           dbo.tblCostCentre.ParentCostCentreId, 
           dbo.tblCostCentre.RouteId,
           dbo.tblLineItems.DocumentID, 
           tblCostCentre_1.Id AS DistributorID, 
           tblCostCentre_1.Name AS Distributor, 
           dbo.tblRoutes.Name AS Route, 
           dbo.tblDocument.DocumentIssuerCostCentreId, 
           dbo.tblDocument.DocumentRecipientCostCentre, 
           tblCostCentre_3.Name AS Salesman, 
           tblCostCentre_3.Id AS SalesmanId, 
           tblCostCentre_3.CostCentreType AS SalesmanTypeID, 
           dbo.tblRoutes.RouteID AS Expr1, 
           dbo.tblLineItems.ProductDiscount, 
           dbo.tblRegion.Name AS Region, 
           dbo.tblRegion.id AS RegionId, 
           dbo.tblCountry.Name AS Country, 
           dbo.tblCountry.id AS CountryId, 
           dbo.tblProduct.Description AS Product, 
           dbo.tblProductBrand.name AS Brand, 
           dbo.tblProductBrand.id AS BrandId, 
           dbo.tblCostCentre.Id AS OutLetID, 
           dbo.tblDocument.SaleDiscount, 
           dbo.tblTargetPeriod.Id AS TargetPeriodId, 
           dbo.tblTargetPeriod.Name AS TargetPeriod, 
           dbo.tblTargetPeriod.StartDate, 
           dbo.tblTargetPeriod.EndDate, 
           dbo.tblTarget.TargetValue, 
           dbo.tblOutletType.Name AS OutletType
           
FROM         dbo.tblCostCentre AS tblCostCentre_1 INNER JOIN
                      dbo.tblCostCentre ON tblCostCentre_1.Id = dbo.tblCostCentre.ParentCostCentreId INNER JOIN
                      dbo.tblDocument INNER JOIN
                      dbo.tblLineItems ON dbo.tblDocument.Id = dbo.tblLineItems.DocumentID ON dbo.tblCostCentre.Id = dbo.tblDocument.OrderIssuedOnBehalfOfCC INNER JOIN
                      dbo.tblRoutes ON dbo.tblCostCentre.RouteId = dbo.tblRoutes.RouteID INNER JOIN
                      dbo.tblCostCentre AS tblCostCentre_3 ON dbo.tblDocument.DocumentRecipientCostCentre = tblCostCentre_3.Id INNER JOIN
                      dbo.tblRegion ON dbo.tblRoutes.RegionId = dbo.tblRegion.id INNER JOIN
                      dbo.tblCountry ON dbo.tblRegion.Country = dbo.tblCountry.id INNER JOIN
                      dbo.tblProduct ON dbo.tblLineItems.ProductID = dbo.tblProduct.id INNER JOIN
                      dbo.tblProductBrand ON dbo.tblProduct.BrandId = dbo.tblProductBrand.id INNER JOIN
                      dbo.tblTarget ON dbo.tblCostCentre.Id = dbo.tblTarget.CostCentreId INNER JOIN
                      dbo.tblTargetPeriod ON dbo.tblTarget.PeriodId = dbo.tblTargetPeriod.Id INNER JOIN
                      dbo.tblOutletType ON dbo.tblCostCentre.Outlet_Type_Id = dbo.tblOutletType.id
                      
WHERE     (dbo.tblDocument.DocumentTypeId = 1) 
           AND (dbo.tblDocument.OrderOrderTypeId = 1 OR dbo.tblDocument.OrderOrderTypeId = 3)
           AND (dbo.tblCostCentre.CostCentreType = 5) 
           AND (dbo.tblDocument.DocumentStatusId = 99)
           AND (CONVERT(NVARCHAR(26),dbo.tblDocument.DocumentDateIssued,23)BETWEEN @startDate AND @endDate)
           AND (CONVERT(NVARCHAR(50),dbo.tblCountry.id) LIKE ISNULL(@countryId, '%'))
		   AND (CONVERT(NVARCHAR(50),dbo.tblRegion.id) LIKE ISNULL(@regionId, '%'))       
		   AND (CONVERT(NVARCHAR(50),tblCostCentre_1.Id) LIKE ISNULL(@distributorId, '%')) 
		   AND (CONVERT(NVARCHAR(50),tblCostCentre_3.Id) LIKE ISNULL(@salesmanId, '%'))
		   AND (CONVERT(NVARCHAR(50),tblRoutes.RouteID) LIKE ISNULL(@routeId, '%')) 
		   AND (CONVERT(NVARCHAR(50),dbo.tblCostCentre.Id) LIKE ISNULL(@outletId, '%')) 
		   AND (CONVERT(NVARCHAR(50),dbo.tblProductBrand.id) LIKE ISNULL(@brandId, '%'))
		   AND (CONVERT(NVARCHAR(50),dbo.tblTargetPeriod.Id) LIKE ISNULL (@targetPeriod, '%'))
		   