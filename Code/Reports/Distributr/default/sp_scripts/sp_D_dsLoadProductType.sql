
DROP PROCEDURE [dbo].[sp_D_dsLoadProductType]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_D_dsLoadProductType]

AS  

SELECT  top(1)   'ALL'  AS ProductTypeId,
                 'ALL'  AS ProductType


Union ALL

SELECT    LOWER(CONVERT(nvarchar(50),id)) AS ProductTypeId,
           name AS ProductType 
FROM      dbo.tblProductType
WHERE dbo.tblProductType.IM_Status = 1
order by ProductType

