
/****** Object:  View [dbo].[vLocationResults]    Script Date: 07/18/2014 14:01:08 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
DROP VIEW [dbo].[vLocationResults]
GO
CREATE VIEW [dbo].[vLocationResults]
AS
SELECT     TOP (100) PERCENT ROW_NUMBER() OVER (ORDER BY sales.DocumentDateIssued ASC) AS Row,outlet.Id as ResultID, 
             dist.Id AS DistributorId, dist.Name AS Distributor, 
             outlet.Id AS OutletId, outlet.Name AS Outlet, 
			 salesItems.Quantity * (salesItems.Value + salesItems.Vat) AS SaleAmount, 
			 sales.DocumentReference, 
             sales.DocumentDateIssued, 
             isnull(sales.Latitude, '') AS Latitude, 
             isnull(sales.Longitude, '') AS Longitude,
             rt.RouteID AS RouteID,rt.Name AS Route, 
			 salesman.Name AS Salesman, salesman.Id AS SalesmanID, salesman.CostCentreType AS SalesmanTypeID, 
			 rt.RouteID AS RouteIDroutesTable,
			 salesItems.ProductDiscount, 
			 reg.Name AS Region, 
			 cntry.Name AS Country, 
			 sales.SaleDiscount, 
             salesItems.ProductDiscount * salesItems.Quantity AS TotalProductDiscount
FROM     dbo.tblDocument sales
JOIN     dbo.tblLineItems salesItems ON sales.Id = salesItems.DocumentID
JOIN     dbo.tblCostCentre dist ON sales.DocumentIssuerCostCentreId = dist.Id OR sales.DocumentRecipientCostCentre = dist.Id
JOIN     dbo.tblCostCentre salesman ON sales.DocumentIssuerCostCentreId = salesman.Id OR sales.DocumentRecipientCostCentre = salesman.Id
JOIN     dbo.tblCostCentre outlet ON sales.OrderIssuedOnBehalfOfCC = outlet.Id
JOIN     dbo.tblRoutes rt ON outlet.RouteId = rt.RouteID
JOIN     dbo.tblRegion reg ON rt.RegionId = reg.id
JOIN     dbo.tblCountry cntry ON reg.Country = cntry.id

WHERE     sales.DocumentTypeId = 1
	--AND  (sales.OrderOrderTypeId = 1 OR (sales.OrderOrderTypeId = 3 AND sales.DocumentStatusId = 99))
	AND   dist.CostCentreType = 2 AND salesman.CostCentreType = 4 AND outlet.CostCentreType = 5
ORDER BY sales.DocumentDateIssued

GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPane1', @value=N'[0E232FF0-B466-11cf-A24F-00AA00A3EFFF, 1.00]
Begin DesignProperties = 
   Begin PaneConfigurations = 
      Begin PaneConfiguration = 0
         NumPanes = 4
         Configuration = "(H (1[13] 4[13] 2[55] 3) )"
      End
      Begin PaneConfiguration = 1
         NumPanes = 3
         Configuration = "(H (1 [50] 4 [25] 3))"
      End
      Begin PaneConfiguration = 2
         NumPanes = 3
         Configuration = "(H (1 [50] 2 [25] 3))"
      End
      Begin PaneConfiguration = 3
         NumPanes = 3
         Configuration = "(H (4 [30] 2 [40] 3))"
      End
      Begin PaneConfiguration = 4
         NumPanes = 2
         Configuration = "(H (1 [56] 3))"
      End
      Begin PaneConfiguration = 5
         NumPanes = 2
         Configuration = "(H (2 [66] 3))"
      End
      Begin PaneConfiguration = 6
         NumPanes = 2
         Configuration = "(H (4 [50] 3))"
      End
      Begin PaneConfiguration = 7
         NumPanes = 1
         Configuration = "(V (3))"
      End
      Begin PaneConfiguration = 8
         NumPanes = 3
         Configuration = "(H (1[56] 4[18] 2) )"
      End
      Begin PaneConfiguration = 9
         NumPanes = 2
         Configuration = "(H (1 [75] 4))"
      End
      Begin PaneConfiguration = 10
         NumPanes = 2
         Configuration = "(H (1[66] 2) )"
      End
      Begin PaneConfiguration = 11
         NumPanes = 2
         Configuration = "(H (4 [60] 2))"
      End
      Begin PaneConfiguration = 12
         NumPanes = 1
         Configuration = "(H (1) )"
      End
      Begin PaneConfiguration = 13
         NumPanes = 1
         Configuration = "(V (4))"
      End
      Begin PaneConfiguration = 14
         NumPanes = 1
         Configuration = "(V (2))"
      End
      ActivePaneConfig = 0
   End
   Begin DiagramPane = 
      Begin Origin = 
         Top = 0
         Left = 0
      End
      Begin Tables = 
      End
   End
   Begin SQLPane = 
   End
   Begin DataPane = 
      Begin ParameterDefaults = ""
      End
      Begin ColumnWidths = 12
         Width = 284
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
         Width = 1500
      End
   End
   Begin CriteriaPane = 
      Begin ColumnWidths = 11
         Column = 1440
         Alias = 900
         Table = 1170
         Output = 720
         Append = 1400
         NewValue = 1170
         SortType = 1350
         SortOrder = 1410
         GroupBy = 1350
         Filter = 1350
         Or = 1350
         Or = 1350
         Or = 1350
      End
   End
End
' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vLocationResults'
GO
EXEC sys.sp_addextendedproperty @name=N'MS_DiagramPaneCount', @value=1 , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'VIEW',@level1name=N'vLocationResults'
GO
/****** Object:  StoredProcedure [dbo].[map_spGetSalesMen]    Script Date: 07/18/2014 14:01:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
DROP PROCEDURE [dbo].[map_spGetSalesMen]
GO
CREATE procedure [dbo].[map_spGetSalesMen](
	@sDate as datetime,
	@eDate as datetime,
	@uDistributor varchar(200)
)
as 


SELECT distinct [Salesman] , [SalesmanID] FROM [vLocationResults]
WHERE   Longitude <> '' AND Longitude <> 0 AND Longitude IS NOT NULL
	AND Latitude <> '' AND Latitude <> 0 AND Latitude IS NOT NULL
	AND DistributorId = (case when @uDistributor = 'ALL' then DistributorId else @uDistributor end )
	AND DocumentDateIssued between @sDate and @eDate
GO
/****** Object:  StoredProcedure [dbo].[map_spGetRoutes]    Script Date: 07/18/2014 14:01:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
DROP PROCEDURE [dbo].[map_spGetRoutes]
GO
CREATE procedure [dbo].[map_spGetRoutes](
	@sDate as datetime,
	@eDate as datetime,
	@uDistributor varchar(200),
	@uSalesman varchar(200)
)
as 

SELECT distinct [RouteID] ,[Route] FROM [vLocationResults]
WHERE   Longitude <> '' AND Longitude <> 0 AND Longitude IS NOT NULL
	AND Latitude <> '' AND Latitude <> 0 AND Latitude IS NOT NULL
	AND DistributorId = (case when @uDistributor = 'ALL' then DistributorId else @uDistributor end )
	AND SalesmanID = (case when @uSalesman = 'ALL' then SalesmanID else @uSalesman end )
	AND DocumentDateIssued between @sDate and @eDate
GO
/****** Object:  StoredProcedure [dbo].[map_spGetOutletTransactions]    Script Date: 07/18/2014 14:01:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
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
SaleDiscount , ProductDiscount from dbo.vLocationResults
WHERE   Longitude <> '' AND Longitude <> 0 AND Longitude IS NOT NULL
	AND Latitude <> '' AND Latitude <> 0 AND Latitude IS NOT NULL
	AND ResultID = @sResultID
	AND DocumentDateIssued between @sDate and @eDate
GO
/****** Object:  StoredProcedure [dbo].[map_spGetDistributors]    Script Date: 07/18/2014 14:01:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
DROP PROCEDURE [dbo].[map_spGetDistributors]
GO
CREATE procedure [dbo].[map_spGetDistributors](
	@sDate as datetime,
	@eDate as datetime
)
as 


SELECT distinct [DistributorId] ,[Distributor] FROM [vLocationResults]
WHERE   Longitude <> '' AND Longitude <> 0 AND Longitude IS NOT NULL
	AND Latitude <> '' AND Latitude <> 0 AND Latitude IS NOT NULL
	AND DocumentDateIssued between @sDate and @eDate
GO
/****** Object:  StoredProcedure [dbo].[map_GetSalesPoints]    Script Date: 07/18/2014 14:01:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
DROP PROCEDURE [dbo].[map_GetSalesPoints]
GO
CREATE procedure [dbo].[map_GetSalesPoints](
	@sDate as datetime,
	@eDate as datetime,
	@uDistributor varchar(200),
	@uSalesman varchar(200),
	@uRoute varchar(200),
	@uOutlet varchar(200)
)
as 

SELECT ResultID , DistributorId ,Distributor ,OutletId ,Outlet ,SaleAmount ,DocumentReference ,DocumentDateIssued ,
Latitude ,Longitude ,RouteID ,Route ,Salesman ,SalesmanID ,SalesmanTypeID ,RouteIDroutesTable ,
ProductDiscount ,Region ,Country ,SaleDiscount ,TotalProductDiscount
FROM vLocationResults
WHERE   Longitude <> '' AND Longitude <> 0 AND Longitude IS NOT NULL
	AND Latitude <> '' AND Latitude <> 0 AND Latitude IS NOT NULL
	AND DistributorId = (case when @uDistributor = 'ALL' then DistributorId else @uDistributor end )
	AND SalesmanID = (case when @uSalesman = 'ALL' then SalesmanID else @uSalesman end )
	AND RouteID = (case when @uRoute = 'ALL' then RouteID else @uRoute end )
	AND OutletId = (case when @uOutlet = 'ALL' then OutletId else @uOutlet end )
	AND DocumentDateIssued between @sDate and @eDate
order by DocumentDateIssued asc
GO
/****** Object:  StoredProcedure [dbo].[map_GetOutlets]    Script Date: 07/18/2014 14:01:09 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
DROP PROCEDURE [dbo].[map_GetOutlets]
GO
CREATE procedure [dbo].[map_GetOutlets](
	@sDate as datetime,
	@eDate as datetime,
	@uDistributor varchar(200),
	@uSalesman varchar(200),
	@uRoute varchar(200)
)
as 

SELECT distinct [OutletId] ,[Outlet] 
FROM [vLocationResults]
WHERE   Longitude <> '' AND Longitude <> 0 AND Longitude IS NOT NULL
	AND Latitude <> '' AND Latitude <> 0 AND Latitude IS NOT NULL
	AND DistributorId = (case when @uDistributor = 'ALL' then DistributorId else @uDistributor end )
	AND SalesmanID = (case when @uSalesman = 'ALL' then SalesmanID else @uSalesman end )
	AND RouteID = (case when @uRoute = 'ALL' then RouteID else @uRoute end )
	AND DocumentDateIssued between @sDate and @eDate
GO
