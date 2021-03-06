IF NOT EXISTS (SELECT * FROM sys.objects WHERE type = 'P' AND name = 'sp_A_Drivers')
   exec('CREATE PROCEDURE [sp_A_Drivers] AS BEGIN SET NOCOUNT ON; END')
GO
Alter PROCEDURE sp_A_Drivers	 	 
AS
BEGIN
	   
	SELECT  'ALL' AS driverId, 'ALL' AS driverName
	UNION
	--SELECT LOWER(convert(varchar(50),usr.Id)) AS driverId, convert(varchar(50),usr.UserName) as driverName
	--FROM dbo.tblUsers AS usr 
	--WHERE usr.UserType = 11
	SELECT distinct LOWER(convert(varchar(50),usr.Id)) AS driverId, convert(varchar(50),usr.UserName) as driverName
	from tblcostcentre cc 
	left JOIN tblSourcingDocument  doc ON cc.Id = doc.DocumentIssuerCostCentreId or  cc.Id =DocumentRecipientCostCentreId
	left join tblUsers usr on usr.UserName = doc.drivername
	where cc.costcentretype= 8 and doc.DocumentTypeId = 16
	order by driverName
END;

--EXEC sp_A_Drivers @routeid='ALL', @hubId='ALL'
--EXEC sp_A_Drivers @routeid='ALL', @hubId='E6834108-4BA7-4A1A-98CA-9DD4DF8D68E3'
--EXEC sp_A_Drivers @hubId='E6834108-4BA7-4A1A-98CA-9DD4DF8D68E2'
--EXEC sp_A_Drivers @routeid='9b3fe18e-0bba-471c-a4c6-96ea9ebd0277'
--EXEC sp_A_Drivers @centreid='E04AB521-7034-4059-9941-E401B49B7CE4'
