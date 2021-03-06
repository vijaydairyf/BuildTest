/****** Object:  StoredProcedure [dbo].[sp_D_PaymentDetails]    Script Date: 07/24/2013 08:51:32 ******/
DROP PROCEDURE [dbo].[sp_D_PaymentDetails]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_D_PaymentDetails] 
(
@salesRef as nvarchar(50)
)
AS
SELECT dbo.tblCostCentre.Name, 
       dbo.tblCostCentre.CostCentreType, 
       dbo.tblCostCentre.ParentCostCentreId, 
       dbo.tblDocument.DocumentTypeId, 
       dbo.tblDocument.OrderOrderTypeId, 
       tblDocument_1.DocumentTypeId AS Expr1, 
       tblDocument_2.DocumentTypeId AS Expr3, 
       dbo.tblLineItems.Value, 
       dbo.tblLineItems.ProductDiscount, 
       Receipt_PaymentTypeId = CASE dbo.tblLineItems.Receipt_PaymentTypeId
									 WHEN '1' THEN 'Cash'
									 WHEN '2' THEN 'Cheque'
									 WHEN '3' THEN 'Mmoney'	END,	
       dbo.tblCostCentre.Id, 
       dbo.tblLineItems.Quantity,
       dbo.tblLineItems.Receipt_PaymentReference as PaymentReference,
       dbo.tblDocument.DocumentReference
FROM   dbo.tblCostCentre 
 JOIN  dbo.tblDocument ON dbo.tblCostCentre.Id = dbo.tblDocument.DocumentRecipientCostCentre 
 JOIN  dbo.tblDocument AS tblDocument_1 ON dbo.tblDocument.Id = tblDocument_1.InvoiceOrderId 
 JOIN  dbo.tblDocument AS tblDocument_2 ON tblDocument_1.Id = tblDocument_2.InvoiceOrderId 
 JOIN  dbo.tblLineItems ON tblDocument_2.Id = dbo.tblLineItems.DocumentID
WHERE (dbo.tblDocument.DocumentTypeId = 1) 
 --AND (dbo.tblDocument.OrderOrderTypeId = 1) 
 AND (tblDocument_1.DocumentTypeId = 5) 
 AND (tblDocument_2.DocumentTypeId = 8) 
 AND (CONVERT(NVARCHAR(50),dbo.tblDocument.DocumentReference) like rtrim(ltrim(@salesRef)))
 
 
 --   EXEC   [dbo].[sp_D_PaymentDetails]   @salesRef = 'O_Amina_CKO6858_20140730_092740_00695' 
 
 --   EXEC   [dbo].[sp_D_PaymentDetails]   @salesRef = 'S_Frank_CKO2595_20140305_143827_00002'
 
  --   EXEC   [dbo].[sp_D_PaymentDetails]   @salesRef = 'O_Kamau_GD0007_20140801_153132_00008'
  
  --   EXEC   [dbo].[sp_D_PaymentDetails]   @salesRef = 'O_Kelly_CKO7094_20140910_111146_00935'Sale_EdwinLukano_92173_20150307_100144_00053
  --   EXEC   [dbo].[sp_D_PaymentDetails]   @salesRef = 'Sale_EdwinLukano_92173_20150307_100144_00053'

GO
