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
    
    public partial class tblRequestResponce
    {
        public tblRequestResponce()
        {
            this.tblRequestResponceDestination = new HashSet<tblRequestResponceDestination>();
        }
    
        public int Id { get; set; }
        public string ReferenceId { get; set; }
        public string MessageId { get; set; }
        public string StatusCode { get; set; }
        public string StatusDetails { get; set; }
        public string Vesion { get; set; }
        public System.DateTime DateCreated { get; set; }
    
        public virtual ICollection<tblRequestResponceDestination> tblRequestResponceDestination { get; set; }
    }
}
