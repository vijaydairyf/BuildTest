﻿using System;
using System.Linq;
using Distributr.Core.Domain.Transactional;
using Distributr.Mobile.Core.OrderSale;
using Distributr.Mobile.Core.Products;
using NUnit.Framework;

namespace Distributr.Mobile.Core.Test.OrderSale
{
    [TestFixture]
    public class OrderTest
    {
        [Test]
        public void CalculatesCorrectTotalIncludingVatRoundedUp()
        {
            var order = new MockOrderBuilder()
                .WithLineItem(price: 1.5m, vatRate: 0.10m, eachQuantity: 100m)
                .WithLineItem(price: 0.99m, vatRate: 0.20m, eachQuantity: 49m)
                .Build();

            //165
            //58.212
            //= 223.212
            //= 224 when rounded up
            Assert.AreEqual(224m, order.TotalValueIncludingVat, "Total inc VAT");
        }

        [Test]
        public void GeneratesCorrectChequePaymentDetails()
        {
            var order = new MockOrderBuilder()
                .WithChequePayment("12345678", "0267K", "09875", 1m)
                .Build();

            Assert.AreEqual(PaymentMode.Cheque, order.Payments[0].PaymentMode, "Payment Mode");
            Assert.AreEqual(string.Format("{0} - {1} - {2}", "12345678", "0267K", "09875"), order.Payments[0].PaymentReference, "Payment Reference");
            Assert.AreEqual(1m, order.Payments[0].Amount, "Payment Amount");
            Assert.AreEqual("0267K", order.Payments[0].Bank, "Bank");
            Assert.AreEqual("09875", order.Payments[0].BankBranch, "Bank Branch");
        }

        [Test]
        public void GeneratesCorrectCashPaymentDetails()
        {
            var order = new MockOrderBuilder()
                .WithCashPayment("cash ref", 99.9m)
                .Build();

            Assert.AreEqual(PaymentMode.Cash, order.Payments[0].PaymentMode, "Payment Mode");
            Assert.AreEqual("cash ref", order.Payments[0].PaymentReference, "Payment Reference");
            Assert.AreEqual(99.9m, order.Payments[0].Amount, "Payment Amount");            
        }

        [Test]
        public void CalculatesCorrectTotalPayments()
        {
            var order = new MockOrderBuilder()
                .WithCashPayment(amount: 100)
                .WithChequePayment(amount: 59.50m)
                .Build();

            Assert.AreEqual(159.50m, order.TotalPayments);
        }

        [Test]
        public void UpdatesAmountDueAfterReceivingPayment()
        {
            var order = new MockOrderBuilder()
                .WithLineItem(price: 100, eachQuantity: 1)
                .Build();

            //includes 10% VAT
            Assert.AreEqual(order.BalanceOutstanding, 110);

            order.AddCashPayment("partial payment ", 50m);

            Assert.AreEqual(order.BalanceOutstanding, 60);
        }

        [Test]
        public void ConfirmsNewPayments()
        {
            var order = new MockOrderBuilder()
                .WithLineItem(price: 100, eachQuantity: 1)
                .WithCashPayment()
                .Build();

            Assert.AreEqual(1, order.NewPayments.Count, "new payments before confirm");

            order.ConfirmNewPayments();

            Assert.AreEqual(0, order.NewPayments.Count, "new payments after confirm");
            Assert.AreEqual(PaymentStatus.Confirmed, order.Payments[0].PaymentStatus, "payment status");
        }

        [Test]
        public void UpdatesNewLineItemsAfterApproval()
        {
            var order = new MockOrderBuilder()
                .WithLineItem()
                .WithLineItem()
                .Build();

            Assert.AreEqual(2, order.LineItems.Count(l => l.LineItemStatus == LineItemStatus.New));

            order.ApproveNewLineItems();

            Assert.AreEqual(0, order.LineItems.Count(l => l.LineItemStatus == LineItemStatus.New), "item status new");
            Assert.AreEqual(2, order.LineItems.Count(l => l.LineItemStatus == LineItemStatus.Approved), "item status approved");
            Assert.AreEqual(1, order.ApprovedLineItems[0].ApprovedQuantity, "item 1 quantity");
            Assert.AreEqual(1, order.ApprovedLineItems[1].ApprovedQuantity, "item 2 quantity");
        }

        [Test]
        public void ReportsFullyPaidWhenPaymentValueMatchesOrderValue()
        {
            var order = new MockOrderBuilder()
                .WithLineItem(price: 100)
                //Includes 10% VAT
                .WithCashPayment(amount: 110)
                .Build();         
   
            Assert.IsTrue(order.IsFullyPaid, "fully paid");
        }

        [Test]
        public void DoesNotReportFullyPaidWhenPaymentValueIsLessThanOrderValue()
        {
            var order = new MockOrderBuilder()
                .WithLineItem(price: 100)
                //Includes 10% VAT
                .WithCashPayment(amount: 10)
                .Build();

            Assert.IsFalse(order.IsFullyPaid, "fully paid");
        }

        [Test]
        public void CanAddAndRemoveReturnableItems()
        {
            var order = new MockOrderBuilder().Build();
            //Product has a container size of 24
            var product = MockOrderBuilder.AProductWithPrice(1);
            product.VATClass = MockOrderBuilder.AVatClassWithRate(0.10m);

            var wrapper = new ProductWrapper() { 
                SaleProduct = product, 
                EachQuantity = 2, 
                CaseQuantity = 1, 
                EachReturnableQuantity = 50, 
                CaseReturnableQuantity = 1 };

            order.AddOrUpdateSaleLineItem(wrapper);

            Assert.AreEqual(3, order.AllInvoiceItems.Count, "all items");

            wrapper.EachReturnableQuantity = wrapper.CaseReturnableQuantity = 0;

            order.AddOrUpdateSaleLineItem(wrapper);

            Assert.AreEqual(1, order.AllInvoiceItems.Count, "all items");
        }

        [Test]
        public void RemoveItemAndReturnablesWhenQuantityIsZero()
        {
            var order = new MockOrderBuilder().Build();
            //Product has a container size of 24
            var product = MockOrderBuilder.AProductWithPrice(1);
            product.VATClass = MockOrderBuilder.AVatClassWithRate(0.10m);

            var wrapper = new ProductWrapper()
            {
                SaleProduct = product,
                EachQuantity = 2,
                CaseQuantity = 1,
                EachReturnableQuantity = 50,
                CaseReturnableQuantity = 1
            };

            order.AddOrUpdateSaleLineItem(wrapper);

            Assert.AreEqual(3, order.AllItems.Count, "all items");

            wrapper.EachQuantity = wrapper.CaseQuantity = 0;

            order.AddOrUpdateSaleLineItem(wrapper);

            Assert.AreEqual(0, order.AllItems.Count, "all items");
        }

        [Test]
        public void CalculatesCorrectNetQuantitiesWhenIncludingReturnables()
        {
            var order = new MockOrderBuilder().Build();
            //Product has a container size of 24
            var product = MockOrderBuilder.AProductWithPrice(1);
            product.VATClass = MockOrderBuilder.AVatClassWithRate(0.10m);

            var wrapper = new ProductWrapper()
            {
                SaleProduct = product,
                EachQuantity = 2,
                CaseQuantity = 1,
            };

            order.AddOrUpdateOrderLineItem(wrapper);
            // 2 each + 24 in container
            Assert.AreEqual(26, order.AllItems.First(p => p is ProductLineItem).Quantity, "all items");

            Assert.AreEqual(26, order.AllItems.First(p => p.Description == "item returnable").Quantity, "item returnable");
            Assert.AreEqual(1, order.AllItems.First(p => p.Description == "container returnable").Quantity, "container returnable");
        }

        [Test]
        public void UpdatesQuantityForExistingItem()
        {
            var order = new MockOrderBuilder()
                .WithLineItem(caseQuantity: 1, eachQuantity: 1)
                .Build();

            var wrapper = new ProductWrapper()
            {
                SaleProduct = order.LineItems[0].Product,
                EachQuantity = 2,
                CaseQuantity = 2,
            };

            order.AddOrUpdateSaleLineItem(wrapper);

            Assert.AreEqual(1, order.AllItems.Count, "all items count");
            // (2 x 24) + 2
            Assert.AreEqual(50, order.LineItems[0].Quantity, "item quantity");
        }

        [Test]
        public void ConfirmsApprovedLineItems()
        {
            var order = new MockOrderBuilder()
                .WithLineItem()
                .WithLineItem()
                .Build();

            order.LineItems[1].LineItemStatus = LineItemStatus.Approved;
            
            order.ConfirmApprovedLineItems();

            Assert.AreEqual(1, order.LineItems.Count(o => o.LineItemStatus == LineItemStatus.Confirmed), "confirmed count");
            Assert.AreEqual(2, order.LineItems.Count, "all items count");
        }

        [Test]
        public void ConfirmsAllLineItems()
        {
            var order = new MockOrderBuilder()
                .WithLineItem()
                .WithLineItem()
                .Build();

            order.ConfirmAllLineItems();

            Assert.AreEqual(2, order.LineItems.Count(o => o.LineItemStatus == LineItemStatus.Confirmed), "confirmed items count");            
        }
    }
}
