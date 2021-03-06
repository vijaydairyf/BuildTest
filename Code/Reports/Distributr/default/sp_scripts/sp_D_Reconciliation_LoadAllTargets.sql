--USE [DistributrTrunk]
--GO
/****** Object:  StoredProcedure [dbo].[sp_D_Reconciliation_LoadAllTargets]    Script Date: 10/04/2013 12:18:56 ******/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
--ALTER procedure [dbo].[sp_D_Reconciliation_LoadAllTargets]
DROP PROCEDURE [dbo].[sp_D_Reconciliation_LoadAllTargets]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_D_Reconciliation_LoadAllTargets]

AS


SELECT DISTINCT top(1)'ALL' AS Id, 'ALL' AS Name 
FROM         dbo.tblTargetPeriod

UNION ALL

SELECT LOWER(CONVERT(nvarchar(50), Id))AS id, Name 
FROM         dbo.tblTargetPeriod

order by Name 