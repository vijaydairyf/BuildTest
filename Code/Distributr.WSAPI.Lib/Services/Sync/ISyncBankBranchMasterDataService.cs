﻿using Distributr.Core.ClientApp.CommandResults;
using Distributr.Core.MasterDataDTO.DTOModels.MasterDataDTO.Banks;
using Distributr.Core.Utility;
using Distributr.Core.Utility.MasterData;
using Distributr.WSAPI.Lib.System.Utility;

namespace Distributr.WSAPI.Lib.Services.Sync
{
    public interface ISyncBankBranchMasterDataService
    {
        SyncResponseMasterDataInfo<BankBranchDTO> GetBankBranch(QueryMasterData myQuery);
    }
}
