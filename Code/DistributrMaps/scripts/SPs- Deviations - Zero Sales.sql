/****** Object:  StoredProcedure [dbo].[map_spGetPoints_DevZeroSales]    Script Date: 11/12/2014 10:39:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[map_spDev_ZS_GetPoints]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[map_spDev_ZS_GetPoints]
GO


CREATE procedure [dbo].[map_spDev_ZS_GetPoints](
	@uDistributor varchar(200),
	@uSalesman varchar(200),
	@uRoute varchar(200),
	@uOutlet varchar(200),
	@sDate datetime,
	@eDate datetime
)
AS 
SELECT     dist.Id AS DistributorId, 
           dist.Name AS DistributorName,
		   sm.id SalesmanId,
		   sm.Name SalesmanName,
		   routes.RouteID AS RouteId, 
           routes.Name AS RouteName, 
           outlets.Id AS OutletId, 
           outlets.Name AS OutletName, 
           outlets.CostCentreType AS OutletCctype, 
		   s.Longitude,
		   s.Latitude
FROM    dbo.tblCostCentre outlets
 JOIN   dbo.tblRoutes routes ON outlets.RouteId = routes.RouteID 
 JOIN   dbo.tblSalemanRoute sr on routes.RouteID = sr.RouteId
 JOIN   dbo.tblCostCentre sm on sr.SalemanId = sm.Id
 JOIN   dbo.tblCostCentre AS dist ON outlets.ParentCostCentreId = dist.Id 
 JOIN   dbo.tblDocument s ON outlets.Id = s.OrderIssuedOnBehalfOfCC
WHERE (outlets.CostCentreType = 5)
	AND dist.Id = (case when @uDistributor = 'ALL' then dist.Id else @uDistributor end )
	AND sm.Id = (case when @uSalesman = 'ALL' then sm.Id else @uSalesman end )
	AND routes.RouteID = (case when @uRoute = 'ALL' then routes.RouteID else @uRoute end )
	AND outlets.Id = (case when @uOutlet = 'ALL' then outlets.Id else @uOutlet end )
	AND s.Longitude is not null 
	AND s.Latitude is not null 
	AND (s.Longitude  <> 0 or s.Latitude <> 0)
	AND(outlets.Id NOT IN(
		SELECT dbo.tblDocument.OrderIssuedOnBehalfOfCC
		FROM dbo.tblDocument INNER JOIN
		dbo.tblLineItems as line ON dbo.tblDocument.Id = line.DocumentID
		WHERE (dbo.tblDocument.DocumentTypeId = 1)
		AND  convert(nvarchar(26),dbo.tblDocument.DocumentDateIssued,23) between @sDate and @eDate
		AND ((dbo.tblDocument.OrderOrderTypeId = 1)OR(dbo.tblDocument.OrderOrderTypeId = 3 AND dbo.tblDocument.DocumentStatusId = 99))))   
                        
GO


-- ===================================================================================================================================
-- ===================================================================================================================================


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[map_spDev_ZeroSales_GetDistributors]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[map_spDev_ZeroSales_GetDistributors]
GO

CREATE procedure [dbo].[map_spDev_ZeroSales_GetDistributors]
as 

SELECT  distinct tblCostCentre_1.Id AS DistributorId, 
           tblCostCentre_1.Name AS DistributorName
FROM
	dbo.tblCostCentre INNER JOIN
	dbo.tblRoutes ON dbo.tblCostCentre.RouteId = dbo.tblRoutes.RouteID INNER JOIN
	dbo.tblCostCentre AS tblCostCentre_1 ON dbo.tblCostCentre.ParentCostCentreId = tblCostCentre_1.Id INNER JOIN
	dbo.tblDocument s ON dbo.tblCostCentre.Id = s.OrderIssuedOnBehalfOfCC
WHERE     (dbo.tblCostCentre.CostCentreType = 5)
	AND s.Longitude is not null 
	AND s.Latitude is not null 
	AND (s.Longitude  <> 0 or s.Latitude <> 0)
AND(dbo.tblCostCentre.Id NOT IN(
	SELECT dbo.tblDocument.OrderIssuedOnBehalfOfCC
	FROM dbo.tblDocument INNER JOIN
	dbo.tblLineItems as line ON dbo.tblDocument.Id = line.DocumentID
	WHERE (dbo.tblDocument.DocumentTypeId = 1)
	AND ((dbo.tblDocument.OrderOrderTypeId = 1)OR(dbo.tblDocument.OrderOrderTypeId = 3 AND dbo.tblDocument.DocumentStatusId = 99)))
)   
                        
GO

-- ===================================================================================================================================
-- ===================================================================================================================================


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[map_spDev_ZeroSales_GetRoutes]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[map_spDev_ZeroSales_GetRoutes]
GO

CREATE procedure [dbo].[map_spDev_ZeroSales_GetRoutes](
	@uDistributor varchar(200)
)
as 

SELECT  distinct
           dbo.tblRoutes.RouteID AS RouteId, 
           dbo.tblRoutes.Name AS RouteName
FROM
	dbo.tblCostCentre INNER JOIN
	dbo.tblRoutes ON dbo.tblCostCentre.RouteId = dbo.tblRoutes.RouteID INNER JOIN
	dbo.tblCostCentre AS tblCostCentre_1 ON dbo.tblCostCentre.ParentCostCentreId = tblCostCentre_1.Id INNER JOIN
	dbo.tblDocument s ON dbo.tblCostCentre.Id = s.OrderIssuedOnBehalfOfCC
WHERE     (dbo.tblCostCentre.CostCentreType = 5)
AND tblCostCentre_1.Id = (case when @uDistributor = 'ALL' then tblCostCentre_1.Id else @uDistributor end )
	AND s.Longitude is not null 
	AND s.Latitude is not null 
	AND (s.Longitude  <> 0 or s.Latitude <> 0)
AND(dbo.tblCostCentre.Id NOT IN(
	SELECT dbo.tblDocument.OrderIssuedOnBehalfOfCC
	FROM dbo.tblDocument INNER JOIN
	dbo.tblLineItems as line ON dbo.tblDocument.Id = line.DocumentID
	WHERE (dbo.tblDocument.DocumentTypeId = 1)
	AND ((dbo.tblDocument.OrderOrderTypeId = 1)OR(dbo.tblDocument.OrderOrderTypeId = 3 AND dbo.tblDocument.DocumentStatusId = 99)))
)   
                        
GO

-- ===================================================================================================================================
-- ===================================================================================================================================


IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[map_spDev_ZeroSales_GetOutlets]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[map_spDev_ZeroSales_GetOutlets]
GO

CREATE procedure [dbo].[map_spDev_ZeroSales_GetOutlets](
	@uDistributor varchar(200),
	@uRoute varchar(200)
)
as 

SELECT  distinct 
		dbo.tblCostCentre.Id AS OutletId, 
        dbo.tblCostCentre.Name AS OutletName
FROM
	dbo.tblCostCentre INNER JOIN
	dbo.tblRoutes ON dbo.tblCostCentre.RouteId = dbo.tblRoutes.RouteID INNER JOIN
	dbo.tblCostCentre AS tblCostCentre_1 ON dbo.tblCostCentre.ParentCostCentreId = tblCostCentre_1.Id INNER JOIN
	dbo.tblDocument s ON dbo.tblCostCentre.Id = s.OrderIssuedOnBehalfOfCC
WHERE     (dbo.tblCostCentre.CostCentreType = 5)
AND tblCostCentre_1.Id = (case when @uDistributor = 'ALL' then tblCostCentre_1.Id else @uDistributor end )
AND dbo.tblRoutes.RouteID = (case when @uRoute = 'ALL' then dbo.tblRoutes.RouteID else @uRoute end )
	AND s.Longitude is not null 
	AND s.Latitude is not null 
	AND (s.Longitude  <> 0 or s.Latitude <> 0)
AND(dbo.tblCostCentre.Id NOT IN(
	SELECT dbo.tblDocument.OrderIssuedOnBehalfOfCC
	FROM dbo.tblDocument INNER JOIN
	dbo.tblLineItems as line ON dbo.tblDocument.Id = line.DocumentID
	WHERE (dbo.tblDocument.DocumentTypeId = 1)
	AND ((dbo.tblDocument.OrderOrderTypeId = 1)OR(dbo.tblDocument.OrderOrderTypeId = 3 AND dbo.tblDocument.DocumentStatusId = 99)))
)   
                        
GO