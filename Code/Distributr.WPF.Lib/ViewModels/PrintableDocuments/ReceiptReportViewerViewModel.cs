﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Distributr.Core.Domain.Master.CostCentreEntities;
using Distributr.Core.Domain.Transactional;
using Distributr.Core.Domain.Transactional.DocumentEntities.LineItems;
using Distributr.Core.Repository.Master.CostCentreRepositories;
using Distributr.Core.Repository.Transactional.DocumentRepositories.IInvoiceRepositories;
using Distributr.Core.Repository.Transactional.DocumentRepositories.ReceiptInventories;
using Distributr.WPF.Lib.Services.DocumentReports;
using Distributr.WPF.Lib.Services.DocumentReports.Receipt;

namespace Distributr.WPF.Lib.ViewModels.PrintableDocuments
{
    public partial class DocumentReportViewerViewModel
    {
        public ReceiptReportContainer GetReceipt(Guid receiptId)
        {
            using (StructureMap.IContainer c = NestedContainer)
            {
                ReceiptReportContainer doc = new ReceiptReportContainer();
                ReceiptReportHeader docHeader = new ReceiptReportHeader();
                CompanyHeaderReport compHeader = new CompanyHeaderReport();

                doc.DocumentHeader = docHeader;
                doc.CompanyHeader = compHeader;

                var receipt = Using<IReceiptRepository>(c).GetById(receiptId);
                var invoice = Using<IInvoiceRepository>(c).GetById(receipt.InvoiceId);

                docHeader.CompanyName = receipt.DocumentIssuerCostCentre.Name;
                docHeader.ChequePayableTo = receipt.DocumentIssuerCostCentre.Name;
                docHeader.ReceiptNo = receipt.DocumentReference;
                docHeader.ReceiptDate = receipt.DocumentDateIssued;
                docHeader.ServedByUserName = receipt.DocumentIssuerUser.Username;
                docHeader.ReceiptRecipientCompanyName = receipt.DocumentRecipientCostCentre.Name;
                docHeader.InvoiceRef = invoice.DocumentReference;
                docHeader.InvoiceDate = invoice.DocumentDateIssued;
                docHeader.DatePrinted = DateTime.Now;

                var rli =
                    receipt.LineItems
                        .Where(n => n.LineItemType == OrderLineItemType.PostConfirmation)
                        .Select((n, i) =>
                                new ReceiptReportLineItem
                                    {
                                        RowNumber = i + 1,
                                        Description = n.Description,
                                        PaymentMode =
                                            n.PaymentType == PaymentMode.MMoney
                                                ? n.MMoneyPaymentType
                                                : (n.PaymentType).ToString(),
                                        PaymentReference = n.PaymentRefId,
                                        Amount = n.Value
                                    });

                var invoiceTotalNet = invoice.TotalNet;
                var invoiceTotalVat = invoice.TotalVat;
                var invoiceTotalGross = invoice.TotalGross;

                docHeader.TotalGross = rli.Sum(n => n.Amount);
                docHeader.TotalNet = ((Convert.ToDecimal(docHeader.TotalGross)/invoiceTotalGross)*invoiceTotalNet);
                docHeader.TotalVat = ((Convert.ToDecimal(docHeader.TotalGross)/invoiceTotalGross)*invoiceTotalVat);

                docHeader.DocumentIssuerDetails = "Generated by: " + docHeader.ServedByUserName + " ; Cost centre: " +
                                                  docHeader.CompanyName + "; Date: " +
                                                  docHeader.DatePrinted.ToShortDateString();

                foreach (var item in rli) doc.LineItems.Add(item);

                Distributor distributr = null;
                if (receipt.DocumentIssuerCostCentre is Distributor)
                {
                    distributr = receipt.DocumentIssuerCostCentre as Distributor;
                }
                if (invoice.DocumentRecipientCostCentre is Distributor)
                {
                    distributr = invoice.DocumentRecipientCostCentre as Distributor;
                }
                //contact info


                compHeader.CompanyName = receipt.DocumentIssuerCostCentre.Name;

                Contact contact = null;
                if (distributr.Contact.Any())
                {
                    contact = distributr.Contact.FirstOrDefault(
                        n => n.ContactClassification == ContactClassification.PrimaryContact);
                }
                if (contact == null)
                {
                    var contacts = Using<IContactRepository>(c).GetByContactsOwnerId(distributr.Id);
                    contact = contacts.FirstOrDefault(
                        n => n.ContactClassification == ContactClassification.PrimaryContact) ??
                              contacts.FirstOrDefault();
                }
                if (contact != null)
                {
                    compHeader.PostalAddress = contact.PostalAddress;
                    compHeader.PhysicalAddress = contact.City == contact.PhysicalAddress
                                                     ? contact.City
                                                     : contact.City + " ," +
                                                       contact.PhysicalAddress;
                    compHeader.Telephone = contact.BusinessPhone;
                    compHeader.Fax = contact.Fax;
                    compHeader.CellNo = contact.MobilePhone;
                    compHeader.Email = contact.Email;
                }

                compHeader.VATNo = distributr != null ? distributr.VatRegistrationNo : "";
                compHeader.PINNo = distributr != null ? distributr.PIN : "";
                compHeader.WebSite = "";


                compHeader.ContactsConcat = compHeader.PhysicalAddress + ", "
                                                + compHeader.PostalAddress + ", ";
                compHeader.ContactsConcat += "Tel: " + compHeader.Telephone + ",";
                compHeader.ContactsConcat += "Cell: " + compHeader.CellNo + ",";

                if (!string.IsNullOrEmpty(compHeader.Fax))
                    compHeader.ContactsConcat += "Fax: " + compHeader.Fax + ", ";

                if (!string.IsNullOrEmpty(compHeader.VATNo))
                    compHeader.ContactsConcat += "VAT No: " + compHeader.VATNo + ".";

                if (!string.IsNullOrEmpty(compHeader.PINNo))
                    compHeader.ContactsConcat += "PIN No: " + compHeader.PINNo + ".";

                if (!string.IsNullOrEmpty(compHeader.Email))
                    compHeader.ContactsConcat += "Email: " + compHeader.Email + ".";

                if (!string.IsNullOrEmpty(compHeader.WebSite))
                    compHeader.ContactsConcat += "Web Site: " + compHeader.WebSite + ".";

                CompanyHeader = compHeader;

                return doc;
            }
        }

    }
}
