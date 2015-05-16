﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using LINQtoCSV;

namespace Integration.Cussons.WPF.Lib.ImportEntities
{
  public  class DistributorSalesmanImport
    {
        [CsvColumn(FieldIndex = 1)]
        public string Code { get; set; }

        [CsvColumn(FieldIndex = 2)]
        public string Name { get; set; }

        [CsvColumn(FieldIndex = 3)]
        public string Description { get; set; }
    }
}
