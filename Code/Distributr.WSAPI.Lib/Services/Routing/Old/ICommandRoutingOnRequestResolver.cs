﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using Distributr.Core.Commands;

namespace Distributr.WSAPI.Lib.Services.Routing
{
    public interface ICommandRoutingOnRequestResolver
    {
        CommandRouteOnRequestDTO GetCommand(ICommand command, CommandType commandType);
    }
}
