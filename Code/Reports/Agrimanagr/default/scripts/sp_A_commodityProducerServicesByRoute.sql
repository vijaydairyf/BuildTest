IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_A_commodityProducerServicesByRoute')
   exec('CREATE PROCEDURE [sp_A_commodityProducerServicesByRoute] AS BEGIN SET NOCOUNT ON; END')
GO
Alter PROCEDURE sp_A_commodityProducerServicesByRoute
(
@StartDate AS DATE,
@EndDate AS DATE,
@HubId AS NVARCHAR(50),
@RouteId AS NVARCHAR(50),
@CentreId AS NVARCHAR(50),
@FarmerId AS NVARCHAR(50),
@FarmId AS NVARCHAR(50),
@ActivityId AS NVARCHAR(50),
@ClerkId AS NVARCHAR(50)
)

AS

if  @HubId='ALL'  begin set @HubId='%' end
if  @RouteId='ALL'  begin set @RouteId='%' end
if  @CentreId='ALL'  begin set @CentreId='%' end
if  @FarmerId='ALL'  begin set @FarmerId='%' end
if  @FarmId='ALL'  begin set @FarmId='%' end
if  @ActivityId='ALL'  begin set @ActivityId='%' end
if  @ClerkId='ALL'  begin set @ClerkId='%' end

;WITH Producer_CTE AS(
SELECT	DISTINCT dbo.tblActivityDocument.Id AS ActivityId,
		dbo.tblActivityDocument.ActivityReference,
		dbo.tblActivityType.Name AS ActivityName,
		dbo.tblService.Name AS Service,
		dbo.tblService.Cost,
		hub.Name as Factory,
		dbo.tblActivityDocument.ActivityDate AS TimeStamp,
		1 AS NoOfActivities,
		tblRoutes.Name AS RouteName

FROM	dbo.tblActivityDocument
		INNER JOIN dbo.tblActivityType ON dbo.tblActivityDocument.ActivityTypeId = dbo.tblActivityType.Id
		INNER JOIN dbo.tblActivityServiceLineItem ON dbo.tblActivityDocument.Id = dbo.tblActivityServiceLineItem.ActivityId
		INNER JOIN dbo.tblServiceProvider ON dbo.tblActivityServiceLineItem.ServiceProviderId = dbo.tblServiceProvider.id
		INNER JOIN dbo.tblService ON dbo.tblActivityServiceLineItem.ServiceId = dbo.tblService.id
		INNER JOIN dbo.tblCostCentre ON dbo.tblCostCentre.Id = dbo.tblActivityDocument.CommoditySupplierId
		INNER JOIN dbo.tblCostCentre AS hub ON dbo.tblCostCentre.ParentCostCentreId = hub.Id
		INNER JOIN dbo.tblCommodityOwner ON dbo.tblCostCentre.Id = dbo.tblCommodityOwner.CostCentreId
		INNER JOIN dbo.tblCommodityProducer ON dbo.tblActivityDocument.CommodityProducerId = dbo.tblCommodityProducer.Id
		INNER JOIN dbo.tblUsers ON dbo.tblActivityDocument.ClerkId = dbo.tblUsers.CostCenterId
		INNER JOIN dbo.tblRoutes ON dbo.tblActivityDocument.RouteId = dbo.tblRoutes.RouteID

WHERE	--tblCostCentre.CostCentreType2 =1
		(CONVERT(VARCHAR(26),tblActivityDocument.ActivityDate,23)  BETWEEN @startDate AND @endDate)   
        AND(CONVERT(NVARCHAR(50),hub.Id) LIKE ISNULL(@hubId, N'%'))             
        AND(CONVERT(NVARCHAR(50),dbo.tblActivityDocument.RouteID) LIKE ISNULL(@routeId, N'%'))  
        AND(CONVERT(NVARCHAR(50),dbo.tblActivityDocument.CentreId) LIKE ISNULL(@centreId, N'%'))
        AND(CONVERT(NVARCHAR(50),dbo.tblCommodityOwner.Id) LIKE ISNULL(@farmerId, N'%'))
		AND(CONVERT(NVARCHAR(50),dbo.tblCommodityProducer.Id) LIKE ISNULL(@farmId, N'%'))
		AND(CONVERT(NVARCHAR(50),dbo.tblActivityType.Id) LIKE ISNULL(@ActivityId, N'%'))
		AND(CONVERT(NVARCHAR(50),dbo.tblUsers.Id) LIKE ISNULL(@ClerkId, N'%'))

)

SELECT RouteName,ActivityName,Service,SUM(Cost) AS Cost,SUM(NoOfActivities) AS NoOfActivities
FROM Producer_CTE

GROUP BY RouteName,ActivityName,Service

-- EXEC sp_A_commodityProducerServicesByRoute @StartDate='2015-06-01',@EndDate='2015-07-15',@HubId='ALL',@RouteId='ALL',@CentreId='ALL',@FarmerId='ALL',@FarmId='ALL',@ActivityId='ALL',@ClerkId='ALL'

