/****** Object:  StoredProcedure [dbo].[sp_D_LoadAllProductPackaging]    Script Date: 07/24/2013 08:51:32 ******/
DROP PROCEDURE [dbo].[sp_D_LoadAllProductPackaging]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_D_LoadAllProductPackaging]
as 
SELECT 'ALL' as Id, 'ALL' AS Name
UNION ALL
SELECT convert(nvarchar(50),Id) as Id, Name
FROM     tblProductPackaging AS tblProductPackaging_1
WHERE tblProductPackaging_1.IM_Status = 1
GO
