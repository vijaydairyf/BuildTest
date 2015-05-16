﻿using System;
using System.Linq;
using Distributr.Core.ClientApp.CommandResults;
using Distributr.Core.Data.EF;
using Distributr.Core.Domain.Master;
using Distributr.Core.MasterDataDTO.DTOModels.MasterDataDTO.Assets;
using Distributr.Core.Utility;
using Distributr.Core.Utility.MasterData;
using Distributr.WSAPI.Lib.System.Utility;

namespace Distributr.WSAPI.Lib.Services.Sync.Impl
{
    public class SyncAssetCategoryMasterDataService : ISyncAssetCategoryMasterDataService
    {
        private readonly CokeDataContext _context;

        public SyncAssetCategoryMasterDataService(CokeDataContext context)
        {
            _context = context;
        }

        public SyncResponseMasterDataInfo<AssetCategoryDTO> GetAssetCategory(QueryMasterData myQuery)
        {
            var response = new SyncResponseMasterDataInfo<AssetCategoryDTO>();
            response.MasterData = new SyncMasterDataInfo<AssetCategoryDTO>();
            response.MasterData.EntityName = MasterDataCollective.AssetCategory.ToString();
            try
            {
                var query = _context.tblAssetCategory.AsQueryable();
                query = query.Where(n => n.IM_DateLastUpdated > myQuery.From 
                    && (n.IM_Status == (int)EntityStatus.Active || n.IM_Status == (int)EntityStatus.Inactive))
                    .OrderBy(s => s.IM_DateCreated);

                var deletedQuery = _context.tblAssetCategory.AsQueryable();
                deletedQuery = deletedQuery.Where(n => n.IM_DateLastUpdated > myQuery.From
                    && (n.IM_Status == (int)EntityStatus.Deleted))
                    .OrderBy(s => s.IM_DateCreated);

                if (myQuery.Skip.HasValue && myQuery.Take.HasValue)
                    query = query.Skip(myQuery.Skip.Value).Take(myQuery.Take.Value);
                if (myQuery.Skip.HasValue && myQuery.Skip.Value == 0)
                {
                    response.DeletedItems = deletedQuery.Select(s => s.Id).ToList();
                }
                response.MasterData.MasterDataItems = query.ToList().Select(n => Map(n)).ToArray();
                response.ErrorInfo = "Success";
            }
            catch (Exception ex)
            {
                response.ErrorInfo = ex.Message;
            }
            response.MasterData.LastSyncTimeStamp = DateTime.Now;
            return response;
        }

        private AssetCategoryDTO Map(tblAssetCategory tbl)
        {
            var dto = new AssetCategoryDTO
                          {
                              MasterId = tbl.Id,
                              DateCreated = tbl.IM_DateCreated,
                              DateLastUpdated = tbl.IM_DateLastUpdated,
                              StatusId = tbl.IM_Status,
                              Name = tbl.Description,
                              Description = tbl.Description,
                              AssetTypeMasterId = tbl.AssetTypeId
                          };
            return dto;
        }
    }
}