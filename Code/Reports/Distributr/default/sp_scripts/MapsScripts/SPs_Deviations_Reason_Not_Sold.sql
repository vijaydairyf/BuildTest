IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[map_spDev_RNS_GetPoints]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[map_spDev_RNS_GetPoints]
GO


CREATE procedure [dbo].[map_spDev_RNS_GetPoints](
	@sDate as datetime,
	@eDate as datetime,
	@uDistributor varchar(200),
	@uSalesman varchar(200),
	@uRoute varchar(200),
	@uOutlet varchar(200)
)
AS

SELECT DISTINCT
	   d.id DistributorID,
       d.Name DistributorName,
	   s.Id SalesmanId,
	   s.Name SalesmanName,
	   rt.Name AS RouteName,
	   rt.RouteId AS RouteId,
	   o.Id AS OutletId, 
       o.Name AS OutletName, 
	   dbo.tblOutletVisitReasonType.Name ReasonNotSold, 
       v.DocumentDateIssued AS VisitDate,
	   (select top 1 p.Longitude from dbo.tblDocument p where p.OrderIssuedOnBehalfOfCC = o.Id and Longitude <> '' ) Longitude,
	   (select top 1 p.Latitude from dbo.tblDocument p where p.OrderIssuedOnBehalfOfCC = o.Id and Latitude <> '' ) Latitude
FROM   dbo.tblOutletVisitReasonType 
 JOIN  dbo.tblDocument v ON dbo.tblOutletVisitReasonType.id = v.PaymentDocId 
 JOIN  dbo.tblCostCentre o ON v.OrderIssuedOnBehalfOfCC = o.Id
 JOIN  dbo.tblCostCentre d ON (v.DocumentIssuerCostCentreId = d.id or v.DocumentRecipientCostCentre = d.Id)
 JOIN  dbo.tblCostCentre s ON (v.DocumentIssuerCostCentreId = s.id or v.DocumentRecipientCostCentre = s.Id)
 JOIN  dbo.tblRoutes rt ON o.RouteId = rt.RouteID
WHERE d.CostCentreType = 2 AND s.CostCentreType = 4 
AND CONVERT(nvarchar(26),v.DocumentDateIssued,23) BETWEEN @sDate AND @eDate
AND d.Id = (case when @uDistributor = 'ALL' then d.Id else @uDistributor end )
AND s.Id = (case when @uSalesman = 'ALL' then s.Id else @uSalesman end )
AND rt.RouteID = (case when @uRoute = 'ALL' then rt.RouteID else @uRoute end )
AND o.Id = (case when @uOutlet = 'ALL' then o.Id else @uOutlet end )
--Added to include only those transactions with co-ordinates.
AND v.Latitude IS NOT NULL  AND v.Latitude <> '' AND v.Latitude <> 0
AND v.Longitude IS NOT NULL  AND v.Longitude <> '' AND v.Longitude <> 0


GO

-- ===================================================================================================================================
-- ===================================================================================================================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[map_spDev_RNS_GetDistributors]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[map_spDev_RNS_GetDistributors]
GO

CREATE procedure [dbo].[map_spDev_RNS_GetDistributors](
	@sDate as datetime,
	@eDate as datetime
)
AS

SELECT DISTINCT
	   d.id DistributorID,
       d.Name DistributorName
FROM   dbo.tblOutletVisitReasonType 
 JOIN  dbo.tblDocument v ON dbo.tblOutletVisitReasonType.id = v.PaymentDocId 
 JOIN  dbo.tblCostCentre o ON v.OrderIssuedOnBehalfOfCC = o.Id
 JOIN  dbo.tblCostCentre d ON (v.DocumentIssuerCostCentreId = d.id or v.DocumentRecipientCostCentre = d.Id)
 JOIN  dbo.tblCostCentre s ON (v.DocumentIssuerCostCentreId = s.id or v.DocumentRecipientCostCentre = s.Id)
 JOIN  dbo.tblRoutes rt ON o.RouteId = rt.RouteID
 --JOIN dbo.tblDocument p ON o.Id = p.OrderIssuedOnBehalfOfCC
WHERE d.CostCentreType = 2 AND s.CostCentreType = 4
AND v.Latitude IS NOT NULL  AND v.Latitude <> '' AND v.Latitude <> 0
AND v.Longitude IS NOT NULL  AND v.Longitude <> '' AND v.Longitude <> 0
AND CONVERT(nvarchar(26),v.DocumentDateIssued,23) BETWEEN @sDate AND @eDate
                        
GO

-- ===================================================================================================================================
-- ===================================================================================================================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[map_spDev_RNS_GetSalesMen]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[map_spDev_RNS_GetSalesMen]
GO

CREATE procedure [dbo].[map_spDev_RNS_GetSalesMen](
	@sDate as datetime,
	@eDate as datetime,
	@uDistributor varchar(200)
)
AS

SELECT DISTINCT
	   s.Id SalesmanId,
	   s.Name SalesmanName
FROM   dbo.tblOutletVisitReasonType 
 JOIN  dbo.tblDocument v ON dbo.tblOutletVisitReasonType.id = v.PaymentDocId 
 JOIN  dbo.tblCostCentre o ON v.OrderIssuedOnBehalfOfCC = o.Id
 JOIN  dbo.tblCostCentre d ON (v.DocumentIssuerCostCentreId = d.id or v.DocumentRecipientCostCentre = d.Id)
 JOIN  dbo.tblCostCentre s ON (v.DocumentIssuerCostCentreId = s.id or v.DocumentRecipientCostCentre = s.Id)
 JOIN  dbo.tblRoutes rt ON o.RouteId = rt.RouteID
 --JOIN dbo.tblDocument p ON o.Id = p.OrderIssuedOnBehalfOfCC
WHERE d.CostCentreType = 2 AND s.CostCentreType = 4
AND v.Latitude IS NOT NULL  AND v.Latitude <> '' AND v.Latitude <> 0
AND v.Longitude IS NOT NULL  AND v.Longitude <> '' AND v.Longitude <> 0
AND CONVERT(nvarchar(26),v.DocumentDateIssued,23) BETWEEN @sDate AND @eDate
AND d.Id = (case when @uDistributor = 'ALL' then d.Id else @uDistributor end )
                        
GO

-- ===================================================================================================================================
-- ===================================================================================================================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[map_spDev_RNS_GetRoutes]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[map_spDev_RNS_GetRoutes]
GO

CREATE procedure [dbo].[map_spDev_RNS_GetRoutes](
	@sDate as datetime,
	@eDate as datetime,
	@uDistributor varchar(200),
	@uSalesman varchar(200)
)
AS

SELECT DISTINCT
	   rt.Name AS RouteName,
	   rt.RouteId AS RouteId
FROM   dbo.tblOutletVisitReasonType 
 JOIN  dbo.tblDocument v ON dbo.tblOutletVisitReasonType.id = v.PaymentDocId 
 JOIN  dbo.tblCostCentre o ON v.OrderIssuedOnBehalfOfCC = o.Id
 JOIN  dbo.tblCostCentre d ON (v.DocumentIssuerCostCentreId = d.id or v.DocumentRecipientCostCentre = d.Id)
 JOIN  dbo.tblCostCentre s ON (v.DocumentIssuerCostCentreId = s.id or v.DocumentRecipientCostCentre = s.Id)
 JOIN  dbo.tblRoutes rt ON o.RouteId = rt.RouteID
 --JOIN dbo.tblDocument p ON o.Id = p.OrderIssuedOnBehalfOfCC
WHERE d.CostCentreType = 2 AND s.CostCentreType = 4
AND v.Latitude IS NOT NULL  AND v.Latitude <> '' AND v.Latitude <> 0
AND v.Longitude IS NOT NULL  AND v.Longitude <> '' AND v.Longitude <> 0
AND CONVERT(nvarchar(26),v.DocumentDateIssued,23) BETWEEN @sDate AND @eDate
AND d.Id = (case when @uDistributor = 'ALL' then d.Id else @uDistributor end )
AND s.Id = (case when @uSalesman = 'ALL' then s.Id else @uSalesman end )
                        
GO

-- ===================================================================================================================================
-- ===================================================================================================================================

IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[map_spDev_RNS_GetOutlets]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[map_spDev_RNS_GetOutlets]
GO

CREATE procedure [dbo].[map_spDev_RNS_GetOutlets](
	@sDate as datetime,
	@eDate as datetime,
	@uDistributor varchar(200),
	@uSalesman varchar(200),
	@uRoute varchar(200)
)
AS
SELECT DISTINCT
	   o.Id AS OutletId, 
       o.Name AS OutletName
FROM   dbo.tblOutletVisitReasonType 
 JOIN  dbo.tblDocument v ON dbo.tblOutletVisitReasonType.id = v.PaymentDocId 
 JOIN  dbo.tblCostCentre o ON v.OrderIssuedOnBehalfOfCC = o.Id
 JOIN  dbo.tblCostCentre d ON (v.DocumentIssuerCostCentreId = d.id or v.DocumentRecipientCostCentre = d.Id)
 JOIN  dbo.tblCostCentre s ON (v.DocumentIssuerCostCentreId = s.id or v.DocumentRecipientCostCentre = s.Id)
 JOIN  dbo.tblRoutes rt ON o.RouteId = rt.RouteID
 JOIN dbo.tblDocument p ON o.Id = p.OrderIssuedOnBehalfOfCC
WHERE d.CostCentreType = 2 AND s.CostCentreType = 4
AND v.Latitude IS NOT NULL AND v.Latitude <>'' AND v.Latitude <> 0
AND v.Longitude IS NOT NULL AND v.Longitude <>'' AND v.Longitude <> 0
AND CONVERT(nvarchar(26),v.DocumentDateIssued,23)  BETWEEN @sDate AND @eDate
AND d.Id = (case when @uDistributor = 'ALL' then d.Id else @uDistributor end )
AND s.Id = (case when @uSalesman = 'ALL' then s.Id else @uSalesman end )
AND rt.RouteID = (case when @uRoute = 'ALL' then rt.RouteID else @uRoute end )
                        
GO