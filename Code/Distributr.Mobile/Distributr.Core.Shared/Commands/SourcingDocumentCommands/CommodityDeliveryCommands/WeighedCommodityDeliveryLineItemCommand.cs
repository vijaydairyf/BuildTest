﻿using System;
using Distributr.Core.Commands.DocumentCommands;

namespace Distributr.Core.Commands.SourcingDocumentCommands.CommodityDeliveryCommands
{
    public class WeighedCommodityDeliveryLineItemCommand : ApproveCommand
    {
        public WeighedCommodityDeliveryLineItemCommand()
        {
        }

        public WeighedCommodityDeliveryLineItemCommand(
            Guid commandId,
            Guid documentId,
            Guid documentItemLineId,
            Guid commandGeneratedByUserId,
            Guid commandGeneratedByCostCentreId,
            int costCentreApplicationCommandSequenceId,
            Guid commandGeneratedByCostCentreApplicationId,
            Guid parentDocId,

            double? longitude = null, double? latitude = null)
            : base(
                commandId, documentId, commandGeneratedByUserId, commandGeneratedByCostCentreId,
                costCentreApplicationCommandSequenceId, commandGeneratedByCostCentreApplicationId, parentDocId,
                longitude, latitude)
        {

            DocumentLineItemId = documentItemLineId;

        }

        public Guid DocumentLineItemId { get; set; }

        public override string CommandTypeRef
        {
            get { return CommandType.WeighedCommodityDeliveryLineItem.ToString(); }
        }
    }
}
  
