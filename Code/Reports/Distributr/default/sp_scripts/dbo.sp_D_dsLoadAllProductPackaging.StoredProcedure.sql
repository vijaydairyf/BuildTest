/****** Object:  StoredProcedure [dbo].[sp_D_dsLoadAllProductPackaging]    Script Date: 07/24/2013 08:51:32 ******/
DROP PROCEDURE [dbo].[sp_D_dsLoadAllProductPackaging]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_D_dsLoadAllProductPackaging]
as 
SELECT TOP (1)  ' ALL' AS PackagingId, 
                ' ALL' AS PackagingName
UNION ALL
SELECT CONVERT(NVARCHAR(50),Id) as PackagingId,
                           Name as PackagingName
FROM     tblProductPackaging AS tblProductPackaging_1
WHERE tblProductPackaging_1.IM_Status = 1

ORDER BY PackagingName
GO
