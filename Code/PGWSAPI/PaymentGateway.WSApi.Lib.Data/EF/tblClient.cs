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
    
    public partial class tblClient
    {
        public tblClient()
        {
            this.tblClientMember = new HashSet<tblClientMember>();
        }
    
        public int Id { get; set; }
        public string ClientName { get; set; }
        public string ClientKeyWord { get; set; }
        public string ClientUri { get; set; }
        public string ApplicationId { get; set; }
        public string ApplicationPassword { get; set; }
        public string ExternalId { get; set; }
        public System.DateTime IM_DateCreated { get; set; }
        public System.DateTime IM_DateLastUpdated { get; set; }
        public int IM_Status { get; set; }
    
        public virtual ICollection<tblClientMember> tblClientMember { get; set; }
    }
}
