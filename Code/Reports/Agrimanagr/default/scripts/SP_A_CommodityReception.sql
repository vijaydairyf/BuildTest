--USE [AgrimanagerHq]
--GO
/****** Object:  StoredProcedure [dbo].[SP_A_CommodityReception]    Script Date: 11/05/2013 09:47:32 ******/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
--ALTER procedure [dbo].[SP_A_CommodityReception]

DROP PROCEDURE [dbo].[SP_A_CommodityReception]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_A_CommodityReception]

(
@startDate AS DATE,
@endDate AS DATE,
@hubId AS NVARCHAR(50),
@routeId AS NVARCHAR(50),
@centreId AS NVARCHAR(50),
@documentId AS NVARCHAR(50)
)
 
 AS
 
if  @hubId='ALL'  begin set @hubId='%' end
if  @routeId='ALL' begin set @routeId='%' end
if  @centreId='ALL' begin set @centreId='%' end 
 
SELECT 
                      dbo.tblSourcingDocument.DocumentTypeId,
                      dbo.tblSourcingDocument.DocumentReference,
                      dbo.tblCostCentre.Id AS HubId, 
                      dbo.tblCostCentre.Name AS Hub, 
                      dbo.tblCostCentre.CostCentreType AS ccHub, 
                      dbo.tblRoutes.RouteID AS RouteId, 
                      dbo.tblRoutes.Name AS Route, 
                      dbo.tblCentre.Id AS CentreId, 
                      dbo.tblCentre.Name AS Centre, 
                      dbo.tblSourcingLineItem.Weight, 
                      dbo.tblSourcingLineItem.TareWeight, 
                      dbo.tblCommodity.Id AS CommodityId, 
                      dbo.tblCommodity.Name AS Commodity, 
                      dbo.tblSourcingDocument.DateSent
                      
FROM         dbo.tblSourcingDocument INNER JOIN
                      dbo.tblCostCentre ON dbo.tblSourcingDocument.DocumentIssuerCostCentreId = dbo.tblCostCentre.Id INNER JOIN
                      dbo.tblRoutes ON dbo.tblSourcingDocument.RouteId = dbo.tblRoutes.RouteID INNER JOIN
                      dbo.tblCentre ON dbo.tblSourcingDocument.CentreId = dbo.tblCentre.Id INNER JOIN
                      dbo.tblSourcingLineItem ON dbo.tblSourcingDocument.Id = dbo.tblSourcingLineItem.DocumentId INNER JOIN
                      dbo.tblCommodity ON dbo.tblSourcingLineItem.CommodityId = dbo.tblCommodity.Id
                      
WHERE     (dbo.tblSourcingDocument.DocumentTypeId = 17) AND (dbo.tblCostCentre.CostCentreType = 8) 
           AND(CONVERT(VARCHAR(26), dbo.tblSourcingDocument.DateSent,23)  BETWEEN @startDate AND @endDate)
           AND(CONVERT(NVARCHAR(50), dbo.tblCostCentre.Id) LIKE ISNULL(@hubId, N'%')) 
           AND(CONVERT(NVARCHAR(50),dbo.tblRoutes.RouteID) LIKE ISNULL(@routeId, N'%'))  
           AND(CONVERT(NVARCHAR(50),dbo.tblCentre.Id) LIKE ISNULL(@centreId, N'%'))
