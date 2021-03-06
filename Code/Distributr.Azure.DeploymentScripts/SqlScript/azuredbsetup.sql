/****** Object:  Table [dbo].[rorIdGenerator]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[rorIdGenerator](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[f1] [nchar](1) NOT NULL
)

GO
/****** Object:  Table [dbo].[tblAccount]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblAccount](
	[id] [uniqueidentifier] NOT NULL,
	[CostCenterId] [uniqueidentifier] NOT NULL,
	[AccountType] [int] NOT NULL,
	[Balance] [money] NULL,
 CONSTRAINT [PK_tblAccount] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblAccountTransaction]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblAccountTransaction](
	[Id] [uniqueidentifier] NOT NULL,
	[AccountId] [uniqueidentifier] NOT NULL,
	[Amount] [decimal](18, 2) NOT NULL,
	[DocumentType] [int] NOT NULL,
	[DocumentId] [uniqueidentifier] NOT NULL,
	[DateInserted] [datetime] NOT NULL,
 CONSTRAINT [PK_AccountTransaction] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblActivityDocument]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblActivityDocument](
	[Id] [uniqueidentifier] NOT NULL,
	[ActivityReference] [nvarchar](250) NULL,
	[ActivityTypeId] [uniqueidentifier] NOT NULL,
	[Description] [nvarchar](250) NULL,
	[ActivityDate] [datetime] NOT NULL,
	[SeasonId] [uniqueidentifier] NOT NULL,
	[ClerkId] [uniqueidentifier] NOT NULL,
	[hubId] [uniqueidentifier] NOT NULL,
	[RouteId] [uniqueidentifier] NOT NULL,
	[CentreId] [uniqueidentifier] NOT NULL,
	[CommoditySupplierId] [uniqueidentifier] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
	[CommodityProducerId] [uniqueidentifier] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblActivityInfectionLineItem]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblActivityInfectionLineItem](
	[Id] [uniqueidentifier] NOT NULL,
	[InfectionId] [uniqueidentifier] NOT NULL,
	[InfectionRate] [decimal](4, 2) NOT NULL,
	[Description] [nvarchar](250) NULL,
	[ActivityId] [uniqueidentifier] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblActivityInputLineItem]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblActivityInputLineItem](
	[Id] [uniqueidentifier] NOT NULL,
	[ProductId] [uniqueidentifier] NOT NULL,
	[Description] [nvarchar](250) NULL,
	[Quantity] [decimal](18, 2) NOT NULL,
	[MF_Date] [datetime] NULL,
	[EP_Date] [datetime] NULL,
	[ActivityId] [uniqueidentifier] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblActivityProduceLineItem]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblActivityProduceLineItem](
	[Id] [uniqueidentifier] NOT NULL,
	[CommodityId] [uniqueidentifier] NOT NULL,
	[GradeId] [uniqueidentifier] NOT NULL,
	[Weight] [decimal](18, 2) NOT NULL,
	[Description] [nvarchar](250) NULL,
	[ActivityId] [uniqueidentifier] NOT NULL,
	[ServiceProviderId] [uniqueidentifier] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblActivityServiceLineItem]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblActivityServiceLineItem](
	[Id] [uniqueidentifier] NOT NULL,
	[ServiceProviderId] [uniqueidentifier] NOT NULL,
	[ServiceId] [uniqueidentifier] NOT NULL,
	[ShiftId] [uniqueidentifier] NOT NULL,
	[Description] [nvarchar](250) NULL,
	[ActivityId] [uniqueidentifier] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblActivityType]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblActivityType](
	[Id] [uniqueidentifier] NOT NULL,
	[Code] [nvarchar](50) NULL,
	[Name] [nvarchar](250) NOT NULL,
	[Description] [nvarchar](250) NULL,
	[IsInputsRequired] [bit] NOT NULL,
	[IsInfectionsRequired] [bit] NOT NULL,
	[IsServicesRequired] [bit] NOT NULL,
	[IsProduceRequired] [bit] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblArea]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblArea](
	[id] [uniqueidentifier] NOT NULL,
	[Name] [varchar](50) NULL,
	[Description] [varchar](50) NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[Region] [uniqueidentifier] NOT NULL,
	[IM_Status] [int] NOT NULL,
 CONSTRAINT [PK_Area] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblAsset]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblAsset](
	[Id] [uniqueidentifier] NOT NULL,
	[AssetTypeId] [uniqueidentifier] NOT NULL,
	[Code] [varchar](50) NULL,
	[Capacity] [varchar](50) NULL,
	[AssetNo] [varchar](50) NULL,
	[SerialNo] [varchar](50) NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[Name] [nvarchar](250) NULL,
	[AssetCategoryId] [uniqueidentifier] NULL,
	[AssetStatusId] [uniqueidentifier] NULL,
	[IM_Status] [int] NOT NULL,
 CONSTRAINT [PK_tblAsset] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblAssetCategory]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblAssetCategory](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](250) NOT NULL,
	[Description] [nvarchar](4000) NULL,
	[AssetTypeId] [uniqueidentifier] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
 CONSTRAINT [PK__tblAsset__3214EC076ACA8730] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblAssetStatus]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblAssetStatus](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](250) NOT NULL,
	[Description] [nvarchar](4000) NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
 CONSTRAINT [PK__tblAsset__3214EC073FE0292B] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblAssetType]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblAssetType](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [varchar](50) NULL,
	[Code] [varchar](50) NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
 CONSTRAINT [PK_tblAssetType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblAuditLog]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblAuditLog](
	[Id] [uniqueidentifier] NOT NULL,
	[OwnerId] [varchar](100) NOT NULL,
	[UserId] [varchar](100) NOT NULL,
	[Module] [varchar](100) NOT NULL,
	[Action] [varchar](max) NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
 CONSTRAINT [PK_tblAuditLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblBank]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblBank](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [varchar](150) NULL,
	[Code] [varchar](50) NULL,
	[Description] [varchar](150) NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
 CONSTRAINT [PK_tblBank] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblBankBranch]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblBankBranch](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [varchar](150) NULL,
	[Code] [varchar](50) NULL,
	[BankId] [uniqueidentifier] NOT NULL,
	[Description] [varchar](150) NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
 CONSTRAINT [PK_tblBankBranch] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblCentre]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCentre](
	[Id] [uniqueidentifier] NOT NULL,
	[CentreTypeId] [uniqueidentifier] NOT NULL,
	[HubId] [uniqueidentifier] NOT NULL,
	[Code] [nvarchar](50) NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](250) NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
	[RouteId] [uniqueidentifier] NULL,
 CONSTRAINT [PK__tblCentr__3214EC075D2BD0E6] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblCentreType]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCentreType](
	[Id] [uniqueidentifier] NOT NULL,
	[Code] [nvarchar](50) NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](250) NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
 CONSTRAINT [PK__tblCentr__3214EC07595B4002] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblCertainValueCertainProductDiscount]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCertainValueCertainProductDiscount](
	[id] [uniqueidentifier] NOT NULL,
	[Value] [money] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
 CONSTRAINT [PK_tblCertainValueCertainProductDiscount] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblCertainValueCertainProductDiscountItem]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCertainValueCertainProductDiscountItem](
	[id] [uniqueidentifier] NOT NULL,
	[CertainValueCertainDiscountID] [uniqueidentifier] NOT NULL,
	[Product] [uniqueidentifier] NOT NULL,
	[Quantity] [int] NOT NULL,
	[Value] [money] NOT NULL,
	[EffectiveDate] [datetime] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
	[EndDate] [datetime] NULL,
 CONSTRAINT [PK_tblCertainValueCertainProductDiscountItem] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblChannelPackaging]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblChannelPackaging](
	[id] [uniqueidentifier] NOT NULL,
	[PackagingId] [uniqueidentifier] NOT NULL,
	[OutletTypeId] [uniqueidentifier] NOT NULL,
	[IsChecked] [bit] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
 CONSTRAINT [PK_tblChannelPackaging] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblClientMasterDataTracker]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblClientMasterDataTracker](
	[CostCentreApplicationId] [uniqueidentifier] NOT NULL,
	[MasterDataId] [int] NOT NULL,
	[DateTimePushed] [datetime] NOT NULL,
	[DateTimePushConfirmed] [datetime] NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[Id] [uniqueidentifier] NOT NULL,
	[IM_Status] [int] NOT NULL,
 CONSTRAINT [PK_tblClientMasterDataTracker] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblCommodity]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCommodity](
	[Id] [uniqueidentifier] NOT NULL,
	[Code] [nvarchar](50) NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](250) NULL,
	[CommodityTypeId] [uniqueidentifier] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblCommodityGrade]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCommodityGrade](
	[Id] [uniqueidentifier] NOT NULL,
	[CommodityId] [uniqueidentifier] NOT NULL,
	[Code] [nvarchar](50) NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](250) NULL,
	[UsageTypeId] [int] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblCommodityOwner]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCommodityOwner](
	[Id] [uniqueidentifier] NOT NULL,
	[Code] [nvarchar](50) NULL,
	[Surname] [nvarchar](50) NOT NULL,
	[FirstName] [nvarchar](50) NOT NULL,
	[LastName] [nvarchar](50) NULL,
	[Gender] [int] NOT NULL,
	[IdNo] [nvarchar](50) NOT NULL,
	[PINNo] [nvarchar](50) NOT NULL,
	[DOB] [datetime] NOT NULL,
	[MaritalStatus] [int] NULL,
	[MaritalStatusId] [uniqueidentifier] NULL,
	[PhysicalAddress] [nvarchar](250) NULL,
	[PostalAddress] [nvarchar](250) NULL,
	[Email] [nvarchar](250) NULL,
	[PhoneNo] [nvarchar](20) NULL,
	[BusinessNo] [nvarchar](20) NULL,
	[FaxNo] [nvarchar](20) NULL,
	[OfficeNo] [nvarchar](20) NULL,
	[Description] [nvarchar](250) NULL,
	[CommodityOwnerTypeId] [uniqueidentifier] NOT NULL,
	[CostCentreId] [uniqueidentifier] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblCommodityOwnerType]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCommodityOwnerType](
	[Id] [uniqueidentifier] NOT NULL,
	[Code] [nvarchar](50) NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](250) NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblCommodityProducer]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCommodityProducer](
	[Id] [uniqueidentifier] NOT NULL,
	[Code] [nvarchar](50) NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Acrage] [nvarchar](50) NOT NULL,
	[RegNo] [nvarchar](50) NOT NULL,
	[PhysicalAddress] [nvarchar](250) NULL,
	[Description] [nvarchar](250) NULL,
	[CostCentreId] [uniqueidentifier] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblCommodityType]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCommodityType](
	[Id] [uniqueidentifier] NOT NULL,
	[Code] [nvarchar](50) NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](250) NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblCompetitor]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCompetitor](
	[id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](250) NOT NULL,
	[PostaAddress] [nvarchar](250) NULL,
	[PhysicalAddress] [nvarchar](250) NULL,
	[Telephone] [nvarchar](150) NULL,
	[ContactPerson] [nvarchar](250) NULL,
	[City] [nvarchar](250) NULL,
	[Longitude] [nvarchar](150) NULL,
	[Lattitude] [nvarchar](150) NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
 CONSTRAINT [PK_tblCompetitor] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblCompetitorProducts]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCompetitorProducts](
	[id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](250) NOT NULL,
	[Description] [nvarchar](350) NULL,
	[CompetitorId] [uniqueidentifier] NOT NULL,
	[BrandId] [uniqueidentifier] NOT NULL,
	[FlavourId] [uniqueidentifier] NOT NULL,
	[PackagingId] [uniqueidentifier] NOT NULL,
	[PackagingTypeId] [uniqueidentifier] NOT NULL,
	[ProductTypeId] [uniqueidentifier] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
 CONSTRAINT [PK_tblCompetitorProducts] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblConsolidatedProductProducts]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblConsolidatedProductProducts](
	[ConsolidatedProductId] [uniqueidentifier] NOT NULL,
	[ProductId] [uniqueidentifier] NOT NULL,
	[QtyPerConsolidatedProduct] [int] NOT NULL,
 CONSTRAINT [PK_tblConsolidatedProductProducts] PRIMARY KEY CLUSTERED 
(
	[ConsolidatedProductId] ASC,
	[ProductId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblContact]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblContact](
	[id] [uniqueidentifier] NOT NULL,
	[CostCenterId] [uniqueidentifier] NOT NULL,
	[Firstname] [nvarchar](250) NULL,
	[Lastname] [nvarchar](250) NULL,
	[DateOfBirth] [datetime] NULL,
	[ContactType] [uniqueidentifier] NULL,
	[ContactOwner] [int] NOT NULL,
	[SpouseName] [nvarchar](250) NULL,
	[Company] [nvarchar](250) NULL,
	[JobTitle] [nvarchar](250) NULL,
	[City] [nvarchar](250) NULL,
	[HomeTown] [nvarchar](250) NULL,
	[PhysicalAddress] [nvarchar](350) NULL,
	[PostalAddress] [nvarchar](350) NULL,
	[BusinessPhone] [nvarchar](350) NULL,
	[MobilePhone] [nvarchar](250) NULL,
	[HomePhone] [nvarchar](250) NULL,
	[WorkExtPhone] [nvarchar](250) NULL,
	[Fax] [nvarchar](250) NULL,
	[Email] [nvarchar](350) NULL,
	[ChildrenNames] [nvarchar](500) NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[ContactClassification] [int] NULL,
	[IM_Status] [int] NOT NULL,
	[MaritalStatusId] [int] NULL,
 CONSTRAINT [PK_tblContact] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblContactType]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblContactType](
	[id] [uniqueidentifier] NOT NULL,
	[Code] [nvarchar](250) NULL,
	[Name] [nvarchar](250) NOT NULL,
	[Description] [nvarchar](350) NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
 CONSTRAINT [PK_tblContactType] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblContainerType]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblContainerType](
	[Id] [uniqueidentifier] NOT NULL,
	[Code] [nvarchar](50) NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](250) NULL,
	[LoadCariage] [decimal](18, 2) NULL,
	[TareWeight] [decimal](18, 2) NULL,
	[Lenght] [decimal](18, 2) NULL,
	[Width] [decimal](18, 2) NULL,
	[Height] [decimal](18, 2) NULL,
	[BubbleSpace] [decimal](18, 2) NULL,
	[Volume] [decimal](18, 2) NULL,
	[FreezerTemp] [decimal](18, 2) NULL,
	[Make] [nvarchar](50) NOT NULL,
	[Model] [nvarchar](50) NOT NULL,
	[CommodityGradeId] [uniqueidentifier] NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
	[ContainerUseId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblContainment]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblContainment](
	[id] [uniqueidentifier] NOT NULL,
	[Quantity] [int] NOT NULL,
	[ReturnableProduct] [uniqueidentifier] NOT NULL,
	[ProductPackagingType] [uniqueidentifier] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
 CONSTRAINT [PK_tblContainment] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblCostCentre]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCostCentre](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](200) NOT NULL,
	[CostCentreType] [int] NULL,
	[ParentCostCentreId] [uniqueidentifier] NULL,
	[RouteId] [uniqueidentifier] NULL,
	[StandardWH_Latitude] [nvarchar](50) NULL,
	[StandardWH_Longtitude] [nvarchar](50) NULL,
	[StandardWH_VatRegistrationNo] [nvarchar](50) NULL,
	[Transporter_Drivername] [nvarchar](50) NULL,
	[Transporter_VehicleRegistrationNo] [nvarchar](50) NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[Outlet_Category_Id] [uniqueidentifier] NULL,
	[Outlet_Type_Id] [uniqueidentifier] NULL,
	[Distributor_RegionId] [uniqueidentifier] NULL,
	[Distributor_Owner] [nvarchar](500) NULL,
	[Distributor_PIN] [nvarchar](50) NULL,
	[Distributor_ASM_Id] [uniqueidentifier] NULL,
	[SalesRep_Id] [uniqueidentifier] NULL,
	[Surveyor_Id] [uniqueidentifier] NULL,
	[Tier_Id] [uniqueidentifier] NULL,
	[Disabled] [bit] NULL,
	[Cost_Centre_Code] [nvarchar](50) NULL,
	[SocioEconomicStatus_id] [uniqueidentifier] NULL,
	[Owner_Id] [uniqueidentifier] NULL,
	[Revenue_PIN] [nvarchar](50) NULL,
	[VATClass_Id] [uniqueidentifier] NULL,
	[Outlet_DiscountGroupId] [uniqueidentifier] NULL,
	[PaybillNumber] [nvarchar](50) NULL,
	[MerchantNumber] [nvarchar](50) NULL,
	[IM_Status] [int] NOT NULL,
	[CostCentreType2] [int] NOT NULL,
	[JoinDate] [datetime] NULL,
	[SpecialPricingTierId] [uniqueidentifier] NULL,
	[BankId] [uniqueidentifier] NULL,
	[BankBranchId] [uniqueidentifier] NULL,
	[AccountName] [varchar](100) NULL,
	[AccountNumber] [varchar](100) NULL,
 CONSTRAINT [PK_tblCostCentre] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblCostCentreApplication]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCostCentreApplication](
	[id] [uniqueidentifier] NOT NULL,
	[costcentreid] [uniqueidentifier] NOT NULL,
	[description] [nvarchar](50) NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
 CONSTRAINT [PK_tblCostCentreApplication] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblCostCentreMapping]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCostCentreMapping](
	[Id] [uniqueidentifier] NOT NULL,
	[MapToCostCentreId] [uniqueidentifier] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblCountry]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCountry](
	[id] [uniqueidentifier] NOT NULL,
	[Name] [varchar](150) NOT NULL,
	[Code] [nvarchar](150) NULL,
	[Currency] [nvarchar](150) NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[Territory_ID] [uniqueidentifier] NULL,
	[IM_Status] [int] NOT NULL,
 CONSTRAINT [PK_dbo.tlbCountry] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblCustomerDiscount]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCustomerDiscount](
	[id] [uniqueidentifier] NOT NULL,
	[Outlet] [uniqueidentifier] NOT NULL,
	[ProductRef] [uniqueidentifier] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
 CONSTRAINT [PK_tblCustomerDiscount] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblCustomerDiscountItem]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCustomerDiscountItem](
	[id] [uniqueidentifier] NOT NULL,
	[CustomerDiscountId] [uniqueidentifier] NOT NULL,
	[DiscountRate] [money] NOT NULL,
	[EffectiveDate] [datetime] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
	[EndDate] [datetime] NULL,
 CONSTRAINT [PK_tblCustomerDiscountItem] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblDiscountGroup]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblDiscountGroup](
	[id] [uniqueidentifier] NOT NULL,
	[Code] [varchar](250) NOT NULL,
	[Name] [varchar](250) NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
 CONSTRAINT [PK_tblDiscountGroup] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblDiscountItem]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblDiscountItem](
	[id] [uniqueidentifier] NOT NULL,
	[DiscountId] [uniqueidentifier] NOT NULL,
	[DiscountRate] [money] NOT NULL,
	[EffectiveDate] [datetime] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
	[EndDate] [datetime] NULL,
	[IsByQuantity] [bit] NOT NULL,
	[Quantity] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_tblDiscountItem] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblDiscounts]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblDiscounts](
	[id] [uniqueidentifier] NOT NULL,
	[ProductRef] [uniqueidentifier] NOT NULL,
	[TierId] [uniqueidentifier] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
 CONSTRAINT [PK_tblDiscounts] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblDistrict]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblDistrict](
	[Id] [uniqueidentifier] NOT NULL,
	[ProvinceId] [uniqueidentifier] NOT NULL,
	[District] [varchar](250) NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
 CONSTRAINT [PK_tblDistrict] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblDocument]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblDocument](
	[Id] [uniqueidentifier] NOT NULL,
	[DocumentTypeId] [int] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_IsActive] [bit] NOT NULL,
	[DocumentReference] [varchar](250) NULL,
	[DocumentIssuerCostCentreId] [uniqueidentifier] NOT NULL,
	[DocumentIssuerUserId] [uniqueidentifier] NOT NULL,
	[DocumentDateIssued] [datetime] NOT NULL,
	[DocumentStatusId] [int] NOT NULL,
	[DocumentRecipientCostCentre] [uniqueidentifier] NOT NULL,
	[OrderDateRequired] [date] NULL,
	[OrderIssuedOnBehalfOfCC] [uniqueidentifier] NULL,
	[DocumentIssuerCostCentreApplicationId] [uniqueidentifier] NULL,
	[IRNOrderReferences] [nvarchar](200) NULL,
	[IRNLoadNo] [nvarchar](50) NULL,
	[IRNGoodsReceivedFromCC] [uniqueidentifier] NULL,
	[InvoiceOrderId] [uniqueidentifier] NULL,
	[OrderOrderTypeId] [int] NULL,
	[Note] [text] NULL,
	[Longitude] [float] NULL,
	[Latitude] [float] NULL,
	[SaleDiscount] [money] NULL,
	[PaymentDocId] [uniqueidentifier] NULL,
	[DocumentParentId] [uniqueidentifier] NULL,
	[SendDateTime] [datetime] NULL,
	[OrderStatusId] [int] NULL,
	[OrderParentId] [uniqueidentifier] NULL,
	[ShipToAddress] [varchar](250) NULL,
	[ExtDocumentReference] [varchar](250) NULL,
 CONSTRAINT [PK_tblOrders] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblEquipment]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblEquipment](
	[Id] [uniqueidentifier] NOT NULL,
	[Code] [nvarchar](50) NULL,
	[EquipmentNumber] [nvarchar](50) NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Make] [nvarchar](50) NULL,
	[Model] [nvarchar](50) NULL,
	[EquipmentType] [int] NOT NULL,
	[Description] [nvarchar](250) NULL,
	[CostCentreId] [uniqueidentifier] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
	[ContainerTypeId] [uniqueidentifier] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblExportImportAudit]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblExportImportAudit](
	[DocumentId] [uniqueidentifier] NOT NULL,
	[IntegrationModule] [int] NOT NULL,
	[DocumentAuditStatus] [int] NOT NULL,
	[DocumentReference] [varchar](250) NULL,
	[ExternalDocumentReference] [varchar](250) NULL,
	[DocumentType] [int] NULL,
	[DateUploaded] [datetime] NULL,
 CONSTRAINT [PK_tblExportImportAudit] PRIMARY KEY CLUSTERED 
(
	[DocumentId] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblFiles]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblFiles](
	[Id] [uniqueidentifier] NOT NULL,
	[FileData] [varbinary](max) NOT NULL,
	[FileExtension] [varchar](20) NOT NULL,
	[FileType] [int] NOT NULL,
	[FileDescription] [varchar](200) NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
 CONSTRAINT [PK__tblFiles__3214EC07501690F4] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblFreeOfChargeDiscount]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblFreeOfChargeDiscount](
	[id] [uniqueidentifier] NOT NULL,
	[ProductRef] [uniqueidentifier] NOT NULL,
	[IsChecked] [bit] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
	[StartDate] [datetime] NULL,
	[EndDate] [datetime] NULL,
 CONSTRAINT [PK_tblFreeOfChargeDiscount] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblInfection]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblInfection](
	[id] [uniqueidentifier] NOT NULL,
	[Code] [nvarchar](50) NULL,
	[Name] [nvarchar](250) NOT NULL,
	[Type] [int] NOT NULL,
	[Description] [nvarchar](450) NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
 CONSTRAINT [PK_tblInfection] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblInventory]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblInventory](
	[id] [uniqueidentifier] NOT NULL,
	[WareHouseId] [uniqueidentifier] NOT NULL,
	[ProductId] [uniqueidentifier] NOT NULL,
	[Balance] [decimal](20, 2) NULL,
	[Value] [money] NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[UnavailableBalance] [decimal](18, 2) NOT NULL,
	[IM_Status] [int] NOT NULL,
 CONSTRAINT [PK_tblInventory] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblInventorySerials]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblInventorySerials](
	[Id] [uniqueidentifier] NOT NULL,
	[CostCentreId] [uniqueidentifier] NOT NULL,
	[ProductId] [uniqueidentifier] NOT NULL,
	[DocumentId] [uniqueidentifier] NOT NULL,
	[From] [nvarchar](150) NOT NULL,
	[To] [nvarchar](150) NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
 CONSTRAINT [PK_tblInventorySerials] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblInventoryTransaction]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblInventoryTransaction](
	[Id] [uniqueidentifier] NOT NULL,
	[InventoryId] [uniqueidentifier] NOT NULL,
	[NoItems] [decimal](20, 2) NULL,
	[NetValue] [decimal](18, 2) NOT NULL,
	[GrossValue] [decimal](18, 2) NOT NULL,
	[DocumentType] [int] NOT NULL,
	[DocumentId] [uniqueidentifier] NOT NULL,
	[DateInserted] [datetime] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
 CONSTRAINT [PK_tblInventoryTransaction] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblLineItems]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblLineItems](
	[id] [uniqueidentifier] NOT NULL,
	[DocumentID] [uniqueidentifier] NULL,
	[ProductID] [uniqueidentifier] NULL,
	[Description] [nvarchar](250) NULL,
	[LineItemSequenceNo] [int] NULL,
	[Quantity] [decimal](20, 2) NULL,
	[Value] [money] NULL,
	[Vat] [money] NULL,
	[OrderLineItemType] [int] NULL,
	[DiscountLineItemTypeId] [int] NULL,
	[IAN_Actual] [decimal](18, 2) NULL,
	[PaymentDocLineItemId] [uniqueidentifier] NULL,
	[Receipt_AccountType] [int] NULL,
	[Receipt_PaymentTypeId] [int] NULL,
	[Receipt_PaymentReference] [nvarchar](50) NULL,
	[Receipt_MMoneyPaymentType] [nvarchar](50) NULL,
	[ProductDiscount] [money] NULL,
	[ReturnsNoteReason] [nvarchar](250) NULL,
	[Other] [nvarchar](250) NULL,
	[NotificationId] [nvarchar](1000) NULL,
	[LineItemStatusId] [int] NULL,
	[ApprovedQuantity] [decimal](18, 2) NULL,
	[LostSaleQuantity] [decimal](18, 2) NULL,
	[BackOrderQuantity] [decimal](18, 2) NULL,
	[DispatchedQuantity] [decimal](18, 2) NULL,
 CONSTRAINT [PK_tblLineItems] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblMarketAudit]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblMarketAudit](
	[Id] [uniqueidentifier] NOT NULL,
	[Question] [varchar](max) NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
 CONSTRAINT [PK_tblMarketAudit] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblMasterDataAllocation]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblMasterDataAllocation](
	[Id] [uniqueidentifier] NOT NULL,
	[EntityAId] [uniqueidentifier] NOT NULL,
	[EntityBId] [uniqueidentifier] NOT NULL,
	[AllocationType] [int] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
 CONSTRAINT [PK_tblMasterDataAllocation] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblOrderPaymentInfo]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblOrderPaymentInfo](
	[Id] [uniqueidentifier] NOT NULL,
	[DocumentId] [uniqueidentifier] NOT NULL,
	[Amount] [decimal](18, 2) NOT NULL,
	[ConfirmedAmount] [decimal](18, 2) NOT NULL,
	[PaymentMode] [int] NOT NULL,
	[MMoneyPaymentType] [varchar](50) NULL,
	[PaymentRefId] [varchar](50) NULL,
	[IsConfirmed] [bit] NULL,
	[NotificationId] [nvarchar](50) NULL,
	[Description] [nvarchar](250) NULL,
	[TransactionDate] [datetime] NULL,
	[IsProcessed] [bit] NULL,
	[BankCode] [varchar](250) NULL,
	[BranchCode] [varchar](250) NULL,
	[ChequeDueDate] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblOutletAudit]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblOutletAudit](
	[Id] [uniqueidentifier] NOT NULL,
	[Question] [varchar](max) NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
 CONSTRAINT [PK_tblOutletAudit] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblOutletCategory]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblOutletCategory](
	[id] [uniqueidentifier] NOT NULL,
	[Name] [varchar](max) NOT NULL,
	[Description] [varchar](max) NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
	[Code] [nvarchar](50) NULL,
 CONSTRAINT [PK_tblOutletCategory] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblOutletPriority]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblOutletPriority](
	[Id] [uniqueidentifier] NOT NULL,
	[OutletId] [uniqueidentifier] NOT NULL,
	[RouteId] [uniqueidentifier] NOT NULL,
	[OutletPriority] [int] NOT NULL,
	[EffectiveDate] [datetime] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
 CONSTRAINT [PK__tblOutle__3214EC075B8843A0] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblOutletType]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblOutletType](
	[id] [uniqueidentifier] NOT NULL,
	[Name] [varchar](max) NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
	[Code] [nvarchar](50) NULL,
 CONSTRAINT [PK_tblOutletType] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblOutletVisitDay]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblOutletVisitDay](
	[Id] [uniqueidentifier] NOT NULL,
	[OutletId] [uniqueidentifier] NOT NULL,
	[VistDay] [int] NOT NULL,
	[EffectiveDate] [datetime] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
 CONSTRAINT [PK__tblOutle__3214EC0755CF6A4A] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblPaymentTracker]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblPaymentTracker](
	[id] [uniqueidentifier] NOT NULL,
	[CostCenterId] [uniqueidentifier] NOT NULL,
	[PaymentModeId] [int] NOT NULL,
	[Balance] [money] NULL,
	[PendingConfirmBalance] [money] NULL,
 CONSTRAINT [PK_tblPaymentTracker] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblPricing]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblPricing](
	[id] [uniqueidentifier] NOT NULL,
	[ProductRef] [uniqueidentifier] NOT NULL,
	[Tier] [uniqueidentifier] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
 CONSTRAINT [PK_tblPricing] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblPricingItem]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblPricingItem](
	[id] [uniqueidentifier] NOT NULL,
	[PricingId] [uniqueidentifier] NOT NULL,
	[Exfactory] [money] NOT NULL,
	[SellingPrice] [money] NOT NULL,
	[EffecitiveDate] [datetime] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
 CONSTRAINT [PK_tblPricingItem] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblPricingTier]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblPricingTier](
	[id] [uniqueidentifier] NOT NULL,
	[Code] [nvarchar](50) NULL,
	[Name] [nvarchar](250) NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[Description] [nvarchar](450) NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
 CONSTRAINT [PK_tblPricingTier] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblProduct]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblProduct](
	[id] [uniqueidentifier] NOT NULL,
	[DomainTypeId] [int] NOT NULL,
	[BrandId] [uniqueidentifier] NULL,
	[FlavourId] [uniqueidentifier] NULL,
	[PackagingTypeId] [uniqueidentifier] NULL,
	[PackagingId] [uniqueidentifier] NULL,
	[ProductTypeId] [uniqueidentifier] NULL,
	[ProductCode] [nvarchar](50) NOT NULL,
	[Description] [nvarchar](4000) NULL,
	[Returnable] [uniqueidentifier] NULL,
	[UnitCases] [money] NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[ReturnableType] [int] NULL,
	[Capacity] [int] NOT NULL,
	[VatClassId] [uniqueidentifier] NULL,
	[ExFactoryPrice] [decimal](20, 2) NOT NULL,
	[IM_Status] [int] NOT NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblProductBrand]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblProductBrand](
	[id] [uniqueidentifier] NOT NULL,
	[SupplierId] [uniqueidentifier] NULL,
	[code] [nvarchar](50) NULL,
	[name] [nvarchar](250) NOT NULL,
	[description] [nvarchar](4000) NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
 CONSTRAINT [PK_ProductBrand] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblProductDiscountGroup]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblProductDiscountGroup](
	[id] [uniqueidentifier] NOT NULL,
	[DiscountGroup] [uniqueidentifier] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
 CONSTRAINT [PK_tblProductDiscountGroup] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblProductDiscountGroupItem]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblProductDiscountGroupItem](
	[id] [uniqueidentifier] NOT NULL,
	[ProductDiscountGroup] [uniqueidentifier] NOT NULL,
	[ProductRef] [uniqueidentifier] NOT NULL,
	[DiscountRate] [money] NOT NULL,
	[EffectiveDate] [datetime] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
	[EndDate] [datetime] NULL,
	[IsByQuantity] [bit] NOT NULL,
	[Quantity] [decimal](18, 2) NOT NULL,
 CONSTRAINT [PK_tblProductDiscountGroupItem] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblProductFlavour]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblProductFlavour](
	[id] [uniqueidentifier] NOT NULL,
	[BrandId] [uniqueidentifier] NULL,
	[code] [nvarchar](50) NULL,
	[name] [nvarchar](250) NOT NULL,
	[description] [nvarchar](4000) NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
 CONSTRAINT [PK_ProductFlavour] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblProductPackaging]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblProductPackaging](
	[Id] [uniqueidentifier] NOT NULL,
	[code] [nvarchar](250) NULL,
	[Name] [nvarchar](250) NOT NULL,
	[description] [nvarchar](4000) NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[Containment] [uniqueidentifier] NULL,
	[ReturnableProduct] [uniqueidentifier] NULL,
	[IM_Status] [int] NOT NULL,
 CONSTRAINT [PK_ProductPackaging] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblProductPackagingType]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblProductPackagingType](
	[id] [uniqueidentifier] NOT NULL,
	[code] [nvarchar](250) NULL,
	[name] [nvarchar](250) NOT NULL,
	[description] [nvarchar](4000) NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
 CONSTRAINT [PK_ProductPackagingType] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblProductType]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblProductType](
	[id] [uniqueidentifier] NOT NULL,
	[code] [nvarchar](250) NULL,
	[name] [nvarchar](250) NULL,
	[Description] [nvarchar](400) NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
 CONSTRAINT [PK_ProductType] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblPromotionDiscount]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblPromotionDiscount](
	[id] [uniqueidentifier] NOT NULL,
	[ProductRef] [uniqueidentifier] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
 CONSTRAINT [PK_tblPromotionDiscount] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblPromotionDiscountItem]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblPromotionDiscountItem](
	[id] [uniqueidentifier] NOT NULL,
	[PromotionDiscountId] [uniqueidentifier] NOT NULL,
	[ParentProductQuantity] [int] NOT NULL,
	[FreeOfChargeProductRef] [uniqueidentifier] NULL,
	[FreeOfChargeQuantity] [int] NULL,
	[DiscountRate] [money] NULL,
	[EffectiveDate] [datetime] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
	[EndDate] [datetime] NULL,
 CONSTRAINT [PK_tblFreeOfChargeDiscountItem] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblProvince]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblProvince](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [varchar](50) NULL,
	[CountryId] [uniqueidentifier] NOT NULL,
	[Description] [varchar](150) NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
 CONSTRAINT [PK_tblProvince] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblPurchasingClerkRoute]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblPurchasingClerkRoute](
	[Id] [uniqueidentifier] NOT NULL,
	[RouteId] [uniqueidentifier] NOT NULL,
	[PurchasingClerkId] [uniqueidentifier] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblRecollection]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblRecollection](
	[Id] [uniqueidentifier] NOT NULL,
	[CostCentreId] [uniqueidentifier] NOT NULL,
	[FromCostCentreId] [uniqueidentifier] NOT NULL,
	[Description] [varchar](50) NULL,
	[Amount] [decimal](16, 2) NOT NULL,
	[IsReceived] [bit] NOT NULL,
	[DateInserted] [datetime] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblRecollectionItem]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblRecollectionItem](
	[Id] [uniqueidentifier] NOT NULL,
	[RecollectionId] [uniqueidentifier] NOT NULL,
	[Amount] [decimal](16, 2) NOT NULL,
	[DateInserted] [datetime] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
	[IsComfirmed] [bit] NOT NULL,
	[CollectionModeId] [int] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblRegion]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblRegion](
	[id] [uniqueidentifier] NOT NULL,
	[Name] [varchar](50) NULL,
	[Description] [varchar](50) NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[Country] [uniqueidentifier] NOT NULL,
	[IM_Status] [int] NOT NULL,
 CONSTRAINT [PK_tblRegion] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblReOrderLevel]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblReOrderLevel](
	[id] [uniqueidentifier] NOT NULL,
	[DistributorId] [uniqueidentifier] NOT NULL,
	[ProductId] [uniqueidentifier] NOT NULL,
	[ProductReOrderLevel] [money] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
 CONSTRAINT [PK_tblReOrderLevel] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblRetireDocumentSetting]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblRetireDocumentSetting](
	[Id] [uniqueidentifier] NOT NULL,
	[RetireTypeId] [int] NOT NULL,
	[Duration] [int] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblRoutes]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblRoutes](
	[RouteID] [uniqueidentifier] NOT NULL,
	[Name] [varchar](250) NOT NULL,
	[RegionId] [uniqueidentifier] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[Code] [varchar](50) NULL,
	[IM_Status] [int] NOT NULL,
 CONSTRAINT [PK_tblRoutes] PRIMARY KEY CLUSTERED 
(
	[RouteID] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblSalemanRoute]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblSalemanRoute](
	[Id] [uniqueidentifier] NOT NULL,
	[RouteId] [uniqueidentifier] NOT NULL,
	[SalemanId] [uniqueidentifier] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
 CONSTRAINT [PK__tblSalem__3214EC0709202D14] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblSaleValueDiscount]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblSaleValueDiscount](
	[id] [uniqueidentifier] NOT NULL,
	[TierId] [uniqueidentifier] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
 CONSTRAINT [PK_tblSaleValueDiscount] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblSaleValueDiscountItems]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblSaleValueDiscountItems](
	[id] [uniqueidentifier] NOT NULL,
	[SaleValueId] [uniqueidentifier] NOT NULL,
	[DiscountRate] [money] NOT NULL,
	[SaleValue] [money] NOT NULL,
	[EffectiveDate] [datetime] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
	[EndDate] [datetime] NULL,
 CONSTRAINT [PK_tblSaleValueDiscountItems] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblSeason]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblSeason](
	[id] [uniqueidentifier] NOT NULL,
	[CommodityProducerId] [uniqueidentifier] NOT NULL,
	[Code] [nvarchar](50) NULL,
	[Name] [nvarchar](250) NOT NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NOT NULL,
	[Description] [nvarchar](450) NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
 CONSTRAINT [PK_tblSeason] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblService]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblService](
	[id] [uniqueidentifier] NOT NULL,
	[Code] [nvarchar](50) NULL,
	[Name] [nvarchar](250) NOT NULL,
	[Cost] [decimal](18, 2) NULL,
	[Description] [nvarchar](450) NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
 CONSTRAINT [PK_tblService] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblServiceProvider]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblServiceProvider](
	[id] [uniqueidentifier] NOT NULL,
	[Code] [nvarchar](50) NULL,
	[Name] [nvarchar](250) NOT NULL,
	[PIN] [nvarchar](50) NULL,
	[IDNo] [nvarchar](50) NOT NULL,
	[Mobile] [nvarchar](50) NOT NULL,
	[BankId] [uniqueidentifier] NULL,
	[BankBranchId] [uniqueidentifier] NULL,
	[AccountName] [nvarchar](250) NULL,
	[AccountNumber] [nvarchar](250) NULL,
	[Description] [nvarchar](450) NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
	[Gender] [int] NULL,
 CONSTRAINT [PK_tblServiceProvider] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblSettings]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblSettings](
	[Id] [uniqueidentifier] NOT NULL,
	[Key] [int] NOT NULL,
	[Value] [nvarchar](250) NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
	[AppId] [int] NULL,
 CONSTRAINT [PK_[tblSettings] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblShift]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblShift](
	[id] [uniqueidentifier] NOT NULL,
	[Code] [nvarchar](50) NULL,
	[Name] [nvarchar](250) NOT NULL,
	[StartTime] [datetime] NOT NULL,
	[EndTime] [datetime] NOT NULL,
	[Description] [nvarchar](450) NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
 CONSTRAINT [PK_tblShift] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblShipToAddress]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblShipToAddress](
	[Id] [uniqueidentifier] NOT NULL,
	[CostCentreId] [uniqueidentifier] NOT NULL,
	[Name] [varchar](250) NULL,
	[Description] [nvarchar](250) NULL,
	[PostalAddress] [nvarchar](250) NULL,
	[PhysicalAddress] [nvarchar](250) NULL,
	[Longitude] [decimal](18, 4) NULL,
	[Latitude] [decimal](18, 4) NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
	[Code] [varchar](250) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblSocioEconomicStatus]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblSocioEconomicStatus](
	[id] [uniqueidentifier] NOT NULL,
	[Status] [nvarchar](50) NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
 CONSTRAINT [PK_tblSocioEconomicStatus] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblSourcingDocument]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblSourcingDocument](
	[Id] [uniqueidentifier] NOT NULL,
	[DocumentTypeId] [int] NOT NULL,
	[DocumentStatusId] [int] NOT NULL,
	[DocumentParentId] [uniqueidentifier] NULL,
	[DocumentReference] [varchar](250) NULL,
	[DocumentIssuerCostCentreId] [uniqueidentifier] NOT NULL,
	[DocumentIssuerUserId] [uniqueidentifier] NOT NULL,
	[DocumentRecipientCostCentreId] [uniqueidentifier] NOT NULL,
	[DocumentOnBehalfOfCostCentreId] [uniqueidentifier] NULL,
	[DocumentIssuerCostCentreApplicationId] [uniqueidentifier] NULL,
	[DeliveredBy] [nvarchar](50) NULL,
	[Description] [nvarchar](250) NULL,
	[Note] [nvarchar](250) NULL,
	[CommodityOwnerId] [uniqueidentifier] NOT NULL,
	[CommodityProducerId] [uniqueidentifier] NULL,
	[DateIssued] [datetime] NOT NULL,
	[DocumentDate] [datetime] NOT NULL,
	[DateSent] [datetime] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
	[DriverName] [varchar](50) NULL,
	[VehicleRegNo] [varchar](50) NULL,
	[RouteId] [uniqueidentifier] NULL,
	[CentreId] [uniqueidentifier] NULL,
	[DocumentTypeId2] [int] NULL,
	[VehicleArrivalMileage] [decimal](18, 2) NULL,
	[VehicleDepartureMileage] [decimal](18, 2) NULL,
	[VehicleArrivalTime] [datetime] NULL,
	[VehicleDepartureTime] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblSourcingInventory]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblSourcingInventory](
	[id] [uniqueidentifier] NOT NULL,
	[WareHouseId] [uniqueidentifier] NOT NULL,
	[CommodityId] [uniqueidentifier] NOT NULL,
	[GradeId] [uniqueidentifier] NOT NULL,
	[Balance] [decimal](20, 2) NULL,
	[UnavailableBalance] [decimal](20, 2) NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblSourcingLineItem]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblSourcingLineItem](
	[Id] [uniqueidentifier] NOT NULL,
	[ParentId] [uniqueidentifier] NULL,
	[DocumentId] [uniqueidentifier] NOT NULL,
	[CommodityId] [uniqueidentifier] NULL,
	[GradeId] [uniqueidentifier] NULL,
	[ContainerId] [uniqueidentifier] NULL,
	[Weight] [decimal](18, 2) NULL,
	[TareWeight] [decimal](18, 2) NULL,
	[Description] [nvarchar](250) NULL,
	[Note] [nvarchar](250) NULL,
	[ContainerNo] [varchar](50) NULL,
	[LineItemStatusId] [int] NULL,
	[NoOfContainer] [decimal](16, 2) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblSupplier]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblSupplier](
	[id] [uniqueidentifier] NOT NULL,
	[Code] [nvarchar](250) NULL,
	[Name] [nvarchar](250) NOT NULL,
	[Description] [nvarchar](350) NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
 CONSTRAINT [PK_tblSupplier] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblTarget]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblTarget](
	[id] [uniqueidentifier] NOT NULL,
	[CostCentreId] [uniqueidentifier] NOT NULL,
	[PeriodId] [uniqueidentifier] NOT NULL,
	[TargetValue] [decimal](20, 2) NOT NULL,
	[IsQuantityTarget] [bit] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
 CONSTRAINT [PK_tblTarget] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblTargetItem]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblTargetItem](
	[Id] [uniqueidentifier] NOT NULL,
	[TargetId] [uniqueidentifier] NOT NULL,
	[ProductId] [uniqueidentifier] NOT NULL,
	[Quantity] [decimal](18, 2) NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
 CONSTRAINT [PK__tblTarge__3214EC072BD9307E] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblTargetPeriod]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblTargetPeriod](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [varchar](50) NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
 CONSTRAINT [PK_tblTargetPeriod] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblTerritory]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblTerritory](
	[id] [uniqueidentifier] NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
 CONSTRAINT [PK_dbo.tblTerritory] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblUserGroup]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUserGroup](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](250) NULL,
	[Description] [nvarchar](250) NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
 CONSTRAINT [PK__tblUserG__3214EC0712A9974E] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblUserGroupRoles]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUserGroupRoles](
	[Id] [uniqueidentifier] NOT NULL,
	[RoleId] [int] NOT NULL,
	[GroupId] [uniqueidentifier] NOT NULL,
	[CanAccess] [bit] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
 CONSTRAINT [PK__tblUserG__3214EC074905A7FF] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblUsers]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUsers](
	[Id] [uniqueidentifier] NOT NULL,
	[CostCenterId] [uniqueidentifier] NOT NULL,
	[UserName] [nvarchar](250) NOT NULL,
	[Password] [nvarchar](250) NOT NULL,
	[PIN] [nvarchar](250) NULL,
	[UserType] [int] NOT NULL,
	[Mobile] [nvarchar](250) NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NULL,
	[GroupId] [uniqueidentifier] NULL,
	[TillNumber] [nvarchar](250) NULL,
	[IM_Status] [int] NOT NULL,
	[Code] [varchar](250) NULL,
	[FirstName] [varchar](250) NULL,
	[LastName] [varchar](250) NULL,
 CONSTRAINT [PK_tblUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblUserTypes]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblUserTypes](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [varchar](max) NOT NULL,
	[Description] [text] NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
 CONSTRAINT [PK_tblUserTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblVATClass]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblVATClass](
	[id] [uniqueidentifier] NOT NULL,
	[Name] [nvarchar](50) NOT NULL,
	[Class] [nvarchar](50) NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
 CONSTRAINT [PK_tblVATClass] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[tblVATClassItem]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblVATClassItem](
	[id] [uniqueidentifier] NOT NULL,
	[VATClassID] [uniqueidentifier] NOT NULL,
	[Rate] [money] NOT NULL,
	[EffectiveDate] [datetime] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [int] NOT NULL,
 CONSTRAINT [PK_tblVATClassItem] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF)
)

GO
/****** Object:  Table [dbo].[test]    Script Date: 07/05/2014 10:33:54 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[test](
	[Id] [uniqueidentifier] NOT NULL,
	[DocumentTypeId] [int] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[DocumentReference] [nvarchar](50) NULL,
	[DocumentIssuerCostCentreId] [uniqueidentifier] NOT NULL,
	[DocumentIssuerUserId] [uniqueidentifier] NOT NULL,
	[DocumentDateIssued] [date] NOT NULL,
	[DocumentStatusId] [int] NOT NULL,
	[DocumentRecipientCostCentre] [uniqueidentifier] NOT NULL,
	[OrderDateRequired] [date] NULL,
	[OrderIssuedOnBehalfOfCC] [uniqueidentifier] NULL,
	[DocumentIssuerCostCentreApplicationId] [uniqueidentifier] NULL,
	[IRNOrderReferences] [nvarchar](200) NULL,
	[IRNLoadNo] [nvarchar](50) NULL,
	[IRNGoodsReceivedFromCC] [uniqueidentifier] NULL,
	[InvoiceOrderId] [uniqueidentifier] NULL,
	[OrderOrderTypeId] [int] NULL,
	[IM_Status] [int] NOT NULL
)

GO
ALTER TABLE [dbo].[tblArea] ADD  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblAsset] ADD  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblAssetCategory] ADD  CONSTRAINT [DF__tblAssetC__IM_Da__0672A1A5]  DEFAULT (getdate()) FOR [IM_DateCreated]
GO
ALTER TABLE [dbo].[tblAssetCategory] ADD  CONSTRAINT [DF__tblAssetC__IM_Da__0766C5DE]  DEFAULT (getdate()) FOR [IM_DateLastUpdated]
GO
ALTER TABLE [dbo].[tblAssetCategory] ADD  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblAssetStatus] ADD  CONSTRAINT [DF__tblAssetS__IM_Da__085AEA17]  DEFAULT (getdate()) FOR [IM_DateCreated]
GO
ALTER TABLE [dbo].[tblAssetStatus] ADD  CONSTRAINT [DF__tblAssetS__IM_Da__094F0E50]  DEFAULT (getdate()) FOR [IM_DateLastUpdated]
GO
ALTER TABLE [dbo].[tblAssetStatus] ADD  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblAssetType] ADD  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblBank] ADD  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblBankBranch] ADD  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblCertainValueCertainProductDiscount] ADD  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblCertainValueCertainProductDiscountItem] ADD  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblChannelPackaging] ADD  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblClientMasterDataTracker] ADD  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblCompetitor] ADD  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblCompetitorProducts] ADD  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblContact] ADD  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblContact] ADD  DEFAULT ((0)) FOR [MaritalStatusId]
GO
ALTER TABLE [dbo].[tblContactType] ADD  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblContainment] ADD  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblCostCentre] ADD  CONSTRAINT [DF__tblCostCe__IM_St__5649C92D]  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblCostCentre] ADD  CONSTRAINT [DF__tblCostCe__CostC__573DED66]  DEFAULT ((0)) FOR [CostCentreType2]
GO
ALTER TABLE [dbo].[tblCostCentreApplication] ADD  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblCountry] ADD  CONSTRAINT [DF__tblCountr__IM_St__592635D8]  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblCustomerDiscount] ADD  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblCustomerDiscountItem] ADD  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblDiscountGroup] ADD  CONSTRAINT [DF__tblDiscou__IM_St__5C02A283]  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblDiscountItem] ADD  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblDiscountItem] ADD  DEFAULT ((0)) FOR [IsByQuantity]
GO
ALTER TABLE [dbo].[tblDiscountItem] ADD  DEFAULT ((0)) FOR [Quantity]
GO
ALTER TABLE [dbo].[tblDiscounts] ADD  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblDistrict] ADD  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblDocument] ADD  DEFAULT ((0)) FOR [OrderStatusId]
GO
ALTER TABLE [dbo].[tblFiles] ADD  CONSTRAINT [DF__tblFiles__IM_Dat__0B3756C2]  DEFAULT (getdate()) FOR [IM_DateCreated]
GO
ALTER TABLE [dbo].[tblFiles] ADD  CONSTRAINT [DF__tblFiles__IM_Dat__0C2B7AFB]  DEFAULT (getdate()) FOR [IM_DateLastUpdated]
GO
ALTER TABLE [dbo].[tblFiles] ADD  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblFreeOfChargeDiscount] ADD  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblInventory] ADD  CONSTRAINT [DF__tblInvent__Unava__02C769E9]  DEFAULT ((0)) FOR [UnavailableBalance]
GO
ALTER TABLE [dbo].[tblInventory] ADD  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblInventoryTransaction] ADD  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblLineItems] ADD  DEFAULT ((0)) FOR [LineItemStatusId]
GO
ALTER TABLE [dbo].[tblLineItems] ADD  DEFAULT ((0)) FOR [ApprovedQuantity]
GO
ALTER TABLE [dbo].[tblLineItems] ADD  DEFAULT ((0)) FOR [LostSaleQuantity]
GO
ALTER TABLE [dbo].[tblLineItems] ADD  DEFAULT ((0)) FOR [BackOrderQuantity]
GO
ALTER TABLE [dbo].[tblLineItems] ADD  DEFAULT ((0)) FOR [DispatchedQuantity]
GO
ALTER TABLE [dbo].[tblMarketAudit] ADD  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblOutletAudit] ADD  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblOutletCategory] ADD  CONSTRAINT [DF__tblOutlet__IM_St__6F1576F7]  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblOutletPriority] ADD  CONSTRAINT [DF__tblOutlet__IM_Da__0D1F9F34]  DEFAULT (getdate()) FOR [IM_DateCreated]
GO
ALTER TABLE [dbo].[tblOutletPriority] ADD  CONSTRAINT [DF__tblOutlet__IM_Da__0E13C36D]  DEFAULT (getdate()) FOR [IM_DateLastUpdated]
GO
ALTER TABLE [dbo].[tblOutletPriority] ADD  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblOutletVisitDay] ADD  CONSTRAINT [DF__tblOutlet__IM_Da__0F07E7A6]  DEFAULT (getdate()) FOR [IM_DateCreated]
GO
ALTER TABLE [dbo].[tblOutletVisitDay] ADD  CONSTRAINT [DF__tblOutlet__IM_Da__0FFC0BDF]  DEFAULT (getdate()) FOR [IM_DateLastUpdated]
GO
ALTER TABLE [dbo].[tblOutletVisitDay] ADD  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblPaymentTracker] ADD  CONSTRAINT [DF__tblPaymen__Balan__05A3D694]  DEFAULT ((0)) FOR [Balance]
GO
ALTER TABLE [dbo].[tblPaymentTracker] ADD  CONSTRAINT [DF__tblPaymen__Pendi__0697FACD]  DEFAULT ((0)) FOR [PendingConfirmBalance]
GO
ALTER TABLE [dbo].[tblPricing] ADD  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblPricingItem] ADD  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblPricingTier] ADD  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblProduct] ADD  CONSTRAINT [DF__tblProduc__ExFac__14C0C0FC]  DEFAULT ((0)) FOR [ExFactoryPrice]
GO
ALTER TABLE [dbo].[tblProduct] ADD  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblProductBrand] ADD  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblProductDiscountGroup] ADD  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblProductDiscountGroupItem] ADD  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblProductDiscountGroupItem] ADD  DEFAULT ((0)) FOR [IsByQuantity]
GO
ALTER TABLE [dbo].[tblProductDiscountGroupItem] ADD  DEFAULT ((0)) FOR [Quantity]
GO
ALTER TABLE [dbo].[tblProductFlavour] ADD  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblProductPackaging] ADD  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblProductPackagingType] ADD  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblProductType] ADD  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblPromotionDiscount] ADD  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblPromotionDiscountItem] ADD  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblProvince] ADD  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblRecollectionItem] ADD  DEFAULT ((0)) FOR [IsComfirmed]
GO
ALTER TABLE [dbo].[tblRecollectionItem] ADD  DEFAULT ((0)) FOR [CollectionModeId]
GO
ALTER TABLE [dbo].[tblRegion] ADD  CONSTRAINT [DF__tblRegion__IM_Da__3F466844]  DEFAULT (getdate()) FOR [IM_DateCreated]
GO
ALTER TABLE [dbo].[tblRegion] ADD  CONSTRAINT [DF__tblRegion__IM_Da__403A8C7D]  DEFAULT (getdate()) FOR [IM_DateLastUpdated]
GO
ALTER TABLE [dbo].[tblRegion] ADD  CONSTRAINT [DF__tblRegion__IM_St__08D548FA]  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblReOrderLevel] ADD  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblRetireDocumentSetting] ADD  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblRoutes] ADD  CONSTRAINT [DF__tblRoutes__IM_Da__4222D4EF]  DEFAULT (getdate()) FOR [IM_DateCreated]
GO
ALTER TABLE [dbo].[tblRoutes] ADD  CONSTRAINT [DF__tblRoutes__IM_Da__4316F928]  DEFAULT (getdate()) FOR [IM_DateLastUpdated]
GO
ALTER TABLE [dbo].[tblRoutes] ADD  CONSTRAINT [DF__tblRoutes__IM_St__0D99FE17]  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblSalemanRoute] ADD  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblSaleValueDiscount] ADD  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblSaleValueDiscountItems] ADD  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblSettings] ADD  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblSocioEconomicStatus] ADD  CONSTRAINT [DF__tblSocioE__IM_St__125EB334]  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblSupplier] ADD  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblTarget] ADD  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblTargetItem] ADD  CONSTRAINT [DF__tblTarget__IM_Da__29BBDDE2]  DEFAULT (getdate()) FOR [IM_DateCreated]
GO
ALTER TABLE [dbo].[tblTargetItem] ADD  CONSTRAINT [DF__tblTarget__IM_Da__2AB0021B]  DEFAULT (getdate()) FOR [IM_DateLastUpdated]
GO
ALTER TABLE [dbo].[tblTargetItem] ADD  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblTargetPeriod] ADD  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblTerritory] ADD  CONSTRAINT [DF__tblTerrit__IM_St__190BB0C3]  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblUserGroup] ADD  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblUserGroupRoles] ADD  CONSTRAINT [DF__tblUserGr__CanAc__6E372CAE]  DEFAULT ((0)) FOR [CanAccess]
GO
ALTER TABLE [dbo].[tblUserGroupRoles] ADD  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblUsers] ADD  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblUserTypes] ADD  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblVATClass] ADD  CONSTRAINT [DF__tblVATCla__IM_St__1EC48A19]  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblVATClassItem] ADD  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[test] ADD  DEFAULT ((1)) FOR [IM_Status]
GO
ALTER TABLE [dbo].[tblAccount]  WITH CHECK ADD  CONSTRAINT [FK_tblAccount_tblCostCentre] FOREIGN KEY([CostCenterId])
REFERENCES [dbo].[tblCostCentre] ([Id])
GO
ALTER TABLE [dbo].[tblAccount] CHECK CONSTRAINT [FK_tblAccount_tblCostCentre]
GO
ALTER TABLE [dbo].[tblAccountTransaction]  WITH CHECK ADD  CONSTRAINT [FK_AccountTransaction_AccountTransaction] FOREIGN KEY([AccountId])
REFERENCES [dbo].[tblAccount] ([id])
GO
ALTER TABLE [dbo].[tblAccountTransaction] CHECK CONSTRAINT [FK_AccountTransaction_AccountTransaction]
GO
ALTER TABLE [dbo].[tblActivityDocument]  WITH CHECK ADD  CONSTRAINT [ActivityDocument_ActivityType_FK] FOREIGN KEY([ActivityTypeId])
REFERENCES [dbo].[tblActivityType] ([Id])
GO
ALTER TABLE [dbo].[tblActivityDocument] CHECK CONSTRAINT [ActivityDocument_ActivityType_FK]
GO
ALTER TABLE [dbo].[tblActivityInfectionLineItem]  WITH CHECK ADD  CONSTRAINT [ActivityInfectionLineItem_ActivityDocument_FK] FOREIGN KEY([ActivityId])
REFERENCES [dbo].[tblActivityDocument] ([Id])
GO
ALTER TABLE [dbo].[tblActivityInfectionLineItem] CHECK CONSTRAINT [ActivityInfectionLineItem_ActivityDocument_FK]
GO
ALTER TABLE [dbo].[tblActivityInputLineItem]  WITH CHECK ADD  CONSTRAINT [ActivityInputLineItem_ActivityDocument_FK] FOREIGN KEY([ActivityId])
REFERENCES [dbo].[tblActivityDocument] ([Id])
GO
ALTER TABLE [dbo].[tblActivityInputLineItem] CHECK CONSTRAINT [ActivityInputLineItem_ActivityDocument_FK]
GO
ALTER TABLE [dbo].[tblActivityProduceLineItem]  WITH CHECK ADD  CONSTRAINT [ActivityProduceLineItem_ActivityDocument_FK] FOREIGN KEY([ActivityId])
REFERENCES [dbo].[tblActivityDocument] ([Id])
GO
ALTER TABLE [dbo].[tblActivityProduceLineItem] CHECK CONSTRAINT [ActivityProduceLineItem_ActivityDocument_FK]
GO
ALTER TABLE [dbo].[tblActivityServiceLineItem]  WITH CHECK ADD  CONSTRAINT [ActivityServiceLineItem_ActivityDocument_FK] FOREIGN KEY([ActivityId])
REFERENCES [dbo].[tblActivityDocument] ([Id])
GO
ALTER TABLE [dbo].[tblActivityServiceLineItem] CHECK CONSTRAINT [ActivityServiceLineItem_ActivityDocument_FK]
GO
ALTER TABLE [dbo].[tblAsset]  WITH CHECK ADD  CONSTRAINT [FK__tblAsset__AssetC__2E8092FF] FOREIGN KEY([AssetCategoryId])
REFERENCES [dbo].[tblAssetCategory] ([Id])
GO
ALTER TABLE [dbo].[tblAsset] CHECK CONSTRAINT [FK__tblAsset__AssetC__2E8092FF]
GO
ALTER TABLE [dbo].[tblAsset]  WITH CHECK ADD  CONSTRAINT [FK__tblAsset__AssetS__2F74B738] FOREIGN KEY([AssetStatusId])
REFERENCES [dbo].[tblAssetStatus] ([Id])
GO
ALTER TABLE [dbo].[tblAsset] CHECK CONSTRAINT [FK__tblAsset__AssetS__2F74B738]
GO
ALTER TABLE [dbo].[tblAsset]  WITH CHECK ADD  CONSTRAINT [FK__tblAsset__AssetT__3068DB71] FOREIGN KEY([AssetTypeId])
REFERENCES [dbo].[tblAssetType] ([Id])
GO
ALTER TABLE [dbo].[tblAsset] CHECK CONSTRAINT [FK__tblAsset__AssetT__3068DB71]
GO
ALTER TABLE [dbo].[tblAsset]  WITH CHECK ADD  CONSTRAINT [FK_tblAsset_tblAssetType] FOREIGN KEY([AssetTypeId])
REFERENCES [dbo].[tblAssetType] ([Id])
GO
ALTER TABLE [dbo].[tblAsset] CHECK CONSTRAINT [FK_tblAsset_tblAssetType]
GO
ALTER TABLE [dbo].[tblAssetCategory]  WITH CHECK ADD  CONSTRAINT [FK__tblAssetC__Asset__325123E3] FOREIGN KEY([AssetTypeId])
REFERENCES [dbo].[tblAssetType] ([Id])
GO
ALTER TABLE [dbo].[tblAssetCategory] CHECK CONSTRAINT [FK__tblAssetC__Asset__325123E3]
GO
ALTER TABLE [dbo].[tblBankBranch]  WITH CHECK ADD  CONSTRAINT [FK_tblBankBranch_tblBank] FOREIGN KEY([BankId])
REFERENCES [dbo].[tblBank] ([Id])
GO
ALTER TABLE [dbo].[tblBankBranch] CHECK CONSTRAINT [FK_tblBankBranch_tblBank]
GO
ALTER TABLE [dbo].[tblCentre]  WITH CHECK ADD  CONSTRAINT [Centre_CentreType_FK] FOREIGN KEY([CentreTypeId])
REFERENCES [dbo].[tblCentreType] ([Id])
GO
ALTER TABLE [dbo].[tblCentre] CHECK CONSTRAINT [Centre_CentreType_FK]
GO
ALTER TABLE [dbo].[tblCentre]  WITH CHECK ADD  CONSTRAINT [Centre_Hub_FK] FOREIGN KEY([HubId])
REFERENCES [dbo].[tblCostCentre] ([Id])
GO
ALTER TABLE [dbo].[tblCentre] CHECK CONSTRAINT [Centre_Hub_FK]
GO
ALTER TABLE [dbo].[tblCentre]  WITH CHECK ADD  CONSTRAINT [Centre_Route_FK] FOREIGN KEY([RouteId])
REFERENCES [dbo].[tblRoutes] ([RouteID])
GO
ALTER TABLE [dbo].[tblCentre] CHECK CONSTRAINT [Centre_Route_FK]
GO
ALTER TABLE [dbo].[tblCertainValueCertainProductDiscountItem]  WITH CHECK ADD  CONSTRAINT [FK_tblCertainValueCertainProductDiscountItem_tblCertainValueCertainProductDiscount] FOREIGN KEY([CertainValueCertainDiscountID])
REFERENCES [dbo].[tblCertainValueCertainProductDiscount] ([id])
GO
ALTER TABLE [dbo].[tblCertainValueCertainProductDiscountItem] CHECK CONSTRAINT [FK_tblCertainValueCertainProductDiscountItem_tblCertainValueCertainProductDiscount]
GO
ALTER TABLE [dbo].[tblCertainValueCertainProductDiscountItem]  WITH CHECK ADD  CONSTRAINT [FK_tblCertainValueCertainProductDiscountItem_tblProduct] FOREIGN KEY([Product])
REFERENCES [dbo].[tblProduct] ([id])
GO
ALTER TABLE [dbo].[tblCertainValueCertainProductDiscountItem] CHECK CONSTRAINT [FK_tblCertainValueCertainProductDiscountItem_tblProduct]
GO
ALTER TABLE [dbo].[tblChannelPackaging]  WITH CHECK ADD  CONSTRAINT [FK_tblChannelPackaging_tblOutletType] FOREIGN KEY([OutletTypeId])
REFERENCES [dbo].[tblOutletType] ([id])
GO
ALTER TABLE [dbo].[tblChannelPackaging] CHECK CONSTRAINT [FK_tblChannelPackaging_tblOutletType]
GO
ALTER TABLE [dbo].[tblChannelPackaging]  WITH CHECK ADD  CONSTRAINT [FK_tblChannelPackaging_tblProductPackaging] FOREIGN KEY([PackagingId])
REFERENCES [dbo].[tblProductPackaging] ([Id])
GO
ALTER TABLE [dbo].[tblChannelPackaging] CHECK CONSTRAINT [FK_tblChannelPackaging_tblProductPackaging]
GO
ALTER TABLE [dbo].[tblCommodity]  WITH CHECK ADD  CONSTRAINT [Commodity_CommodityType_FK] FOREIGN KEY([CommodityTypeId])
REFERENCES [dbo].[tblCommodityType] ([Id])
GO
ALTER TABLE [dbo].[tblCommodity] CHECK CONSTRAINT [Commodity_CommodityType_FK]
GO
ALTER TABLE [dbo].[tblCommodityGrade]  WITH CHECK ADD  CONSTRAINT [CommodityGrade_Commodity_FK] FOREIGN KEY([CommodityId])
REFERENCES [dbo].[tblCommodity] ([Id])
GO
ALTER TABLE [dbo].[tblCommodityGrade] CHECK CONSTRAINT [CommodityGrade_Commodity_FK]
GO
ALTER TABLE [dbo].[tblCommodityOwner]  WITH CHECK ADD  CONSTRAINT [CommodityOwner_CommodityOwnerSupplier_FK] FOREIGN KEY([CostCentreId])
REFERENCES [dbo].[tblCostCentre] ([Id])
GO
ALTER TABLE [dbo].[tblCommodityOwner] CHECK CONSTRAINT [CommodityOwner_CommodityOwnerSupplier_FK]
GO
ALTER TABLE [dbo].[tblCommodityOwner]  WITH CHECK ADD  CONSTRAINT [CommodityOwner_CommodityOwnerType_FK] FOREIGN KEY([CommodityOwnerTypeId])
REFERENCES [dbo].[tblCommodityOwnerType] ([Id])
GO
ALTER TABLE [dbo].[tblCommodityOwner] CHECK CONSTRAINT [CommodityOwner_CommodityOwnerType_FK]
GO
ALTER TABLE [dbo].[tblCompetitorProducts]  WITH CHECK ADD  CONSTRAINT [FK_tblCompetitorProducts_tblCompetitor] FOREIGN KEY([CompetitorId])
REFERENCES [dbo].[tblCompetitor] ([id])
GO
ALTER TABLE [dbo].[tblCompetitorProducts] CHECK CONSTRAINT [FK_tblCompetitorProducts_tblCompetitor]
GO
ALTER TABLE [dbo].[tblCompetitorProducts]  WITH CHECK ADD  CONSTRAINT [FK_tblCompetitorProducts_tblProductBrand] FOREIGN KEY([BrandId])
REFERENCES [dbo].[tblProductBrand] ([id])
GO
ALTER TABLE [dbo].[tblCompetitorProducts] CHECK CONSTRAINT [FK_tblCompetitorProducts_tblProductBrand]
GO
ALTER TABLE [dbo].[tblCompetitorProducts]  WITH CHECK ADD  CONSTRAINT [FK_tblCompetitorProducts_tblProductFlavour] FOREIGN KEY([FlavourId])
REFERENCES [dbo].[tblProductFlavour] ([id])
GO
ALTER TABLE [dbo].[tblCompetitorProducts] CHECK CONSTRAINT [FK_tblCompetitorProducts_tblProductFlavour]
GO
ALTER TABLE [dbo].[tblCompetitorProducts]  WITH CHECK ADD  CONSTRAINT [FK_tblCompetitorProducts_tblProductPackaging] FOREIGN KEY([PackagingId])
REFERENCES [dbo].[tblProductPackaging] ([Id])
GO
ALTER TABLE [dbo].[tblCompetitorProducts] CHECK CONSTRAINT [FK_tblCompetitorProducts_tblProductPackaging]
GO
ALTER TABLE [dbo].[tblCompetitorProducts]  WITH CHECK ADD  CONSTRAINT [FK_tblCompetitorProducts_tblProductPackagingType] FOREIGN KEY([PackagingTypeId])
REFERENCES [dbo].[tblProductPackagingType] ([id])
GO
ALTER TABLE [dbo].[tblCompetitorProducts] CHECK CONSTRAINT [FK_tblCompetitorProducts_tblProductPackagingType]
GO
ALTER TABLE [dbo].[tblCompetitorProducts]  WITH CHECK ADD  CONSTRAINT [FK_tblCompetitorProducts_tblProductType] FOREIGN KEY([ProductTypeId])
REFERENCES [dbo].[tblProductType] ([id])
GO
ALTER TABLE [dbo].[tblCompetitorProducts] CHECK CONSTRAINT [FK_tblCompetitorProducts_tblProductType]
GO
ALTER TABLE [dbo].[tblConsolidatedProductProducts]  WITH CHECK ADD  CONSTRAINT [FK_tblConsolidatedProductProducts_tblProduct] FOREIGN KEY([ConsolidatedProductId])
REFERENCES [dbo].[tblProduct] ([id])
GO
ALTER TABLE [dbo].[tblConsolidatedProductProducts] CHECK CONSTRAINT [FK_tblConsolidatedProductProducts_tblProduct]
GO
ALTER TABLE [dbo].[tblConsolidatedProductProducts]  WITH CHECK ADD  CONSTRAINT [FK_tblConsolidatedProductProducts_tblProduct1] FOREIGN KEY([ProductId])
REFERENCES [dbo].[tblProduct] ([id])
GO
ALTER TABLE [dbo].[tblConsolidatedProductProducts] CHECK CONSTRAINT [FK_tblConsolidatedProductProducts_tblProduct1]
GO
ALTER TABLE [dbo].[tblContact]  WITH CHECK ADD  CONSTRAINT [FK_tblContact_tblContactType] FOREIGN KEY([ContactType])
REFERENCES [dbo].[tblContactType] ([id])
GO
ALTER TABLE [dbo].[tblContact] CHECK CONSTRAINT [FK_tblContact_tblContactType]
GO
ALTER TABLE [dbo].[tblContainerType]  WITH CHECK ADD  CONSTRAINT [ContainerType_CommodityGrade_FK] FOREIGN KEY([CommodityGradeId])
REFERENCES [dbo].[tblCommodityGrade] ([Id])
GO
ALTER TABLE [dbo].[tblContainerType] CHECK CONSTRAINT [ContainerType_CommodityGrade_FK]
GO
ALTER TABLE [dbo].[tblContainment]  WITH CHECK ADD  CONSTRAINT [FK_tblContainment_tblProduct] FOREIGN KEY([ReturnableProduct])
REFERENCES [dbo].[tblProduct] ([id])
GO
ALTER TABLE [dbo].[tblContainment] CHECK CONSTRAINT [FK_tblContainment_tblProduct]
GO
ALTER TABLE [dbo].[tblContainment]  WITH CHECK ADD  CONSTRAINT [FK_tblContainment_tblProductPackagingType] FOREIGN KEY([ProductPackagingType])
REFERENCES [dbo].[tblProductPackagingType] ([id])
GO
ALTER TABLE [dbo].[tblContainment] CHECK CONSTRAINT [FK_tblContainment_tblProductPackagingType]
GO
ALTER TABLE [dbo].[tblCostCentre]  WITH NOCHECK ADD  CONSTRAINT [FK_tblCostCentre_tblCostCentre] FOREIGN KEY([Id])
REFERENCES [dbo].[tblCostCentre] ([Id])
GO
ALTER TABLE [dbo].[tblCostCentre] CHECK CONSTRAINT [FK_tblCostCentre_tblCostCentre]
GO
ALTER TABLE [dbo].[tblCostCentre]  WITH NOCHECK ADD  CONSTRAINT [FK_tblCostCentre_tblDiscountGroup] FOREIGN KEY([Outlet_DiscountGroupId])
REFERENCES [dbo].[tblDiscountGroup] ([id])
GO
ALTER TABLE [dbo].[tblCostCentre] CHECK CONSTRAINT [FK_tblCostCentre_tblDiscountGroup]
GO
ALTER TABLE [dbo].[tblCostCentre]  WITH NOCHECK ADD  CONSTRAINT [FK_tblCostCentre_tblOutletCategory] FOREIGN KEY([Outlet_Category_Id])
REFERENCES [dbo].[tblOutletCategory] ([id])
GO
ALTER TABLE [dbo].[tblCostCentre] CHECK CONSTRAINT [FK_tblCostCentre_tblOutletCategory]
GO
ALTER TABLE [dbo].[tblCostCentre]  WITH NOCHECK ADD  CONSTRAINT [FK_tblCostCentre_tblOutletType] FOREIGN KEY([Outlet_Type_Id])
REFERENCES [dbo].[tblOutletType] ([id])
GO
ALTER TABLE [dbo].[tblCostCentre] CHECK CONSTRAINT [FK_tblCostCentre_tblOutletType]
GO
ALTER TABLE [dbo].[tblCostCentre]  WITH NOCHECK ADD  CONSTRAINT [FK_tblCostCentre_tblRegion] FOREIGN KEY([Distributor_RegionId])
REFERENCES [dbo].[tblRegion] ([id])
GO
ALTER TABLE [dbo].[tblCostCentre] CHECK CONSTRAINT [FK_tblCostCentre_tblRegion]
GO
ALTER TABLE [dbo].[tblCostCentre]  WITH NOCHECK ADD  CONSTRAINT [FK_tblCostCentre_tblRoutes] FOREIGN KEY([RouteId])
REFERENCES [dbo].[tblRoutes] ([RouteID])
GO
ALTER TABLE [dbo].[tblCostCentre] CHECK CONSTRAINT [FK_tblCostCentre_tblRoutes]
GO
ALTER TABLE [dbo].[tblCostCentre]  WITH NOCHECK ADD  CONSTRAINT [FK_tblCostCentre_tblSocioEconomicStatus] FOREIGN KEY([SocioEconomicStatus_id])
REFERENCES [dbo].[tblSocioEconomicStatus] ([id])
GO
ALTER TABLE [dbo].[tblCostCentre] CHECK CONSTRAINT [FK_tblCostCentre_tblSocioEconomicStatus]
GO
ALTER TABLE [dbo].[tblCostCentre]  WITH NOCHECK ADD  CONSTRAINT [FK_tblCostCentre_tblVATClass] FOREIGN KEY([VATClass_Id])
REFERENCES [dbo].[tblVATClass] ([id])
GO
ALTER TABLE [dbo].[tblCostCentre] CHECK CONSTRAINT [FK_tblCostCentre_tblVATClass]
GO
ALTER TABLE [dbo].[tblCostCentreApplication]  WITH CHECK ADD  CONSTRAINT [FK_tblCostCentreApplication_tblCostCentre] FOREIGN KEY([costcentreid])
REFERENCES [dbo].[tblCostCentre] ([Id])
GO
ALTER TABLE [dbo].[tblCostCentreApplication] CHECK CONSTRAINT [FK_tblCostCentreApplication_tblCostCentre]
GO
ALTER TABLE [dbo].[tblCostCentreMapping]  WITH CHECK ADD  CONSTRAINT [Mapping_CostCentre_FK] FOREIGN KEY([Id])
REFERENCES [dbo].[tblCostCentre] ([Id])
GO
ALTER TABLE [dbo].[tblCostCentreMapping] CHECK CONSTRAINT [Mapping_CostCentre_FK]
GO
ALTER TABLE [dbo].[tblCountry]  WITH CHECK ADD  CONSTRAINT [FK_tblCountry_tblTerritory] FOREIGN KEY([Territory_ID])
REFERENCES [dbo].[tblTerritory] ([id])
GO
ALTER TABLE [dbo].[tblCountry] CHECK CONSTRAINT [FK_tblCountry_tblTerritory]
GO
ALTER TABLE [dbo].[tblCustomerDiscount]  WITH CHECK ADD  CONSTRAINT [FK_tblCustomerDiscount_tblCostCentre] FOREIGN KEY([Outlet])
REFERENCES [dbo].[tblCostCentre] ([Id])
GO
ALTER TABLE [dbo].[tblCustomerDiscount] CHECK CONSTRAINT [FK_tblCustomerDiscount_tblCostCentre]
GO
ALTER TABLE [dbo].[tblCustomerDiscount]  WITH CHECK ADD  CONSTRAINT [FK_tblCustomerDiscount_tblProduct] FOREIGN KEY([ProductRef])
REFERENCES [dbo].[tblProduct] ([id])
GO
ALTER TABLE [dbo].[tblCustomerDiscount] CHECK CONSTRAINT [FK_tblCustomerDiscount_tblProduct]
GO
ALTER TABLE [dbo].[tblCustomerDiscountItem]  WITH CHECK ADD  CONSTRAINT [FK_tblCustomerDiscountItem_tblCustomerDiscount] FOREIGN KEY([CustomerDiscountId])
REFERENCES [dbo].[tblCustomerDiscount] ([id])
GO
ALTER TABLE [dbo].[tblCustomerDiscountItem] CHECK CONSTRAINT [FK_tblCustomerDiscountItem_tblCustomerDiscount]
GO
ALTER TABLE [dbo].[tblDiscountItem]  WITH CHECK ADD  CONSTRAINT [FK_tblDiscountItem_tblDiscounts] FOREIGN KEY([DiscountId])
REFERENCES [dbo].[tblDiscounts] ([id])
GO
ALTER TABLE [dbo].[tblDiscountItem] CHECK CONSTRAINT [FK_tblDiscountItem_tblDiscounts]
GO
ALTER TABLE [dbo].[tblDiscounts]  WITH CHECK ADD  CONSTRAINT [FK_tblDiscounts_tblPricingTier] FOREIGN KEY([TierId])
REFERENCES [dbo].[tblPricingTier] ([id])
GO
ALTER TABLE [dbo].[tblDiscounts] CHECK CONSTRAINT [FK_tblDiscounts_tblPricingTier]
GO
ALTER TABLE [dbo].[tblDistrict]  WITH CHECK ADD  CONSTRAINT [FK_tblDistrict_tblProvince] FOREIGN KEY([ProvinceId])
REFERENCES [dbo].[tblProvince] ([Id])
GO
ALTER TABLE [dbo].[tblDistrict] CHECK CONSTRAINT [FK_tblDistrict_tblProvince]
GO
ALTER TABLE [dbo].[tblEquipment]  WITH CHECK ADD  CONSTRAINT [Equipment_ContainerType_FK] FOREIGN KEY([ContainerTypeId])
REFERENCES [dbo].[tblContainerType] ([Id])
GO
ALTER TABLE [dbo].[tblEquipment] CHECK CONSTRAINT [Equipment_ContainerType_FK]
GO
ALTER TABLE [dbo].[tblEquipment]  WITH CHECK ADD  CONSTRAINT [Equipment_CostCentre_FK] FOREIGN KEY([CostCentreId])
REFERENCES [dbo].[tblCostCentre] ([Id])
GO
ALTER TABLE [dbo].[tblEquipment] CHECK CONSTRAINT [Equipment_CostCentre_FK]
GO
ALTER TABLE [dbo].[tblFreeOfChargeDiscount]  WITH CHECK ADD  CONSTRAINT [FK_tblFreeOfChargeDiscount_tblProduct] FOREIGN KEY([ProductRef])
REFERENCES [dbo].[tblProduct] ([id])
GO
ALTER TABLE [dbo].[tblFreeOfChargeDiscount] CHECK CONSTRAINT [FK_tblFreeOfChargeDiscount_tblProduct]
GO
ALTER TABLE [dbo].[tblInventory]  WITH CHECK ADD  CONSTRAINT [fk_costcentre_pid] FOREIGN KEY([WareHouseId])
REFERENCES [dbo].[tblCostCentre] ([Id])
GO
ALTER TABLE [dbo].[tblInventory] CHECK CONSTRAINT [fk_costcentre_pid]
GO
ALTER TABLE [dbo].[tblInventory]  WITH CHECK ADD  CONSTRAINT [FK_tblInventory_tblProduct] FOREIGN KEY([ProductId])
REFERENCES [dbo].[tblProduct] ([id])
GO
ALTER TABLE [dbo].[tblInventory] CHECK CONSTRAINT [FK_tblInventory_tblProduct]
GO
ALTER TABLE [dbo].[tblInventorySerials]  WITH CHECK ADD  CONSTRAINT [FK_tblInventorySerials_tblCostCentre] FOREIGN KEY([CostCentreId])
REFERENCES [dbo].[tblCostCentre] ([Id])
GO
ALTER TABLE [dbo].[tblInventorySerials] CHECK CONSTRAINT [FK_tblInventorySerials_tblCostCentre]
GO
ALTER TABLE [dbo].[tblInventorySerials]  WITH CHECK ADD  CONSTRAINT [FK_tblInventorySerials_tblProduct] FOREIGN KEY([ProductId])
REFERENCES [dbo].[tblProduct] ([id])
GO
ALTER TABLE [dbo].[tblInventorySerials] CHECK CONSTRAINT [FK_tblInventorySerials_tblProduct]
GO
ALTER TABLE [dbo].[tblInventoryTransaction]  WITH CHECK ADD  CONSTRAINT [FK_tblInventoryTransaction_tblInventory] FOREIGN KEY([InventoryId])
REFERENCES [dbo].[tblInventory] ([id])
GO
ALTER TABLE [dbo].[tblInventoryTransaction] CHECK CONSTRAINT [FK_tblInventoryTransaction_tblInventory]
GO
ALTER TABLE [dbo].[tblLineItems]  WITH CHECK ADD  CONSTRAINT [FK_tblLineItems_tblDocument] FOREIGN KEY([DocumentID])
REFERENCES [dbo].[tblDocument] ([Id])
GO
ALTER TABLE [dbo].[tblLineItems] CHECK CONSTRAINT [FK_tblLineItems_tblDocument]
GO
ALTER TABLE [dbo].[tblOrderPaymentInfo]  WITH CHECK ADD  CONSTRAINT [OrderPayment_Order_FK] FOREIGN KEY([DocumentId])
REFERENCES [dbo].[tblDocument] ([Id])
GO
ALTER TABLE [dbo].[tblOrderPaymentInfo] CHECK CONSTRAINT [OrderPayment_Order_FK]
GO
ALTER TABLE [dbo].[tblPaymentTracker]  WITH CHECK ADD  CONSTRAINT [FK_tblPaymentTracker_tblCostCentre] FOREIGN KEY([CostCenterId])
REFERENCES [dbo].[tblCostCentre] ([Id])
GO
ALTER TABLE [dbo].[tblPaymentTracker] CHECK CONSTRAINT [FK_tblPaymentTracker_tblCostCentre]
GO
ALTER TABLE [dbo].[tblPricing]  WITH CHECK ADD  CONSTRAINT [FK_tblPricing_tblPricingTier] FOREIGN KEY([Tier])
REFERENCES [dbo].[tblPricingTier] ([id])
GO
ALTER TABLE [dbo].[tblPricing] CHECK CONSTRAINT [FK_tblPricing_tblPricingTier]
GO
ALTER TABLE [dbo].[tblPricing]  WITH CHECK ADD  CONSTRAINT [FK_tblPricing_tblProduct] FOREIGN KEY([ProductRef])
REFERENCES [dbo].[tblProduct] ([id])
GO
ALTER TABLE [dbo].[tblPricing] CHECK CONSTRAINT [FK_tblPricing_tblProduct]
GO
ALTER TABLE [dbo].[tblPricingItem]  WITH CHECK ADD  CONSTRAINT [FK__tblPricin__Prici__19218AB3] FOREIGN KEY([PricingId])
REFERENCES [dbo].[tblPricing] ([id])
GO
ALTER TABLE [dbo].[tblPricingItem] CHECK CONSTRAINT [FK__tblPricin__Prici__19218AB3]
GO
ALTER TABLE [dbo].[tblPricingItem]  WITH CHECK ADD  CONSTRAINT [FK__tblPricin__Prici__1A15AEEC] FOREIGN KEY([PricingId])
REFERENCES [dbo].[tblPricing] ([id])
GO
ALTER TABLE [dbo].[tblPricingItem] CHECK CONSTRAINT [FK__tblPricin__Prici__1A15AEEC]
GO
ALTER TABLE [dbo].[tblProduct]  WITH NOCHECK ADD  CONSTRAINT [FK_Product_ProductBrand] FOREIGN KEY([BrandId])
REFERENCES [dbo].[tblProductBrand] ([id])
GO
ALTER TABLE [dbo].[tblProduct] CHECK CONSTRAINT [FK_Product_ProductBrand]
GO
ALTER TABLE [dbo].[tblProduct]  WITH NOCHECK ADD  CONSTRAINT [FK_Product_ProductFlavour] FOREIGN KEY([FlavourId])
REFERENCES [dbo].[tblProductFlavour] ([id])
GO
ALTER TABLE [dbo].[tblProduct] CHECK CONSTRAINT [FK_Product_ProductFlavour]
GO
ALTER TABLE [dbo].[tblProduct]  WITH NOCHECK ADD  CONSTRAINT [FK_Product_ProductPackaging] FOREIGN KEY([PackagingId])
REFERENCES [dbo].[tblProductPackaging] ([Id])
GO
ALTER TABLE [dbo].[tblProduct] CHECK CONSTRAINT [FK_Product_ProductPackaging]
GO
ALTER TABLE [dbo].[tblProduct]  WITH NOCHECK ADD  CONSTRAINT [FK_Product_ProductPackagingType] FOREIGN KEY([PackagingTypeId])
REFERENCES [dbo].[tblProductPackagingType] ([id])
GO
ALTER TABLE [dbo].[tblProduct] CHECK CONSTRAINT [FK_Product_ProductPackagingType]
GO
ALTER TABLE [dbo].[tblProduct]  WITH NOCHECK ADD  CONSTRAINT [FK_Product_ProductType] FOREIGN KEY([ProductTypeId])
REFERENCES [dbo].[tblProductType] ([id])
GO
ALTER TABLE [dbo].[tblProduct] CHECK CONSTRAINT [FK_Product_ProductType]
GO
ALTER TABLE [dbo].[tblProductBrand]  WITH CHECK ADD  CONSTRAINT [FK_tblProductBrand_tblSupplier] FOREIGN KEY([SupplierId])
REFERENCES [dbo].[tblSupplier] ([id])
GO
ALTER TABLE [dbo].[tblProductBrand] CHECK CONSTRAINT [FK_tblProductBrand_tblSupplier]
GO
ALTER TABLE [dbo].[tblProductDiscountGroup]  WITH CHECK ADD  CONSTRAINT [FK_tblProductDiscountGroup_tblDiscountGroup] FOREIGN KEY([DiscountGroup])
REFERENCES [dbo].[tblDiscountGroup] ([id])
GO
ALTER TABLE [dbo].[tblProductDiscountGroup] CHECK CONSTRAINT [FK_tblProductDiscountGroup_tblDiscountGroup]
GO
ALTER TABLE [dbo].[tblProductDiscountGroupItem]  WITH CHECK ADD  CONSTRAINT [FK_tblProductDiscountGroupItem_tblProduct] FOREIGN KEY([ProductRef])
REFERENCES [dbo].[tblProduct] ([id])
GO
ALTER TABLE [dbo].[tblProductDiscountGroupItem] CHECK CONSTRAINT [FK_tblProductDiscountGroupItem_tblProduct]
GO
ALTER TABLE [dbo].[tblProductDiscountGroupItem]  WITH CHECK ADD  CONSTRAINT [FK_tblProductDiscountGroupItem_tblProductDiscountGroup] FOREIGN KEY([ProductDiscountGroup])
REFERENCES [dbo].[tblProductDiscountGroup] ([id])
GO
ALTER TABLE [dbo].[tblProductDiscountGroupItem] CHECK CONSTRAINT [FK_tblProductDiscountGroupItem_tblProductDiscountGroup]
GO
ALTER TABLE [dbo].[tblProductPackaging]  WITH NOCHECK ADD  CONSTRAINT [FK_tblProductPackaging_tblContainment] FOREIGN KEY([Containment])
REFERENCES [dbo].[tblContainment] ([id])
GO
ALTER TABLE [dbo].[tblProductPackaging] CHECK CONSTRAINT [FK_tblProductPackaging_tblContainment]
GO
ALTER TABLE [dbo].[tblProductPackaging]  WITH NOCHECK ADD  CONSTRAINT [FK_tblProductPackaging_tblProduct] FOREIGN KEY([ReturnableProduct])
REFERENCES [dbo].[tblProduct] ([id])
GO
ALTER TABLE [dbo].[tblProductPackaging] CHECK CONSTRAINT [FK_tblProductPackaging_tblProduct]
GO
ALTER TABLE [dbo].[tblPromotionDiscount]  WITH CHECK ADD  CONSTRAINT [FK_tblPromotionDiscount_tblProduct] FOREIGN KEY([ProductRef])
REFERENCES [dbo].[tblProduct] ([id])
GO
ALTER TABLE [dbo].[tblPromotionDiscount] CHECK CONSTRAINT [FK_tblPromotionDiscount_tblProduct]
GO
ALTER TABLE [dbo].[tblPromotionDiscountItem]  WITH CHECK ADD  CONSTRAINT [FK_tblPromotionDiscountItem_tblPromotionDiscount] FOREIGN KEY([PromotionDiscountId])
REFERENCES [dbo].[tblPromotionDiscount] ([id])
GO
ALTER TABLE [dbo].[tblPromotionDiscountItem] CHECK CONSTRAINT [FK_tblPromotionDiscountItem_tblPromotionDiscount]
GO
ALTER TABLE [dbo].[tblProvince]  WITH CHECK ADD  CONSTRAINT [FK_tblProvince_tblProvince] FOREIGN KEY([CountryId])
REFERENCES [dbo].[tblCountry] ([id])
GO
ALTER TABLE [dbo].[tblProvince] CHECK CONSTRAINT [FK_tblProvince_tblProvince]
GO
ALTER TABLE [dbo].[tblPurchasingClerkRoute]  WITH CHECK ADD  CONSTRAINT [PurchasingClerkRoute_Route_FK] FOREIGN KEY([RouteId])
REFERENCES [dbo].[tblRoutes] ([RouteID])
GO
ALTER TABLE [dbo].[tblPurchasingClerkRoute] CHECK CONSTRAINT [PurchasingClerkRoute_Route_FK]
GO
ALTER TABLE [dbo].[tblRecollectionItem]  WITH CHECK ADD  CONSTRAINT [RecollectionItem_Recollection_FK] FOREIGN KEY([RecollectionId])
REFERENCES [dbo].[tblRecollection] ([Id])
GO
ALTER TABLE [dbo].[tblRecollectionItem] CHECK CONSTRAINT [RecollectionItem_Recollection_FK]
GO
ALTER TABLE [dbo].[tblRegion]  WITH CHECK ADD  CONSTRAINT [FK_tblRegion_tblCountry] FOREIGN KEY([Country])
REFERENCES [dbo].[tblCountry] ([id])
GO
ALTER TABLE [dbo].[tblRegion] CHECK CONSTRAINT [FK_tblRegion_tblCountry]
GO
ALTER TABLE [dbo].[tblReOrderLevel]  WITH CHECK ADD  CONSTRAINT [FK_tblReOrderLevel_tblProduct] FOREIGN KEY([ProductId])
REFERENCES [dbo].[tblProduct] ([id])
GO
ALTER TABLE [dbo].[tblReOrderLevel] CHECK CONSTRAINT [FK_tblReOrderLevel_tblProduct]
GO
ALTER TABLE [dbo].[tblReOrderLevel]  WITH CHECK ADD  CONSTRAINT [FK_tblReOrderLevel_tblReOrderLevel] FOREIGN KEY([DistributorId])
REFERENCES [dbo].[tblCostCentre] ([Id])
GO
ALTER TABLE [dbo].[tblReOrderLevel] CHECK CONSTRAINT [FK_tblReOrderLevel_tblReOrderLevel]
GO
ALTER TABLE [dbo].[tblRoutes]  WITH CHECK ADD  CONSTRAINT [FK_tblRoutes_tblRoute] FOREIGN KEY([RegionId])
REFERENCES [dbo].[tblRegion] ([id])
GO
ALTER TABLE [dbo].[tblRoutes] CHECK CONSTRAINT [FK_tblRoutes_tblRoute]
GO
ALTER TABLE [dbo].[tblSalemanRoute]  WITH CHECK ADD  CONSTRAINT [FK__tblSalema__Route__2C345F27] FOREIGN KEY([RouteId])
REFERENCES [dbo].[tblRoutes] ([RouteID])
GO
ALTER TABLE [dbo].[tblSalemanRoute] CHECK CONSTRAINT [FK__tblSalema__Route__2C345F27]
GO
ALTER TABLE [dbo].[tblSalemanRoute]  WITH CHECK ADD  CONSTRAINT [FK__tblSalema__Route__2D288360] FOREIGN KEY([RouteId])
REFERENCES [dbo].[tblRoutes] ([RouteID])
GO
ALTER TABLE [dbo].[tblSalemanRoute] CHECK CONSTRAINT [FK__tblSalema__Route__2D288360]
GO
ALTER TABLE [dbo].[tblSaleValueDiscount]  WITH CHECK ADD  CONSTRAINT [FK_tblSaleValueDiscount_tblSaleValueDiscount] FOREIGN KEY([TierId])
REFERENCES [dbo].[tblPricingTier] ([id])
GO
ALTER TABLE [dbo].[tblSaleValueDiscount] CHECK CONSTRAINT [FK_tblSaleValueDiscount_tblSaleValueDiscount]
GO
ALTER TABLE [dbo].[tblSaleValueDiscountItems]  WITH CHECK ADD  CONSTRAINT [FK_tblSaleValueDiscountItems_tblSaleValueDiscount] FOREIGN KEY([SaleValueId])
REFERENCES [dbo].[tblSaleValueDiscount] ([id])
GO
ALTER TABLE [dbo].[tblSaleValueDiscountItems] CHECK CONSTRAINT [FK_tblSaleValueDiscountItems_tblSaleValueDiscount]
GO
ALTER TABLE [dbo].[tblShipToAddress]  WITH CHECK ADD  CONSTRAINT [ShipToAdress_CostCentre_FK] FOREIGN KEY([CostCentreId])
REFERENCES [dbo].[tblCostCentre] ([Id])
GO
ALTER TABLE [dbo].[tblShipToAddress] CHECK CONSTRAINT [ShipToAdress_CostCentre_FK]
GO
ALTER TABLE [dbo].[tblSourcingLineItem]  WITH CHECK ADD  CONSTRAINT [SourcingLineItem_SourcingDocument_FK] FOREIGN KEY([DocumentId])
REFERENCES [dbo].[tblSourcingDocument] ([Id])
GO
ALTER TABLE [dbo].[tblSourcingLineItem] CHECK CONSTRAINT [SourcingLineItem_SourcingDocument_FK]
GO
ALTER TABLE [dbo].[tblTarget]  WITH CHECK ADD  CONSTRAINT [FK_tblTarget_tblCostCentre] FOREIGN KEY([CostCentreId])
REFERENCES [dbo].[tblCostCentre] ([Id])
GO
ALTER TABLE [dbo].[tblTarget] CHECK CONSTRAINT [FK_tblTarget_tblCostCentre]
GO
ALTER TABLE [dbo].[tblTarget]  WITH CHECK ADD  CONSTRAINT [FK_tblTarget_tblTargetPeriod] FOREIGN KEY([PeriodId])
REFERENCES [dbo].[tblTargetPeriod] ([Id])
GO
ALTER TABLE [dbo].[tblTarget] CHECK CONSTRAINT [FK_tblTarget_tblTargetPeriod]
GO
ALTER TABLE [dbo].[tblTargetItem]  WITH CHECK ADD  CONSTRAINT [FK__tblTarget__Produ__732AC307] FOREIGN KEY([ProductId])
REFERENCES [dbo].[tblProduct] ([id])
GO
ALTER TABLE [dbo].[tblTargetItem] CHECK CONSTRAINT [FK__tblTarget__Produ__732AC307]
GO
ALTER TABLE [dbo].[tblTargetItem]  WITH CHECK ADD  CONSTRAINT [FK__tblTarget__Targe__741EE740] FOREIGN KEY([TargetId])
REFERENCES [dbo].[tblTarget] ([id])
GO
ALTER TABLE [dbo].[tblTargetItem] CHECK CONSTRAINT [FK__tblTarget__Targe__741EE740]
GO
ALTER TABLE [dbo].[tblUserGroupRoles]  WITH CHECK ADD  CONSTRAINT [FK__tblUserGr__Group__31ED387D] FOREIGN KEY([GroupId])
REFERENCES [dbo].[tblUserGroup] ([Id])
GO
ALTER TABLE [dbo].[tblUserGroupRoles] CHECK CONSTRAINT [FK__tblUserGr__Group__31ED387D]
GO
ALTER TABLE [dbo].[tblUsers]  WITH CHECK ADD  CONSTRAINT [FK__tblUsers__GroupI__34C9A528] FOREIGN KEY([GroupId])
REFERENCES [dbo].[tblUserGroup] ([Id])
GO
ALTER TABLE [dbo].[tblUsers] CHECK CONSTRAINT [FK__tblUsers__GroupI__34C9A528]
GO
ALTER TABLE [dbo].[tblUsers]  WITH CHECK ADD  CONSTRAINT [FK_tblUsers_tblUsers] FOREIGN KEY([CostCenterId])
REFERENCES [dbo].[tblCostCentre] ([Id])
GO
ALTER TABLE [dbo].[tblUsers] CHECK CONSTRAINT [FK_tblUsers_tblUsers]
GO
ALTER TABLE [dbo].[tblVATClassItem]  WITH CHECK ADD  CONSTRAINT [FK_tblVATClassItem_tblVATClass] FOREIGN KEY([VATClassID])
REFERENCES [dbo].[tblVATClass] ([id])
GO
ALTER TABLE [dbo].[tblVATClassItem] CHECK CONSTRAINT [FK_tblVATClassItem_tblVATClass]
GO
