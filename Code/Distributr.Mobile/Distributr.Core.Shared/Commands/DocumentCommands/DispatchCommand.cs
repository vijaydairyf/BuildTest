﻿using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace Distributr.Core.Commands.DocumentCommands
{
  public abstract  class DispatchCommand : DocumentCommand
    {
      public DispatchCommand()
      {
          
      }
      protected DispatchCommand(Guid commandId, Guid documentId, Guid commandGeneratedByUserId, Guid commandGeneratedByCostCentreId, 
          int costCentreApplicationCommandSequenceId, Guid commandGeneratedByCostCentreApplicationId, Guid parentDocId, 
          double? longitude = null, double? latitude = null) 
          : base(commandId, documentId, commandGeneratedByUserId, commandGeneratedByCostCentreId, costCentreApplicationCommandSequenceId,
          commandGeneratedByCostCentreApplicationId, parentDocId, longitude, latitude)
      {
      }
    }
}
