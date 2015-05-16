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
using System.Windows.Shapes;
using Distributr.Core.Domain.Master.CostCentreEntities;
using Distributr.Core.Domain.Master.SuppliersEntities;
using Distributr.Core.Domain.Transactional.DocumentEntities;
using Distributr.WPF.Lib.UI.Hierarchy;
using Distributr.WPF.Lib.UI.Pages;
using Distributr.WPF.Lib.UI.UI_Utillity;
using Distributr.WPF.Lib.ViewModels.Transactional.Orders;

namespace Distributr.WPF.UI.Views.Orders
{
    /// <summary>
    /// Interaction logic for OrderProductPopup.xaml
    /// </summary>
    public partial class OrderProductPopup : Window, IOrderProductPage
    {
        private ProductMainOrderLineItem vm;

       public OrderProductPopup()
        {
            InitializeComponent();
            this.CenterWindowOnScreen();
            vm = this.DataContext as ProductMainOrderLineItem;
            vm.ProductMainOrderLineItemLoadCommand.Execute(null);
            vm.RequestClose += (s, e) => this.Close();
        }
       
        public List<ProductPopUpItem> GetProduct(Outlet outlet,OrderType orderType)
        {
            vm.SetUp(outlet, orderType);
            this.Owner = Application.Current.MainWindow;
            this.ShowDialog();
            return vm.GetProductsLineItem();
        }

        public List<ProductPopUpItem> GetProductBySupplier(Outlet outlet, OrderType orderType, Supplier supplier)
        {
            throw new NotImplementedException();
        }

        public List<ProductPopUpItem> GetProduct(Outlet outlet, OrderType orderType, List<ProductPopUpItem> existing)
        {
            vm.SetUpPOS(outlet, orderType,existing);
            this.Owner = Application.Current.MainWindow;
            this.ShowDialog();
            return vm.GetProductsLineItem();
        }

        public List<ProductPopUpItem> EditProduct(Outlet outlet, Guid productId, decimal quantity, OrderType orderType)
        {
            vm.SetUp(outlet, orderType);
            vm.LoadForEdit(productId,quantity);
            this.Owner = Application.Current.MainWindow;
            this.ShowDialog();
            return vm.GetProductsLineItem();
        }
        

        public List<ProductPopUpItem> GetReturnables(Outlet outlet, Dictionary<Guid,int> returnables, OrderType orderType)
        {
            vm.SetUp(outlet,orderType);
            vm.SetReturnables(outlet, returnables);
            this.Owner = Application.Current.MainWindow;
             ShowDialog();
             return vm.GetProductsLineItem();
        }
       
        protected override void OnClosed(EventArgs e)
        {
            base.OnClosed(e);
           vm.Cleanup();
        }
    }
}
