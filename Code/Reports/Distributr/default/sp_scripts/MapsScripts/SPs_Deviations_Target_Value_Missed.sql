IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[map_spDev_TVM_GetPoints]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[map_spDev_TVM_GetPoints]
GO


CREATE procedure [dbo].[map_spDev_TVM_GetPoints](
	@sDate as datetime,
	@eDate as datetime,
	@uDistributor varchar(200),
	@uSalesman varchar(200),
	@uRoute varchar(200),
	@uOutlet varchar(200)
)
AS

;WITH tvm_CTE AS (		
SELECT  DISTINCT
		outlets.Id AS OutletId,
		outlets.Name AS OutletName,
		salesman.Name AS SalesmanName,
		salesman.Id AS SalesmanId,
		rt.Name AS RouteName,
		rt.RouteId AS RouteId,
		dist.Name AS DistributorName,
		dist.Id AS DistributorID,
		SUM(saleItems.Quantity) SoldQty,
		SUM(saleItems.Quantity + (saleItems.Value + saleItems.Vat)) SoldAmt,
	    sale.Longitude,
	    sale.Latitude,
		CONVERT(NVARCHAR(26),sale.DocumentDateIssued,23) SalesDate,
		tp.Name TargetPeriod,
		tp.StartDate TpStartDate,
		tp.EndDate TpEndDate,
		t.TargetValue
FROM    dbo.tblDocument AS sale 
 JOIN   dbo.tblLineItems AS saleItems ON sale.Id = saleItems.DocumentID 
 JOIN   dbo.tblCostCentre AS dist ON sale.DocumentIssuerCostCentreId = dist.Id OR sale.DocumentRecipientCostCentre = dist.Id 
 JOIN   dbo.tblCostCentre AS salesman ON sale.DocumentIssuerCostCentreId = salesman.Id OR sale.DocumentRecipientCostCentre = salesman.Id 
 JOIN   dbo.tblCostCentre outlets ON sale.OrderIssuedOnBehalfOfCC = outlets.id
 JOIN   dbo.tblRegion AS reg ON dist.Distributor_RegionId = reg.id 
 JOIN   dbo.tblCountry AS cntry ON reg.Country = cntry.id 
 JOIN   dbo.tblRoutes rt ON outlets.RouteId = rt.RouteID
 JOIN   dbo.tblTarget t ON outlets.Id = t.CostCentreId
 JOIN   dbo.tblTargetPeriod tp ON t.PeriodId = tp.Id
WHERE sale.DocumentDateIssued BETWEEN tp.StartDate AND tp.EndDate
AND sale.Latitude is not null AND sale.Longitude is not null 
AND sale.Latitude <> 0 AND sale.Longitude <> 0
AND sale.Latitude <>'' AND sale.Longitude <> ''
AND dist.Id = (case when @uDistributor = 'ALL' then dist.Id else @uDistributor end )
AND salesman.Id = (case when @uSalesman = 'ALL' then salesman.Id else @uSalesman end )
AND rt.RouteId = (case when @uRoute = 'ALL' then rt.RouteId else @uRoute end )
AND outlets.Id = (case when @uOutlet = 'ALL' then outlets.Id else @uOutlet end )
--AND sale.DocumentDateIssued BETWEEN @sDate AND @eDate

GROUP BY    outlets.Id,outlets.Name,
			salesman.Name,salesman.Id,
			rt.Name,rt.RouteId,
			dist.Name,dist.Id,
		    sale.Longitude,sale.Latitude,
		    sale.DocumentDateIssued,
			tp.Name,tp.StartDate,tp.EndDate ,t.TargetValue

)
SELECT
OutletId,OutletName,
Longitude,Latitude,
TargetPeriod,TpStartDate,TpEndDate,TargetValue

FROM tvm_CTE
GROUP BY 
OutletId,OutletName,
Longitude,Latitude,TargetValue,TargetPeriod,TpStartDate,TpEndDate


GO

-- ===================================================================================================================================
-- ===================================================================================================================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[map_spDev_TVM_GetDistributors]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[map_spDev_TVM_GetDistributors]
GO

CREATE procedure [dbo].[map_spDev_TVM_GetDistributors](
	@sDate as datetime,
	@eDate as datetime
)
AS

;WITH tvm_CTE AS (		
SELECT  DISTINCT
		dist.Name AS DistributorName,
		dist.Id AS DistributorID
FROM    dbo.tblDocument AS sale 
 JOIN   dbo.tblLineItems AS saleItems ON sale.Id = saleItems.DocumentID 
 JOIN   dbo.tblCostCentre AS dist ON sale.DocumentIssuerCostCentreId = dist.Id OR sale.DocumentRecipientCostCentre = dist.Id 
 JOIN   dbo.tblCostCentre AS salesman ON sale.DocumentIssuerCostCentreId = salesman.Id OR sale.DocumentRecipientCostCentre = salesman.Id 
 JOIN   dbo.tblCostCentre outlets ON sale.OrderIssuedOnBehalfOfCC = outlets.id
 JOIN   dbo.tblRegion AS reg ON dist.Distributor_RegionId = reg.id 
 JOIN   dbo.tblCountry AS cntry ON reg.Country = cntry.id 
 JOIN   dbo.tblRoutes rt ON outlets.RouteId = rt.RouteID
 JOIN   dbo.tblTarget t ON outlets.Id = t.CostCentreId
 JOIN   dbo.tblTargetPeriod tp ON t.PeriodId = tp.Id
WHERE sale.DocumentDateIssued BETWEEN tp.StartDate AND tp.EndDate
AND sale.Latitude is not null AND sale.Longitude is not null 
AND sale.Latitude <> 0 AND sale.Longitude <> 0
AND sale.Latitude <>'' AND sale.Longitude <> ''
AND dist.CostCentreType = 2
AND salesman.CostCentreType = 4

--AND sale.DocumentDateIssued BETWEEN @sDate AND @eDate

GROUP BY    outlets.Id,outlets.Name,
			salesman.Name,salesman.Id,
			rt.Name,rt.RouteId,
			dist.Name,dist.Id,
		    sale.Longitude,sale.Latitude,
		    sale.DocumentDateIssued,
			tp.Name,tp.StartDate,tp.EndDate ,t.TargetValue

)
SELECT DISTINCT DistributorID,DistributorName
FROM tvm_CTE
                        
GO

-- ===================================================================================================================================
-- ===================================================================================================================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[map_spDev_TVM_GetSalesMen]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[map_spDev_TVM_GetSalesMen]
GO

CREATE procedure [dbo].[map_spDev_TVM_GetSalesMen](
	@sDate as datetime,
	@eDate as datetime,
	@uDistributor varchar(200)
)
AS

;WITH tvm_CTE AS (		
SELECT  DISTINCT
		salesman.Name AS SalesmanName,
		salesman.Id AS SalesmanId
FROM    dbo.tblDocument AS sale 
 JOIN   dbo.tblLineItems AS saleItems ON sale.Id = saleItems.DocumentID 
 JOIN   dbo.tblCostCentre AS dist ON sale.DocumentIssuerCostCentreId = dist.Id OR sale.DocumentRecipientCostCentre = dist.Id 
 JOIN   dbo.tblCostCentre AS salesman ON sale.DocumentIssuerCostCentreId = salesman.Id OR sale.DocumentRecipientCostCentre = salesman.Id 
 JOIN   dbo.tblCostCentre outlets ON sale.OrderIssuedOnBehalfOfCC = outlets.id
 JOIN   dbo.tblRegion AS reg ON dist.Distributor_RegionId = reg.id 
 JOIN   dbo.tblCountry AS cntry ON reg.Country = cntry.id 
 JOIN   dbo.tblRoutes rt ON outlets.RouteId = rt.RouteID
 JOIN   dbo.tblTarget t ON outlets.Id = t.CostCentreId
 JOIN   dbo.tblTargetPeriod tp ON t.PeriodId = tp.Id
WHERE sale.DocumentDateIssued BETWEEN tp.StartDate AND tp.EndDate
AND dist.Id = (case when @uDistributor = 'ALL' then dist.Id else @uDistributor end )
AND sale.Latitude is not null AND sale.Longitude is not null 
AND sale.Latitude <> 0 AND sale.Longitude <> 0
AND sale.Latitude <>'' AND sale.Longitude <> ''
AND dist.CostCentreType = 2
AND salesman.CostCentreType = 4
--AND sale.DocumentDateIssued BETWEEN @sDate AND @eDate

GROUP BY    outlets.Id,outlets.Name,
			salesman.Name,salesman.Id,
			rt.Name,rt.RouteId,
			dist.Name,dist.Id,
		    sale.Longitude,sale.Latitude,
		    sale.DocumentDateIssued,
			tp.Name,tp.StartDate,tp.EndDate ,t.TargetValue

)
SELECT DISTINCT SalesmanId,SalesmanName
FROM tvm_CTE
                        
GO

-- ===================================================================================================================================
-- ===================================================================================================================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[map_spDev_TVM_GetRoutes]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[map_spDev_TVM_GetRoutes]
GO

CREATE procedure [dbo].[map_spDev_TVM_GetRoutes](
	@sDate as datetime,
	@eDate as datetime,
	@uDistributor varchar(200),
	@uSalesman varchar(200)
)
AS

;WITH tvm_CTE AS (		
SELECT  DISTINCT
        rt.RouteID RouteId,rt.Name RouteName
FROM    dbo.tblDocument AS sale 
 JOIN   dbo.tblLineItems AS saleItems ON sale.Id = saleItems.DocumentID 
 JOIN   dbo.tblCostCentre AS dist ON sale.DocumentIssuerCostCentreId = dist.Id OR sale.DocumentRecipientCostCentre = dist.Id 
 JOIN   dbo.tblCostCentre AS salesman ON sale.DocumentIssuerCostCentreId = salesman.Id OR sale.DocumentRecipientCostCentre = salesman.Id 
 JOIN   dbo.tblCostCentre outlets ON sale.OrderIssuedOnBehalfOfCC = outlets.id
 JOIN   dbo.tblRegion AS reg ON dist.Distributor_RegionId = reg.id 
 JOIN   dbo.tblCountry AS cntry ON reg.Country = cntry.id 
 JOIN   dbo.tblRoutes rt ON outlets.RouteId = rt.RouteID
 JOIN   dbo.tblTarget t ON outlets.Id = t.CostCentreId
 JOIN   dbo.tblTargetPeriod tp ON t.PeriodId = tp.Id
WHERE sale.DocumentDateIssued BETWEEN tp.StartDate AND tp.EndDate
--AND dist.Id = (case when @uDistributor = 'ALL' then dist.Id else @uDistributor end )
AND sale.Latitude is not null AND sale.Longitude is not null 
AND sale.Latitude <> 0 AND sale.Longitude <> 0
AND sale.Latitude <>'' AND sale.Longitude <> ''
AND dist.CostCentreType = 2
AND salesman.CostCentreType = 4
--AND sale.DocumentDateIssued BETWEEN @sDate AND @eDate

GROUP BY    outlets.Id,outlets.Name,
			salesman.Name,salesman.Id,
			rt.Name,rt.RouteId,
			dist.Name,dist.Id,
		    sale.Longitude,sale.Latitude,
		    sale.DocumentDateIssued,
			tp.Name,tp.StartDate,tp.EndDate ,t.TargetValue

)
SELECT DISTINCT RouteId,RouteName
FROM tvm_CTE 
                        
GO

-- ===================================================================================================================================
-- ===================================================================================================================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[map_spDev_TVM_GetOutlets]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[map_spDev_TVM_GetOutlets]
GO

CREATE procedure [dbo].[map_spDev_TVM_GetOutlets](
	@sDate as datetime,
	@eDate as datetime,
	@uDistributor varchar(200),
	@uSalesman varchar(200),
	@uRoute varchar(200)
)
AS

;WITH tvm_CTE AS (		
SELECT  DISTINCT
        outlets.Id OutletId,outlets.Name OutletName
FROM    dbo.tblDocument AS sale 
 JOIN   dbo.tblLineItems AS saleItems ON sale.Id = saleItems.DocumentID 
 JOIN   dbo.tblCostCentre AS dist ON sale.DocumentIssuerCostCentreId = dist.Id OR sale.DocumentRecipientCostCentre = dist.Id 
 JOIN   dbo.tblCostCentre AS salesman ON sale.DocumentIssuerCostCentreId = salesman.Id OR sale.DocumentRecipientCostCentre = salesman.Id 
 JOIN   dbo.tblCostCentre outlets ON sale.OrderIssuedOnBehalfOfCC = outlets.id
 JOIN   dbo.tblRegion AS reg ON dist.Distributor_RegionId = reg.id 
 JOIN   dbo.tblCountry AS cntry ON reg.Country = cntry.id 
 JOIN   dbo.tblRoutes rt ON outlets.RouteId = rt.RouteID
 JOIN   dbo.tblTarget t ON outlets.Id = t.CostCentreId
 JOIN   dbo.tblTargetPeriod tp ON t.PeriodId = tp.Id
WHERE sale.DocumentDateIssued BETWEEN tp.StartDate AND tp.EndDate
AND dist.Id = (case when @uDistributor = 'ALL' then dist.Id else @uDistributor end )
AND salesman.Id = (case when @uSalesman = 'ALL' then salesman.Id else @uSalesman end )
AND rt.RouteId = (case when @uRoute = 'ALL' then rt.RouteId else @uRoute end )
AND sale.Latitude is not null AND sale.Longitude is not null 
AND sale.Latitude <> 0 AND sale.Longitude <> 0
AND sale.Latitude <>'' AND sale.Longitude <> ''
AND dist.CostCentreType = 2
AND salesman.CostCentreType = 4
--AND sale.DocumentDateIssued BETWEEN @sDate AND @eDate

GROUP BY    outlets.Id,outlets.Name,
			salesman.Name,salesman.Id,
			rt.Name,rt.RouteId,
			dist.Name,dist.Id,
		    sale.Longitude,sale.Latitude,
		    sale.DocumentDateIssued,
			tp.Name,tp.StartDate,tp.EndDate ,t.TargetValue

)
SELECT DISTINCT OutletId,OutletName
FROM tvm_CTE
                        
GO