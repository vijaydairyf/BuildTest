/****** Object:  StoredProcedure [dbo].[map_spGetSalesPoints]    Script Date: 11/12/2014 10:39:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[map_spGetSalesPoints]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[map_spGetSalesPoints]
GO

CREATE procedure [dbo].[map_spGetSalesPoints](
	@sDate as datetime,
	@eDate as datetime,
	@uDistributor varchar(200),
	@uSalesman varchar(200),
	@uRoute varchar(200),
	@uOutlet varchar(200)
)
as 

SELECT ResultID , DistributorId ,Distributor ,OutletId ,Outlet ,
	sum(SaleAmount) SaleAmount ,DocumentReference ,DocumentDateIssued ,
	Latitude ,Longitude ,RouteID ,Route ,Salesman ,SalesmanID ,SalesmanTypeID ,RouteIDroutesTable ,
	sum(ProductDiscount) ProductDiscount ,
	Region ,Country ,sum(SaleDiscount) SaleDiscount,sum(TotalProductDiscount) TotalProductDiscount
FROM tLocationResults
WHERE (Latitude <> '' and Longitude <> '')
AND DistributorId = (case when @uDistributor = 'ALL' then DistributorId else @uDistributor end )
AND SalesmanID = (case when @uSalesman = 'ALL' then SalesmanID else @uSalesman end )
AND RouteID = (case when @uRoute = 'ALL' then RouteID else @uRoute end )
AND OutletId = (case when @uOutlet = 'ALL' then OutletId else @uOutlet end )
AND DocumentDateIssued between @sDate and @eDate
group by 
	ResultID , DistributorId ,Distributor ,OutletId ,Outlet,DocumentReference ,DocumentDateIssued ,
	Latitude ,Longitude ,RouteID ,Route ,Salesman ,SalesmanID ,SalesmanTypeID ,RouteIDroutesTable ,
	Region ,Country 
order by DocumentDateIssued asc
GO


/****** Object:  StoredProcedure [dbo].[map_spGetSalesMen]    Script Date: 11/12/2014 10:39:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[map_spGetSalesMen]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[map_spGetSalesMen]
GO


CREATE procedure [dbo].[map_spGetSalesMen](
	@sDate as datetime,
	@eDate as datetime,
	@uDistributor varchar(200)
)
as 


SELECT distinct [Salesman] , [SalesmanID] FROM tLocationResults
where (Latitude <> '' and Longitude <> '')
AND DistributorId = (case when @uDistributor = 'ALL' then DistributorId else @uDistributor end )
AND DocumentDateIssued between @sDate and @eDate
GO


/****** Object:  StoredProcedure [dbo].[map_spGetRoutes]   Script Date: 11/12/2014 10:39:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[map_spGetRoutes]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[map_spGetRoutes]
GO


CREATE procedure [dbo].[map_spGetRoutes](
	@sDate as datetime,
	@eDate as datetime,
	@uDistributor varchar(200),
	@uSalesman varchar(200)
)
as 

SELECT distinct [RouteID] ,[Route] FROM tLocationResults
where (Latitude <> '' and Longitude <> '')
AND DistributorId = (case when @uDistributor = 'ALL' then DistributorId else @uDistributor end )
AND SalesmanID = (case when @uSalesman = 'ALL' then SalesmanID else @uSalesman end )
AND DocumentDateIssued between @sDate and @eDate
GO

/****** Object:  StoredProcedure [dbo].[map_spGetOutletTransactions]    Script Date: 11/12/2014 10:39:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[map_spGetOutletTransactions]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[map_spGetOutletTransactions]
GO


CREATE procedure [dbo].[map_spGetOutletTransactions](
	@sDate as datetime,
	@eDate as datetime,
	@sResultID varchar(200)
)
as
 
-- ResultID = Outlet ID 

SELECT ROW_NUMBER() OVER (ORDER BY DocumentDateIssued ASC) as row , ResultID , SaleAmount , DocumentReference , DocumentDateIssued , 
Outlet , Salesman ,
SaleDiscount , ProductDiscount from dbo.tLocationResults
where (Latitude <> '' and Longitude <> '')
AND ResultID = @sResultID
AND DocumentDateIssued between @sDate and @eDate
GO


/****** Object:  StoredProcedure [dbo].[map_spGetOutlets]    Script Date: 11/12/2014 10:39:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[map_spGetOutlets]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[map_spGetOutlets]
GO

CREATE procedure [dbo].[map_spGetOutlets](
	@sDate as datetime,
	@eDate as datetime,
	@uDistributor varchar(200),
	@uSalesman varchar(200),
	@uRoute varchar(200)
)
as 

SELECT distinct [OutletId] ,[Outlet] FROM tLocationResults
WHERE (Latitude <> '' and Longitude <> '')
AND DistributorId = (case when @uDistributor = 'ALL' then DistributorId else @uDistributor end )
AND SalesmanID = (case when @uSalesman = 'ALL' then SalesmanID else @uSalesman end )
AND RouteID = (case when @uRoute = 'ALL' then RouteID else @uRoute end )
AND DocumentDateIssued between @sDate and @eDate
GO


/****** Object:  StoredProcedure [dbo].[map_spGetOutlets]    Script Date: 11/12/2014 10:39:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[map_spGetDistributors]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[map_spGetDistributors]
GO


CREATE procedure [dbo].[map_spGetDistributors](
	@sDate as datetime,
	@eDate as datetime
)
as 


SELECT distinct [DistributorId] ,[Distributor] FROM tLocationResults
where (Latitude <> '' and Longitude <> '')
AND DocumentDateIssued between @sDate and @eDate
GO




/****** Object:  StoredProcedure [dbo].[map_spGetOutlets]    Script Date: 11/12/2014 10:39:45 ******/
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[map_spCache]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[map_spCache]
GO


CREATE procedure [dbo].[map_spCache]
as 


IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tLocationResults]') AND type in (N'U'))
BEGIN
	SELECT * INTO tLocationResults from vLocationResults
	CREATE INDEX index_cache_date ON tLocationResults (DocumentReference)
	CREATE INDEX index_cache_resid ON tLocationResults (ResultID)
	CREATE INDEX index_cache_dist ON tLocationResults ([DistributorId])
	CREATE INDEX index_cache_salesman ON tLocationResults ([SalesmanID])
	CREATE INDEX index_cache_route ON tLocationResults ([RouteID])
END

IF EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[tLocationResults]') AND type in (N'U'))
BEGIN
INSERT INTO tLocationResults(
		  [Row]
	  ,[ResultID]
      ,[DistributorId]
      ,[Distributor]
      ,[OutletId]
      ,[Outlet]
      ,[SaleAmount]
      ,[DocumentReference]
      ,[DocumentDateIssued]
      ,[Latitude]
      ,[Longitude]
      ,[RouteID]
      ,[Route]
      ,[Salesman]
      ,[SalesmanID]
      ,[SalesmanTypeID]
      ,[RouteIDroutesTable]
      ,[ProductDiscount]
      ,[Region]
      ,[Country]
      ,[SaleDiscount]
      ,[TotalProductDiscount]
)

SELECT [Row]
	  ,[ResultID]
      ,[DistributorId]
      ,[Distributor]
      ,[OutletId]
      ,[Outlet]
      ,[SaleAmount]
      ,[DocumentReference]
      ,[DocumentDateIssued]
      ,[Latitude]
      ,[Longitude]
      ,[RouteID]
      ,[Route]
      ,[Salesman]
      ,[SalesmanID]
      ,[SalesmanTypeID]
      ,[RouteIDroutesTable]
      ,[ProductDiscount]
      ,[Region]
      ,[Country]
      ,[SaleDiscount]
      ,[TotalProductDiscount]
  FROM [vLocationResults] v where v.[Row] > (select isnull(max([Row]),0) from tLocationResults)
 END
  
GO

execute [map_spCache]
GO