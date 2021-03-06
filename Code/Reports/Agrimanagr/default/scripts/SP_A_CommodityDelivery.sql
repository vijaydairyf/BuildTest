--USE [AgrimanagerHq]
--GO
/****** Object:  StoredProcedure [dbo].[SP_A_CommodityDelivery]    Script Date: 11/05/2013 15:30:33 ******/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
--ALTER procedure [dbo].[SP_A_CommodityDelivery]

DROP PROCEDURE [dbo].[SP_A_CommodityDelivery]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_A_CommodityDelivery]
(
@startDate AS DATE,
@endDate AS DATE,
@hubId AS NVARCHAR(50),
@routeId AS NVARCHAR(50),
@centreId AS NVARCHAR(50),
@driverId AS NVARCHAR(50),
@documentId AS NVARCHAR(50)

)

as

if  @hubId='ALL'  begin set @hubId='%' end
if  @routeId='ALL' begin set @routeId='%' end
if  @centreId='ALL' begin set @centreId='%' end 
if  @driverId='ALL' begin set @driverId='%' end



SELECT 
                      dbo.tblSourcingDocument.DocumentTypeId,
                      dbo.tblSourcingDocument.DocumentReference, 
                      dbo.tblSourcingDocument.DateSent, 
                      dbo.tblCostCentre.Id AS HubId, 
                      dbo.tblCostCentre.Name AS Hub, 
                      dbo.tblCostCentre.CostCentreType AS ccHub, 
                      dbo.tblRoutes.RouteID, 
                      dbo.tblRoutes.Name AS Route, 
                      dbo.tblSourcingDocument.CentreId, 
                      dbo.tblCentre.Name AS Centre, 
                      dbo.tblSourcingDocument.DriverName, 
                      dbo.tblUsers.Id AS DriverId, 
                      dbo.tblUsers.UserType AS ccDriver, 
                      dbo.tblSourcingLineItem.Weight, 
                      dbo.tblCommodity.Id AS CommodityId, 
                      dbo.tblCommodity.Name AS Commodity,
                       dbo.tblSourcingDocument.Id AS DocumentId
                      
FROM         dbo.tblSourcingDocument INNER JOIN
                      dbo.tblCostCentre ON dbo.tblSourcingDocument.DocumentRecipientCostCentreId = dbo.tblCostCentre.Id INNER JOIN
                      dbo.tblRoutes ON dbo.tblSourcingDocument.RouteId = dbo.tblRoutes.RouteID INNER JOIN
                      dbo.tblCentre ON dbo.tblSourcingDocument.CentreId = dbo.tblCentre.Id INNER JOIN
                      dbo.tblUsers ON dbo.tblSourcingDocument.DriverName = dbo.tblUsers.UserName INNER JOIN
                      dbo.tblSourcingLineItem ON dbo.tblSourcingDocument.Id = dbo.tblSourcingLineItem.DocumentId INNER JOIN
                      dbo.tblCommodity ON dbo.tblSourcingLineItem.CommodityId = dbo.tblCommodity.Id
                      
WHERE     (dbo.tblSourcingDocument.DocumentTypeId = 16) AND (dbo.tblCostCentre.CostCentreType = 8)
           AND(CONVERT(VARCHAR(26), dbo.tblSourcingDocument.DateSent,23)  BETWEEN @startDate AND @endDate) 
           AND(CONVERT(NVARCHAR(50), dbo.tblCostCentre.Id) LIKE ISNULL(@hubId, N'%')) 
           AND(CONVERT(NVARCHAR(50),dbo.tblRoutes.RouteID) LIKE ISNULL(@routeId, N'%'))  
           AND(CONVERT(NVARCHAR(50),dbo.tblCentre.Id) LIKE ISNULL(@centreId, N'%'))
           AND(CONVERT(NVARCHAR(50), dbo.tblUsers.Id) LIKE ISNULL(@driverId, N'%'))
