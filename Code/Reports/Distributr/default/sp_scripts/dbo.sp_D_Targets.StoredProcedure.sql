/****** Object:  StoredProcedure [dbo].[sp_D_Targets]    Script Date: 07/24/2013 08:51:32 ******/
DROP PROCEDURE [dbo].[sp_D_Targets]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_D_Targets]
(
@targetId AS NVARCHAR(50),
@countryId AS NVARCHAR(50),
@regionId AS NVARCHAR(50),
@distributorId AS NVARCHAR(50),
@routeId AS NVARCHAR(50)
)

AS
if ltrim(rtrim(@targetId))='ALL'  begin set @targetId='%' end
if ltrim(rtrim(@countryId))='ALL'  begin set @countryId='%' end
if ltrim(rtrim(@regionId))='ALL'  begin set @regionId='%' end
if ltrim(rtrim(@distributorId))='ALL'  begin set @distributorId='%' end
if ltrim(rtrim(@routeId))='ALL'  begin set @routeId='%' end

SELECT     dbo.tblCostCentre.Id AS DistributorId, dbo.tblCostCentre.Name AS DistributorName, dbo.tblCostCentre.CostCentreType AS DCCtype, tblCostCentre_1.Id AS OutletId, 
                      tblCostCentre_1.Name AS OutletName, tblCostCentre_1.CostCentreType AS OutCCtype, dbo.tblRoutes.RouteID AS RouteId, dbo.tblRoutes.Name AS RouteName, 
                      dbo.tblRegion.id AS RegionId, dbo.tblRegion.Name AS RegionName, dbo.tblCountry.id AS CountryId, dbo.tblCountry.Name AS CountryName, 
                      dbo.tblTarget.id AS TargetId, dbo.tblTarget.TargetValue, dbo.tblTargetPeriod.Id AS TargetPeriodId, dbo.tblTargetPeriod.Name AS TargetPeriodName, 
                      dbo.tblTargetPeriod.StartDate, dbo.tblTargetPeriod.EndDate
FROM         dbo.tblTargetPeriod INNER JOIN
                      dbo.tblTarget ON dbo.tblTargetPeriod.Id = dbo.tblTarget.PeriodId INNER JOIN
                      dbo.tblCostCentre INNER JOIN
                      dbo.tblCostCentre AS tblCostCentre_1 ON dbo.tblCostCentre.Id = tblCostCentre_1.ParentCostCentreId INNER JOIN
                      dbo.tblRoutes ON tblCostCentre_1.RouteId = dbo.tblRoutes.RouteID INNER JOIN
                      dbo.tblRegion ON dbo.tblRoutes.RegionId = dbo.tblRegion.id INNER JOIN
                      dbo.tblCountry ON dbo.tblRegion.Country = dbo.tblCountry.id ON dbo.tblTarget.CostCentreId = dbo.tblCostCentre.Id
WHERE     (dbo.tblCostCentre.CostCentreType = 2) 
           AND (tblCostCentre_1.CostCentreType = 5)
           AND(CONVERT(NVARCHAR(50), dbo.tblCostCentre.Id)LIKE ISNULL(@distributorId, N'%'))
           AND(CONVERT(NVARCHAR(50), dbo.tblTargetPeriod.Id)LIKE ISNULL(@targetId, N'%'))
           AND(CONVERT(NVARCHAR(50), dbo.tblTargetPeriod.Id)LIKE ISNULL(@countryId, N'%'))
           AND(CONVERT(NVARCHAR(50), dbo.tblRegion.id)LIKE ISNULL(@regionId, N'%'))
           
--  exec   [dbo].[sp_D_Targets]    @targetId='ALL', @countryId='ALL',@regionId='ALL',@distributorId='ALL',@routeId='ALL'    
           
GO
