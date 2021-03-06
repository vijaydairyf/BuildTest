USE [DistributrTrunk]
GO
/****** Object:  StoredProcedure [dbo].[SP_D_DistributorSaleman]    Script Date: 09/13/2013 08:21:40 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
ALTER proc [dbo].[SP_D_DistributorSaleman]
(
 
 @distributorID as nvarchar(50)
 
 )
 
as

if  @distributorID='ALL'  begin set @distributorID='%' end

 


SELECT  TOP (1) 'ALL' AS SalesmanId, 
                'ALL' AS Salesman, 
                    0 AS CostCentreType
UNION ALL
SELECT        CONVERT(nvarchar(50), Id) AS SalesmanId, 
                                   Name AS Salesman,
                                      CostCentreType
FROM       tblCostCentre AS tblCostCentre_1
WHERE        (CostCentreType = 4)
           AND (convert(varchar(50),tblCostCentre_1.ParentCostCentreId) like ISNULL(@distributorID,'%'))
         
ORDER BY Salesman
