﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using Distributr.WPF.Lib.UI.UI_Utillity;
using Distributr.WPF.Lib.ViewModels.ApplicSettings;

namespace Agrimanagr.WPF.UI.Views.Settings
{
    public partial class AgriGeneralSettings : UserControl
    {
        private GeneralSettingsViewModel _vm;
        public AgriGeneralSettings()
        {
            InitializeComponent();
            Loaded += GeneralSettings_Loaded;
        }

        void GeneralSettings_Loaded(object sender, RoutedEventArgs e)
        {
            _vm = this.DataContext as GeneralSettingsViewModel;
            _vm.SetUp();
        }

        private void TextBox_KeyDown(object sender, KeyEventArgs e)
        {
            e.Handled = WPFValidation.AllowNumberOnlyOnKeyDown(e);
        }
    }
}
