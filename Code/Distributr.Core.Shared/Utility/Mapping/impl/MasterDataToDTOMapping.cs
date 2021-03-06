﻿using System;
using System.Linq;
using AutoMapper;
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
using Distributr.Core.MasterDataDTO.DTOModels.MasterDataDTO;
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

namespace Distributr.Core.Utility.Mapping.impl
{
    public class MasterDataToDTOMapping : IMasterDataToDTOMapping
    {
        public MasterDataToDTOMapping()
        {
           // SetupMapper();
        }

      public static void SetupMapper()
        {
            Mapper.CreateMap<MaritalStatus, MaritalStatusDTO>().AfterMap(AfterMapAction);
            Mapper.CreateMap<ContactType, ContactTypeDTO>().AfterMap(AfterMapAction);
            Mapper.CreateMap<ProductPricingTier, ProductPricingTierDTO>().AfterMap(AfterMapAction);
            Mapper.CreateMap<ProductBrand, ProductBrandDTO>()
                .ForMember(dest=>dest.SupplierMasterId,opt=>opt.MapFrom(src=>src.Supplier==null?Guid.Empty:src.Supplier.Id))
                .AfterMap(AfterMapAction);
            Mapper.CreateMap<ProductFlavour, ProductFlavourDTO>()
                .ForMember(dest=>dest.ProductBrandMasterId,opt=>opt.MapFrom(src=>src.ProductBrand.Id))
                .AfterMap(AfterMapAction);
            Mapper.CreateMap<ProductPackaging, ProductPackagingDTO>()
                //.ForMember(dest => dest.ContainmentMasterId, opt => opt.MapFrom(src => src.Containment.Id))
                .ForMember(dest => dest.ReturnableProductMasterId, opt => opt.MapFrom(src => src.ReturnableProductRef == null ? Guid.Empty : src.ReturnableProductRef.ProductId))
                .AfterMap(AfterMapAction);
            Mapper.CreateMap<ProductPackagingType, ProductPackagingTypeDTO>().AfterMap(AfterMapAction);
            Mapper.CreateMap<ProductType, ProductTypeDTO>().AfterMap(AfterMapAction);
            Mapper.CreateMap<ReturnableProduct, ReturnableProductDTO>()
                .ForMember(dest => dest.ProductBrandMasterId, opt => opt.MapFrom(src => src.Brand.Id))
                .ForMember(dest => dest.ProductPackagingMasterId, opt => opt.MapFrom(src => src.Packaging == null ? Guid.Empty : src.Packaging.Id))
                .ForMember(dest => dest.ProductPackagingTypeMasterId, opt => opt.MapFrom(src => src.PackagingType.Id))
                .ForMember(dest => dest.VatClassMasterId, opt => opt.MapFrom(src => src.VATClass == null ? Guid.Empty : src.VATClass.Id))
                .ForMember(dest => dest.ReturnableTypeMasterId, opt => opt.MapFrom(src => (int)src.ReturnableType))
                .ForMember(dest => dest.ProductFlavourMasterId, opt => opt.MapFrom(src => src.Flavour == null ? Guid.Empty : src.Flavour.Id))
                .ForMember(dest => dest.ReturnableProductMasterId, opt => opt.MapFrom(src => src.ReturnAbleProduct == null ? Guid.Empty : src.ReturnAbleProduct.Id))
                .AfterMap(AfterMapAction);
            Mapper.CreateMap<SaleProduct, SaleProductDTO>()
                .ForMember(dest => dest.ProductBrandMasterId, opt => opt.MapFrom(src => src.Brand.Id))
                .ForMember(dest => dest.ProductPackagingMasterId, opt => opt.MapFrom(src => src.Packaging == null ? Guid.Empty : src.Packaging.Id))
                .ForMember(dest => dest.ProductPackagingTypeMasterId, opt => opt.MapFrom(src => src.PackagingType.Id))
                .ForMember(dest => dest.ProductFlavourMasterId, opt => opt.MapFrom(src => src.Flavour.Id))
                .ForMember(dest => dest.ProductTypeMasterId, opt => opt.MapFrom(src => src.ProductType.Id))
                .ForMember(dest => dest.ReturnableTypeMasterId, opt => opt.MapFrom(src => (int)src.ReturnableType))
                .ForMember(dest => dest.VatClassMasterId, opt => opt.MapFrom(src => src.VATClass == null ? Guid.Empty : src.VATClass.Id))
                .ForMember(dest => dest.ReturnableProductMasterId, opt => opt.MapFrom(src => src.ReturnableProduct == null ? Guid.Empty : src.ReturnableProduct.Id))
                .AfterMap(AfterMapAction);
            Mapper.CreateMap<ConsolidatedProduct, ConsolidatedProductDTO>()
                .ForMember(dest => dest.ProductBrandMasterId, opt => opt.MapFrom(src => src.Brand.Id))
                .ForMember(dest => dest.ProductPackagingMasterId, opt => opt.MapFrom(src => src.Packaging == null ? Guid.Empty : src.Packaging.Id))
                .ForMember(dest => dest.ProductPackagingTypeMasterId, opt => opt.MapFrom(src => src.PackagingType.Id))
                .ForMember(dest => dest.ReturnableTypeMasterId, opt => opt.MapFrom(src => (int)src.ReturnableType))
                .ForMember(dest => dest.ProductDetails, opt => opt.Ignore()) //do manually
                .AfterMap(AfterMapAction);
            Mapper.CreateMap<Area, AreaDTO>()
                .ForMember(dest => dest.RegionMasterId, opt => opt.MapFrom(src => src.region.Id))
                .AfterMap(AfterMapAction);
            Mapper.CreateMap<Country, CountryDTO>().AfterMap(AfterMapAction);
            Mapper.CreateMap<Distributor, DistributorDTO>()
                .ForMember(dest => dest.RegionMasterId, opt => opt.MapFrom(src => src.Region == null ? Guid.Empty : src.Region.Id))
                .ForMember(dest => dest.ASMUserMasterId, opt => opt.MapFrom(src => src.ASM == null ? Guid.Empty : src.ASM.Id))
                .ForMember(dest => dest.SalesRepUserMasterId, opt => opt.MapFrom(src => src.SalesRep == null ? Guid.Empty : src.SalesRep.Id))
                .ForMember(dest => dest.SurveyorUserMasterId, opt => opt.MapFrom(src => src.Surveyor == null ? Guid.Empty : src.Surveyor.Id))
                .ForMember(dest => dest.ParentCostCentreId, opt => opt.MapFrom(src => src.ParentCostCentre == null ? Guid.Empty : src.ParentCostCentre.Id))
                .ForMember(dest => dest.ProductPricingTierMasterId, opt => opt.MapFrom(src => src.ProductPricingTier == null ? Guid.Empty : src.ProductPricingTier.Id))
                .ForMember(dest => dest.CostCentreTypeId, opt => opt.MapFrom(src => (int) src.CostCentreType))
               .AfterMap(AfterMapAction);
            Mapper.CreateMap<OutletCategory, OutletCategoryDTO>()
                .AfterMap(AfterMapAction);
            Mapper.CreateMap<OutletType, OutletTypeDTO>()
                .AfterMap(AfterMapAction);
            Mapper.CreateMap<Outlet, OutletDTO>()
                .ForMember(dest => dest.RouteMasterId, opt => opt.MapFrom(src => src.Route.Id))
                .ForMember(dest => dest.OutletCategoryMasterId, opt => opt.MapFrom(src => src.OutletCategory.Id))
                .ForMember(dest => dest.OutletTypeMasterId, opt => opt.MapFrom(src => src.OutletType.Id))
                .ForMember(dest => dest.ParentCostCentreId, opt => opt.MapFrom(src => src.ParentCostCentre.Id))
                .ForMember(dest => dest.CostCentreTypeId, opt => opt.MapFrom(src => (int)src.CostCentreType))
                .ForMember(dest => dest.DiscountGroupMasterId, opt => opt.MapFrom(src => src.DiscountGroup == null ? Guid.Empty : src.DiscountGroup.Id))
                .ForMember(dest => dest.OutletProductPricingTierMasterId, opt => opt.MapFrom(src => src.OutletProductPricingTier == null ? Guid.Empty : src.OutletProductPricingTier.Id))
                .ForMember(dest => dest.VatClassMasterId, opt => opt.MapFrom(src => src.VatClass == null ? Guid.Empty : src.VatClass.Id))
                .AfterMap(AfterMapAction);
            Mapper.CreateMap<ShipToAddress, ShipToAddressDTO>()
                .AfterMap(AfterMapAction);
            Mapper.CreateMap<Region, RegionDTO>()
                .ForMember(dest => dest.CountryMasterId, opt => opt.MapFrom(src => src.Country.Id))
                .AfterMap(AfterMapAction);
            Mapper.CreateMap<SocioEconomicStatus, SocioEconomicStatusDTO>()
                .AfterMap(AfterMapAction);
            Mapper.CreateMap<Producer, ProducerDTO>()               
                .ForMember(dest => dest.ParentCostCentreId, opt => opt.Ignore())
                .ForMember(dest => dest.CostCentreTypeId, opt => opt.MapFrom(src => (int)src.CostCentreType))
                .AfterMap(AfterMapAction);
            Mapper.CreateMap<Territory, TerritoryDTO>()
                .AfterMap(AfterMapAction);
            Mapper.CreateMap<User, UserDTO>()
                .ForMember( dest => dest.UserTypeId, opt => opt.MapFrom(src => (int) src.UserType))
                .ForMember(dest => dest.GroupMasterId, opt => opt.MapFrom(src => src.Group == null ? Guid.Empty : src.Group.Id))
                .AfterMap(AfterMapAction);
            Mapper.CreateMap<Contact, ContactDTO>()
                .ForMember( dest => dest.ContactClassificationId,opt => opt.MapFrom(src => (int) src.ContactClassification))
                .ForMember(dest => dest.MaritalStatusMasterId, opt => opt.MapFrom(src => (int)src.MStatus))
                .ForMember(dest => dest.ContactTypeMasterId, opt => opt.MapFrom(src => src.ContactType == null ? Guid.Empty : src.ContactType.Id))
                .ForMember(dest=>dest.ContactOwnerType, opt=> opt.MapFrom(src=> (int)src.ContactOwnerType))
                .ForMember(dest=>dest.ContactOwnerMasterId, opt=> opt.MapFrom(src => src.ContactOwnerMasterId))
                .AfterMap(AfterMapAction);
            Mapper.CreateMap<Route, RouteDTO>()
                .AfterMap(AfterMapAction);
            Mapper.CreateMap<CostCentreApplication, CostCentreApplicationDTO>();
            Mapper.CreateMap<DistributorSalesman, DistributorSalesmanDTO>()
                //.ForMember(dest => dest.RouteMasterId, opt => opt.MapFrom(src => src.Route.Id))
                .ForMember(dest => dest.CostCentreTypeId, opt => opt.MapFrom(src => (int)src.CostCentreType))
                .ForMember(dest => dest.ParentCostCentreId, opt => opt.MapFrom(src => src.ParentCostCentre.Id))
                .AfterMap(AfterMapAction);
            Mapper.CreateMap<DistributorPendingDispatchWarehouse, DistributorPendingDispatchWarehouseDTO>()
                .ForMember(dest => dest.CostCentreTypeId, opt => opt.MapFrom(src => (int)src.CostCentreType))
                .ForMember(dest => dest.ParentCostCentreId, opt => opt.MapFrom(src => src.ParentCostCentre.Id))
                .AfterMap(AfterMapAction);
            Mapper.CreateMap<ChannelPackaging, ChannelPackagingDTO>()
                .ForMember(dest => dest.OutletTypeMasterId, opt => opt.MapFrom(src => src.OutletType.Id))
                 .ForMember(dest => dest.ProductPackagingMasterId, opt => opt.MapFrom(src => src.Packaging.Id))
                .AfterMap(AfterMapAction);
            Mapper.CreateMap<Competitor, CompetitorDTO>()
                .AfterMap(AfterMapAction);
            Mapper.CreateMap<CompetitorProducts , CompetitorProductDTO >()
               .ForMember(dest => dest.CompetitorMasterId, opt => opt.MapFrom(src => src.Competitor.Id ))
               .ForMember(dest => dest.BrandMasterId , opt => opt.MapFrom(src => src.Brand.Id ))
               .ForMember(dest => dest.PackagingMasterId , opt => opt.MapFrom(src => src.Packaging.Id ))
               .ForMember(dest => dest.PackagingTypeMasterId , opt => opt.MapFrom(src => src.PackagingType.Id ))
               .ForMember(dest => dest.FlavourMasterId , opt => opt.MapFrom(src => src.Flavour.Id ))
               .ForMember(dest => dest.ProductTypeMasterId , opt => opt.MapFrom(src => src.ProductType.Id ))
               .AfterMap(AfterMapAction);
            Mapper.CreateMap<Asset, AssetDTO>()
                 .ForMember(dest => dest.AssetTypeMasterId , opt => opt.MapFrom(src => src.AssetType.Id))
                 .ForMember(dest => dest.AssetCategoryMasterId, opt => opt.MapFrom(src => src.AssetCategory.Id))
                 .ForMember(dest => dest.AssetStatusMasterId, opt => opt.MapFrom(src => src.AssetStatus.Id))
                 .AfterMap(AfterMapAction);
            Mapper.CreateMap<AssetType, AssetTypeDTO>().AfterMap(AfterMapAction);
            Mapper.CreateMap<District ,DistrictDTO >()
                .ForMember(dest => dest.ProvinceMasterId , opt => opt.MapFrom(src => src.Province.Id ))
                .AfterMap(AfterMapAction);
            Mapper.CreateMap<Province , ProvinceDTO>()
                .ForMember(dest => dest.CountryMasterId , opt => opt.MapFrom(src => src.Country.Id ))
                .AfterMap(AfterMapAction);
            Mapper.CreateMap<ReOrderLevel,ReorderLevelDTO>()
                 .ForMember(dest => dest.ProductMasterId , opt => opt.MapFrom(src => src.ProductId.Id ))
                 .ForMember(dest => dest.DistributorMasterId, opt => opt.MapFrom(src => src.DistributorId.Id ))
                 .AfterMap(AfterMapAction);
            Mapper.CreateMap<TargetPeriod, TargetPeriodDTO>().AfterMap(AfterMapAction);
            Mapper.CreateMap<Target, TargetDTO>()
                // .ForMember(dest => dest.productId , opt => opt.MapFrom(src => src.product.Id ))
                 .ForMember(dest => dest.TargetPeriodMasterId , opt => opt.MapFrom(src => src.TargetPeriod.Id ))
                 .ForMember(dest => dest.CostCentreId , opt => opt.MapFrom(src =>src.CostCentre.Id ))
                 .AfterMap(AfterMapAction);
            Mapper.CreateMap<ChannelPackaging, ChannelPackagingDTO>()
                .ForMember(dest => dest.OutletTypeMasterId, opt => opt.MapFrom(src => src.OutletType.Id))
                .ForMember(dest => dest.ProductPackagingMasterId, opt => opt.MapFrom(src => src.Packaging.Id))
                .AfterMap(AfterMapAction);
            Mapper.CreateMap<FreeOfChargeDiscount, FreeOfChargeDiscountDTO>()
                .ForMember(dest => dest.ProductRefMasterId, opt => opt.MapFrom(src => src.ProductRef.ProductId))
                .AfterMap(AfterMapAction);
            Mapper.CreateMap<AssetType, AssetTypeDTO>().AfterMap(AfterMapAction);
            Mapper.CreateMap<Asset, AssetDTO>()
                .ForMember(dest => dest.AssetTypeMasterId, opt => opt.MapFrom(src => src.AssetType.Id))
                .AfterMap(AfterMapAction);
            Mapper.CreateMap<Competitor, CompetitorDTO>().AfterMap(AfterMapAction);
            Mapper.CreateMap<CompetitorProducts, CompetitorProductDTO>()
                .ForMember(dest => dest.BrandMasterId, opt => opt.MapFrom(src => src.Brand.Id))
                .ForMember(dest => dest.CompetitorMasterId, opt => opt.MapFrom(src => src.Competitor.Id))
                .ForMember(dest => dest.FlavourMasterId, opt => opt.MapFrom(src => src.Flavour.Id))
                .ForMember(dest => dest.PackagingMasterId, opt => opt.MapFrom(src => src.Packaging.Id))
                .ForMember(dest => dest.PackagingTypeMasterId, opt => opt.MapFrom(src => src.PackagingType.Id))
                .ForMember(dest => dest.ProductTypeMasterId, opt => opt.MapFrom(src => src.ProductType.Id))
                .AfterMap(AfterMapAction);
            Mapper.CreateMap<DiscountGroup, DiscountGroupDTO>().AfterMap(AfterMapAction);
            Mapper.CreateMap<SalesmanRoute, SalesmanRouteDTO>()
                 .ForMember(dest => dest.RouteMasterId, opt => opt.MapFrom(src => src.Route.Id))
                 .ForMember(dest => dest.DistributorSalesmanMasterId, opt => opt.MapFrom(src => src.DistributorSalesmanRef.Id))
                 .AfterMap(AfterMapAction);
            Mapper.CreateMap<SalesmanSupplier, SalesmanSupplierDTO>()
                  .ForMember(dest => dest.SupplierMasterId , opt => opt.MapFrom(src => src.Supplier.Id))
                  .ForMember(dest => dest.DistributorSalesmanMasterId, opt => opt.MapFrom(src => src.DistributorSalesmanRef.Id))
                  .AfterMap(AfterMapAction);

            Mapper.CreateMap<Containment, ContainmentDTO>()
                .ForMember(dest => dest.ProductPackagingTypeMasterId, opt => opt.MapFrom(src => src.ProductPackagingType.Id))
                .ForMember(dest => dest.ReturnableProductMasterId, opt => opt.MapFrom(src => src.ProductRef.ProductId))
                .AfterMap(AfterMapAction);
            Mapper.CreateMap<UserGroup, UserGroupDTO>()
                .AfterMap(AfterMapAction);
            Mapper.CreateMap<UserGroupRoles, UserGroupRoleDTO>()
                .ForMember(dest => dest.UserGroupMasterId, opt => opt.MapFrom(src => src.UserGroup.Id))
                .ForMember(dest => dest.UserRoleMasterId, opt => opt.MapFrom(src => src.UserRole))
                .AfterMap(AfterMapAction);
            Mapper.CreateMap<Bank, BankDTO>()
                 .AfterMap(AfterMapAction);
            Mapper.CreateMap<BankBranch, BankBranchDTO>()
              .ForMember(dest => dest.BankMasterId, opt => opt.MapFrom(src => src.Bank.Id))
              .AfterMap(AfterMapAction);
            Mapper.CreateMap<Supplier, SupplierDTO>()
                .AfterMap(AfterMapAction);
            Mapper.CreateMap<AssetCategory, AssetCategoryDTO>()
                .ForMember(dest => dest.AssetTypeMasterId, opt => opt.MapFrom(src => src.AssetType.Id))
                .AfterMap(AfterMapAction);
            Mapper.CreateMap<AssetStatus, AssetStatusDTO>()
               .AfterMap(AfterMapAction);
            Mapper.CreateMap<OutletPriority, OutletPriorityDTO>()
                 .ForMember(dest => dest.OutletMasterId, opt => opt.MapFrom(src => src.Outlet.Id))
                 .ForMember(dest => dest.RouteMasterId, opt => opt.MapFrom(src => src.Route.Id))
              .AfterMap(AfterMapAction);
            Mapper.CreateMap<OutletVisitDay, OutletVisitDayDTO>()
                .ForMember(dest => dest.OutletMasterId, opt => opt.MapFrom(src => src.Outlet.Id))
                .AfterMap(AfterMapAction);
            Mapper.CreateMap<TargetItem, TargetItemDTO>()
               .ForMember(dest => dest.TargetMasterId, opt => opt.MapFrom(src => src.Target.Id))
               .ForMember(dest => dest.ProductMasterId, opt => opt.MapFrom(src => src.Product.ProductId))
               .AfterMap(AfterMapAction);
            Mapper.CreateMap<AppSettings, AppSettingsDTO>().AfterMap(AfterMapAction);
            Mapper.CreateMap<Inventory, InventoryDTO>()
              .ForMember(dest => dest.ProductMasterID, opt => opt.MapFrom(src => src.Product.Id))
              .ForMember(dest => dest.WarehouseMasterID, opt => opt.MapFrom(src => src.Warehouse.Id))
              .AfterMap(AfterMapAction);
            Mapper.CreateMap<PaymentTracker, PaymentTrackerDTO>()
              .ForMember(dest => dest.PaymentModeId, opt => opt.MapFrom(src => (int)src.PaymentMode))
              .ForMember(dest => dest.CostcentreId, opt => opt.MapFrom(src => src.CostcentreId))
              .AfterMap(AfterMapAction);
            Mapper.CreateMap<RetireDocumentSetting, RetireSettingDTO>()
              .ForMember(dest => dest.RetireTypeId, opt => opt.MapFrom(src => (int)src.RetireType))
              .ForMember(dest => dest.Duration, opt => opt.MapFrom(src => src.Duration))
              .AfterMap(AfterMapAction);
            Mapper.CreateMap<CommodityType, CommodityTypeDTO>()
                .AfterMap(AfterMapAction);
            Mapper.CreateMap<Commodity, CommodityDTO>()
                .AfterMap(AfterMapAction);
            Mapper.CreateMap<CommodityGrade, CommodityGradeDTO>()
                .AfterMap(AfterMapAction);
            Mapper.CreateMap<CommodityOwnerType, CommodityOwnerTypeDTO>()
                .AfterMap(AfterMapAction);
          Mapper.CreateMap<Centre, Guid>().ConvertUsing(dest => dest.Id);
            Mapper.CreateMap<CommodityProducer, CommodityProducerDTO>()
                .ForMember(dest=>dest.CenterIds,opt=>opt.MapFrom(src=>src.CommodityProducerCentres))
                .AfterMap(AfterMapAction);
            Mapper.CreateMap<CommoditySupplier, CommoditySupplierDTO>()
                .ForMember(dest => dest.CostCentreTypeId, opt => opt.MapFrom(src => (int)src.CostCentreType))
                .ForMember(dest => dest.ParentCostCentreId, opt => opt.MapFrom(src => src.ParentCostCentre.Id))
                .ForMember(dest => dest.CommoditySupplierTypeId, opt => opt.MapFrom(src => (int)src.CommoditySupplierType))
                .AfterMap(AfterMapAction);
            Mapper.CreateMap<CommodityOwner, CommodityOwnerDTO>()
                .ForMember(dest => dest.MaritalStatusId, opt => opt.MapFrom(src => (int)src.MaritalStatus))
                .AfterMap(AfterMapAction);
            Mapper.CreateMap<Centre, CentreDTO>()
                .AfterMap(AfterMapAction);
            Mapper.CreateMap<CentreType, CentreTypeDTO>()
                .AfterMap(AfterMapAction);
            Mapper.CreateMap<Hub, HubDTO>()
                .ForMember(dest => dest.CostCentreTypeId, opt => opt.MapFrom(src => (int)src.CostCentreType))
                .ForMember(dest => dest.ParentCostCentreId, opt => opt.MapFrom(src => src.ParentCostCentre.Id))
                .AfterMap(AfterMapAction);
            Mapper.CreateMap<Store, StoreDTO>()
               .ForMember(dest => dest.CostCentreTypeId, opt => opt.MapFrom(src => (int)src.CostCentreType))
               .ForMember(dest => dest.ParentCostCentreId, opt => opt.MapFrom(src => src.ParentCostCentre.Id))
               .AfterMap(AfterMapAction);
            Mapper.CreateMap<PurchasingClerkRoute, PurchasingClerkRouteDTO>()
                .ForMember(dest => dest.PurchasingClerkId, opt => opt.MapFrom(src => src.PurchasingClerkRef.Id))
                .ForMember(dest => dest.RouteId , opt => opt.MapFrom(src => src.Route.Id))
                .AfterMap(AfterMapAction);
            Mapper.CreateMap<PurchasingClerk, PurchasingClerkDTO>()
                .ForMember(dest => dest.CostCentreTypeId, opt => opt.MapFrom(src => (int)src.CostCentreType))
                .ForMember(dest => dest.ParentCostCentreId, opt => opt.MapFrom(src => src.ParentCostCentre.Id))
                .ForMember(dest => dest.UserId, opt => opt.MapFrom(src => src.User.Id))
                .AfterMap(AfterMapAction);
            Mapper.CreateMap<ContainerType, ContainerTypeDTO>()
                .ForMember(dest => dest.ContainerUseTypeId, opt => opt.MapFrom(src => (int)src.ContainerUseType))
                .ForMember(dest => dest.CommodityGradeId, opt => opt.MapFrom(src => src.CommodityGrade.Id))
                .AfterMap(AfterMapAction);
            Mapper.CreateMap<Printer, PrinterDTO>()
                .ForMember(dest => dest.EquipmentTypeId, opt => opt.MapFrom(src => (int)src.EquipmentType))
                .ForMember(dest => dest.HubId, opt => opt.MapFrom(src => src.CostCentre.Id))
                .AfterMap(AfterMapAction);
            Mapper.CreateMap<WeighScale, WeighScaleDTO>()
                .ForMember(dest => dest.EquipmentTypeId, opt => opt.MapFrom(src => (int)src.EquipmentType))
                .ForMember(dest => dest.HubId, opt => opt.MapFrom(src => src.CostCentre.Id))
                .AfterMap(AfterMapAction);
            Mapper.CreateMap<Vehicle, VehicleDTO>()
                .ForMember(dest => dest.EquipmentTypeId, opt => opt.MapFrom(src => (int)src.EquipmentType))
                .ForMember(dest => dest.HubId, opt => opt.MapFrom(src => src.CostCentre.Id))
                .AfterMap(AfterMapAction);
            Mapper.CreateMap<SourcingContainer, SourcingContainerDTO>()
                .ForMember(dest => dest.EquipmentTypeId, opt => opt.MapFrom(src => (int)src.EquipmentType))
                .ForMember(dest => dest.HubId, opt => opt.MapFrom(src => src.CostCentre.Id))
                .AfterMap(AfterMapAction);
            Mapper.CreateMap<MasterDataAllocation, RouteCentreAllocationDTO>()
                .ForMember(dest => dest.RouteId, opt => opt.MapFrom(src => src.EntityAId))
                .ForMember(dest => dest.CentreId, opt => opt.MapFrom(src => src.EntityBId))
                .AfterMap(AfterMapAction);
            Mapper.CreateMap<MasterDataAllocation, CommodityProducerCentreAllocationDTO>()
                .ForMember(dest => dest.CommodityProducerId, opt => opt.MapFrom(src => src.EntityAId))
                .ForMember(dest => dest.CentreId, opt => opt.MapFrom(src => src.EntityBId))
                .AfterMap(AfterMapAction);
            Mapper.CreateMap<MasterDataAllocation, RouteCostCentreAllocationDTO>()
                .ForMember(dest => dest.RouteId, opt => opt.MapFrom(src => src.EntityAId))
                .ForMember(dest => dest.CostCentreId, opt => opt.MapFrom(src => src.EntityBId))
                .AfterMap(AfterMapAction);
            Mapper.CreateMap<MasterDataAllocation, RouteRegionAllocationDTO>()
                .ForMember(dest => dest.RouteId, opt => opt.MapFrom(src => src.EntityAId))
                .ForMember(dest => dest.RegionId, opt => opt.MapFrom(src => src.EntityBId))
                .AfterMap(AfterMapAction);
            Mapper.CreateMap<Infection, InfectionDTO>()
               .ForMember(dest => dest.InfectionTypeId, opt => opt.MapFrom(src =>(int) src.InfectionType))
               .AfterMap(AfterMapAction);
            Mapper.CreateMap<Season, SeasonDTO>()
                 .AfterMap(AfterMapAction);
            Mapper.CreateMap<CommodityProducerService, ServiceDTO>()
                  .AfterMap(AfterMapAction);
            Mapper.CreateMap<Shift, ShiftDTO>()
                   .AfterMap(AfterMapAction);
            Mapper.CreateMap<ActivityType, ActivityTypeDTO>()
                    .AfterMap(AfterMapAction);
            Mapper.CreateMap<ServiceProvider, ServiceProviderDTO>()
                .ForMember(dest=>dest.BankId,opt=>opt.MapFrom(src=>src.Bank.Id))
                .ForMember(dest=>dest.BankBranchId,opt=>opt.MapFrom(src=>src.BankBranch.Id))
                .ForMember(dest=>dest.GenderId,opt=>opt.MapFrom(src=>(int)src.Gender))
                    .AfterMap(AfterMapAction);

            Mapper.CreateMap<OutletVisitReasonsType, OutletVisitReasonTypeDTO>()
                 .ForMember(dest => dest.OutletVisitActionId, opt => opt.MapFrom(src => (int)src.OutletVisitAction))
                 .AfterMap(AfterMapAction);

        }

        /// <summary>
        /// Dodgy mappings
        /// </summary>
       static void AfterMapAction(MasterEntity me, MasterBaseDTO mb)
        {
            if(me==null){
                //Workaround for e.g. Route which bring a null me
                return;
            }
            mb.DateCreated = me._DateCreated;
            mb.MasterId = me.Id;
            mb.DateLastUpdated = me._DateLastUpdated;
            mb.StatusId = (int)me._Status;
        }

        
        /*>*/
        public ProductPricingTierDTO Map(ProductPricingTier productPricingTier)
        {
            if (productPricingTier == null) return null;
            return Mapper.Map<ProductPricingTier, ProductPricingTierDTO>(productPricingTier);
        }

        /*>*/
        public ProductBrandDTO Map(ProductBrand productBrand)
        {
            if (productBrand == null) return null;
            return Mapper.Map<ProductBrand, ProductBrandDTO>(productBrand);
            
        }
        /**/
        public ConsolidatedProductDTO Map(ConsolidatedProduct c)
        {
           // if (consolidatedProduct == null) return null;
           // return Mapper.Map<ConsolidatedProduct, ConsolidatedProductDTO>(consolidatedProduct);
            return new ConsolidatedProductDTO
                       {
                           DateCreated = c._DateCreated,
                           DateLastUpdated = c._DateLastUpdated,
                           Description = c.Description,
                           StatusId =(int) c._Status,
                           MasterId = c.Id,
                           ProductBrandMasterId = c.Brand.Id,
                           ProductCode = c.ProductCode,
                           ProductPackagingMasterId = c.Packaging == null ? Guid.Empty : c.Packaging.Id,
                           ProductPackagingTypeMasterId = c.PackagingType.Id,
                           ProductDetails = c.ProductDetails.Select(s => Map((ConsolidatedProduct.ProductDetail) s, c.Id)).ToList(),
                           ReturnableTypeMasterId = (int) c.ReturnableType,
                           VatClassMasterId = c.VATClass == null ? Guid.Empty : c.VATClass.Id,
                           ExFactoryPrice = c.ExFactoryPrice,
                       };
        }
        
        public ConsolidatedProductProductDetailDTO Map(ConsolidatedProduct.ProductDetail productDetail,Guid consolidationProductId)
        {
            if (productDetail == null) return null;
            return new ConsolidatedProductProductDetailDTO()
            {
                ProductDetailQuantityPerConsolidatedProduct = productDetail.QuantityPerConsolidatedProduct,
                ProductDetailProductMasterId = productDetail.Product.Id,
                ConsolidatedProductId=consolidationProductId,
                MasterId = consolidationProductId,
                DateCreated = productDetail.Product._DateCreated,
                DateLastUpdated = productDetail.Product._DateLastUpdated,
                StatusId = (int)productDetail.Product._Status
            };
        }
        /*>*/
        public ProductFlavourDTO Map(ProductFlavour productFlavour)
        {
            if (productFlavour == null) return null;
            return Mapper.Map<ProductFlavour, ProductFlavourDTO>(productFlavour);
        }
        /*>*/
        public ProductPackagingDTO Map(ProductPackaging productPackaging)
        {
            if (productPackaging == null) return null;
            return Mapper.Map<ProductPackaging, ProductPackagingDTO>(productPackaging);
        }
        /*>*/
        public ProductPackagingTypeDTO Map(ProductPackagingType productPackagingType)
        {
            if (productPackagingType == null) return null;
            return Mapper.Map<ProductPackagingType, ProductPackagingTypeDTO>(productPackagingType);
        }
        
        /*>*/
        public ProductPricingDTO Map(ProductPricing productPricing)
        {
            if (productPricing == null) return null;
            return new ProductPricingDTO()
            {
                DateCreated = productPricing._DateCreated,
                DateLastUpdated = productPricing._DateLastUpdated,
                StatusId =(int) productPricing._Status,
                MasterId = productPricing.Id,
                ProductMasterId = productPricing.ProductRef.ProductId,
                ProductPricingTierMasterId=productPricing.Tier.Id,
                ProductPricingItems = productPricing.ProductPricingItems.Select(n => Map(n,productPricing.Id)).ToList()
            };
        }
        /*>*/
        public ProductPricingItemDTO Map(ProductPricing.ProductPricingItem productPricingItem)
        {
            if (productPricingItem == null) return null;
            return new ProductPricingItemDTO()
            {
                EffectiveDate = productPricingItem.EffectiveDate,
                DateCreated = productPricingItem._DateCreated,
                DateLastUpdated = productPricingItem._DateLastUpdated,
                ExFactoryRate = productPricingItem.ExFactoryRate,
                StatusId = (int)productPricingItem._Status,
                MasterId = productPricingItem.Id,
                SellingPrice = productPricingItem.SellingPrice,
                
            };
        }
        public ProductPricingItemDTO Map(ProductPricing.ProductPricingItem productPricingItem,Guid productpricingId)
        {
            if (productPricingItem == null) return null;
            return new ProductPricingItemDTO()
            {
                EffectiveDate = productPricingItem.EffectiveDate,
                DateCreated = productPricingItem._DateCreated,
                DateLastUpdated = productPricingItem._DateLastUpdated,
                ExFactoryRate = productPricingItem.ExFactoryRate,
                StatusId = (int)productPricingItem._Status,
                MasterId = productPricingItem.Id,
                SellingPrice = productPricingItem.SellingPrice,
                ProductPricingMasterId=productpricingId

            };
        }
        /*>*/
        public ProductTypeDTO Map(ProductType productType)
        {
            if (productType == null) return null;
            return Mapper.Map<ProductType, ProductTypeDTO>(productType);
        }
        
        /**/
        public ReturnableProductDTO Map(ReturnableProduct returnableProduct)
        {
            if (returnableProduct == null) return null;
            return Mapper.Map<ReturnableProduct, ReturnableProductDTO>(returnableProduct);
        }
        /**/
        public SaleProductDTO Map(SaleProduct saleProduct)
        {
            if (saleProduct == null) return null;
            return Mapper.Map<SaleProduct, SaleProductDTO>(saleProduct);
        }


        public VATClassDTO Map(VATClass vatClass)
        {
            if (vatClass == null) return null;
            var item = new VATClassDTO()
            {
                DateCreated = vatClass._DateCreated,
                DateLastUpdated = vatClass._DateLastUpdated,
                StatusId =(int) vatClass._Status,
                MasterId = vatClass.Id,
                Name = vatClass.Name,
                VatClass = vatClass.VatClass,
                VatClassItems = vatClass.VATClassItems
                .Select(n => new VatClassItemDTO
                {
                    DateCreated = n._DateCreated,
                    DateLastUpdated = n._DateLastUpdated,
                    EffectiveDate = n.EffectiveDate,
                    StatusId = (int)n._Status,
                    MasterId = n.Id,
                    Rate = n.Rate
                }).ToList()
            };

            return item;
        }

        public AreaDTO Map(Area area)
        {
            if (area == null) return null;
            return Mapper.Map<Area, AreaDTO>(area);
        }

        public CountryDTO Map(Country country)
        {
            if (country == null) return null;
            return Mapper.Map<Country, CountryDTO>(country);
        }
        
        public DistributorDTO Map(Distributor distributor)
        {
            if (distributor == null) return null;
            DistributorDTO dto = Mapper.Map<Distributor, DistributorDTO>(distributor);
            dto.ASMDTO = Map(distributor.ASM);
            dto.SalesRepDTO = Map(distributor.SalesRep);
            dto.SurveyorDTO = Map(distributor.Surveyor);
            return dto;
        }

        public OutletCategoryDTO Map(OutletCategory outletCategory)
        {
            if (outletCategory == null) return null;
            return Mapper.Map<OutletCategory, OutletCategoryDTO>(outletCategory);
        }
        
        public OutletDTO Map(Outlet outlet)
        {
            if (outlet == null) return null;
            var dto = Mapper.Map<Outlet, OutletDTO>(outlet);
            dto.ShippingAddresses = outlet.ShipToAddresses.Select(n => Map(n)).ToList();
            return dto;
        }

        public ShipToAddressDTO Map(ShipToAddress address)
        {
            if (address == null) return null;
            return Mapper.Map<ShipToAddress, ShipToAddressDTO>(address);
        }

        public OutletTypeDTO Map(OutletType outletType)
        {
            if (outletType == null) return null;
            return Mapper.Map<OutletType, OutletTypeDTO>(outletType);
        }
        
        public RegionDTO Map(Region region)
        {
            if (region == null) return null;
            return Mapper.Map<Region, RegionDTO>(region);
        }
        
        public SocioEconomicStatusDTO Map(SocioEconomicStatus socioEconomicStatus)
        {
            if (socioEconomicStatus == null) return null;
            return Mapper.Map<SocioEconomicStatus, SocioEconomicStatusDTO>(socioEconomicStatus);
        }
        
        public ProducerDTO Map(Producer producer)
        {
            if (producer == null) return null;
            return Mapper.Map<Producer, ProducerDTO>(producer);
        }
        
        public TerritoryDTO Map(Territory territory)
        {
            if (territory == null) return null;
            return Mapper.Map<Territory, TerritoryDTO>(territory);
        }

        public UserDTO Map(User user)
        {
            if (user == null) return null;

            return Mapper.Map<User, UserDTO>(user);
        }

        public ContactDTO Map(Contact contact)
        {
            if (contact == null) return null;
            return Mapper.Map<Contact, ContactDTO>(contact);
        }

        public RouteDTO Map(Route route)
        {
            if (route == null) return null;
            return Mapper.Map<Route, RouteDTO>(route);
        }

        public CostCentreApplicationDTO Map(CostCentreApplication costCentreApplication)
        {
            if (costCentreApplication == null) return null;
            return Mapper.Map<CostCentreApplication, CostCentreApplicationDTO>(costCentreApplication);
        }

        public DistributorSalesmanDTO Map(DistributorSalesman distributorSalesman)
        {
            if (distributorSalesman == null) return null;
            return Mapper.Map<DistributorSalesman, DistributorSalesmanDTO>(distributorSalesman);
        }

        public DistributorPendingDispatchWarehouseDTO Map(DistributorPendingDispatchWarehouse distributorPendingDispatchWarehouse)
        {
            if (distributorPendingDispatchWarehouse == null) return null;
            return Mapper.Map<DistributorPendingDispatchWarehouse, DistributorPendingDispatchWarehouseDTO>(distributorPendingDispatchWarehouse);
        }
        public ChannelPackagingDTO Map(ChannelPackaging channelPackaging)
        {
            if (channelPackaging == null) return null;
            return Mapper.Map<ChannelPackaging, ChannelPackagingDTO>(channelPackaging);
        }
        public FreeOfChargeDiscountDTO Map(FreeOfChargeDiscount focDiscount)
        {
            if (focDiscount == null) return null;
            return Mapper.Map<FreeOfChargeDiscount, FreeOfChargeDiscountDTO>(focDiscount);
        }
        public CompetitorDTO  Map(Competitor  competitor)
        {
            if (competitor == null) return null;
            return Mapper.Map<Competitor, CompetitorDTO>(competitor);
        }
        public CompetitorProductDTO  Map(CompetitorProducts  competitorProduct)
        {
            if (competitorProduct == null) return null;
            return Mapper.Map<CompetitorProducts, CompetitorProductDTO>(competitorProduct);
        }
        public AssetDTO  Map(Asset  cooler)
        {
            if (cooler == null) return null;
            return Mapper.Map<Asset, AssetDTO>(cooler);
        }
        public AssetTypeDTO Map(AssetType coolerType)
        {
            if (coolerType == null) return null;
            return Mapper.Map<AssetType, AssetTypeDTO>(coolerType);
        }
        public DistrictDTO Map(District district)
        {
            if (district == null) return null;
            return Mapper.Map<District, DistrictDTO>(district);
        }
        public ProvinceDTO Map(Province  province)
        {
            if (province == null) return null;
            return Mapper.Map<Province, ProvinceDTO>(province);
        }
        public ReorderLevelDTO Map(ReOrderLevel reorderLevel)
        {
            if (reorderLevel == null) return null;
            return Mapper.Map<ReOrderLevel, ReorderLevelDTO>(reorderLevel);
        }
        //public ReturnablesDTO Map(Returnables returnables)
        //{
        //    if (returnables == null) return null;
        //    return Mapper.Map<Returnables, ReturnablesDTO>(returnables);
        //}
        //public ShellsDTO Map(Shells shells)
        //{
        //    if (shells == null) return null;
        //    return Mapper.Map<Shells, ShellsDTO>(shells);
        //}
        public TargetPeriodDTO Map(TargetPeriod targetPeriod)
        {
            if (targetPeriod == null) return null;
            return Mapper.Map<TargetPeriod, TargetPeriodDTO>(targetPeriod);
        }
        public TargetDTO Map(Target target)
        {
            if (target == null) return null;
            return Mapper.Map<Target, TargetDTO>(target);
        }




        public SaleValueDiscountDTO Map(SaleValueDiscount saleValueDiscount)
        {
            if (saleValueDiscount == null) return null;
            var item = new SaleValueDiscountDTO()
                           {
                               DateCreated = saleValueDiscount._DateCreated,
                               DateLastUpdated = saleValueDiscount._DateLastUpdated,
                               StatusId = (int)saleValueDiscount._Status,
                               MasterId = saleValueDiscount.Id,
                               TierMasterId = saleValueDiscount.Tier!=null?saleValueDiscount.Tier.Id:Guid.Empty,
                               DiscountItems = saleValueDiscount.DiscountItems
                                   .Select(n => new SaleValueDiscountItemDTO
                                                    {
                                                        DateCreated = n._DateCreated,
                                                        DateLastUpdated = n._DateLastUpdated,
                                                        DiscountThreshold = n.DiscountThreshold,
                                                        DiscountValue = n.DiscountValue,
                                                        EffectiveDate = n.EffectiveDate,
                                                        EndDate = n.EndDate,
                                                        StatusId = (int)n._Status,
                                                        MasterId = n.Id

                                                    }).ToList()
                           };

            return item;
        }

        public ProductDiscountDTO Map(ProductDiscount productDiscount)
        {
            if (productDiscount == null) return null;
            var item = new ProductDiscountDTO()
                           {
                               DateCreated = productDiscount._DateCreated,
                               DateLastUpdated = productDiscount._DateLastUpdated,
                               StatusId = (int)productDiscount._Status,
                               MasterId = productDiscount.Id,
                               ProductMasterId = productDiscount.ProductRef.ProductId,
                               TierMasterId = productDiscount.Tier.Id,
                               DiscountItem = productDiscount.DiscountItems
                                   .Select(s => new ProductDiscountItemDTO
                                                    {
                                                        DateCreated = s._DateCreated,
                                                        DateLastUpdated = s._DateLastUpdated,
                                                        DiscountRate = s.DiscountRate,
                                                        EffectiveDate = s.EffectiveDate,
                                                        EndDate = s.EndDate,
                                                        StatusId = (int)s._Status,
                                                        MasterId = s.Id,
                                                    }
                                   ).ToList()
                           };
            return item;
        }

        public PromotionDiscountDTO Map(PromotionDiscount promotion)
        {
            if (promotion == null) return null;
            var item = new PromotionDiscountDTO()
                           {
                               DateCreated = promotion._DateCreated,
                               DateLastUpdated = promotion._DateLastUpdated,
                               StatusId = (int) promotion._Status,
                               MasterId = promotion.Id,
                               ProductMasterId = promotion.ProductRef.ProductId,
                               PromotionDiscountItems = promotion.PromotionDiscountItems
                                   .Select(s => new PromotionDiscountItemDTO
                                                    {
                                                        DateCreated = s._DateCreated,
                                                        DateLastUpdated = s._DateLastUpdated,
                                                        StatusId = (int) s._Status,
                                                        EffectiveDate = s.EffectiveDate,
                                                        EndDate = s.EndDate,
                                                        FreeQuantity = s.FreeOfChargeQuantity,
                                                        ParentQuantity = s.ParentProductQuantity,
                                                        MasterId = s.Id,
                                                        ProductMasterId =
                                                            s.FreeOfChargeProduct == null
                                                                ? Guid.Empty
                                                                : s.FreeOfChargeProduct.ProductId,
                                                        DiscountRate = s.DiscountRate
                                                    }).ToList()
                           };
            return item;
        }

        public CertainValueCertainProductDiscountDTO Map(CertainValueCertainProductDiscount certainValueCertainDiscount)
        {
            if (certainValueCertainDiscount == null) return null;
            var items = new CertainValueCertainProductDiscountDTO()
                            {
                                DateCreated = certainValueCertainDiscount._DateCreated,
                                DateLastUpdated = certainValueCertainDiscount._DateLastUpdated,
                                StatusId = (int) certainValueCertainDiscount._Status,
                                MasterId = certainValueCertainDiscount.Id,
                                InitialValue = certainValueCertainDiscount.InitialValue,
                                CertainValueCertainProductDiscountItems =
                                    certainValueCertainDiscount.CertainValueCertainProductDiscountItems
                                    .Select(s => new CertainValueCertainProductDiscountItemDTO
                                                     {
                                                         DateCreated = s._DateCreated,
                                                         DateLastUpdated = s._DateLastUpdated,
                                                         StatusId = (int) s._Status,
                                                         EffectiveDate = s.EffectiveDate,
                                                         EndDate = s.EndDate,
                                                         CertainValue = s.CertainValue,
                                                         MasterId = s.Id,
                                                         ProductMasterId = s.Product.ProductId,
                                                         Quantity = s.Quantity
                                                     }
                                    ).ToList()
                            };
            return items;
        }

        public ProductGroupDiscountDTO Map(ProductGroupDiscount productGroupDiscount)
        {
            if (productGroupDiscount == null) return null;
            if (productGroupDiscount.GroupDiscount == null) return null;
            var item = new ProductGroupDiscountDTO()
                           {
                               DateCreated = productGroupDiscount._DateCreated,
                               DateLastUpdated = productGroupDiscount._DateLastUpdated,
                               StatusId = (int) productGroupDiscount._Status,
                               DiscountGroupMasterId = productGroupDiscount.GroupDiscount.Id,
                               MasterId = productGroupDiscount.Id,
                              
                                                        
                                                        DiscountRate = productGroupDiscount.DiscountRate,
                                                        EffectiveDate = productGroupDiscount.EffectiveDate,
                                                        EndDate = productGroupDiscount.EndDate,
                                                       
                                                        ProductMasterId =productGroupDiscount.Product.ProductId
                                  
                           };
            return item;
        }

        public DiscountGroupDTO Map(DiscountGroup discountGroup)
        {
            if (discountGroup == null) return null;
            return Mapper.Map<DiscountGroup, DiscountGroupDTO>(discountGroup);
        }

        public ContainmentDTO Map(Containment containment)
        {
            if (containment == null) return null;
            return Mapper.Map<Containment, ContainmentDTO>(containment);
        }

        #region IMasterDataToDTOMapping Members


        public SalesmanRouteDTO Map(SalesmanRoute salesmanRoute)
        {
            if (salesmanRoute == null) return null;
            return Mapper.Map<SalesmanRoute, SalesmanRouteDTO>(salesmanRoute);
        }

        public SalesmanSupplierDTO Map(SalesmanSupplier salesmanSupplier)
        {
            if (salesmanSupplier == null) return null;
            return Mapper.Map<SalesmanSupplier, SalesmanSupplierDTO>(salesmanSupplier);
        }

        #endregion

        #region IMasterDataToDTOMapping Members


        public UserGroupDTO Map(UserGroup group)
        {
            if (group == null) return null;
            return Mapper.Map<UserGroup, UserGroupDTO>(group);
        }

        public UserGroupRoleDTO Map(UserGroupRoles role)
        {
            if (role == null) return null;
            return Mapper.Map<UserGroupRoles, UserGroupRoleDTO>(role);
        }

        #endregion


        public BankDTO Map(Bank bank)
        {
            if (bank  == null) return null;
            return Mapper.Map<Bank, BankDTO>(bank);
        }

        public BankBranchDTO Map(BankBranch bankBranch)
        {
            if (bankBranch == null) return null;
            return Mapper.Map<BankBranch, BankBranchDTO>(bankBranch);
        }
        public SupplierDTO Map(Supplier supplier)
        {
            if (supplier == null) return null;
            return Mapper.Map<Supplier, SupplierDTO>(supplier);
        }
        public ContactTypeDTO Map(ContactType contactType)
        {
            if (contactType == null)
                return null;
            return Mapper.Map<ContactType,ContactTypeDTO>(contactType);
        }

        public AssetCategoryDTO Map(AssetCategory category)
        {
            if (category == null)
                return null;
            return Mapper.Map<AssetCategory, AssetCategoryDTO>(category);
        }

        public AssetStatusDTO Map(AssetStatus status)
        {
            if (status == null)
                return null;
            return Mapper.Map<AssetStatus, AssetStatusDTO>(status);
        }

        public MaritalStatusDTO Map(MaritalStatus maritalStatus)
        {
            if (maritalStatus == null)
                return null;
            return Mapper.Map<MaritalStatus, MaritalStatusDTO>(maritalStatus);
        }


        public OutletPriorityDTO Map(OutletPriority priority)
        {
            if (priority == null)
                return null;
            return Mapper.Map<OutletPriority, OutletPriorityDTO>(priority);
        }

        public OutletVisitDayDTO Map(OutletVisitDay priority)
        {
            if (priority == null)
                return null;
            return Mapper.Map<OutletVisitDay, OutletVisitDayDTO>(priority);
        }

        public TargetItemDTO Map(TargetItem targetItem)
        {
            if (targetItem == null)
                return null;
            return Mapper.Map<TargetItem, TargetItemDTO>(targetItem);
        }

        public AppSettingsDTO Map(AppSettings setting)
        {
            if (setting == null)
                return null;
            return Mapper.Map<AppSettings, AppSettingsDTO>(setting);
        }

        public InventoryDTO Map(Inventory inventory)
        {
            if (inventory == null) return null;
            return Mapper.Map<Inventory, InventoryDTO>(inventory);
        }

        public PaymentTrackerDTO Map(PaymentTracker paymentTracker)
        {
            if (paymentTracker == null) return null;
            return Mapper.Map<PaymentTracker, PaymentTrackerDTO>(paymentTracker);
        }

        public RetireSettingDTO Map(RetireDocumentSetting setting)
        {
            if (setting == null) return null;
            return Mapper.Map<RetireDocumentSetting, RetireSettingDTO>(setting);
        }

        public CommodityTypeDTO Map(CommodityType commodityType)
        {
            if (commodityType == null) return null;
            return Mapper.Map<CommodityType, CommodityTypeDTO>(commodityType);
        }

        public CommodityDTO Map(Commodity commodity)
        { 
            if (commodity == null) return null;
            var commodityDto = Mapper.Map<Commodity, CommodityDTO>(commodity);
            commodityDto.CommodityGrades = commodity.CommodityGrades.Select(n => Map(n, commodity.Id)).ToList();
            return commodityDto;
        }

        public CommodityGradeDTO Map(CommodityGrade commodityGrade, Guid commodityId)
        {
            if (commodityGrade == null) return null;
            var grade = Mapper.Map<CommodityGrade, CommodityGradeDTO>(commodityGrade);
            grade.CommodityId = commodityId;
            return grade;
        }

        public CommodityOwnerTypeDTO Map(CommodityOwnerType commodityOwnerType)
        {
            if (commodityOwnerType == null) return null;
            var commodityOwnerTypeDto = Mapper.Map<CommodityOwnerType, CommodityOwnerTypeDTO>(commodityOwnerType);
            return commodityOwnerTypeDto;
        }

        public CommodityProducerDTO Map(CommodityProducer commodityProducer)
        {
            if (commodityProducer == null) return null;
            var commodityProducerDto = Mapper.Map<CommodityProducer, CommodityProducerDTO>(commodityProducer);
            return commodityProducerDto;
        }

        public CommoditySupplierDTO Map(CommoditySupplier commoditySupplier)
        {
            if (commoditySupplier == null) return null;
            var commoditySupplierDto = Mapper.Map<CommoditySupplier, CommoditySupplierDTO>(commoditySupplier);
            return commoditySupplierDto;
        }

        public CommodityOwnerDTO Map(CommodityOwner commodityOwner)
        {
            if (commodityOwner == null) return null;
            var commodityOwnerDto = Mapper.Map<CommodityOwner, CommodityOwnerDTO>(commodityOwner);
            return commodityOwnerDto;
        }

        public CentreTypeDTO Map(CentreType centreType)
        {
            if (centreType == null) return null;
            var centreTypeDto = Mapper.Map<CentreType, CentreTypeDTO>(centreType);
            return centreTypeDto;
        }

        public CentreDTO Map(Centre centre)
        {
            if (centre == null) return null;
            var centreDto = Mapper.Map<Centre, CentreDTO>(centre);
            return centreDto;
        }

        public HubDTO Map(Hub hub)
        {
            if (hub == null) return null;
            var hubDto = Mapper.Map<Hub, HubDTO>(hub);
            return hubDto;
        }

        public StoreDTO Map(Store store)
        {
            if (store == null) return null;
            var storeDto = Mapper.Map<Store, StoreDTO>(store);
            return storeDto;
        }

        public PurchasingClerkDTO Map(PurchasingClerk purchasingClerk)
        {
            if (purchasingClerk == null) return null;
            var purchasingClerkDto = Mapper.Map<PurchasingClerk, PurchasingClerkDTO>(purchasingClerk);
            purchasingClerkDto.UserDto = Map(purchasingClerk.User);
            purchasingClerkDto.PurchasingClerkRoutes = purchasingClerk.PurchasingClerkRoutes.Select(Map).ToList();
            return purchasingClerkDto;
        }

        public PurchasingClerkRouteDTO Map(PurchasingClerkRoute route)
        {
            if (route == null) return null;
            return Mapper.Map<PurchasingClerkRoute, PurchasingClerkRouteDTO>(route);
        }

        public ContainerTypeDTO Map(ContainerType containerType)
        {
            if (containerType == null) return null;
            return Mapper.Map<ContainerType, ContainerTypeDTO>(containerType);
        }

        public PrinterDTO Map(Printer printer)
        {
            if (printer == null) return null;
            var printerDto = Mapper.Map<Printer, PrinterDTO>(printer);
            return printerDto;
        }

        public WeighScaleDTO Map(WeighScale scale)
        {
            if (scale == null) return null;
            var scaleDto = Mapper.Map<WeighScale, WeighScaleDTO>(scale);
            return scaleDto;
        }

        public SourcingContainerDTO Map(SourcingContainer container)
        {
            if (container == null) return null;
            var containerDto = Mapper.Map<SourcingContainer, SourcingContainerDTO>(container);
            return containerDto;
        }

        public VehicleDTO Map(Vehicle vehicle)
        {
            if (vehicle == null) return null;
            var vehicleDto = Mapper.Map<Vehicle, VehicleDTO>(vehicle);
            return vehicleDto;
        }

        public MasterDataAllocationDTO Map(MasterDataAllocation allocation)
        {
            if (allocation == null) return null;
            var allocationDto = Mapper.Map<MasterDataAllocation, MasterDataAllocationDTO>(allocation);
            return allocationDto;
        }

        public MasterDataAllocationDTO Map(MasterDataAllocation allocation, MasterDataAllocationType allocationType)
        {
            MasterDataAllocationDTO allocationDto = new MasterDataAllocationDTO(); 
            if (allocation == null) return null;
            switch (allocationType)
            {
                    case MasterDataAllocationType.CommodityProducerCentreAllocation:
                        allocationDto = Mapper.Map<MasterDataAllocation, CommodityProducerCentreAllocationDTO>(allocation);
                    break;
                    case MasterDataAllocationType.RouteCostCentreAllocation:
                        allocationDto = Mapper.Map<MasterDataAllocation, RouteCostCentreAllocationDTO>(allocation);
                    break;
                    case MasterDataAllocationType.RouteCentreAllocation:
                        allocationDto = Mapper.Map<MasterDataAllocation, RouteCentreAllocationDTO>(allocation);
                    break;
                    case MasterDataAllocationType.RouteRegionAllocation:
                        allocationDto = Mapper.Map<MasterDataAllocation, RouteRegionAllocationDTO>(allocation);
                    break;
                default:
                        throw new Exception("Failed to map to DTO " + allocationType);
            }
            return allocationDto;
        }

        public InfectionDTO Map(Infection infectionEntity)
        {
            if (infectionEntity == null) return null;
            var infectionDto = Mapper.Map<Infection, InfectionDTO>(infectionEntity);
            return infectionDto;
        }

        public SeasonDTO Map(Season seasonEntity)
        {
            if (seasonEntity == null) return null;
            var seasonDto = Mapper.Map<Season, SeasonDTO>(seasonEntity);
            return seasonDto;
        }

        public ServiceDTO Map(CommodityProducerService commodityProducerServiceEntity)
        {
            if (commodityProducerServiceEntity == null) return null;
            var serviceDto = Mapper.Map<CommodityProducerService, ServiceDTO>(commodityProducerServiceEntity);
            return serviceDto;
        }

        public ShiftDTO Map(Shift shiftEntity)
        {
            if (shiftEntity == null) return null;
            var shiftDto = Mapper.Map<Shift, ShiftDTO>(shiftEntity);
            return shiftDto;
        }

        public ActivityTypeDTO Map(ActivityType activityType)
        {
            if (activityType == null) return null;
            var activityTypeDto = Mapper.Map<ActivityType, ActivityTypeDTO>(activityType);
            return activityTypeDto;
        }

        public ServiceProviderDTO Map(ServiceProvider serviceProviderEntity)
        {
            if (serviceProviderEntity == null) return null;
            var serviceProviderDto = Mapper.Map<ServiceProvider, ServiceProviderDTO>(serviceProviderEntity);
            return serviceProviderDto;
        }


        public OutletVisitReasonTypeDTO Map(OutletVisitReasonsType outletVisitReasonsTypeEntity)
        {
            if (outletVisitReasonsTypeEntity == null) return null;
            var outletReasonVisitDto = Mapper.Map<OutletVisitReasonsType, OutletVisitReasonTypeDTO>(outletVisitReasonsTypeEntity);
            return outletReasonVisitDto;
        }
    }
}
