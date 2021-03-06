DROP FUNCTION [dbo].[func_D_GetTargetPeriodName] 
GO


CREATE FUNCTION [dbo].[func_D_GetTargetPeriodName] 
(
@Id nvarchar(100)
)
RETURNS TABLE
AS
RETURN (SELECT TargetPeriod.Name, 
               [Target].PeriodId, 
               [Target].TargetValue,
                TargetPeriod.StartDate, 
                TargetPeriod.EndDate,
                [Target].CostCentreId as distributorId,
                dbo.getsales(TargetPeriod.StartDate, 
							TargetPeriod.EndDate,
							[Target].CostCentreId) as sales
        FROM  dbo.tblTargetPeriod AS TargetPeriod 
             INNER JOIN dbo.tblTarget AS [Target] ON TargetPeriod.Id = [Target].PeriodId)
        --WHERE Target.CostCentreId like @distributorId);

--GO

--select Name
--from dbo.func_D_GetTargetPeriodName
--from dbo.func_D_GetTargetPeriodName('6AEF541C-0E6F-4068-80DF-2E97F94AE1D9') 
 


--select * , dbo.test(dbo.Saf_LocationStructureMatrix.Level2Name) as [count] FROM dbo.Saf_LocationStructureMatrix
