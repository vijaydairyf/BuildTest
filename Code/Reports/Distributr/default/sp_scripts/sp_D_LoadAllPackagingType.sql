--USE [DistributrTrunk]
--GO
/****** Object:  StoredProcedure [dbo].[sp_D_LoadAllPackagingType]    Script Date: 09/20/2013 16:07:48 ******/
--SET ANSI_NULLS ON
--GO
--SET QUOTED_IDENTIFIER ON
--GO
--ALTER procedure [dbo].[sp_D_LoadAllPackagingType]
DROP PROCEDURE [dbo].[sp_D_LoadAllPackagingType]
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE procedure [dbo].[sp_D_LoadAllPackagingType]

as 

SELECT TOP(1) 'ALL' PackagingTypeId,
              'ALL' PackagingType
         


UNION  ALL

SELECT     LOWER(CONVERT(nvarchar(50),id)) AS PackagingTypeId,
           name AS PackagingType 
           
           
FROM       dbo.tblProductPackagingType
--WHERE dbo.tblProductPackagingType.IM_Status = 1

order by PackagingType


