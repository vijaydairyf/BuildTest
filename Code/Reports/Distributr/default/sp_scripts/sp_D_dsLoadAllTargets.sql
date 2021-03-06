--USE [DistributrTrunk]
--GO
/****** Object:  StoredProcedure [dbo].[sp_D_dsLoadAllTargets]    Script Date: 10/02/2013 10:09:41 ******/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
--ALTER procedure [dbo].[sp_D_dsLoadAllTargets]
DROP PROCEDURE [dbo].[sp_D_dsLoadAllTargets]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_D_dsLoadAllTargets]
as 
SELECT    TOP(1) 'ALL' AS TargetId, 
                 'ALL' AS Target


UNION ALL

SELECT      CONVERT(nvarchar(50), Id)AS TargetId, Name AS Target
FROM         dbo.tblTargetPeriod
WHERE  dbo.tblTargetPeriod.IM_Status = 1