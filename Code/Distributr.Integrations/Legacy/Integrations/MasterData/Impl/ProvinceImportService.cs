﻿using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.Linq;
using System.Threading.Tasks;
using Distributr.Core.Data.EF;
using Distributr.Core.Domain.Master.CostCentreEntities;
using Distributr.Core.MasterDataDTO.DTOModels.MasterDataDTO.CostCentre;
using Distributr.Core.Repository.Master.CostCentreRepositories;
using Distributr.Core.Utility.Mapping;

namespace Distributr.Integrations.Legacy.Integrations.MasterData.Impl
{
   public class ProvinceImportService:MasterDataImportServiceBase, IProvinceImportService
    {
        private readonly IProvincesRepository _repository;
        private readonly IDTOToEntityMapping _mappingService;
        private readonly CokeDataContext _ctx;
        private List<ImportValidationResultInfo> validationResultInfos;

       public ProvinceImportService(IProvincesRepository repository, IDTOToEntityMapping mappingService, CokeDataContext ctx)
       {
           _repository = repository;
           _mappingService = mappingService;
           _ctx = ctx;
           validationResultInfos=new List<ImportValidationResultInfo>();
       }

       public async Task<MasterDataImportResponse> ValidateAsync(IEnumerable<ImportEntity> imports)
       {
           return await Task.Run(async () =>
           {
               var vResults = new MasterDataImportResponse();
               var dtos = await ConstructDtOs(imports);
               int index = 1;
               foreach (var dto in dtos)
               {
                   var res = await MapAndValidate(dto, index);
                   vResults.ValidationResults.Add(res);
                   index++;
               }
               return vResults;
           });
       }

       public async Task<MasterDataImportResponse> ValidateAndSaveAsync(IEnumerable<ImportEntity> imports)
       {
           return await Task.Run<MasterDataImportResponse>(async () =>
           {
               var vResults = new MasterDataImportResponse();
               var dtos = await ConstructDtOs(imports);
               int index = 1;
               foreach (var dto in dtos)
               {
                   var res = await MapAndValidate(dto, index);
                   if (res.IsValid)
                   {
                       _repository.Save(res.Entity as Province, true);
                   }
                   vResults.ValidationResults.Add(res);
                   index++;
               }
               if (validationResultInfos.Any())
               {
                   vResults.ValidationResults.AddRange(validationResultInfos);
                   validationResultInfos.Clear();
               }
               return vResults;
           });
       }

       private async Task<ImportValidationResultInfo> MapAndValidate(ProvinceDTO dto, int index)
       {
           return await Task.Run(() =>
           {
               if (dto == null) return null;
               var entity = _mappingService.Map(dto);
               var exist = _ctx.tblProvince.FirstOrDefault(p => p.Name.ToLower() == dto.Name.ToLower());

               entity.Id = exist == null ? Guid.NewGuid() : exist.Id;

               var res = _repository.Validate(entity);
               var vResult = new ImportValidationResultInfo()
               {
                   Results = res.Results,
                   Description =
                       string.Format("Row-{0} name or code=>{1}", index,
                                     entity.Name ?? entity.Description),
                   Entity = entity
               };
               return vResult;

           });


       }

       private async Task<IEnumerable<ProvinceDTO>> ConstructDtOs(IEnumerable<ImportEntity> entities)
       {
           var items = new List<ProvinceDTO>();
           return await Task.Run(() =>
           {
               items.AddRange(entities.Select(n => n.Fields).Select(row =>
                                                                        {
                                                                            var countryname = SetFieldValue(row, 3);
                                                                            tblCountry country = null;
                                                                            if (!string.IsNullOrEmpty(countryname))
                                                                                country =
                                                                                    _ctx.tblCountry.FirstOrDefault(
                                                                                        p =>
                                                                                        p.Name.ToLower() ==
                                                                                        countryname.ToLower());
                   if (country == null)
                   {
                       var res = new List<ValidationResult>
                                     {
                                         new ValidationResult(string.Format("Country with Name={0} not found",
                                                                            SetFieldValue(row, 3)))
                                     };
                       validationResultInfos.Add(new ImportValidationResultInfo()
                                                     {
                                                         Results = res
                                                     });
                       return null;
                   }
                   return new ProvinceDTO()
                   {
                       Name = SetFieldValue(row, 1),
                       CountryMasterId = country.id,
                       Description =SetFieldValue(row, 2)

                   };
               }));

               return items;
           });

       }
    }
}
