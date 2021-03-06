/****** Object:  StoredProcedure [dbo].[sp_D_dsLoadAllTier]    Script Date: 07/24/2013 08:51:32 ******/
DROP PROCEDURE [dbo].[sp_D_dsLoadAllTier]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_D_dsLoadAllTier]
AS
SELECT TOP(1)'ALL' AS TierId, 
             'ALL' AS TierName
UNION ALL

SELECT       convert(nvarchar(50),id) AS TierId, 
                                 Name AS TierName
FROM            tblPricingTier
WHERE tblPricingTier.IM_Status = 1
order by TierName
GO
