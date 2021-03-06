/****** Object:  StoredProcedure [dbo].[sp_D_dsLoadAllRegion]    Script Date: 07/24/2013 08:51:32 ******/
DROP PROCEDURE [dbo].[sp_D_dsLoadAllRegion]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_D_dsLoadAllRegion]
as 
SELECT TOP(1) 'ALL' as RegionId, 
              'ALL' AS RegionName

UNION ALL
SELECT lower(Convert(nvarchar(50),id)) as RegionId, 
                           Name as RegionName
FROM     tblRegion AS tblRegion_1
where tblRegion_1.IM_Status = 1
GO
