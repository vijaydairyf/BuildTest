--USE [ag3]
--GO
/****** Object:  StoredProcedure [dbo].[SP_A_CommodityReceptionByTransactionDetails]    Script Date: 11/25/2013 10:49:08 ******/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
--ALTER PROCEDURE [dbo].[SP_A_CommodityReceptionByTransactionDetails]

DROP PROCEDURE [dbo].[SP_A_CommodityReceptionByTransactionDetails]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_A_CommodityReceptionByTransactionDetails]


(
--@startDate AS DATE,
--@endDate AS DATE,
--@hubId AS NVARCHAR(50),
--@routeId AS NVARCHAR(50),
--@centreId AS NVARCHAR(50),
@documentId AS NVARCHAR(50)
)

AS

--if  @hubId='ALL'  begin set @hubId='%' end
--if  @routeId='ALL' begin set @routeId='%' end
--if  @centreId='ALL' begin set @centreId='%' end 
if @documentId='ALL' begin set @documentId='%' end
SELECT 
                      dbo.tblSourcingDocument.DocumentTypeId, 
                      dbo.tblSourcingDocument.Id AS DocumentId,
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
                      dbo.tblSourcingDocument.DateSent, 
                      dbo.tblCommodityGrade.Id AS GradeId, 
                      dbo.tblCommodityGrade.Name AS Grade
                      
FROM         dbo.tblSourcingDocument INNER JOIN
                      dbo.tblCostCentre ON dbo.tblSourcingDocument.DocumentIssuerCostCentreId = dbo.tblCostCentre.Id INNER JOIN
                      dbo.tblRoutes ON dbo.tblSourcingDocument.RouteId = dbo.tblRoutes.RouteID INNER JOIN
                      dbo.tblCentre ON dbo.tblSourcingDocument.CentreId = dbo.tblCentre.Id INNER JOIN
                      dbo.tblSourcingLineItem ON dbo.tblSourcingDocument.Id = dbo.tblSourcingLineItem.DocumentId INNER JOIN
                      dbo.tblCommodity ON dbo.tblSourcingLineItem.CommodityId = dbo.tblCommodity.Id INNER JOIN
                      dbo.tblCommodityGrade ON dbo.tblSourcingLineItem.GradeId = dbo.tblCommodityGrade.Id
                      
WHERE     (dbo.tblSourcingDocument.DocumentTypeId = 17) AND (dbo.tblCostCentre.CostCentreType = 8)
           --AND(CONVERT(VARCHAR(26), dbo.tblSourcingDocument.DateSent,23)  BETWEEN @startDate AND @endDate)
           --AND(CONVERT(NVARCHAR(50), dbo.tblCostCentre.Id) LIKE ISNULL(@hubId, N'%')) 
           --AND(CONVERT(NVARCHAR(50),dbo.tblRoutes.RouteID) LIKE ISNULL(@routeId, N'%'))  
           --AND(CONVERT(NVARCHAR(50),dbo.tblCentre.Id) LIKE ISNULL(@centreId, N'%'))
           AND(CONVERT(NVARCHAR(50),dbo.tblSourcingDocument.Id) LIKE ISNULL (@documentId, N'%'))