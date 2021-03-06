﻿//------------------------------------------------------------------------------
// <auto-generated>
//     This code was generated by a tool.
//     Runtime Version:4.0.30319.18449
//
//     Changes to this file may cause incorrect behavior and will be lost if
//     the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace Distributr.Core.Data.Resources.OutletOrders {
    using System;
    
    
    /// <summary>
    ///   A strongly-typed resource class, for looking up localized strings, etc.
    /// </summary>
    // This class was auto-generated by the StronglyTypedResourceBuilder
    // class via a tool like ResGen or Visual Studio.
    // To add or remove a member, edit your .ResX file then rerun ResGen
    // with the /str option, or rebuild your VS project.
    [global::System.CodeDom.Compiler.GeneratedCodeAttribute("System.Resources.Tools.StronglyTypedResourceBuilder", "4.0.0.0")]
    [global::System.Diagnostics.DebuggerNonUserCodeAttribute()]
    [global::System.Runtime.CompilerServices.CompilerGeneratedAttribute()]
    internal class OutletOrdersResource {
        
        private static global::System.Resources.ResourceManager resourceMan;
        
        private static global::System.Globalization.CultureInfo resourceCulture;
        
        [global::System.Diagnostics.CodeAnalysis.SuppressMessageAttribute("Microsoft.Performance", "CA1811:AvoidUncalledPrivateCode")]
        internal OutletOrdersResource() {
        }
        
        /// <summary>
        ///   Returns the cached ResourceManager instance used by this class.
        /// </summary>
        [global::System.ComponentModel.EditorBrowsableAttribute(global::System.ComponentModel.EditorBrowsableState.Advanced)]
        internal static global::System.Resources.ResourceManager ResourceManager {
            get {
                if (object.ReferenceEquals(resourceMan, null)) {
                    global::System.Resources.ResourceManager temp = new global::System.Resources.ResourceManager("Distributr.Core.Data.Resources.OutletOrders.OutletOrdersResource", typeof(OutletOrdersResource).Assembly);
                    resourceMan = temp;
                }
                return resourceMan;
            }
        }
        
        /// <summary>
        ///   Overrides the current thread's CurrentUICulture property for all
        ///   resource lookups using this strongly typed resource class.
        /// </summary>
        [global::System.ComponentModel.EditorBrowsableAttribute(global::System.ComponentModel.EditorBrowsableState.Advanced)]
        internal static global::System.Globalization.CultureInfo Culture {
            get {
                return resourceCulture;
            }
            set {
                resourceCulture = value;
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to ;with cte as (select  o.Id, 
        /// o.DocumentDateIssued as [Required],
        /// o.DocumentReference,
        /// o.ExtDocumentReference,
        /// (select Name from tblCostCentre where CostCentreType=4 and  (o.DocumentIssuerCostCentreId=id or o.DocumentRecipientCostCentre=id))as Salesman,
        /// (select Name from tblCostCentre where CostCentreType=2 and  (o.DocumentIssuerCostCentreId=id or o.DocumentRecipientCostCentre=id))as Distributor,
        /// (select Name from tblCostCentre where CostCentreType=5 and  o.OrderIssuedOnBehalfOfCC=id )as Outlet,        /// [rest of string was truncated]&quot;;.
        /// </summary>
        internal static string DispatchedOutletOrders {
            get {
                return ResourceManager.GetString("DispatchedOutletOrders", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to ;with cte as (select  o.Id, 
        /// o.DocumentDateIssued as [Required],
        /// o.DocumentReference,
        /// o.ExtDocumentReference,
        /// (select Name from tblCostCentre where CostCentreType=4 and  (o.DocumentIssuerCostCentreId=id or o.DocumentRecipientCostCentre=id))as Salesman,
        /// (select Name from tblCostCentre where CostCentreType=2 and  (o.DocumentIssuerCostCentreId=id or o.DocumentRecipientCostCentre=id))as Distributor,
        /// (select Name from tblCostCentre where CostCentreType=5 and  o.OrderIssuedOnBehalfOfCC=id )as Outlet,        /// [rest of string was truncated]&quot;;.
        /// </summary>
        internal static string OutletOrders {
            get {
                return ResourceManager.GetString("OutletOrders", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to ;with cte as (select  o.Id, 
        /// o.DocumentDateIssued as [Required],
        /// o.DocumentReference,
        /// o.ExtDocumentReference,
        /// (select Name from tblCostCentre where CostCentreType=4 and  (o.DocumentIssuerCostCentreId=id or o.DocumentRecipientCostCentre=id))as Salesman,
        /// (select Name from tblCostCentre where CostCentreType=2 and  (o.DocumentIssuerCostCentreId=id or o.DocumentRecipientCostCentre=id))as Distributor,
        /// (select Name from tblCostCentre where CostCentreType=5 and  o.OrderIssuedOnBehalfOfCC=id )as Outlet,        /// [rest of string was truncated]&quot;;.
        /// </summary>
        internal static string OutletOrdersPendingApproval {
            get {
                return ResourceManager.GetString("OutletOrdersPendingApproval", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to ;with cte as (select  o.Id, 
        /// o.DocumentDateIssued as [Required],
        /// o.DocumentReference,
        /// o.ExtDocumentReference,
        /// (select Name from tblCostCentre where CostCentreType=4 and  (o.DocumentIssuerCostCentreId=id or o.DocumentRecipientCostCentre=id))as Salesman,
        /// (select Name from tblCostCentre where CostCentreType=2 and  (o.DocumentIssuerCostCentreId=id or o.DocumentRecipientCostCentre=id))as Distributor,
        /// (select Name from tblCostCentre where CostCentreType=5 and  o.OrderIssuedOnBehalfOfCC=id )as Outlet,        /// [rest of string was truncated]&quot;;.
        /// </summary>
        internal static string OutletOrdersPendingDispatch {
            get {
                return ResourceManager.GetString("OutletOrdersPendingDispatch", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to ;with cte as (select  o.Id, 
        /// o.DocumentDateIssued as [Required],
        /// o.DocumentReference,
        /// o.ExtDocumentReference,
        /// (select Name from tblCostCentre where CostCentreType=4 and  (o.DocumentIssuerCostCentreId=id or o.DocumentRecipientCostCentre=id))as Salesman,
        /// (select Name from tblCostCentre where CostCentreType=2 and  (o.DocumentIssuerCostCentreId=id or o.DocumentRecipientCostCentre=id))as Distributor,
        /// (select Name from tblCostCentre where CostCentreType=5 and  o.OrderIssuedOnBehalfOfCC=id )as Outlet,        /// [rest of string was truncated]&quot;;.
        /// </summary>
        internal static string OutstandingOutletOrders {
            get {
                return ResourceManager.GetString("OutstandingOutletOrders", resourceCulture);
            }
        }
        
        /// <summary>
        ///   Looks up a localized string similar to ;with cte as (select  o.Id, 
        /// o.DocumentDateIssued as [Required],
        /// o.DocumentReference,
        /// o.ExtDocumentReference,
        /// (select Name from tblCostCentre where CostCentreType=4 and  (o.DocumentIssuerCostCentreId=id or o.DocumentRecipientCostCentre=id))as Salesman,
        /// (select Name from tblCostCentre where CostCentreType=2 and  (o.DocumentIssuerCostCentreId=id or o.DocumentRecipientCostCentre=id))as Distributor,
        /// (select Name from tblCostCentre where CostCentreType=5 and  o.OrderIssuedOnBehalfOfCC=id )as Outlet,        /// [rest of string was truncated]&quot;;.
        /// </summary>
        internal static string RejectedOutletOrders {
            get {
                return ResourceManager.GetString("RejectedOutletOrders", resourceCulture);
            }
        }
    }
}
