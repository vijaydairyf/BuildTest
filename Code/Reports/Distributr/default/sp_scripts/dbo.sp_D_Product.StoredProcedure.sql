/****** Object:  StoredProcedure [dbo].[sp_D_Product]    Script Date: 07/24/2013 08:51:32 ******/
DROP PROCEDURE [dbo].[sp_D_Product]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
create procedure [dbo].[sp_D_Product]
as 
SELECT id, Description AS [Product Name]
FROM     tblProduct
ORDER BY [Product Name]
GO
