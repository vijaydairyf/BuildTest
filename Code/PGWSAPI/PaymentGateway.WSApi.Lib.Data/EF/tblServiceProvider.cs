//------------------------------------------------------------------------------
// <auto-generated>
//    This code was generated from a template.
//
//    Manual changes to this file may cause unexpected behavior in your application.
//    Manual changes to this file will be overwritten if the code is regenerated.
// </auto-generated>
//------------------------------------------------------------------------------

namespace PaymentGateway.WSApi.Lib.Data.EF
{
    using System;
    using System.Collections.Generic;
    
    public partial class tblServiceProvider
    {
        public int Id { get; set; }
        public string SDP_APP_ID { get; set; }
        public string SDP_Password { get; set; }
        public string SubscriberId { get; set; }
        public string Currecy { get; set; }
        public bool AllowPartialPayment { get; set; }
        public bool AllowOverPayment { get; set; }
        public string SPName { get; set; }
        public string SPCode { get; set; }
        public string SPId { get; set; }
        public System.DateTime IM_DateCreated { get; set; }
        public System.DateTime IM_DateUpdated { get; set; }
        public bool IM_IsActive { get; set; }
        public string SmsShortCode { get; set; }
    }
}