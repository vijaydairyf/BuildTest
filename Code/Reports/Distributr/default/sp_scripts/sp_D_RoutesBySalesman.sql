
/****** Object:  StoredProcedure [dbo].[sp_D_RoutesBySalesman]    Script Date: 08/19/2013 11:00:45 ******/
DROP PROCEDURE [dbo].[sp_D_RoutesBySalesman]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_D_RoutesBySalesman]
(
@startDate as date,
@endDate as date,
@salesmanId AS NVARCHAR(50),
@routeId AS NVARCHAR(50)
)

AS
if  ltrim(rtrim(@salesmanId))='ALL'  begin set @salesmanId='%' end
if  ltrim(rtrim(@routeId))='ALL'  begin set @routeId='%' end


SELECT     dbo.tblCostCentre.Id AS salesmanId,
            dbo.tblCostCentre.Name AS salesman,
             dbo.tblCostCentre.CostCentreType AS ccSalesman, 
              dbo.tblRoutes.RouteID AS routeId, 
                dbo.tblRoutes.Name AS route, 
                 dbo.tblRoutes.Code,
                  dbo.tblRoutes.IM_DateCreated AS creationDate,
                   dbo.tblRoutes.IM_DateLastUpdated, 
                    dbo.tblRoutes.IM_Status,
                     @startDate as startDate,
                      @endDate as endDate
                    
FROM         dbo.tblSalemanRoute INNER JOIN
                      dbo.tblCostCentre ON dbo.tblSalemanRoute.SalemanId = dbo.tblCostCentre.Id INNER JOIN
                      dbo.tblRoutes ON dbo.tblSalemanRoute.RouteId = dbo.tblRoutes.RouteID AND dbo.tblSalemanRoute.RouteId = dbo.tblRoutes.RouteID
                      
WHERE     (dbo.tblCostCentre.CostCentreType = 4)
          AND ( Convert(nvarchar(26),dbo.tblRoutes.IM_DateLastUpdated,23) BETWEEN @startDate AND @endDate)
           AND(CONVERT(NVARCHAR(50), dbo.tblCostCentre.Id)LIKE ISNULL(@salesmanId, N'%'))
            AND(CONVERT(NVARCHAR(50), dbo.tblRoutes.RouteID)LIKE ISNULL (@routeId, N'%')) 