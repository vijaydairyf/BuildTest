DROP PROCEDURE [dbo].[sp_D_SVD_PerDistributor]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_D_SVD_PerDistributor]
(
@startDate as datetime,
@endDate as datetime, 
@countryId as nvarchar(50),
@regionId as nvarchar(50),
@distributorId as nvarchar(50)

)
as 
if  LTRIM(RTRIM(@countryId))='ALL'  begin set @countryId='%' end
if  LTRIM(RTRIM(@regionId))='ALL'  begin set @regionId='%' end
if  LTRIM(RTRIM(@distributorId))='ALL'  begin set @distributorId='%' end


SELECT  ctry.id CountryId,
        ctry.Name CountryName,
        reg.id RegionId,
        reg.Name RegionName,
        distributor.Id DistributorId,
        distributor.Name DistributorName,
        outlet.Id OutletId, 
        outlet.Name OutletName, 
        sales.id SaleId,
        sales.DocumentReference SalesRef,
        CONVERT(NVARCHAR(26),sales.DocumentDateIssued,23) SaleDate,
        SUM(salesItems.Quantity) SaleQty,
        SUM((salesItems.Quantity) * (salesItems.Value + salesItems.Vat)) SaleAmount,
        sales.SaleDiscount SaleValueDiscount
FROM          dbo.tblDocument sales 
  JOIN  dbo.tblLineItems salesItems ON sales.Id = salesItems.DocumentID
  JOIN  dbo.tblCostCentre distributor on (sales.DocumentIssuerCostCentreId = distributor.Id or sales.DocumentRecipientCostCentre = distributor.Id)
  JOIN  dbo.tblCostCentre outlet ON sales.OrderIssuedOnBehalfOfCC = outlet.Id
  JOIN  dbo.tblRegion reg ON distributor.Distributor_RegionId = reg.id
  JOIN  dbo.tblCountry ctry ON reg.Country = ctry.id
 
WHERE     (sales.DocumentTypeId = 1) 
    AND (sales.OrderOrderTypeId = 1 OR (sales.OrderOrderTypeId = 3 AND sales.DocumentStatusId = 99))
    AND distributor.CostCentreType = 2 
  	AND CONVERT(NVARCHAR(26),DocumentDateIssued,23) BETWEEN @startDate AND @endDate
  	AND(CONVERT(nvarchar(50),ctry.id) like isnull(@countryId,'%'))
  	AND(CONVERT(nvarchar(50),reg.id) like isnull(@regionId,'%'))
  	AND(CONVERT(nvarchar(50),distributor.id) like isnull(@distributorId,'%'))

GROUP BY ctry.id,ctry.Name,reg.id,reg.Name,distributor.Id,distributor.Name,outlet.Id,outlet.Name,sales.id,sales.DocumentReference,sales.DocumentDateIssued,sales.SaleDiscount
HAVING SUM(sales.SaleDiscount) > 0
ORDER BY sales.DocumentDateIssued DESC

--  EXEC  [dbo].[sp_D_SVD_PerDistributor] @countryId='ALL' ,@regionId='ALL' ,@distributorId='ALL' ,@startDate='2014-06-01',@endDate='2014-06-06'

GO

