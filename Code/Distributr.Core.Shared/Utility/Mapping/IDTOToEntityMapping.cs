﻿using System;
using Distributr.Core.Domain.FinancialEntities;
using Distributr.Core.Domain.InventoryEntities;
using Distributr.Core.Domain.Master;
using Distributr.Core.Domain.Master.AssetEntities;
using Distributr.Core.Domain.Master.BankEntities;
using Distributr.Core.Domain.Master.CentreEntity;
using Distributr.Core.Domain.Master.ChannelPackagings;
using Distributr.Core.Domain.Master.CommodityEntities;
using Distributr.Core.Domain.Master.CommodityEntity;
using Distributr.Core.Domain.Master.CompetitorManagement;
using Distributr.Core.Domain.Master.CoolerEntities;
using Distributr.Core.Domain.Master.CostCentreEntities;
using Distributr.Core.Domain.Master.DistributorTargetEntities;
using Distributr.Core.Domain.Master.EquipmentEntities;
using Distributr.Core.Domain.Master.FarmActivities;
using Distributr.Core.Domain.Master.OutletVisitReasonsTypeEntities;
using Distributr.Core.Domain.Master.ProductEntities;
using Distributr.Core.Domain.Master.ReOrdeLevelEntities;
using Distributr.Core.Domain.Master.SettingsEntities;
using Distributr.Core.Domain.Master.SuppliersEntities;
using Distributr.Core.Domain.Master.UserEntities;
using Distributr.Core.MasterDataDTO.DTOModels.AgrimanagrDTO.CommodityDTOs;
using Distributr.Core.MasterDataDTO.DTOModels.AgrimanagrDTO.CostCentreDTOs;
using Distributr.Core.MasterDataDTO.DTOModels.AgrimanagrDTO.EquipmentDTOs;
using Distributr.Core.MasterDataDTO.DTOModels.AgrimanagrDTO.FarmActivities;
using Distributr.Core.MasterDataDTO.DTOModels.FinancialDTO;
using Distributr.Core.MasterDataDTO.DTOModels.InventoriesDTO;
using Distributr.Core.MasterDataDTO.DTOModels.MasterDataDTO.Assets;
using Distributr.Core.MasterDataDTO.DTOModels.MasterDataDTO.Banks;
using Distributr.Core.MasterDataDTO.DTOModels.MasterDataDTO.ChannelPackaging;
using Distributr.Core.MasterDataDTO.DTOModels.MasterDataDTO.Competitor;
using Distributr.Core.MasterDataDTO.DTOModels.MasterDataDTO.CostCentre;
using Distributr.Core.MasterDataDTO.DTOModels.MasterDataDTO.DistributorTargets;
using Distributr.Core.MasterDataDTO.DTOModels.MasterDataDTO.MaritalStatus;
using Distributr.Core.MasterDataDTO.DTOModels.MasterDataDTO.MasterDataAllocations;
using Distributr.Core.MasterDataDTO.DTOModels.MasterDataDTO.Product;
using Distributr.Core.MasterDataDTO.DTOModels.MasterDataDTO.Retire;
using Distributr.Core.MasterDataDTO.DTOModels.MasterDataDTO.Settings;
using Distributr.Core.MasterDataDTO.DTOModels.MasterDataDTO.Suppliers;
using Distributr.Core.MasterDataDTO.DTOModels.MasterDataDTO.User;

namespace Distributr.Core.Utility.Mapping
{
   public interface IDTOToEntityMapping
   {
       DistributorPendingDispatchWarehouse Map(DistributorPendingDispatchWarehouseDTO dto);
       DistributorSalesman Map(DistributorSalesmanDTO dto);
       Area Map(AreaDTO dto);
       Country Map(CountryDTO dto);
       Contact Map(ContactDTO dto);
       Distributor Map(DistributorDTO dto);
       Producer Map(ProducerDTO dto);
       Transporter Map(TransporterDTO dto);
       OutletCategory Map(OutletCategoryDTO dto);
       Outlet Map(OutletDTO dto);
       OutletType Map(OutletTypeDTO dto);
       ShipToAddress Map(ShipToAddressDTO dto);
       Route Map(RouteDTO dto);
       Region Map(RegionDTO dto);
       SocioEconomicStatus Map(SocioEconomicStatusDTO dto);
       Territory Map(TerritoryDTO dto);
       ConsolidatedProduct Map(ConsolidatedProductDTO dto);
       ProductBrand Map(ProductBrandDTO dto);
       ProductFlavour Map(ProductFlavourDTO dto);
       ProductPackaging Map(ProductPackagingDTO dto);
       ProductPackagingType Map(ProductPackagingTypeDTO dto);
       ProductPricing Map(ProductPricingDTO dto);
       ProductPricing.ProductPricingItem Map(ProductPricingItemDTO dto);
       ProductPricingTier Map(ProductPricingTierDTO dto);
       ProductType Map(ProductTypeDTO dto);
       ReturnableProduct Map(ReturnableProductDTO dto);
       SaleProduct Map(SaleProductDTO dto);
       VATClass Map(VATClassDTO dto);
       VATClass.VATClassItem Map(VatClassItemDTO dto, Guid id);
       User Map(UserDTO dto);
       SaleValueDiscount.SaleValueDiscountItem Map(SaleValueDiscountItemDTO dto, Guid id);
       SaleValueDiscount Map(SaleValueDiscountDTO dto);
       ProductDiscount.ProductDiscountItem Map(ProductDiscountItemDTO dto, Guid id);
       ProductDiscount Map(ProductDiscountDTO dto);
       PromotionDiscount.PromotionDiscountItem Map(PromotionDiscountItemDTO dto, Guid id);
       PromotionDiscount Map(PromotionDiscountDTO dto);
       CertainValueCertainProductDiscount.CertainValueCertainProductDiscountItem Map(
           CertainValueCertainProductDiscountItemDTO dto, Guid id);
       CertainValueCertainProductDiscount Map(CertainValueCertainProductDiscountDTO dto);
      
       ProductGroupDiscount Map(ProductGroupDiscountDTO dto);
       ProductGroupDiscount MapProductGroupDiscount(ProductGroupDiscountDTO dto);
       TargetPeriod Map(TargetPeriodDTO dto);
       Target Map(TargetDTO dto);
       Province Map(ProvinceDTO dto);
       District Map(DistrictDTO dto);
       ReOrderLevel Map(ReorderLevelDTO dto);
       AssetType Map(AssetTypeDTO dto);
       Asset Map(AssetDTO dto);
       Competitor Map(CompetitorDTO dto);
       CompetitorProducts Map(CompetitorProductDTO dto);
       ChannelPackaging Map(ChannelPackagingDTO dto);
       DiscountGroup Map(DiscountGroupDTO dto);
       FreeOfChargeDiscount Map(FreeOfChargeDiscountDTO dto);
       SalesmanRoute Map(SalesmanRouteDTO dto);

       SalesmanSupplier Map(SalesmanSupplierDTO dto);
       UserGroup Map(UserGroupDTO dto);
       UserGroupRoles Map(UserGroupRoleDTO dto);
       Bank Map(BankDTO dto);
       BankBranch Map(BankBranchDTO dto);
       Supplier Map(SupplierDTO dto);
       ContactType Map(ContactTypeDTO dto);
       MaritalStatus Map(MaritalStatusDTO dto);
       AssetCategory Map(AssetCategoryDTO dto);
       AssetStatus Map(AssetStatusDTO dto);
       OutletVisitDay Map(OutletVisitDayDTO dto);
       OutletPriority Map(OutletPriorityDTO dto);
       TargetItem Map(TargetItemDTO dto);
       AppSettings Map(AppSettingsDTO dto);
       Inventory Map(InventoryDTO dto);
       PaymentTracker Map(PaymentTrackerDTO dto);
       RetireDocumentSetting Map(RetireSettingDTO dto);
       CommodityType Map(CommodityTypeDTO dto);
       Commodity Map(CommodityDTO dto);
       CommodityGrade Map(CommodityGradeDTO dto, Guid commodityId);
       CommodityOwnerType Map(CommodityOwnerTypeDTO dto);
       CommodityProducer Map(CommodityProducerDTO dto);
       CommoditySupplier Map(CommoditySupplierDTO dto);
       CommodityOwner Map(CommodityOwnerDTO dto);
       CentreType Map(CentreTypeDTO dto);
       Centre Map(CentreDTO dto);
       Hub Map(HubDTO dto);
       Store Map(StoreDTO dto);
       PurchasingClerk Map(PurchasingClerkDTO dto);
       PurchasingClerkRoute Map(PurchasingClerkRouteDTO dto, Guid clerkId);
       ContainerType Map(ContainerTypeDTO dto);
       Printer Map(PrinterDTO dto);
       WeighScale Map(WeighScaleDTO dto);
       SourcingContainer Map(SourcingContainerDTO dto);
       Vehicle Map(VehicleDTO dto);

       //MasterDataAllocation
       MasterDataAllocation Map(RouteCentreAllocationDTO dto);
       MasterDataAllocation Map(RouteCostCentreAllocationDTO dto);
       MasterDataAllocation Map(RouteRegionAllocationDTO dto);
       MasterDataAllocation Map(CommodityProducerCentreAllocationDTO dto);

       //MasterDataAllocation
       ActivityType Map(ActivityTypeDTO dto);
       ServiceProvider Map(ServiceProviderDTO dto);
       Shift Map(ShiftDTO dto);
       Season Map(SeasonDTO dto);
       Infection Map(InfectionDTO dto);
       CommodityProducerService Map(ServiceDTO dto);

       OutletVisitReasonsType Map(OutletVisitReasonTypeDTO dto);
      
   }
}
