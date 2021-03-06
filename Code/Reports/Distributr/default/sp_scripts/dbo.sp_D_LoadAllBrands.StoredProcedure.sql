/****** Object:  StoredProcedure [dbo].[sp_D_LoadAllBrands]    Script Date: 07/24/2013 08:51:32 ******/
DROP PROCEDURE [dbo].[sp_D_LoadAllBrands]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_D_LoadAllBrands]
as 
SELECT        TOP (1) 'ALL' AS BrandId, 'ALL' AS Brand
UNION ALL
SELECT        CONVERT(nvarchar(50), id) AS BrandId, name AS Brand
FROM            tblProductBrand
WHERE tblProductBrand.IM_Status = 1
GO
