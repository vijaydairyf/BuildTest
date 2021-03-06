--USE [ag3]
--GO
/****** Object:  StoredProcedure [dbo].[SP_A_CommodityReceptionByTransactions]    Script Date: 11/25/2013 10:54:28 ******/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
--ALTER procedure [dbo].[SP_A_CommodityReceptionByTransactions]
DROP PROCEDURE [dbo].[SP_A_CommodityReceptionByTransactions]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_A_CommodityReceptionByTransactions]

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
IF  @documentId='ALL' begin set @documentId='%' end

 
SELECT 
                      dbo.tblSourcingDocument.DocumentTypeId,
                      dbo.tblSourcingDocument.DocumentReference,
                      dbo.tblSourcingDocument.Id AS DocumentId,
                      dbo.tblSourcingDocument.DocumentParentId AS DocumentParentId,
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
           AND(CONVERT(NVARCHAR(50),  dbo.tblSourcingDocument.Id ) LIKE ISNULL (@documentId,N'%'))


-- EXEC [dbo].[SP_A_CommodityReceptionByTransactions] @hubId='ALL' , @routeId='ALL' , @centreId='ALL',@documentId='ALL' ,@startDate='2013-11-01',@endDate='2013-11-20'



