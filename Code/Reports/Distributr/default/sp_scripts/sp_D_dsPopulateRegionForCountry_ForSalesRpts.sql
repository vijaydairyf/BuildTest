DROP PROCEDURE [dbo].[sp_D_dsPopulateRegionForCountry_ForSalesRpts]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_D_dsPopulateRegionForCountry_ForSalesRpts]
@CountryId AS NVARCHAR(50)
as 
if  ltrim(rtrim(@CountryId))='ALL'  begin set @CountryId='%' end
SELECT TOP(1) ' ALL' as RegionId, 
              ' ALL' AS RegionName

UNION ALL
SELECT lower(Convert(nvarchar(50),region.id)) as RegionId, 
                                  region.Name as RegionName
FROM       tblRegion AS region
INNER JOIN tblCountry  country on region.Country = country.id
WHERE region.IM_Status = 1
AND   CONVERT(nvarchar(50),country.id) LIKE ISNULL(@CountryId,'%')


GO
