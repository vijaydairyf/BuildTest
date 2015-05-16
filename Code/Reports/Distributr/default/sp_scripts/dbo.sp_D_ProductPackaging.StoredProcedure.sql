/****** Object:  StoredProcedure [dbo].[sp_D_ProductPackaging]    Script Date: 07/24/2013 08:51:32 ******/
DROP PROCEDURE [dbo].[sp_D_ProductPackaging]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_D_ProductPackaging]
as 
SELECT TOP (1)  Id, 'ALL' AS Name
FROM     tblProductPackaging
UNION ALL
SELECT Id, Name
FROM     tblProductPackaging AS tblProductPackaging_1
GO
