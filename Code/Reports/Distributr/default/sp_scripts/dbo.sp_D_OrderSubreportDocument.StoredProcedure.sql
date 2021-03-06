/****** Object:  StoredProcedure [dbo].[sp_D_OrderSubreportDocument]    Script Date: 07/24/2013 08:51:32 ******/
DROP PROCEDURE [dbo].[sp_D_OrderSubreportDocument]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_D_OrderSubreportDocument]
(@documentId AS NVARCHAR(50))
AS
if  @documentId='ALL'  begin set @documentId='%' end
SELECT     dbo.tblDocument.DocumentReference, 
           dbo.tblDocument.DocumentIssuerCostCentreId, 
           dbo.tblDocument.DocumentIssuerUserId, 
           dbo.tblDocument.OrderIssuedOnBehalfOfCC, 
           dbo.tblDocument.DocumentDateIssued, 
           dbo.tblDocument.Longitude, 
           dbo.tblDocument.Latitude, 
           dbo.tblDocument.DocumentTypeId,
           dbo.tblDocument.DocumentStatusId,  
           CASE WHEN DocumentTypeId = 1 THEN 'Order' END AS DocumentType, 
           CASE WHEN DocumentStatusId = 0 THEN 'New' 
                WHEN DocumentStatusId = 1 THEN 'Confirmed' 
                WHEN DocumentStatusId = 2 THEN 'Submitted'
                WHEN DocumentStatusId = 3 THEN 'Cancelled'
                WHEN DocumentStatusId = 4 THEN 'Approved' 
                WHEN DocumentStatusId = 5 THEN 'Rejected' 
                WHEN DocumentStatusId = 99 THEN 'Closed' END AS DocumentStatus, 
            dbo.tblDocument.SaleDiscount, 
            dbo.tblDocument.Note OrderComment,
            dbo.tblCostCentre.Name AS DocIssuerCC, 
            dbo.tblCostCentre.CostCentreType, 
            tblCostCentre_1.Name AS Customer, 
            tblCostCentre_1.CostCentreType AS ccCustomer, 
            dbo.tblDocument.OrderOrderTypeId
FROM        dbo.tblDocument INNER JOIN
            dbo.tblCostCentre AS tblCostCentre_1 ON dbo.tblDocument.OrderIssuedOnBehalfOfCC = tblCostCentre_1.Id INNER JOIN           
            dbo.tblCostCentre  ON ((dbo.tblDocument.DocumentRecipientCostCentre = tblCostCentre.Id)OR 
                                                    (dbo.tblDocument.DocumentIssuerCostCentreId = tblCostCentre.Id))
WHERE      (dbo.tblDocument.DocumentTypeId = 1) AND 
           (dbo.tblDocument.OrderOrderTypeId = 3) AND 
          (CONVERT(NVARCHAR(50), dbo.tblDocument.Id)LIKE ISNULL(@documentId,N'%')) AND 
            -- (dbo.tblDocument.Id = 'b5a20d07-da8d-45fc-8b86-416fc4a7d793') AND 
           (dbo.tblCostCentre.CostCentreType = 4) AND 
           (tblCostCentre_1.CostCentreType = 5)

         

GO
