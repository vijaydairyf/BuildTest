/****** Object:  StoredProcedure [dbo].[sp_D_TotalDiscountByDistributor]    Script Date: 07/24/2013 08:51:32 ******/
DROP PROCEDURE [dbo].[sp_D_TotalDiscountByDistributor]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_D_TotalDiscountByDistributor]
(
@distributorId AS NVARCHAR(50),
@discountType AS INT,
@startDate AS DATE,
@endDate AS DATE
)
AS 
if  @distributorId='ALL'  begin set @distributorId='%' end
--if  @discountType='ALL'  begin set @discountType=0 end

SELECT 
1 AS [C1], 
[Project1].[Id] AS [Id], 
[Limit1].[Name] AS [Name], 
[Limit1].[Id] AS [DistributorId], 
prod.[Description] AS [Description], 
prod.[id] AS [ProductId], 
[Project1].[Quantity] AS [Quantity],
--[Project1].[DiscountType],
--[Project1].[DocumentDateIssued] AS [DoctDateIssued],
--convert(nvarchar(26),[Project1].DocumentDateIssued,23)as DiscountDate, 
CASE WHEN ([Project1].[C1] = 1) THEN [Project1].[ProductDiscount] * [Project1].[Quantity] ELSE 0.0 END AS [DiscountAmount], 
CASE WHEN ([Project1].[DiscountType] = 1) THEN N'Promotion Discount' 
     WHEN ([Project1].[C4] = 1) THEN N'Certain Value Certain Product Discount' 
     WHEN ([Project1].[C1] = 1) THEN N'Product Discount' 
     WHEN ([Project1].[DiscountAmount] = 1) THEN N'Free Of Charge Discount' ELSE N'Unknown' END AS [DiscountType]

FROM    (SELECT 
	doc.[Id] AS [Id], 
	doc.[DocumentIssuerCostCentreId] AS [DocumentIssuerCostCentreId], 
	doc.[DocumentRecipientCostCentre] AS [DocumentRecipientCostCentre], 
	line.[ProductID] AS [ProductID], 
	line.[Quantity] AS [Quantity], 
	line.[ProductDiscount] AS [ProductDiscount], 
	
	CASE WHEN ((1 = line.[DiscountLineItemTypeId]) AND 
	           (1 = line.[OrderLineItemType]) AND 
	               (line.[ProductDiscount] > cast(0 as decimal(18)))) THEN cast(1 as bit)
	    
	     WHEN ( NOT ((1 = line.[DiscountLineItemTypeId]) AND 
	                 (1 = line.[OrderLineItemType]) AND 
	                     (line.[ProductDiscount] > cast(0 as decimal(18))))) THEN cast(0 as bit) END AS [C1], 
	
	CASE WHEN (((0 = line.[DiscountLineItemTypeId]) OR ((4 = @discountType) AND 
	            (0 = line.[DiscountLineItemTypeId]))) AND 
	            (1 = line.[OrderLineItemType]) AND (cast(0 as decimal(18)) = line.[Value])) THEN cast(1 as bit) 
	     WHEN ( NOT (((0 = line.[DiscountLineItemTypeId]) OR 
	                 ((4 = @discountType) AND 
	                  (0 = line.[DiscountLineItemTypeId]))) AND 
	                  (1 = line.[OrderLineItemType]) AND (cast(0 as decimal(18)) = line.[Value]))) THEN cast(0 as bit) END AS [DiscountAmount], 
	
	CASE WHEN ((5 = line.[DiscountLineItemTypeId]) AND 
	           (2 = line.[OrderLineItemType])) THEN cast(1 as bit) 
	     WHEN ( NOT ((5 = line.[DiscountLineItemTypeId]) AND
	           (2 = line.[OrderLineItemType]))) THEN cast(0 as bit) END AS [DiscountType], 
	
	CASE WHEN ((6 = line.[DiscountLineItemTypeId]) AND 
	           (2 = line.[OrderLineItemType])) THEN cast(1 as bit) WHEN ( NOT ((6 = line.[DiscountLineItemTypeId]) AND 
	           (2 = line.[OrderLineItemType]))) THEN cast(0 as bit) END AS [C4]
	
	FROM   [dbo].[tblDocument] AS doc
	INNER JOIN [dbo].[tblLineItems] AS line ON doc.[Id] = line.[DocumentID]
	INNER JOIN [dbo].[tblCostCentre] AS cc ON doc.[DocumentIssuerCostCentreId] = cc.[Id]
	
	WHERE (convert(nvarchar(26),doc.DocumentDateIssued,23) between @startDate and @endDate)AND(doc.[Id] = doc.[OrderParentId]) AND --
	  (1 = doc.[DocumentTypeId]) AND 
	 ((1 = doc.[OrderOrderTypeId]) OR ((99 = doc.[DocumentStatusId]) AND 
	  (3 = doc.[OrderOrderTypeId]))) AND 
	      ((CONVERT(NVARCHAR(50),doc.[DocumentIssuerCostCentreId]) like isnull(@distributorId,N'%')) OR (CONVERT(NVARCHAR(50),doc.[DocumentRecipientCostCentre]) like isnull(@distributorId,N'%')) ) AND 
	     ((line.[DiscountLineItemTypeId] = @discountType) OR (0 = @discountType) OR ((4 = @discountType) AND 
	  (0 = line.[DiscountLineItemTypeId]))) AND 
	
	  (((CASE WHEN ((1 = line.[DiscountLineItemTypeId]) AND 
	                (1 = line.[OrderLineItemType]) AND 
	                    (line.[ProductDiscount] > cast(0 as decimal(18)))) THEN cast(1 as bit) 
	          WHEN ( NOT ((1 = line.[DiscountLineItemTypeId]) AND 	                                                                                                            (1 = line.[OrderLineItemType]) AND 
	                          (line.[ProductDiscount] > cast(0 as decimal(18))))) THEN cast(0 as bit) END) = 1) OR 
	   
	    ((CASE WHEN (((0 = line.[DiscountLineItemTypeId]) OR ((4 = @discountType) AND 
	                  (0 = line.[DiscountLineItemTypeId]))) AND 
	                  (1 = line.[OrderLineItemType]) AND (cast(0 as decimal(18)) = line.[Value])) THEN cast(1 as bit) 
	           WHEN ( NOT (((0 = line.[DiscountLineItemTypeId]) OR ((4 = @discountType) AND 
	                        (0 = line.[DiscountLineItemTypeId]))) AND 
	                        (1 = line.[OrderLineItemType]) AND (cast(0 as decimal(18)) = line.[Value]))) THEN cast(0 as bit) END) = 1) OR 
	    
	    ((CASE WHEN ((5 = line.[DiscountLineItemTypeId]) AND 
	                 (2 = line.[OrderLineItemType])) THEN cast(1 as bit) 
	           WHEN ( NOT ((5 = line.[DiscountLineItemTypeId]) AND 
	                       (2 = line.[OrderLineItemType]))) THEN cast(0 as bit) END) = 1) OR 
	    
	    ((CASE WHEN ((6 = line.[DiscountLineItemTypeId]) AND (2 = line.[OrderLineItemType])) THEN cast(1 as bit) 
	           WHEN ( NOT ((6 = line.[DiscountLineItemTypeId]) AND 
	                       (2 = line.[OrderLineItemType]))) THEN cast(0 as bit) END) = 1)) ) AS [Project1]

OUTER APPLY  (SELECT TOP (1) [Extent4].[Id] AS [Id], [Extent4].[Name] AS [Name]
	                 FROM [dbo].[tblCostCentre] AS [Extent4]
	                 WHERE ([Extent4].[CostCentreType] IN (2,1)) AND 
	                       ([Extent4].[Id] IN ([Project1].[DocumentRecipientCostCentre],
	                                           [Project1].[DocumentIssuerCostCentreId])) ) AS [Limit1]
INNER JOIN [dbo].[tblProduct] AS prod ON [Project1].[ProductID] = prod.[id]

-- EXEC  [dbo].[sp_D_TotalDiscountByDistributor] @distributorId='ALL',@discountType=5,@startDate='1-May-2014',@endDate='21-May-2014'


           --AND (dbo.tblProductBrand.name LIKE ISNULL(@Brand, N'%')) 
           --AND((CONVERT(NVARCHAR(50),tblCostCentre.Id) LIKE ISNULL(@distributorId, N'%')) OR (CONVERT(NVARCHAR(50),tblCostCentre.ParentCostCentreId) LIKE ISNULL(@distributorId, N'%')))
           --AND(CONVERT(NVARCHAR(50),dbo.tblCostCentre.Id) LIKE ISNULL(@salesManID, N'%')) 
           --AND(dbo.tblProduct.Description LIKE ISNULL(@Product, N'%'))
GO
