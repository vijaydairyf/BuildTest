/****** Object:  StoredProcedure [dbo].[sp_D_Targets_DistributorTargets]    Script Date: 07/24/2013 08:51:32 ******/
DROP PROCEDURE [dbo].[sp_D_Targets_DistributorTargets]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_D_Targets_DistributorTargets]

(
@countryId AS NVARCHAR(50),
@regionId AS NVARCHAR(50),
@distributorId AS NVARCHAR(50),
@targetPeriodId AS NVARCHAR(50)
)
AS
if LTRIM(RTRIM(@countryId))='ALL' begin set @countryId='%' end
if LTRIM(RTRIM(@regionId))='ALL' begin set @regionId='%' end
if LTRIM(RTRIM(@distributorId))='ALL' begin set @distributorId='%' end
if LTRIM(RTRIM(@targetPeriodId))='ALL' begin set @targetPeriodId='%' end

DECLARE @CCID nvarchar(50),
        @DistributorName nvarchar(50),
        @TargetPeriodIds nvarchar(50),
        @TargetPeriodName nvarchar(50),
        @TargetStartDate date,
        @TargetEndDate date,
        @TargetQuantity decimal(18,2),
        @TargetAmount decimal(18,2),
        @SalesQuantity decimal(18,2),
        @TargetValue decimal(18,2),
        @SalesAmount decimal(18,2),
        @IsQtyTarget int,
        
        @CountryIds nvarchar(50),
        @RegionIds nvarchar(50)


        
DECLARE @Table_Targets TABLE (
        CCID nvarchar(50),
        DistributorName nvarchar(50),
        TargetPeriodIds nvarchar(50),
        TargetPeriodName nvarchar(50),
        TargetStartDate date,
        TargetEndDate date,
        TargetQuantity decimal(18,2),
        TargetAmount decimal(18,2),
        TargetValue decimal(18,2),
        SalesQuantity decimal(18,2),
        SalesAmount decimal(18,2),
        IsQtyTarget int,
        
        CountryIds nvarchar(50),
        RegionIds nvarchar(50)


        
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
           t.TargetValue TargetValue,
           t.IsQuantityTarget IsQtyTarget,
           cty.Id,
           reg.Id
          
 FROM       dbo.tblTargetPeriod tp
 INNER JOIN dbo.tblTarget t ON tp.Id = t.PeriodId
 INNER JOIN dbo.tblCostCentre cc ON t.CostCentreId = cc.Id
 INNER JOIN dbo.tblRegion reg on cc.Distributor_RegionId = reg.id
 INNER JOIN dbo.tblCountry cty on reg.Country = cty.id
 WHERE cc.CostCentreType = 2

 
OPEN targets_cursor
FETCH NEXT FROM targets_cursor
INTO    @CCID,
        @DistributorName,
        @TargetPeriodIds,
        @TargetPeriodName,
        @TargetStartDate,
        @TargetEndDate,
        @TargetQuantity,
        @TargetAmount,
        @TargetValue,
        @IsQtyTarget,        
        @CountryIds ,
	    @RegionIds 
       
      
 
     
WHILE @@FETCH_STATUS = 0  
BEGIN
INSERT @SalesTable

       SELECT  distributor.Id,
               CASE WHEN @IsQtyTarget=1 THEN SUM(salesItems.Quantity) ELSE 0 END AS saleQty,
               CASE WHEN @IsQtyTarget=0 THEN SUM(salesItems.Quantity *(salesItems.Value+salesItems.Vat)) ELSE 0 END AS saleAmount 
        FROM        dbo.tblDocument sales 
           INNER JOIN  dbo.tblLineItems salesItems ON sales.Id = salesItems.DocumentID
           INNER JOIN  dbo.tblCostCentre distributor on (sales.DocumentIssuerCostCentreId = distributor.Id or sales.DocumentRecipientCostCentre = distributor.Id)

        WHERE     (sales.DocumentTypeId = 1) 
              AND (sales.OrderOrderTypeId = 1 OR (sales.OrderOrderTypeId = 3 AND sales.DocumentStatusId = 99))
              AND distributor.CostCentreType = 2
			  AND CONVERT(NVARCHAR(26),DocumentDateIssued,23) BETWEEN @TargetStartDate AND @TargetEndDate
         GROUP BY distributor.Id
         
         
     SELECT @SalesQuantity = (SalesQty) FROM @SalesTable WHERE CostCenterId = @CCID 
     SELECT @SalesAmount = (SalesAmt) FROM @SalesTable WHERE CostCenterId = @CCID 

INSERT INTO @Table_Targets VALUES( @CCID ,
                                   @DistributorName ,
								   @TargetPeriodIds ,
								   @TargetPeriodName ,
								   @TargetStartDate ,
								   @TargetEndDate ,
                                   @TargetQuantity ,
                                   @TargetAmount ,
                                   @TargetValue ,
                                   @SalesQuantity ,
                                   @SalesAmount ,
                                   @IsQtyTarget,                                   
								   @CountryIds ,
								   @RegionIds 

                                   );
FETCH NEXT FROM targets_cursor INTO @CCID ,
                                    @DistributorName ,
								    @TargetPeriodIds ,
								    @TargetPeriodName ,
								    @TargetStartDate ,
								    @TargetEndDate ,
                                    @TargetQuantity ,
                                    @TargetAmount ,
                                    @TargetValue ,
                                    @IsQtyTarget,                                    
                                    @CountryIds ,
								    @RegionIds 

                                               

                                     
END;        
CLOSE  targets_cursor ;      
DEALLOCATE targets_cursor;

SELECT CCID DistributorId,
       DistributorName,
       TargetPeriodIds,
       TargetPeriodName,
       TargetStartDate,
       TargetEndDate,
       TargetQuantity,
       TargetAmount,
       TargetValue,
       SalesQuantity,
       SalesAmount,
       CASE WHEN  IsQtyTarget = 1 THEN 'Quantity Target' ELSE 'Sales Target' END AS TargetType,
       CountryIds,
       RegionIds
from @Table_Targets
where CONVERT(nvarchar(50),CountryIds) like ISNULL(@countryId,'%')
  and CONVERT(nvarchar(50),RegionIds) like ISNULL(@regionId,'%')
  and CONVERT(nvarchar(50),CCID) like ISNULL(@distributorId,'%')
  and CONVERT(nvarchar(50),TargetPeriodIds) like ISNULL(@targetPeriodId,'%')
  
  
--    EXEC  [dbo].[sp_D_Targets_DistributorTargets] @countryId ='ALL',@regionId ='ALL',@distributorId='ALL',@targetPeriodId ='ALL'

  
  
GO
