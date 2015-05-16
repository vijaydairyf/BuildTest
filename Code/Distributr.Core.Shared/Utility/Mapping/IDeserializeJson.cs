﻿using Distributr.Core.ClientApp.CommandResults;

namespace Distributr.Core.Utility.Mapping
{
    public interface IDeserializeJson
    {
        ResponseMasterDataInfo DeserializeResponseMasterDataInfo(string responseMasterDataInfo);
        DocumentCommandRoutingResponse DeserializeDocumentCommandRoutingResponse(string jsonString);
        BatchDocumentCommandRoutingResponse DeserializeBatchDocumentCommandRoutingResponse(string jsonString);
    }
}
