/****** Object:  StoredProcedure [dbo].[sp_D_dsLoadAllProducts]    Script Date: 07/24/2013 08:51:32 ******/
DROP PROCEDURE [dbo].[sp_D_dsLoadAllProducts]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_D_dsLoadAllProducts]
as 
SELECT        TOP (1) 'ALL' AS id, 'ALL' AS [Product Name]
FROM            tblProduct
UNION ALL
SELECT        Lower(CONVERT(NVARCHAR(50), id)) AS id, Description AS [Product Name]
FROM            tblProduct AS tblProduct_1
where tblProduct_1.IM_Status = 1
ORDER BY [Product Name]
GO
