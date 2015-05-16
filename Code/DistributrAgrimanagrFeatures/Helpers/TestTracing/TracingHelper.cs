﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Diagnostics;
namespace DistributrAgrimanagrFeatures.Helpers.TestTracing
{
    public class TI
    {
        private static string _thprefix = "[TI]";

        public static void trace(string message)
        {
            Trace.WriteLine(string.Format("{0}_{1}", _thprefix, message));
        }

        public static void trace(string section, string message)
        {
            Trace.WriteLine(string.Format("{0}_[{1}]_{2}", _thprefix, section, message));

        }
    }
}