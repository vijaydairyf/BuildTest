--USE [ag3]
--GO
/****** Object:  StoredProcedure [dbo].[SP_A_CloseOfDay_R]    Script Date: 11/15/2013 09:13:48 ******/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
--ALTER procedure [dbo].[SP_A_CloseOfDay_R]

DROP PROCEDURE [dbo].[SP_A_CloseOfDay_R]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_A_CloseOfDay_R]

(
@startDate AS DATE,
@endDate AS DATE,
@hubId AS NVARCHAR(50),
@routeId AS NVARCHAR(50),
@centreId AS NVARCHAR(50),
@farmerId AS NVARCHAR(50),
@documentId AS NVARCHAR(50)

)

AS

if  @hubId='ALL'  begin set @hubId='%' end
if  @routeId='ALL'  begin set @routeId='%' end
if  @centreId='ALL'  begin set @centreId='%' end
if  @farmerId='ALL'  begin set @farmerId='%' end



SELECT 
                      dbo.tblCostCentre.Id AS HubId,
                      dbo.tblCostCentre.Name AS Hub, 
                      dbo.tblSourcingDocument.DocumentTypeId, 
                      dbo.tblSourcingDocument.DateSent, 
                      dbo.tblRoutes.RouteID AS RouteId, 
                      dbo.tblRoutes.Name AS Route, 
                      dbo.tblCentre.Id AS CentreId, 
                      dbo.tblCentre.Name AS Centre, 
                      dbo.tblCostCentre.CostCentreType, 
                      dbo.tblCostCentre.ParentCostCentreId, 
                      dbo.tblCommodityOwner.Id AS FarmerId, 
                      dbo.tblCommodityOwner.Surname, 
                      dbo.tblCommodityOwner.FirstName, 
                      dbo.tblCommodityOwner.Code, 
                      dbo.tblSourcingLineItem.Weight, 
                      dbo.tblSourcingLineItem.TareWeight, 
                      dbo.tblSourcingDocument.DocumentReference, 
                      dbo.tblCommodity.Id AS CommodityId, 
                      dbo.tblCommodity.Name AS Commodity, 
                      dbo.tblCommodity.Code AS CommodityCode, 
                      dbo.tblCommodityGrade.Id AS CommodityGradeId, 
                      dbo.tblCommodityGrade.Name AS CommodityGrade
                      
FROM         dbo.tblSourcingLineItem INNER JOIN
                      dbo.tblSourcingDocument ON dbo.tblSourcingLineItem.DocumentId = dbo.tblSourcingDocument.Id INNER JOIN
                      dbo.tblRoutes ON dbo.tblSourcingDocument.RouteId = dbo.tblRoutes.RouteID INNER JOIN
                      dbo.tblCentre ON dbo.tblSourcingDocument.CentreId = dbo.tblCentre.Id INNER JOIN
                      dbo.tblCommodityOwner ON dbo.tblSourcingDocument.CommodityOwnerId = dbo.tblCommodityOwner.Id INNER JOIN
                      dbo.tblCostCentre ON dbo.tblSourcingDocument.DocumentRecipientCostCentreId = dbo.tblCostCentre.Id or  dbo.tblSourcingDocument.DocumentIssuerCostCentreId = dbo.tblCostCentre.Id INNER JOIN
                      dbo.tblCommodity ON dbo.tblSourcingLineItem.CommodityId = dbo.tblCommodity.Id INNER JOIN
                      dbo.tblCommodityGrade ON dbo.tblSourcingLineItem.GradeId = dbo.tblCommodityGrade.Id
WHERE     (dbo.tblSourcingDocument.DocumentTypeId = 13) AND (dbo.tblCostCentre.CostCentreType = 8)
           AND(CONVERT(VARCHAR(26), dbo.tblSourcingDocument.DateSent,23)  BETWEEN @startDate AND @endDate)   
           AND(CONVERT(NVARCHAR(50),dbo.tblCostCentre.Id) LIKE ISNULL(@hubId, N'%'))             
           AND(CONVERT(NVARCHAR(50),dbo.tblRoutes.RouteID) LIKE ISNULL(@routeId, N'%'))  
           AND(CONVERT(NVARCHAR(50),dbo.tblCentre.Id) LIKE ISNULL(@centreId, N'%'))
           AND(CONVERT(NVARCHAR(50), dbo.tblCommodityOwner.Id) LIKE ISNULL(@farmerId, N'%'))
                      


--UNION ALL

--SELECT DISTINCT 
--                      dbo.tblCostCentre.Id AS HubId, 
--                      dbo.tblCostCentre.Name AS Hub, 
--                      dbo.tblSourcingDocument.DocumentTypeId, 
--                      dbo.tblSourcingDocument.DateSent, 
--                      dbo.tblRoutes.RouteID AS RouteId,
--                      dbo.tblRoutes.Name AS Route, 
--                      dbo.tblCentre.Id AS CentreId, 
--                      dbo.tblCentre.Name AS Centre, 
--                      dbo.tblCostCentre.CostCentreType, 
--                      dbo.tblCostCentre.ParentCostCentreId, 
--                      dbo.tblCommodityOwner.Id AS FarmerId, 
--                      dbo.tblCommodityOwner.Surname, 
--                      dbo.tblCommodityOwner.FirstName, 
--                      dbo.tblCommodityOwner.Code, 
--                      dbo.tblSourcingLineItem.Weight, 
--                      dbo.tblSourcingLineItem.TareWeight, 
--                      dbo.tblSourcingDocument.DocumentReference, 
--                      dbo.tblCommodity.Id AS CommodityId, 
--                      dbo.tblCommodity.Name AS Commodity, 
--                      dbo.tblCommodity.Code AS CommodityCode, 
--                      dbo.tblCommodityGrade.Id AS CommodityGradeId, 
--                      dbo.tblCommodityGrade.Name AS CommodityGrade
                      
--FROM         dbo.tblSourcingLineItem INNER JOIN
--                      dbo.tblSourcingDocument ON dbo.tblSourcingLineItem.DocumentId = dbo.tblSourcingDocument.Id INNER JOIN
--                      dbo.tblRoutes ON dbo.tblSourcingDocument.RouteId = dbo.tblRoutes.RouteID INNER JOIN
--                      dbo.tblCentre ON dbo.tblSourcingDocument.CentreId = dbo.tblCentre.Id INNER JOIN
--                      dbo.tblCommodityOwner ON dbo.tblSourcingDocument.CommodityOwnerId = dbo.tblCommodityOwner.Id INNER JOIN
--                      dbo.tblCostCentre ON dbo.tblSourcingDocument.DocumentIssuerCostCentreId = dbo.tblCostCentre.Id INNER JOIN
--                      dbo.tblCommodity ON dbo.tblSourcingLineItem.CommodityId = dbo.tblCommodity.Id INNER JOIN
--                      dbo.tblCommodityGrade ON dbo.tblSourcingLineItem.GradeId = dbo.tblCommodityGrade.Id
                      
--WHERE     (dbo.tblSourcingDocument.DocumentTypeId = 13) AND (dbo.tblCostCentre.CostCentreType = 8)
--           AND(CONVERT(VARCHAR(26), dbo.tblSourcingDocument.DateSent,23)  BETWEEN @startDate AND @endDate)             
--           AND(CONVERT(NVARCHAR(50),dbo.tblCostCentre.Id) LIKE ISNULL(@hubId, N'%'))             
--           AND(CONVERT(NVARCHAR(50),dbo.tblRoutes.RouteID) LIKE ISNULL(@routeId, N'%'))  
--           AND(CONVERT(NVARCHAR(50),dbo.tblCentre.Id) LIKE ISNULL(@centreId, N'%'))
--           AND(CONVERT(NVARCHAR(50), dbo.tblCommodityOwner.Id) LIKE ISNULL(@farmerId, N'%'))