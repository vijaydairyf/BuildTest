/****** Object:  StoredProcedure [dbo].[map_spGetPoints_DevPlannedRoute]    Script Date: 11/12/2014 10:39:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[map_spDev_FPR_GetPoints]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[map_spDev_FPR_GetPoints]
GO


CREATE procedure [dbo].[map_spDev_FPR_GetPoints](
	@sDate as datetime,
	@eDate as datetime,
	@uDistributor varchar(200),
	@uSalesman varchar(200),
	@uRoute varchar(200),
	@uOutlet varchar(200)
)
AS

SELECT  DISTINCT
		outlets.Id AS OutletId,
		outlets.Name AS OutletName,
		salesman.Name AS SalesmanName,
		salesman.Id AS SalesmanId,
		rt.Name AS RouteName,
		rt.RouteId AS RouteId,
		dist.Name AS DistributorName,
		dist.Id AS DistributorID,
	    (select top 1 Longitude from tblDocument s where outlets.Id = s.OrderIssuedOnBehalfOfCC and isnull(Longitude,'') <> '') Longitude,
	    (select top 1 Latitude from tblDocument s where outlets.Id = s.OrderIssuedOnBehalfOfCC and isnull(Latitude,'') <> '') Latitude,
	    sale.DocumentDateIssued TransactionDate,
	    sum((saleItems.Quantity * (saleItems.Value + saleItems.Vat))) as GrossAmount
FROM    dbo.tblDocument AS sale 
 JOIN   dbo.tblLineItems AS saleItems ON sale.Id = saleItems.DocumentID 
 JOIN   dbo.tblCostCentre AS dist ON sale.DocumentIssuerCostCentreId = dist.Id OR sale.DocumentRecipientCostCentre = dist.Id 
 JOIN   dbo.tblCostCentre AS salesman ON sale.DocumentIssuerCostCentreId = salesman.Id OR sale.DocumentRecipientCostCentre = salesman.Id 
 JOIN   dbo.tblCostCentre outlets ON sale.OrderIssuedOnBehalfOfCC = outlets.id
 JOIN   dbo.tblRegion AS reg ON dist.Distributor_RegionId = reg.id 
 JOIN   dbo.tblCountry AS cntry ON reg.Country = cntry.id 
 JOIN   dbo.tblRoutes rt ON outlets.RouteId = rt.RouteID
WHERE 
dist.Id = (case when @uDistributor = 'ALL' then dist.Id else @uDistributor end )
AND dist.CostCentreType = 2 
AND salesman.CostCentreType = 4
AND salesman.Id = (case when @uSalesman = 'ALL' then salesman.Id else @uSalesman end )
AND rt.RouteId = (case when @uRoute = 'ALL' then rt.RouteId else @uRoute end )
AND outlets.Id = (case when @uOutlet = 'ALL' then outlets.Id else @uOutlet end )
AND sale.DocumentDateIssued BETWEEN @sDate AND @eDate
AND outlets.Id NOT IN (
	select  ov.OutletId from v_D_OutletVisits ov  
	where ov.OutletId in (
		select o.Id from tblCostCentre d
		   join tblCostCentre s on d.id = s.ParentCostCentreId
		   join tblSalemanRoute sr on sr.SalemanId = s.Id 
		   join tblRoutes rt on sr.RouteId = rt.RouteID
		   join tblCostCentre o on rt.RouteID = o.RouteId
		where d.CostCentreType = 2 and s.CostCentreType = 4 group by o.Id
	)
)
AND (select top 1 Longitude from tblDocument s where outlets.Id = s.OrderIssuedOnBehalfOfCC and isnull(Longitude,'') <> '')  is not null
AND (select top 1 Latitude from tblDocument s where outlets.Id = s.OrderIssuedOnBehalfOfCC and isnull(Latitude,'') <> '')  is not null
group by 
	outlets.Id, outlets.Name , salesman.Name , salesman.Id ,
	rt.Name , rt.RouteId , dist.Name , dist.Id , sale.DocumentDateIssued ,
    Longitude , Latitude
	    
GO

-- ===================================================================================================================================
-- ===================================================================================================================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[map_spDev_FPR_GetDistributors]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[map_spDev_FPR_GetDistributors]
GO

CREATE procedure [dbo].[map_spDev_FPR_GetDistributors](
	@sDate as datetime,
	@eDate as datetime
)
AS

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
 JOIN dbo.tblDocument s ON outlets.Id = s.OrderIssuedOnBehalfOfCC
WHERE 
s.Latitude is not null AND s.Longitude is not null 
AND dist.CostCentreType = 2 
AND salesman.CostCentreType = 4
AND sale.DocumentDateIssued BETWEEN @sDate AND @eDate
AND outlets.Id NOT IN (
	select  ov.OutletId from v_D_OutletVisits ov  
	where ov.OutletId in (
		select o.Id from tblCostCentre d
		   join tblCostCentre s on d.id = s.ParentCostCentreId
		   join tblSalemanRoute sr on sr.SalemanId = s.Id 
		   join tblRoutes rt on sr.RouteId = rt.RouteID
		   join tblCostCentre o on rt.RouteID = o.RouteId
		where d.CostCentreType = 2 and s.CostCentreType = 4 group by o.Id
	)
)   
                        
GO

-- ===================================================================================================================================
-- ===================================================================================================================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[map_spDev_FPR_GetSalesMen]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[map_spDev_FPR_GetSalesMen]
GO

CREATE procedure [dbo].[map_spDev_FPR_GetSalesMen](
	@sDate as datetime,
	@eDate as datetime,
	@uDistributor varchar(200)
)
AS

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
 JOIN dbo.tblDocument s ON outlets.Id = s.OrderIssuedOnBehalfOfCC
WHERE 
s.Latitude is not null AND s.Longitude is not null 
AND dist.CostCentreType = 2 
AND salesman.CostCentreType = 4
AND dist.Id = (case when @uDistributor = 'ALL' then dist.Id else @uDistributor end )
AND sale.DocumentDateIssued BETWEEN @sDate AND @eDate
AND outlets.Id NOT IN (
	select  ov.OutletId from v_D_OutletVisits ov  
	where ov.OutletId in (
		select o.Id from tblCostCentre d
		   join tblCostCentre s on d.id = s.ParentCostCentreId
		   join tblSalemanRoute sr on sr.SalemanId = s.Id 
		   join tblRoutes rt on sr.RouteId = rt.RouteID
		   join tblCostCentre o on rt.RouteID = o.RouteId
		where d.CostCentreType = 2 and s.CostCentreType = 4 group by o.Id
	)
)   
                        
GO

-- ===================================================================================================================================
-- ===================================================================================================================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[map_spDev_FPR_GetRoutes]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[map_spDev_FPR_GetRoutes]
GO

CREATE procedure [dbo].[map_spDev_FPR_GetRoutes](
	@sDate as datetime,
	@eDate as datetime,
	@uDistributor varchar(200),
	@uSalesman varchar(200)
)
AS

SELECT  DISTINCT
		rt.Name AS RouteName,
		rt.RouteId AS RouteId
FROM    dbo.tblDocument AS sale 
 JOIN   dbo.tblLineItems AS saleItems ON sale.Id = saleItems.DocumentID 
 JOIN   dbo.tblCostCentre AS dist ON sale.DocumentIssuerCostCentreId = dist.Id OR sale.DocumentRecipientCostCentre = dist.Id 
 JOIN   dbo.tblCostCentre AS salesman ON sale.DocumentIssuerCostCentreId = salesman.Id OR sale.DocumentRecipientCostCentre = salesman.Id 
 JOIN   dbo.tblCostCentre outlets ON sale.OrderIssuedOnBehalfOfCC = outlets.id
 JOIN   dbo.tblRegion AS reg ON dist.Distributor_RegionId = reg.id 
 JOIN   dbo.tblCountry AS cntry ON reg.Country = cntry.id 
 JOIN   dbo.tblRoutes rt ON outlets.RouteId = rt.RouteID
 JOIN dbo.tblDocument s ON outlets.Id = s.OrderIssuedOnBehalfOfCC
WHERE 
s.Latitude is not null AND s.Longitude is not null 
AND dist.CostCentreType = 2 
AND salesman.CostCentreType = 4
AND dist.Id = (case when @uDistributor = 'ALL' then dist.Id else @uDistributor end )
AND salesman.Id = (case when @uSalesman = 'ALL' then salesman.Id else @uSalesman end )
AND sale.DocumentDateIssued BETWEEN @sDate AND @eDate
AND outlets.Id NOT IN (
	select  ov.OutletId from v_D_OutletVisits ov  
	where ov.OutletId in (
		select o.Id from tblCostCentre d
		   join tblCostCentre s on d.id = s.ParentCostCentreId
		   join tblSalemanRoute sr on sr.SalemanId = s.Id 
		   join tblRoutes rt on sr.RouteId = rt.RouteID
		   join tblCostCentre o on rt.RouteID = o.RouteId
		where d.CostCentreType = 2 and s.CostCentreType = 4 group by o.Id
	)
)   
                        
GO

-- ===================================================================================================================================
-- ===================================================================================================================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[map_spDev_FPR_GetOutlets]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[map_spDev_FPR_GetOutlets]
GO

CREATE procedure [dbo].[map_spDev_FPR_GetOutlets](
	@sDate as datetime,
	@eDate as datetime,
	@uDistributor varchar(200),
	@uSalesman varchar(200),
	@uRoute varchar(200)
)
AS

SELECT 
		outlets.Id AS OutletId,
		outlets.Name AS OutletName
FROM    dbo.tblDocument AS sale 
 JOIN   dbo.tblLineItems AS saleItems ON sale.Id = saleItems.DocumentID 
 JOIN   dbo.tblCostCentre AS dist ON sale.DocumentIssuerCostCentreId = dist.Id OR sale.DocumentRecipientCostCentre = dist.Id 
 JOIN   dbo.tblCostCentre AS salesman ON sale.DocumentIssuerCostCentreId = salesman.Id OR sale.DocumentRecipientCostCentre = salesman.Id 
 JOIN   dbo.tblCostCentre outlets ON sale.OrderIssuedOnBehalfOfCC = outlets.id
 JOIN   dbo.tblRegion AS reg ON dist.Distributor_RegionId = reg.id 
 JOIN   dbo.tblCountry AS cntry ON reg.Country = cntry.id 
 JOIN   dbo.tblRoutes rt ON outlets.RouteId = rt.RouteID
 JOIN dbo.tblDocument s ON outlets.Id = s.OrderIssuedOnBehalfOfCC
WHERE 
s.Latitude is not null AND s.Longitude is not null 
AND dist.CostCentreType = 2 
AND salesman.CostCentreType = 4
AND dist.Id = (case when @uDistributor = 'ALL' then dist.Id else @uDistributor end )
AND salesman.Id = (case when @uSalesman = 'ALL' then salesman.Id else @uSalesman end )
AND rt.RouteId = (case when @uRoute = 'ALL' then rt.RouteId else @uRoute end )
AND sale.DocumentDateIssued BETWEEN @sDate AND @eDate
AND outlets.Id NOT IN (
	select  ov.OutletId from v_D_OutletVisits ov  
	where ov.OutletId in (
		select o.Id from tblCostCentre d
		   join tblCostCentre s on d.id = s.ParentCostCentreId
		   join tblSalemanRoute sr on sr.SalemanId = s.Id 
		   join tblRoutes rt on sr.RouteId = rt.RouteID
		   join tblCostCentre o on rt.RouteID = o.RouteId
		where d.CostCentreType = 2 and s.CostCentreType = 4 group by o.Id
	)
)  --group by outlets.Id , outlets.Name
                        
GO