/****** Object:  StoredProcedure [dbo].[sp_D_dsLoadDiscountTypes]    Script Date: 07/24/2013 08:51:32 ******/
DROP PROCEDURE [dbo].[sp_D_dsLoadDiscountTypes]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_D_dsLoadDiscountTypes]
AS
SELECT 0 AS Id,'ALL' AS Name
UNION
SELECT 1 AS Id,'Product Discount' AS Name
UNION
SELECT 4 AS Id,'Free Of Charge Discount' AS Name
UNION
SELECT 5 AS Id,'Promotion Discount' AS Name
UNION
SELECT 6 AS Id,'Certain Value Certain Product Discount' AS Name
GO
