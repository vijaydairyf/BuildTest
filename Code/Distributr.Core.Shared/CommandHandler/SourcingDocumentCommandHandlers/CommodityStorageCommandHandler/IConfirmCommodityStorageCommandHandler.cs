﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using Distributr.Core.Commands;
using Distributr.Core.Commands.SourcingDocumentCommands.CommodityStorageCommands;

namespace Distributr.Core.CommandHandler.SourcingDocumentCommandHandlers.CommodityStorageCommandHandler
{
    public interface IConfirmCommodityStorageCommandHandler : ICommandHandler<ConfirmCommodityStorageCommand>
    {
    }
}
