 
if not Exists(select * from sys.columns where Name = N'Id' and Object_ID = Object_ID(N'ProductTypes'))
begin  
	ALTER TABLE dbo.ProductTypes ADD Id UNIQUEIDENTIFIER NOT NULL DEFAULT NEWID();
end
