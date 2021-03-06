﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Distributr.Core.Domain.Master.CompetitorManagement;
using Distributr.Core.Utility;
using Distributr.Core.Utility.MasterData;

namespace Distributr.Core.Repository.Master.CompetitorManagement
{
   public interface ICompetitorProductsRepository:IRepositoryMaster<CompetitorProducts>
   {
       QueryResult<CompetitorProducts> Query(QueryStandard query);

   }
}
