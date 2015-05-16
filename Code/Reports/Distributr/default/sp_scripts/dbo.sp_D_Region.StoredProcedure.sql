/****** Object:  StoredProcedure [dbo].[sp_D_Region]    Script Date: 07/24/2013 08:51:32 ******/
DROP PROCEDURE [dbo].[sp_D_Region]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_D_Region]
as 
SELECT TOP (1) id, 'ALL' AS Name
FROM     tblRegion
UNION ALL
SELECT id, Name
FROM     tblRegion AS tblRegion_1
ORDER BY Name
GO
