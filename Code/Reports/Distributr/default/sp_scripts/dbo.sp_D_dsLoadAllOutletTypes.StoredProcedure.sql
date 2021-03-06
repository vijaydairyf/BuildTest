/****** Object:  StoredProcedure [dbo].[sp_D_dsLoadAllOutletTypes]    Script Date: 07/24/2013 08:51:32 ******/
DROP PROCEDURE [dbo].[sp_D_dsLoadAllOutletTypes]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_D_dsLoadAllOutletTypes]
AS
SELECT  'ALL' AS OutletTypeId, 
        'ALL' AS OutletType
UNION ALL
SELECT        CONVERT(nvarchar(50), id) AS OutletTypeId, Name AS OutletType
FROM            tblOutletType AS tblOutletType_1
WHERE tblOutletType_1.IM_Status = 1
GO
