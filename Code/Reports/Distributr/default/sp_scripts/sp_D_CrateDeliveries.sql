---RETURNABLES DELIVERIES
IF  EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[sp_D_CrateDeliveries]') AND type in (N'P', N'PC'))
DROP PROCEDURE [dbo].[sp_D_CrateDeliveries]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE PROCEDURE [dbo].[sp_D_CrateDeliveries]
(
@startDate as date,
@endDate as date,
@countryId AS NVARCHAR(50),
@regionId AS NVARCHAR(50),
@distributorId AS NVARCHAR(50),
@salesmanId AS NVARCHAR(50),
@routeId AS NVARCHAR(50),
@outletId AS NVARCHAR(50),
@productId AS NVARCHAR(50)

)
AS 
if  ltrim(rtrim(@countryId))='ALL'  begin set @countryId='%' end
if  ltrim(rtrim(@regionId))='ALL'  begin set @regionId='%' end
if  ltrim(rtrim(@distributorId))='ALL'  begin set @distributorId='%' end
if  ltrim(rtrim(@salesmanId))='ALL'  begin set @salesmanId='%' end
if  ltrim(rtrim(@routeId))='ALL'  begin set @routeId='%' end
if  ltrim(rtrim(@outletId))='ALL'  begin set @outletId='%' end
if  ltrim(rtrim(@productId))='ALL'  begin set @productId='%' end


SELECT     cntry.id CountryId,cntry.Name CountryName,
		   reg.id RegionId,reg.Name RegionName,
           dist.Id DistributorId,dist.Name DistributorName, 
           sm.Id SalemanId,sm.Name SalemanName, 
           rt.RouteID RouteId,rt.Name RouteName,
           outlet.Id OutletId,outlet.Name OutletName,
           pb.id BrandId,pb.name BrandName,
		   prod.id ProductId,prod.Description ProductName,
  		   prod.Returnable ReturnableId,
		   retunable.Description ReturnableName,
		   retunablePack.Description ReturnablePack,
		   retunablePack.Capacity ReturnablePackCapacity,
           del.Id AS DeliveryId,            
           del.DocumentReference DeliveryReference,
           SUM(delItems.Quantity) DeliveredQty,
		   SUM(delItems.Quantity *  delItems.Vat) TotalVat,
           delItems.Value,
	   	   CAST(ROUND((SUM(delItems.Quantity) / retunablePack.Capacity),1) AS INT) NoOfCrates,
    	   CAST((SUM(delItems.Quantity) % retunablePack.Capacity) AS INT)  ExtraBottle,  
	       ROUND(((delItems.Quantity)*(delItems.Value + delItems.Vat)) +  (delItems.ProductDiscount*delItems.Quantity) ,2,1) as GrossAmount,
	       dbo.udf_D_RoundOff((delItems.Quantity*delItems.Value)) as NetRoundOff,
	       ROUND((delItems.Quantity*delItems.Value),2,1) as NetTruncate,
	       dbo.udf_D_RoundOff(((delItems.Quantity)*(delItems.Value + delItems.Vat))) as GrossRoundOff,          
           trans.DocumentReference AS TransactionRef,
           trans.Id AS TransactionId,
           del.SendDateTime           
FROM       dbo.tblDocument del
 JOIN      dbo.tblLineItems delItems ON del.Id = delItems.DocumentID 
 JOIN      dbo.tblCostCentre sm ON del.DocumentIssuerCostCentreId = sm.Id 
 JOIN      dbo.tblCostCentre AS dist ON del.DocumentRecipientCostCentre = dist.Id 
 JOIN      dbo.tblProduct prod ON delItems.ProductID = prod.id 
 JOIN      dbo.tblProductBrand pb ON prod.BrandId = pb.id 
 JOIN      dbo.tblProduct retunable ON prod.Returnable = retunable.id
 JOIN      dbo.tblProduct retunablePack ON retunable.Returnable = retunablePack.id
 JOIN      dbo.tblDocument AS trans ON del.DocumentParentId = trans.Id 
 JOIN      dbo.tblCostCentre AS outlet ON trans.OrderIssuedOnBehalfOfCC = outlet.Id 
 JOIN      dbo.tblRoutes rt ON outlet.RouteId = rt.RouteID
 JOIN      dbo.tblRegion reg ON dist.Distributor_RegionId = reg.id 
 JOIN      dbo.tblCountry cntry ON reg.Country = cntry.id                     
WHERE     (del.DocumentTypeId = 2)
      AND (del.OrderOrderTypeId = 2)
      AND (sm.CostCentreType = 4)
      AND (dist.CostCentreType = 2)
	  AND CONVERT(NVARCHAR(50),cntry.id) LIKE ISNULL(@countryId,'%')
	  AND CONVERT(NVARCHAR(50),reg.id) LIKE ISNULL(@regionId,'%')
	  AND CONVERT(NVARCHAR(50),dist.id) LIKE ISNULL(@distributorId,'%')
	  AND CONVERT(NVARCHAR(50),sm.id) LIKE ISNULL(@salesmanId,'%')
	  AND CONVERT(NVARCHAR(50),rt.RouteID) LIKE ISNULL(@routeId,'%')
	  AND CONVERT(NVARCHAR(50),outlet.Id) LIKE ISNULL(@outletId,'%')
 	  AND CONVERT(NVARCHAR(50),prod.Id) LIKE ISNULL(@productId,'%')

      AND CONVERT(NVARCHAR(26),del.SendDateTime,23) BETWEEN @startDate AND @endDate
GROUP BY cntry.id,cntry.Name,
         reg.id,reg.Name,
		 dist.Id,dist.Name,
		 sm.Id,sm.Name,
		 rt.RouteID,rt.Name,
		 outlet.Id,outlet.Name,
		 pb.id,pb.name,
		 prod.id,prod.Description,prod.Returnable,
		 retunable.Description,retunablePack.Description,retunablePack.Capacity,
         del.Id,del.DocumentReference,delItems.Value,          
         trans.DocumentReference,trans.Id,
         del.SendDateTime,delItems.Quantity,delItems.ProductDiscount,delItems.Vat           


-- exec [dbo].[sp_D_CrateDeliveries] @startDate ='2014-12-16',@endDate ='2014-12-16',@countryId ='ALL',@regionId ='ALL',@distributorId ='ALL',@salesmanId ='ALL',@routeId ='ALL',@outletId='ALL',@productId='A4E73902-E95C-4D5A-9820-7FAB4530A5BA'

