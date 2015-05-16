﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations.Schema;

namespace PaymentGateway.WSApi.Lib.Domain.Payments.Client.Request
{
    public class PaymentRequest : ClientRequestResponseBase
    {
        public PaymentRequest()
        {
            Extra= new Dictionary<string, string>();
        }
        public string ApplicationId { get; set; } //unique identifier generated by the SDP when provisioning an app
        public string SubscriberId { get; set; } //maps to subscriberId
        public string PaymentInstrumentName { get; set; }
        public string AccountId { get; set; }
        public double Amount { get; set; }
        public string Currency { get; set; }
        public string InvoiceNumber { get; set; }
        public string OrderNumber { get; set; }
        public bool AllowPartialPayments { get; set; }
        public bool AllowOverPayment { get; set; }
        [NotMapped]
        public Dictionary<string, string> Extra { get; set; }
        public string smsDescription { get; set; }//for Operator limit 40chars
    }
}