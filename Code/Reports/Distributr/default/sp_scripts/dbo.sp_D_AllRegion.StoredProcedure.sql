/****** Object:  StoredProcedure [dbo].[sp_D_AllRegion]    Script Date: 07/24/2013 08:51:32 ******/
DROP PROCEDURE [dbo].[sp_D_AllRegion]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_D_AllRegion]
as 
SELECT TOP(1) 'ALL' as id, 'ALL' AS Name

UNION 
SELECT Convert(nvarchar(50),id) as id, Name
FROM     tblRegion AS tblRegion_1
WHERE tblRegion_1.IM_Status = 1
ORDER BY Name
GO
