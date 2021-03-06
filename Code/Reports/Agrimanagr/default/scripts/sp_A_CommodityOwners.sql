IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_A_CommodityOwners')
   exec('CREATE PROCEDURE [sp_A_CommodityOwners] AS BEGIN SET NOCOUNT ON; END')
GO
Alter PROCEDURE sp_A_CommodityOwners	 
	 @hubId varchar(50)=NULL ,
	 @routeId varchar(50)=NULL ,
	 @centreId varchar(50)=NULL   
AS
BEGIN
	declare @costcentreid table(ids varchar(50));
	PRINT 'HubId = '+isnull(@hubId,'NULL');
	PRINT 'RouteId = '+isnull(@routeId,'NULL');
	PRINT 'CentreId = '+isnull(@centreId,'NULL');
    if(@routeId='' or @routeId='ALL') set @routeId=null;
    if(@hubId='' or @hubId='ALL') set @hubId=null;
    if(@centreId='' or @centreId='ALL') set @centreId=null;
    
	SELECT  'ALL' AS commodityOwnerId, 'ALL' AS Name,'ALL' AS Code
	UNION
	SELECT DISTINCT LOwer(convert(varchar(50),co.Id)) as id, co.Surname + ' ' + co.FirstName + ' ' + isnull(co.LastName,'') AS Name, co.Code
	FROM dbo.tblCommodityOwner AS co 
	INNER JOIN  dbo.tblCostCentre AS cc ON co.CostCentreId = cc.Id 
	INNER JOIN  dbo.tblCentre AS c ON cc.ParentCostCentreId = c.HubId
	INNER JOIN  dbo.tblRoutes AS r ON c.RouteId = r.RouteID	
	where (1=1)
	and(@routeid is null or r.routeid=@routeId)
	and(@hubId is null or  cc.parentCostCentreId = @hubId)
	and(@centreId is null or  c.id = @centreId)
	order by name
END;

--EXEC sp_A_CommodityOwners @routeid='ALL', @hubId='ALL'
--EXEC sp_A_CommodityOwners @routeid='ALL', @hubId='E6834108-4BA7-4A1A-98CA-9DD4DF8D68E3'
--EXEC sp_A_CommodityOwners @hubId='E6834108-4BA7-4A1A-98CA-9DD4DF8D68E2'
--EXEC sp_A_CommodityOwners @routeid='9b3fe18e-0bba-471c-a4c6-96ea9ebd0277'
--EXEC sp_A_CommodityOwners @centreid='E04AB521-7034-4059-9941-E401B49B7CE4'
