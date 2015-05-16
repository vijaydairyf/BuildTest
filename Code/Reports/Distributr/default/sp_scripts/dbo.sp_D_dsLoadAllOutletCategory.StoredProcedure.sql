/****** Object:  StoredProcedure [dbo].[sp_D_dsLoadAllOutletCategory]    Script Date: 07/24/2013 08:51:32 ******/
DROP PROCEDURE [dbo].[sp_D_dsLoadAllOutletCategory]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_D_dsLoadAllOutletCategory]
AS

SELECT         'ALL' AS OutletCategoryId, 'ALL' AS OutletCategory
UNION ALL
SELECT        CONVERT(nvarchar(50), id) AS OutletCategoryId, Name AS OutletCategory
FROM            tblOutletCategory AS tblOutletCategory_1
WHERE tblOutletCategory_1.IM_Status = 1
GO
