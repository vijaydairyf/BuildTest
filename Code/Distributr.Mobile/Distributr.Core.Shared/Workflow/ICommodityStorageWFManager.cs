﻿using Distributr.Core.Domain.Transactional.SourcingDocumentEnitities;
using Distributr.Core.Domain.Transactional.SourcingDocumentEnitities.LineItems;

namespace Distributr.Core.Workflow
{
    public interface ICommodityStorageWFManager : ISourcingWFManager<CommodityStorageNote>
    {
    }
}
