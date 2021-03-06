/****** Object:  StoredProcedure [dbo].[sp_D_DeactivatedOutlets]    Script Date: 07/24/2013 08:51:32 ******/
DROP PROCEDURE [dbo].[sp_D_DeactivatedOutlets]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_D_DeactivatedOutlets]

(
@startDate as date,
@endDate as date,
@distributorId AS NVARCHAR(50),
@outletId AS NVARCHAR (50),
@routeId AS NVARCHAR(50),
@tierId AS NVARCHAR(50),
@categoryId AS NVARCHAR(50),
@outletTypeId AS NVARCHAR(50)

)

AS

if  LTRIM(RTRIM(@distributorId))='ALL'  begin set @distributorId='%' end
if  LTRIM(RTRIM(@outletId))='ALL' begin set @outletId='%' end
if  LTRIM(RTRIM(@routeId))='ALL' begin set @routeId='%' end
if  LTRIM(RTRIM(@tierId))='ALL'  begin set @tierId='%' end
if  LTRIM(RTRIM(@categoryId))='ALL'  begin set @categoryId='%' end
if  LTRIM(RTRIM(@outletTypeId))='ALL'  begin set @outletTypeId='%' end


SELECT     dbo.tblCostCentre.Id AS DistributorId,
           dbo.tblCostCentre.Name AS Distributor,
           dbo.tblCostCentre.CostCentreType AS ccDistributor,
           tblCostCentre_1.Id AS OutletId, 
           tblCostCentre_1.Name AS Outlet,
           tblCostCentre_1.CostCentreType AS ccOutlet,
           tblCostCentre_1.IM_DateCreated AS CreationDate, 
           tblCostCentre_1.IM_DateLastUpdated AS DeactivationDate,
           tblCostCentre_1.IM_Status AS IsActive,
           dbo.tblOutletCategory.id AS OutletCategoryId, 
           dbo.tblOutletCategory.Name AS OutletCategory,
           dbo.tblOutletType.id AS OutletTypeId,
           dbo.tblOutletType.Name AS OutletType,
           dbo.tblPricingTier.id AS TierId, 
           dbo.tblPricingTier.Name AS Tier,
           dbo.tblRoutes.RouteID AS RouteId,
           dbo.tblRoutes.Name AS Route,
           @startDate as startDate, @endDate as endDate
           
FROM         dbo.tblCostCentre INNER JOIN
                      dbo.tblCostCentre AS tblCostCentre_1 ON dbo.tblCostCentre.Id = tblCostCentre_1.ParentCostCentreId INNER JOIN
                      dbo.tblOutletCategory ON tblCostCentre_1.Outlet_Category_Id = dbo.tblOutletCategory.id INNER JOIN
                      dbo.tblOutletType ON tblCostCentre_1.Outlet_Type_Id = dbo.tblOutletType.id INNER JOIN
                      dbo.tblPricingTier ON tblCostCentre_1.Tier_Id = dbo.tblPricingTier.id OR tblCostCentre_1.Tier_Id is NULL  INNER JOIN
                      dbo.tblRoutes ON tblCostCentre_1.RouteId = dbo.tblRoutes.RouteID

                      
WHERE     (dbo.tblCostCentre.CostCentreType = 2) AND (tblCostCentre_1.CostCentreType = 5)
            AND (tblCostCentre_1.IM_Status = 2)
            AND (CONVERT(NVARCHAR(26),tblCostCentre_1.IM_DateLastUpdated ,23)) between @startDate and @endDate
            AND(CONVERT(NVARCHAR(50), dbo.tblCostCentre.Id)LIKE ISNULL(@distributorId, N'%'))
            AND(CONVERT(NVARCHAR(50), tblCostCentre_1.Id ) LIKE ISNULL (@outletId, N'%'))
            AND(CONVERT(NVARCHAR(50), dbo.tblRoutes.RouteID)LIKE ISNULL (@routeId, N'%'))
            AND(CONVERT(NVARCHAR(50),dbo.tblPricingTier.id)LIKE ISNULL(@tierId, N'%'))
            AND(CONVERT(NVARCHAR(50),dbo.tblOutletCategory.id)LIKE ISNULL(@categoryId, N'%'))
            AND(CONVERT(NVARCHAR(50),dbo.tblOutletType.id)LIKE ISNULL(@outletTypeId, N'%'))
            
--  Exec   [dbo].[sp_D_DeactivatedOutlets]   @startDate ='2014-01-01',@endDate ='2014-08-08',@distributorId='ALL',@outletId='ALL',@routeId='ALL',@tierId='ALL',@categoryId='ALL',@outletTypeId='ALL'
            
GO
