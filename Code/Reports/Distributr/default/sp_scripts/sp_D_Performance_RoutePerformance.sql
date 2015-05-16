DROP PROCEDURE [dbo].[sp_D_Performance_RoutePerformance]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [sp_D_Performance_RoutePerformance]
(
@countryId AS NVARCHAR(50),
@regionId AS NVARCHAR(50),
@distributorId AS NVARCHAR(50),
@salesmanId AS NVARCHAR(50),
@routeId AS NVARCHAR(50),
@outletId AS NVARCHAR(50),
@targetPeriodId AS NVARCHAR(50)
)
AS
if LTRIM(RTRIM(@countryId))='ALL' begin set @countryId='%' end
if LTRIM(RTRIM(@regionId))='ALL' begin set @regionId='%' end
if LTRIM(RTRIM(@distributorId))='ALL' begin set @distributorId='%' end
if LTRIM(RTRIM(@salesmanId))='ALL' begin set @salesmanId='%' end
if LTRIM(RTRIM(@routeId ))='ALL' begin set @routeId ='%' end
if LTRIM(RTRIM(@outletId))='ALL' begin set @outletId='%' end
if LTRIM(RTRIM(@targetPeriodId))='ALL' begin set @targetPeriodId='%' end

DECLARE @CCID nvarchar(50),
        @OutletName nvarchar(50),
        @TargetPeriodIds nvarchar(50),
        @TargetPeriodName nvarchar(50),
        @TargetStartDate date,
        @TargetEndDate date,
        @TargetQuantity decimal(18,2),
        @TargetAmount decimal(18,2),
        @SalesQuantity decimal(18,2),
        @SalesAmount decimal(18,2),
        @IsQtyTarget int,
        @RouteName nvarchar(50),
        @RouteIds  nvarchar(50),
        @RegionName nvarchar(50),
        @RegionIds  nvarchar(50),
        @CountryName nvarchar(50),
        @CountryIds  nvarchar(50),
     --   @DistributorName nvarchar(50),
        @DistributorIds nvarchar(50),
    --    @SalesmanName nvarchar(50),
        @SalesmanIds nvarchar(50)

        
DECLARE @Table_Targets TABLE (
        CCID nvarchar(50),
        OutletName nvarchar(50),
        TargetPeriodIds nvarchar(50),
        TargetPeriodName nvarchar(50),
        TargetStartDate date,
        TargetEndDate date,
        TargetQuantity decimal(18,2),
        TargetAmount decimal(18,2),
        SalesQuantity decimal(18,2),
        SalesAmount decimal(18,2),
        IsQtyTarget int,
        RouteName nvarchar(50),
        RouteIds nvarchar(50),   
        RegionName nvarchar(50),
        RegionIds  nvarchar(50),
        CountryName nvarchar(50),
        CountryIds  nvarchar(50),
 --       DistributorName nvarchar(50),
        DistributorIds nvarchar(50),
 --       SalesmanName nvarchar(50),
        SalesmanIds nvarchar(50)

 );
DECLARE @SalesTable TABLE(CostCenterId nvarchar(50),
                          SalesQty decimal(18,2),
                          SalesAmt decimal(18,2)
                          );
                          
 DECLARE targets_cursor CURSOR FOR
 SELECT    t.CostCentreId targetCCid,
           cc.Name,
           tp.Id targetPeriodId, 
           tp.Name targetPeriodName, 
           tp.StartDate tpStartDate, 
           tp.EndDate tpEndDate, 
           case when  t.IsQuantityTarget = 1 then t.TargetValue else 0 end as QuantityTarget,
           case when  t.IsQuantityTarget = 0 then t.TargetValue else 0 end as AmountTarget,
           t.IsQuantityTarget IsQtyTarget,
           rt.Name,
           rt.RouteID,
           reg.Name,
           reg.id,
           country.Name,
           country.id,
           cc.ParentCostCentreId,
           sr.SalemanId 
          
 FROM       dbo.tblTargetPeriod tp
 INNER JOIN dbo.tblTarget t ON tp.Id = t.PeriodId
 INNER JOIN dbo.tblCostCentre cc ON t.CostCentreId = cc.Id
 INNER JOIN dbo.tblRoutes rt on rt.RouteID = cc.RouteId
 INNER JOIN dbo.tblRegion reg on rt.RegionId = reg.id
 INNER JOIN dbo.tblCountry country on reg.Country = country.id
 INNER JOIN dbo.tblSalemanRoute  sr on rt.RouteID = sr.RouteId
 
 WHERE cc.CostCentreType = 5
 
OPEN targets_cursor
FETCH NEXT FROM targets_cursor
INTO    @CCID,
        @OutletName,
        @TargetPeriodIds,
        @TargetPeriodName,
        @TargetStartDate,
        @TargetEndDate,
        @TargetQuantity,
        @TargetAmount,
        @IsQtyTarget, 
        @RouteName,
        @RouteIds ,
        @RegionName,
        @RegionIds,
        @CountryName,
        @CountryIds,
   --     @DistributorName ,
        @DistributorIds ,
   --     @SalesmanName ,
        @SalesmanIds 


        
WHILE @@FETCH_STATUS = 0  
BEGIN
INSERT @SalesTable
        SELECT outlet.Id,
               CASE WHEN @IsQtyTarget=1 THEN SUM(salesItems.Quantity) ELSE 0 END AS saleQty,
               CASE WHEN @IsQtyTarget=0 THEN SUM(salesItems.Quantity *(salesItems.Value+salesItems.Vat)) ELSE 0 END AS saleAmount 
        FROM        dbo.tblDocument sales 
           INNER JOIN  dbo.tblLineItems salesItems ON sales.Id = salesItems.DocumentID
           INNER JOIN  dbo.tblCostCentre outlet on sales.OrderIssuedOnBehalfOfCC = outlet.Id 

        WHERE     (sales.DocumentTypeId = 1) 
              AND (sales.OrderOrderTypeId = 1 OR (sales.OrderOrderTypeId = 3 AND sales.DocumentStatusId = 99))
              AND outlet.CostCentreType = 5
			  AND CONVERT(NVARCHAR(26),DocumentDateIssued,23) BETWEEN @TargetStartDate AND @TargetEndDate
         GROUP BY outlet.Id
     SELECT @SalesQuantity = (SalesQty) FROM @SalesTable WHERE CostCenterId = @CCID 
     SELECT @SalesAmount = (SalesAmt) FROM @SalesTable WHERE CostCenterId = @CCID 

INSERT INTO @Table_Targets VALUES( @CCID ,
                                   @OutletName ,
								   @TargetPeriodIds ,
								   @TargetPeriodName ,
								   @TargetStartDate ,
								   @TargetEndDate ,
                                   @TargetQuantity ,
                                   @TargetAmount ,
                                   @SalesQuantity ,
                                   @SalesAmount ,
                                   @IsQtyTarget,
                                   @RouteName,
                                   @RouteIds,
                                   @RegionName,
                                   @RegionIds,
                                   @CountryName,
                                   @CountryIds,
                               --    @DistributorName ,
                                   @DistributorIds ,
                               --    @SalesmanName ,
                                   @SalesmanIds 
 
                                   );
FETCH NEXT FROM targets_cursor INTO @CCID ,
                                    @OutletName ,
								    @TargetPeriodIds ,
								    @TargetPeriodName ,
								    @TargetStartDate ,
								    @TargetEndDate ,
                                    @TargetQuantity ,
                                    @TargetAmount ,
                                    @IsQtyTarget,
                                    @RouteName,
                                    @RouteIds,
                                    @RegionName,
                                    @RegionIds,
                                    @CountryName,
                                    @CountryIds ,
                                 -- @DistributorName ,
                                    @DistributorIds ,
                                 -- @SalesmanName ,
                                    @SalesmanIds 
                                     
END;        
CLOSE  targets_cursor ;      
DEALLOCATE targets_cursor;

select * 
from @Table_Targets
where CONVERT(nvarchar(50),CountryIds) like ISNULL(@countryId,'%')
  and CONVERT(nvarchar(50),RegionIds) like ISNULL(@regionId,'%')
  and CONVERT(nvarchar(50),DistributorIds) like ISNULL(@distributorId,'%')
  and CONVERT(nvarchar(50),SalesmanIds) like ISNULL(@salesmanId,'%')
  and CONVERT(nvarchar(50),RouteIds) like ISNULL(@routeId,'%')
  and CONVERT(nvarchar(50),CCID) like ISNULL(@outletId,'%')
  and CONVERT(nvarchar(50),TargetPeriodIds) like ISNULL(@targetPeriodId,'%')


-- EXEC  [dbo].[sp_D_Performance_RoutePerformance] @countryId ='ALL',@regionId ='ALL',@distributorId ='ALL',@salesmanId ='ALL',@routeId ='ALL',@outletId ='ALL',@targetPeriodId ='1D2BEF24-7B29-4FBD-8C91-2D33BF9A6C78'

go