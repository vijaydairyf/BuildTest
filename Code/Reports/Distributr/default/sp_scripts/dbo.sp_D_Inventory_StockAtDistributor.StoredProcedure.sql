/****** Object:  StoredProcedure [dbo].[sp_D_Inventory_StockAtDistributor]    Script Date: 07/24/2013 08:51:32 ******/
DROP PROCEDURE [dbo].[sp_D_Inventory_StockAtDistributor]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_D_Inventory_StockAtDistributor]
(
@distributorId AS NVARCHAR(50),
@productId AS NVARCHAR(50)
)
AS 
if  LTRIM(rtrim(@distributorId)) = 'ALL'  begin set @distributorId='%' end
if  LTRIM(rtrim(@productId)) = 'ALL'  begin set @productId='%' end

SELECT     cc.Id AS DistributorId,
           cc.Name AS DistributorName, 
		   cc.CostCentreType AS Distcctype, 
		   cc.ParentCostCentreId, 
		   inv.Balance, 
		   prod.ExFactoryPrice, 
		   prod.Description AS ProductName, 
           prod.id AS ProductId,
		   CASE when cc.CostCentreType = 2 then 'Available Stock' END as StockType

FROM      dbo.tblInventory AS inv INNER JOIN
          dbo.tblCostCentre AS cc ON inv.WareHouseId = cc.Id INNER JOIN
          dbo.tblProduct AS prod ON inv.ProductId = prod.id INNER JOIN
          dbo.tblProductBrand AS brand ON prod.BrandId = brand.id
		  
WHERE     (inv.Balance >= 0) AND (cc.CostCentreType = 2)AND
          (CONVERT(NVARCHAR(50),cc.Id) LIKE ISNULL(@distributorId, N'%')) AND
          (CONVERT(NVARCHAR(50),prod.id) LIKE ISNULL(@productId, N'%')) 
group by cc.Id ,
           cc.Name , 
		   cc.CostCentreType , 
		   cc.ParentCostCentreId, 
		   inv.Balance, 
		   prod.ExFactoryPrice, 
		   prod.Description , 
           prod.id
		   
having inv.Balance  > 0

UNION ALL

SELECT     dbo.tblCostCentre.Id AS DistributorId, 
           dbo.tblCostCentre.Name AS DistributorName,  
           cc.CostCentreType AS Distcctype, 
		   cc.ParentCostCentreId, 
           inv.Balance, 
		   prod.ExFactoryPrice,   
		   prod.Description AS ProductName, 
		   prod.id AS ProductId,
		   CASE when cc.CostCentreType = 6 then 'Pending Dispatch Stock' END as StockType
		   
		   
FROM       dbo.tblInventory AS inv INNER JOIN
           dbo.tblCostCentre AS cc ON inv.WareHouseId = cc.Id INNER JOIN
           dbo.tblProduct AS prod ON inv.ProductId = prod.id INNER JOIN
           dbo.tblProductBrand AS brand ON prod.BrandId = brand.id INNER JOIN
           dbo.tblCostCentre ON cc.ParentCostCentreId = dbo.tblCostCentre.Id

WHERE     (inv.Balance >= 0) AND 
          (cc.CostCentreType = 6)AND
          (CONVERT(NVARCHAR(50),tblCostCentre.Id) LIKE ISNULL(@distributorId, N'%')) AND
          (CONVERT(NVARCHAR(50),prod.id) LIKE ISNULL(@productId, N'%'))
          group by dbo.tblCostCentre.Id ,  dbo.tblCostCentre.Name ,
		   cc.CostCentreType  , 
		   cc.ParentCostCentreId, 
		   inv.Balance, 
		   prod.ExFactoryPrice, 
		   prod.Description , 
           prod.id,dbo.tblCostCentre.Id
	   
      having inv.Balance  > 0
GO
