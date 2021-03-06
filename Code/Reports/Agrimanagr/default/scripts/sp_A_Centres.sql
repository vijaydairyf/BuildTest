IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_A_Centres')
   exec('CREATE PROCEDURE [sp_A_Centres] AS BEGIN SET NOCOUNT ON; END')
GO
Alter PROCEDURE sp_A_Centres
	 @routeId varchar(50)=NULL ,
	 @hubId varchar(50)=NULL    
AS
BEGIN
	PRINT 'HubId = '+isnull(@hubId,'NULL');
	PRINT 'RouteId = '+isnull(@routeId,'NULL');
    if(@routeId='' or @routeId='ALL') set @routeId=null;
    if(@hubId='' or @hubId='ALL') set @hubId=null;
	
	SELECT  'ALL' AS centreId, 'ALL' AS Name
	UNION
	select LOWER(convert(varchar(50),id)) as centreId, Name from tblcentre 
	where (1=1)
	and(@routeid is null or routeid=@routeId)
	and(@hubId is null or hubId=@hubId)
	order by name
END;

--EXEC sp_A_Centres @routeid='ALL', @hubId='ALL'
--EXEC sp_A_Centres @routeid='ALL', @hubId='E6834108-4BA7-4A1A-98CA-9DD4DF8D68E3'

