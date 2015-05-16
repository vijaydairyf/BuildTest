﻿using System;
using System.Windows.Data;

namespace Distributr.WPF.UI.Converter
{
    public class IsReadOnlyConverter : IValueConverter
    {

        public object Convert(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
        {
            bool isReadOnly = !((bool)value);
            return isReadOnly;
        }

        public object ConvertBack(object value, Type targetType, object parameter, System.Globalization.CultureInfo culture)
        {
            return (bool) value;
        }
    }
}
