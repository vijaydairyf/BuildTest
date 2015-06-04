﻿using Distributr.Core.Commands;
using Distributr.Core.Commands.SourcingDocumentCommands.CommodityDeliveryCommands;

namespace Distributr.Core.CommandHandler.SourcingDocumentCommandHandlers.ReceivedDeliveryCommandHandler
{
    public interface IConfirmReceivedDeliveryCommandHandler : ICommandHandler<ConfirmReceivedDeliveryCommand>
    {
    }
}
