﻿using System;
using Distributr.Core.Domain.Master.CostCentreEntities;
using Distributr.Core.Domain.Master.UserEntities;
using Distributr.Core.Domain.Transactional.DocumentEntities;
using Distributr.Core.Domain.Transactional.SourcingDocumentEnitities;
using Distributr.Core.Domain.Transactional.SourcingDocumentEnitities.LineItems;

namespace Distributr.Core.Factory.SourcingDocuments
{
    public interface ICommodityWarehouseStorageFactory
    {
        CommodityWarehouseStorageNote Create(CostCentre documentIssuerCostCentre, Guid documentIssueCostCentreApplicationId,
            CostCentre documentRecipientCostCentre,
            User documentIssuerUser, string documentReference, Guid documentParentId, Guid commodityOwnerId,
            DateTime documentDate, DateTime documentDateIssued, string driverName,
            string vehicleRegNo, DateTime? vehicleArrivalTime = null,
            DateTime? vehicleDepartureTime = null,
            decimal? vehicleArrivalMileage = null,
            decimal? vehicleDepartureMileage = null, string description = "", string note = "");

        CommodityWarehouseStorageLineItem CreateLineItem(Guid parentId, Guid commodityId, Guid gradeId, Guid containerId, string containerNo, decimal weight, WeighType weighType, string description);
    }
}