--USE [ag4]
--GO
/****** Object:  StoredProcedure [dbo].[SP_A_DailyTotals_Revised]    Script Date: 11/27/2013 11:30:26 ******/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
--ALTER Procedure [dbo].[SP_A_DailyTotals_Revised] 


DROP PROCEDURE [dbo].[SP_A_DailyTotals_Revised]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[SP_A_DailyTotals_Revised]
  
 (
 
 @StartDate as datetime,
 @EndDate as datetime,
 @hubId as NVARCHAR(50),
 @RouteId as NVARCHAR(50)
  
 )
   
 as 
 
if  @hubId='ALL'  begin set @hubId='%' end
if  @RouteId='ALL'  begin set @RouteId='%' end
   
SELECT     dbo.tblSourcingDocument.DocumentReference AS docRef, 
           dbo.tblSourcingDocument.Id AS docId, 
           dbo.tblSourcingDocument.DocumentTypeId,
            
           case when dbo.tblSourcingDocument.DocumentTypeId = 13 then sum(dbo.tblSourcingLineItem.Weight) else 0 end AS RouteWeight,
           case when dbo.tblSourcingDocument.DocumentTypeId = 16 then sum(dbo.tblSourcingLineItem.Weight) else 0 end AS LorryWeight,
           case when dbo.tblSourcingDocument.DocumentTypeId = 17 then sum(dbo.tblSourcingLineItem.Weight) else 0 end AS FactoryWeight,
           
           dbo.tblCostCentre.Id AS hubId, 
           dbo.tblCostCentre.Name AS Hub, 
           dbo.tblCostCentre.CostCentreType, 
           dbo.tblSourcingLineItem.Weight,
           dbo.tblRoutes.RouteID,
           dbo.tblRoutes.Name AS Route,
           CONVERT(DATE,dbo.tblSourcingDocument.DocumentDate, 101) AS DeliveryDate


FROM       dbo.tblSourcingDocument INNER JOIN
           dbo.tblSourcingLineItem ON dbo.tblSourcingDocument.Id = dbo.tblSourcingLineItem.DocumentId INNER JOIN
           dbo.tblCostCentre ON dbo.tblSourcingDocument.DocumentRecipientCostCentreId = dbo.tblCostCentre.Id  INNER JOIN
           dbo.tblRoutes ON dbo.tblSourcingDocument.RouteId = dbo.tblRoutes.RouteID
           
WHERE     (dbo.tblCostCentre.CostCentreType = 8)
          AND(dbo.tblSourcingDocument.DocumentTypeId = 13 or dbo.tblSourcingDocument.DocumentTypeId = 16 or dbo.tblSourcingDocument.DocumentTypeId = 17)
          AND(CONVERT(VARCHAR(26), dbo.tblSourcingDocument.DocumentDate,23)  BETWEEN @StartDate AND @EndDate) 
          AND(CONVERT(NVARCHAR(50),dbo.tblCostCentre.Id) LIKE ISNULL(@hubId, N'%'))             
          AND(CONVERT(NVARCHAR(50),dbo.tblRoutes.RouteID) LIKE ISNULL(@RouteId, N'%'))  
           
           
Group By   dbo.tblSourcingDocument.DocumentReference,  dbo.tblSourcingDocument.Id,  dbo.tblCostCentre.Id ,dbo.tblSourcingDocument.DocumentTypeId ,
           dbo.tblCostCentre.Name, 
           dbo.tblCostCentre.CostCentreType, 
           dbo.tblSourcingLineItem.Weight,
           dbo.tblRoutes.RouteID,
           dbo.tblRoutes.Name,
           dbo.tblSourcingDocument.DocumentDate 
           
-- EXEC [dbo].[SP_A_DailyTotals_Revised] @startDate = '2013-11-1',@endDate = '2013-11-26', @HubId = 'ALL' , @RouteId = 'ALL'               