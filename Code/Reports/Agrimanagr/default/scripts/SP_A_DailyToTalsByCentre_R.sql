--USE [ag4]
--GO
/****** Object:  StoredProcedure [dbo].[SP_A_DailyToTalsByCentre_R]    Script Date: 11/27/2013 14:39:53 ******/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
--ALTER procedure  [dbo].[SP_A_DailyToTalsByCentre_R]


DROP PROCEDURE [dbo].[SP_A_DailyToTalsByCentre_R]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_A_DailyToTalsByCentre_R]

(

@startDate as datetime,
@endDate as datetime,
@routeId as nvarchar(50),
@hubId as nvarchar(50),
@clerkId as nvarchar(50),
@centreId as nvarchar(50)
)
as 
if  @routeId='ALL'  begin set @routeId='%' end
if  @hubId='ALL'  begin set @hubId='%' end
if  @clerkId='ALL'  begin set @clerkId='%' end
if  @centreId='ALL' begin set @centreId='%' end


SELECT distinct case when purchase.DocumentTypeId = 13 then sum(purchaseItem.Weight) else 0 end as ReceiptWeight,
                case when purchase.DocumentTypeId = 16 then sum(purchaseItem.Weight) else 0 end as LorryWeight,
                case when purchase.DocumentTypeId = 15 then sum(purchaseItem.Weight) else 0 end as FactoryWeight,                
                case when purchase.RouteId is null OR [route].RouteID is null    then CAST(CAST(0 AS BINARY) AS UNIQUEIDENTIFIER) else [route].RouteID end  as RouteId,
                case when purchase.RouteId is null OR [route].RouteID is null   then 'No route' else [route].name end  as RouteName,
                case when purchase.CentreId is null OR [centre].Id is null    then CAST(CAST(0 AS BINARY) AS UNIQUEIDENTIFIER) else [centre].Id end  as CentreId,
                case when purchase.CentreId is null OR [centre].Id is null   then 'No centre' else [centre].name end  as CentreName,

                             hub.Name,
                             hub.Id, 
                             clerk.UserName as ClerkName, 
                             clerk.Id as ClerkId,
                             hub.Cost_Centre_Code as ClerkCode,
                             convert(nvarchar(26),purchase.DocumentDate,23) as PurchaseDate                     
                   
FROM                     dbo.tblSourcingDocument purchase
              INNER JOIN dbo.tblSourcingLineItem purchaseItem ON purchase.Id = purchaseItem.DocumentId 
              INNER JOIN dbo.tblCostCentre hub ON purchase.DocumentRecipientCostCentreId = hub.Id 
              INNER JOIN dbo.tblUsers clerk ON purchase.DocumentIssuerUserId = clerk.Id
              LEFT OUTER JOIN  dbo.tblRoutes [route] ON purchase.RouteId = [route].RouteID or purchase.RouteId is null
              INNER JOIN dbo.tblCentre [centre] ON purchase.CentreId =  [centre].Id or purchase.CentreId is null

WHERE    
convert(nvarchar(26),purchase.DocumentDate,23) between @startDate and @endDate
and (DocumentTypeId = 13 or DocumentTypeId = 15 or DocumentTypeId = 16)
and convert(nvarchar(50),clerk.Id) like isnull(@clerkId,'%')
AND convert(nvarchar(50),[centre].Id) like isnull (@centreId,'%') 

group by [route].RouteID,[route].name,hub.Name,hub.Id,clerk.UserName , clerk.Id,hub.Cost_Centre_Code,purchase.DocumentDate,purchase.DocumentTypeId,purchase.RouteId, purchase.CentreId, [centre].Id, [centre].name
           
-- EXEC [dbo].[SP_A_DailyToTalsByCentre_R] @startDate = '2013-11-1',@endDate = '2013-11-26', @HubId = 'ALL' , @RouteId = 'ALL' , @CentreId='ALL'