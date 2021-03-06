--USE [ag3]
--GO
/****** Object:  StoredProcedure [dbo].[SP_A_CommodityDeliveryByTransactionDetails_R]    Script Date: 11/14/2013 12:25:40 ******/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
--ALTER procedure [dbo].[SP_A_CommodityDeliveryByTransactionDetails_R]
DROP PROCEDURE [dbo].[SP_A_CommodityDeliveryByTransactionDetails_R]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_A_CommodityDeliveryByTransactionDetails_R]
(
--@startDate AS DATE,
--@endDate AS DATE,
--@hubId AS NVARCHAR(50),
--@routeId AS NVARCHAR(50),
--@centreId AS NVARCHAR(50),
--@driverId AS NVARCHAR(50),
@documentId AS NVARCHAR(50)

)

AS

--if  @hubId='ALL'  begin set @hubId='%' end
--if  @routeId='ALL' begin set @routeId='%' end
--if  @centreId='ALL' begin set @centreId='%' end 
--if  @driverId='ALL' begin set @driverId='%' end
IF  @documentId='ALL' begin set @documentId='%' end



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
                      dbo.tblCommodityGrade.Id AS GradeId, 
                      dbo.tblCommodityGrade.Name AS Grade,
                       dbo.tblSourcingDocument.Id AS DocumentId,
					   dbo.tblSourcingDocument.Latitude,
					  dbo.tblSourcingDocument.Longitude
                      
FROM         dbo.tblSourcingDocument INNER JOIN
                      dbo.tblCostCentre ON dbo.tblSourcingDocument.DocumentRecipientCostCentreId = dbo.tblCostCentre.Id INNER JOIN
                      dbo.tblRoutes ON dbo.tblSourcingDocument.RouteId = dbo.tblRoutes.RouteID INNER JOIN
                      dbo.tblCentre ON dbo.tblSourcingDocument.CentreId = dbo.tblCentre.Id INNER JOIN
                      dbo.tblUsers ON dbo.tblSourcingDocument.DriverName = dbo.tblUsers.UserName INNER JOIN
                      dbo.tblSourcingLineItem ON dbo.tblSourcingDocument.Id = dbo.tblSourcingLineItem.DocumentId INNER JOIN
                      dbo.tblCommodity ON dbo.tblSourcingLineItem.CommodityId = dbo.tblCommodity.Id INNER JOIN
                      dbo.tblCommodityGrade ON dbo.tblSourcingLineItem.GradeId = dbo.tblCommodityGrade.Id
                      
WHERE     (dbo.tblSourcingDocument.DocumentTypeId = 16) AND (dbo.tblCostCentre.CostCentreType = 8)

           --AND(CONVERT(VARCHAR(26), dbo.tblSourcingDocument.DateSent,23)  BETWEEN @startDate AND @endDate)           
           AND(CONVERT(NVARCHAR(50), dbo.tblSourcingDocument.Id ) LIKE ISNULL (@documentId,N'%'))
           
           
 -- EXEC  [dbo].[SP_A_CommodityDeliveryByTransactionDetails_R]  @documentId='2383FE55-2B2F-4E6A-B88A-BF06BDAEE623' ,@startDate='2013-11-01',@endDate='2013-11-20'
 