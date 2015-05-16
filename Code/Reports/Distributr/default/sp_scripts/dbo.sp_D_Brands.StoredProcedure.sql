/****** Object:  StoredProcedure [dbo].[sp_D_Brands]    Script Date: 07/24/2013 08:51:32 ******/
DROP PROCEDURE [dbo].[sp_D_Brands]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_D_Brands]
as 
SELECT top(1) 'ALL' AS id, 'ALL' AS name

UNION 
SELECT LOWER(CONVERT(nvarchar(50), id)) AS id, name
FROM     tblProductBrand AS tblProductBrand_1
WHERE tblProductBrand_1.IM_Status = 1
ORDER BY name
GO
