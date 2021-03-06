/****** Object:  StoredProcedure [dbo].[sp_D_dsLoadAllTargets]    Script Date: 07/24/2013 08:51:32 ******/
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
WHERE dbo.tblTargetPeriod.IM_Status = 1
GO
