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
    
    public partial class tblRequest
    {
        public int Id { get; set; }
        public string ReferenceId { get; set; }
        public decimal Amount { get; set; }
        public int MessageType { get; set; }
        public string Payee { get; set; }
        public string Smsc_TillNumber { get; set; }
        public string Smsc_PhoneNumber { get; set; }
        public System.DateTime DateCreated { get; set; }
        public System.Guid ApplicationId { get; set; }
    }
}
