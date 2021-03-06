--USE [DistributrTrunk]
--GO
/****** Object:  StoredProcedure [dbo].[SP_D_DistributorSaleman]    Script Date: 09/11/2013 14:34:35 ******/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
--ALTER proc [dbo].[SP_D_DistributorSaleman]
DROP PROCEDURE [dbo].[SP_D_DistributorSaleman]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[SP_D_DistributorSaleman]
(
 
 @distributorId as nvarchar(50)
 
 )
 
as

if  @distributorId='ALL'  begin set @distributorId='%' end

 


SELECT  TOP (1) 'ALL' AS SalesmanId, 
                'ALL' AS Salesman, 
                    0 AS CostCentreType
UNION ALL
SELECT        CONVERT(nvarchar(50), Id) AS SalesmanId, 
                                   Name AS Salesman,
                                      CostCentreType
FROM       tblCostCentre AS tblCostCentre_1
WHERE        (CostCentreType = 4)
           AND (convert(varchar(50),tblCostCentre_1.ParentCostCentreId) like ISNULL(@distributorId,'%'))
   and tblCostCentre_1.IM_Status = 1      
ORDER BY Salesman