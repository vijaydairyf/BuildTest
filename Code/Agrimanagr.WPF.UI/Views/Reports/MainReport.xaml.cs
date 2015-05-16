﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Text;
using System.Threading.Tasks;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Data;
using System.Windows.Documents;
using System.Windows.Forms.Integration;
using System.Windows.Input;
using System.Windows.Media;
using System.Windows.Media.Imaging;
using System.Windows.Navigation;
using System.Windows.Shapes;
using Distributr.Core.Utility;
using Distributr.WPF.Lib.Services.Service;
using Distributr.WPF.Lib.Services.Service.Utility;
using Microsoft.Reporting.WinForms;
using StructureMap;

namespace Agrimanagr.WPF.UI.Views.Reports
{
    /// <summary>
    /// Interaction logic for MainReport.xaml
    /// </summary>
    public partial class MainReport : Page
    {
        public MainReport()
        {
            InitializeComponent();
        }

        private void ViewReport_Click(object sender, RoutedEventArgs e)
        {
            Hyperlink hyperlink = (Hyperlink) sender;
            NavigationService.Navigate(new Uri("views/reports/ReportView.xaml?" + hyperlink.Tag, UriKind.Relative));
        }

        private void CommodityPurchaseSummary_click(object sender, RoutedEventArgs e)
        {
            RenderReport("Commodity Purchase Summary", "/Agrimanagr.Reports/CommodityPurchaseByFactory_R");
        }

        void RenderReport(string title, string reportPath)
        {
            WindowsFormsHost windowsFormsHost = new WindowsFormsHost();
            var reportViewer = new ReportViewer();
            reportViewer.ProcessingMode = ProcessingMode.Remote;

           
            string url = "";
            string password = "";
            string username = "";
            Guid hubid = Guid.Empty;
            string folder = "";
            using (var c = ObjectFactory.Container.GetNestedContainer())
            {
                var settingrepo = c.GetInstance<IGeneralSettingRepository>();
                GeneralSetting passsetting = settingrepo.GetByKey(GeneralSettingKey.ReportPassword);
                if (passsetting != null) password = VCEncryption.DecryptString(passsetting.SettingValue);
                GeneralSetting usersetting = settingrepo.GetByKey(GeneralSettingKey.ReportUsername);
                if (usersetting != null) username = usersetting.SettingValue;
                GeneralSetting reportUrl = settingrepo.GetByKey(GeneralSettingKey.ReportUrl);
                if (reportUrl != null)
                {
                    url = reportUrl.SettingValue;
                   
                }
                GeneralSetting reportfolder = settingrepo.GetByKey(GeneralSettingKey.ReportFolder);
                if (reportfolder != null)
                {
                    folder = "/" + reportfolder.SettingValue;

                }
                hubid = c.GetInstance<IConfigService>().Load().CostCentreId;

            }
            reportViewer.ServerReport.ReportPath = folder + reportPath; // "/DistributrReports/Losses";
            reportViewer.ServerReport.ReportServerUrl = new Uri(url);
            reportViewer.ServerReport.ReportServerCredentials.NetworkCredentials = new NetworkCredential(username,
                                                                                                         password);
            try
            {
                ReportParameter hubidparam = new ReportParameter("hubId", hubid.ToString(), false);
                reportViewer.ServerReport.SetParameters(new ReportParameter[] { hubidparam });
            }catch
            {
                
            }
            //ReportParameter hubidparam = new ReportParameter("hubId", "E6834108-4BA7-4A1A-98CA-9DD4DF8D68E2", false);
           
            reportViewer.Drillthrough += DrillthroughEventHandler;
            //reportViewer.ServerReport.IsDrillthroughReport = true;
            reportViewer.ServerReport.Refresh();
            windowsFormsHost.Child = reportViewer;

            TabItem tab = new TabItem();
            tab.Header = title;
            Style style = this.FindResource("ClosableTabItemStyle") as Style;
            tab.Style = style;
            // tab.AddHandler(TabItem.ContextMenuClosingEvent, new RoutedEventHandler(this.CloseTab));



            tab.Content = windowsFormsHost;
            int i = ReportTab.Items.Add(tab);
            ReportTab.SelectedIndex = i;
            reportViewer.RefreshReport();
        }

        void DrillthroughEventHandler(object sender, DrillthroughEventArgs e)
        {
            Guid hubid = Guid.Empty;
            var report = e.Report;
            using (var c = ObjectFactory.Container.GetNestedContainer())
            {

                hubid = c.GetInstance<IConfigService>().Load().CostCentreId;

            }

            ReportParameter hubidparam = new ReportParameter("hubId", hubid.ToString(), false);
           // ReportParameter hubidparam = new ReportParameter("hubId", "E6834108-4BA7-4A1A-98CA-9DD4DF8D68E2", false);

            try
            {
                report.SetParameters(new ReportParameter[] {hubidparam});
            }
            catch (Exception ex)
            {
            }

            report.Refresh();

        }





        private void CloseTab(object sender, RoutedEventArgs e)
        {
            throw new NotImplementedException();
        }

        private void commodityPurchaseRouteSummary_click(object sender, RoutedEventArgs e)
        {
            RenderReport("Commodity Purchase By Route", "/Agrimanagr.Reports/CommodityPurchaseByRoute_R");  
        }

        private void commodityPurchaseCentre_click(object sender, RoutedEventArgs e)
        {
            RenderReport("Commodity Purchase By Centre", "/Agrimanagr.Reports/CommodityPurchaseByCentre_R");         
        }

        private void commodityPurchaseFarmer_click(object sender, RoutedEventArgs e)
        {
            RenderReport("Commodity Purchase By Farmer ", "/Agrimanagr.Reports/CommodityPurchaseByFarmer_R"); 
        }

        private void productionbycentre_click(object sender, RoutedEventArgs e)
        {
            RenderReport("Production By Centre ", "/Agrimanagr.Reports/ProductionByCentre"); 
        }
        private void productionbyroute_click(object sender, RoutedEventArgs e)
        {
            RenderReport("Production By Route ", "/Agrimanagr.Reports/ProductionByRoute"); 
        }

        private void CloseOfDay_click(object sender, RoutedEventArgs e)
        {
            RenderReport("Close Of Day ", "/Agrimanagr.Reports/CloseOfDay_R");
        }
        #region Collection Reports
        private void CollectionbycentreClick(object sender, RoutedEventArgs e)
        {
            RenderReport("Collection By Buying/Collection Centre", "/Agrimanagr.Reports/CommodityCollectionByCentre");
        }
        private void CollectionbyDriverClick(object sender, RoutedEventArgs e)
        {
            RenderReport("Collection By Driver", "/Agrimanagr.Reports/CommodityCollectionByDrivers");
        }
        #endregion

        #region Transaction Reports
        private void TransactionbyClerkClick(object sender, RoutedEventArgs e)
        {
            RenderReport("Transaction By Clerk", "/Agrimanagr.Reports/TransactionByClerk");
        }
        private void TransactionByCentreClick(object sender, RoutedEventArgs e)
        {
            RenderReport("Transaction By Centre", "/Agrimanagr.Reports/TransactionsByCentre");
        }
        #endregion

        #region Commodity Delivery Reports

        private void CommodityDeliverySummary_click(object sender, RoutedEventArgs e)
        {
            RenderReport("Commodity Delivery Summary", "/Agrimanagr.Reports/CommodityDeliveryByFactory_R");
        }

        private void commodityDeliveryRoute_click(object sender, RoutedEventArgs e)
        {
            RenderReport("Commodity Delivery By Route", "/Agrimanagr.Reports/CommodityDeliveryByRoute_R");
        }

        private void commodityDeliveryCentre_click(object sender, RoutedEventArgs e)
        {
            RenderReport("Commodity Delivery By Centre", "/Agrimanagr.Reports/CommodityDeliveryByCentre_R");
        }

        private void commodityDeliveryDriver_click(object sender, RoutedEventArgs e)
        {
            RenderReport("Commodity Delivery By Farmer ", "/Agrimanagr.Reports/CommodityDeliveryByDriver_R");
        }

        #endregion

        #region Commodity Reception Reports

        private void CommodityReceptionSummary_click(object sender, RoutedEventArgs e)
        {
            RenderReport("Commodity Reception Summary", "/Agrimanagr.Reports/CommodityReceptionByFactory_R");
        }

        private void commodityReceptionRoute_click(object sender, RoutedEventArgs e)
        {
            RenderReport("Commodity Reception By Route", "/Agrimanagr.Reports/CommodityReceptionByRoute_R");
        }

        private void commodityReceptionCentre_click(object sender, RoutedEventArgs e)
        {
            RenderReport("Commodity Reception By Centre", "/Agrimanagr.Reports/CommodityReceptionByCentre_R");
        }

        #endregion

        #region DailyTotals Reports
        private void DailyTotalsByRouteClick(object sender, RoutedEventArgs e)
        {
            RenderReport("Daily Totals By Route ", "/Agrimanagr.Reports/DailyTotalsByRoute");
        }
        private void DailyTotalsByCentreClick(object sender, RoutedEventArgs e)
        {
            RenderReport("Daily Totals By Centre ", "/Agrimanagr.Reports/DailyTotalsByCentre");
        }
        #endregion

        private void GainsLossesPerClerkClick(object sender, RoutedEventArgs e)
        {
            RenderReport("Gains/Losses Per Field Clerk ", "/Agrimanagr.Reports/GainsLossesPerFieldClerk");
        }

        private void FarmerDeliveliesClick(object sender, RoutedEventArgs e)
        {
            RenderReport("Farmer Deliveries ", "/Agrimanagr.Reports/OwnerDeliveryReport");   
        }

        private void TransactionbyFarmerClick(object sender, RoutedEventArgs e)
        {
            RenderReport("Transaction by Farmer ", "/Agrimanagr.Reports/TransactionByFarmer");
        }

        private void CommodityInventorybyStore_click(object sender, RoutedEventArgs e)
        {
            RenderReport("Commodity Inventory  by Store ", "/Agrimanagr.Reports/CommodityInventoryByStore");   
        }
    }
}