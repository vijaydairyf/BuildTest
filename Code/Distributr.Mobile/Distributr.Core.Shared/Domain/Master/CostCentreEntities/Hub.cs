﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Distributr.Core.Domain.Master.CostCentreEntities
{
#if !SILVERLIGHT
   [Serializable]
#endif
   public  class Hub:StandardWarehouse
    {
       public Hub(Guid id) : base(id)
       {
       }

       public Hub(Guid id, DateTime dateCreated, DateTime dateLastUpdated, EntityStatus isActive) : base(id, dateCreated, dateLastUpdated, isActive)
       {
       }
       public Region Region { get; set; }
    }
}
