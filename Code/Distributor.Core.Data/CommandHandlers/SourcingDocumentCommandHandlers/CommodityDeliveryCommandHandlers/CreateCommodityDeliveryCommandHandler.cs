﻿using System;
using Distributr.Core.CommandHandler.SourcingDocumentCommandHandlers.CommodityDeliveryCommandHandler;
using Distributr.Core.Commands.SourcingDocumentCommands.CommodityDeliveryCommands;
using Distributr.Core.Data.EF;
using Distributr.Core.Domain.Transactional.DocumentEntities;
using log4net;

namespace Distributr.Core.Data.CommandHandlers.SourcingDocumentCommandHandlers.CommodityDeliveryCommandHandlers
{
    public class CreateCommodityDeliveryCommandHandler :BaseSourcingCommandHandler, ICreateCommodityDeliveryCommandHandler
    {

        ILog _log = LogManager.GetLogger("CreateCommodityDeliveryCommandHandler");
        public CreateCommodityDeliveryCommandHandler(CokeDataContext context) : base(context)
        {
        }

        public void Execute(CreateCommodityDeliveryCommand command)
        {
            _log.InfoFormat("Execute {1} - Command Id {0} ", command.CommandId, command.GetType().ToString());
            try
            {
                if (DocumentExists(command.DocumentId))
                    return;
                tblSourcingDocument doc = NewDocument(command, DocumentType.CommodityDelivery, command.DocumentRecipientCostCentreId);
                doc.DriverName = command.DriverName;
                doc.VehicleRegNo = command.VehicleRegNo;
                doc.RouteId = command.RouteId;
                doc.CentreId = command.CentreId;
                doc.VehicleArrivalMileage = command.VehicleArrivalMileage;
                doc.VehicleArrivalTime = command.VehicleArrivalTime;
                doc.VehicleDepartureMileage = command.VehicleDepartureMileage;
                doc.VehicleDepartureTime = command.VehicleDepartureTime;
                doc.Latitude = command.Latitude;
                doc.Longitude = command.Longitude;
                _context.tblSourcingDocument.AddObject(doc);
                _context.SaveChanges();

            }
            catch (Exception ex)
            {
                _log.ErrorFormat("Error Execute {1} - Command Id {0} ", command.CommandId, command.GetType().ToString());
                _log.Error("CreateCommodityDeliveryCommandHandler exception ", ex);
                throw;
            }
        }
    }
}
