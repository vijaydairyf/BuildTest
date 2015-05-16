﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Distributr.Core.Domain.Master.CostCentreEntities;
using Distributr.Core.Utility;
using Distributr.Core.Utility.MasterData;

namespace Distributr.Core.Repository.Master.CostCentreRepositories
{
    public interface ICommodityOwnerTypeRepository: IRepositoryMaster<CommodityOwnerType>
    {

        QueryResult<CommodityOwnerType> Query(QueryStandard query);
    }
}
