
GO
/****** Object:  Table [dbo].[tblPricingTier]    Script Date: 07/13/2012 16:55:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblPricingTier](
	[id] [uniqueidentifier] NOT NULL,
	[Code] [nvarchar](50) NULL,
	[Name] [nvarchar](250) NOT NULL,
	[Description] [nvarchar](450) NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_tblPricingTier] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblSupplier]    Script Date: 07/13/2012 16:55:04 ******/
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
	[IM_IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_tblSupplier] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblProductBrand]    Script Date: 07/13/2012 16:55:04 ******/
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
	[IM_IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_ProductBrand] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblProductFlavour]    Script Date: 07/13/2012 16:55:04 ******/
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
	[IM_IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_ProductFlavour] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblProductPackagingType]    Script Date: 07/13/2012 16:55:04 ******/
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
	[IM_IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_ProductPackagingType] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblProductType]    Script Date: 07/13/2012 16:55:04 ******/
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
	[IM_IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_ProductType] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblProduct]    Script Date: 07/13/2012 16:55:04 ******/
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
	[IM_IsActive] [bit] NOT NULL,
	[ReturnableType] [int] NULL,
	[Capacity] [int] NOT NULL,
	[VatClassId] [uniqueidentifier] NULL,
	[ExFactoryPrice] [decimal](20, 2) NOT NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblPricing]    Script Date: 07/13/2012 16:55:04 ******/
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
	[IM_IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_tblPricing] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblPricingItem]    Script Date: 07/13/2012 16:55:04 ******/
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
	[IM_IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_tblPricingItem] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblTerritory]    Script Date: 07/13/2012 16:55:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblTerritory](
	[id] [uniqueidentifier] NOT NULL,
	[Name] [varchar](50) NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_dbo.tblTerritory] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblCountry]    Script Date: 07/13/2012 16:55:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblCountry](
	[id] [uniqueidentifier] NOT NULL,
	[Name] [varchar](150) NOT NULL,
	[Code] [nvarchar](150) NULL,
	[Currency] [nvarchar](150) NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_IsActive] [bit] NOT NULL,
	[Territory_ID] [uniqueidentifier] NULL,
 CONSTRAINT [PK_dbo.tlbCountry] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblRegion]    Script Date: 07/13/2012 16:55:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblRegion](
	[id] [uniqueidentifier] NOT NULL,
	[Name] [varchar](50) NULL,
	[Description] [varchar](50) NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_IsActive] [bit] NOT NULL,
	[Country] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_tblRegion] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblOutletCategory]    Script Date: 07/13/2012 16:55:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblOutletCategory](
	[id] [uniqueidentifier] NOT NULL,
	[Name] [varchar](max) NOT NULL,
	[Description] [varchar](max) NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_tblOutletCategory] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblOutletType]    Script Date: 07/13/2012 16:55:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblOutletType](
	[id] [uniqueidentifier] NOT NULL,
	[Name] [varchar](max) NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_tblOutletType] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblDiscountGroup]    Script Date: 07/13/2012 16:55:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblDiscountGroup](
	[id] [uniqueidentifier] NOT NULL,
	[Code] [varchar](250) NOT NULL,
	[Name] [varchar](250) NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_tblDiscountGroup] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblVATClass]    Script Date: 07/13/2012 16:55:04 ******/
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
	[IM_IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_tblVATClass] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblSocioEconomicStatus]    Script Date: 07/13/2012 16:55:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblSocioEconomicStatus](
	[id] [uniqueidentifier] NOT NULL,
	[Status] [nvarchar](50) NOT NULL,
	[IM_IsActive] [bit] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
 CONSTRAINT [PK_tblSocioEconomicStatus] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCostCentre]    Script Date: 07/13/2012 16:55:04 ******/
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
	[IM_IsActive] [bit] NOT NULL,
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
	[IsApproved] [bit] NULL,
 CONSTRAINT [PK_tblCostCentre] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCustomerDiscount]    Script Date: 07/13/2012 16:55:04 ******/
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
	[IM_IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_tblCustomerDiscount] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCustomerDiscountItem]    Script Date: 07/13/2012 16:55:04 ******/
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
	[IM_IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_tblCustomerDiscountItem] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblAccount]    Script Date: 07/13/2012 16:55:04 ******/
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
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblAccountTransaction]    Script Date: 07/13/2012 16:55:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblAccountTransaction](
	[Id] [uniqueidentifier] NOT NULL,
	[AccountId] [uniqueidentifier] NOT NULL,
	[Amount] [decimal](18, 0) NOT NULL,
	[DocumentType] [int] NOT NULL,
	[DocumentId] [uniqueidentifier] NOT NULL,
	[DateInserted] [datetime] NOT NULL,
 CONSTRAINT [PK_AccountTransaction] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblInventory]    Script Date: 07/13/2012 16:55:04 ******/
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
	[IM_IsActive] [bit] NOT NULL,
	[UnavailableBalance] [decimal](18, 0) NOT NULL,
 CONSTRAINT [PK_tblInventory] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblInventoryTransaction]    Script Date: 07/13/2012 16:55:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblInventoryTransaction](
	[Id] [uniqueidentifier] NOT NULL,
	[InventoryId] [uniqueidentifier] NOT NULL,
	[NoItems] [decimal](20, 2) NULL,
	[NetValue] [decimal](18, 0) NOT NULL,
	[GrossValue] [decimal](18, 0) NOT NULL,
	[DocumentType] [int] NOT NULL,
	[DocumentId] [uniqueidentifier] NOT NULL,
	[DateInserted] [datetime] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_tblInventoryTransaction] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblPaymentTracker]    Script Date: 07/13/2012 16:55:04 ******/
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
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCostCentreApplication]    Script Date: 07/13/2012 16:55:04 ******/
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
	[IM_IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_tblCostCentreApplication] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblPromotionDiscount]    Script Date: 07/13/2012 16:55:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblPromotionDiscount](
	[id] [uniqueidentifier] NOT NULL,
	[ProductRef] [uniqueidentifier] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_tblPromotionDiscount] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblPromotionDiscountItem]    Script Date: 07/13/2012 16:55:04 ******/
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
	[IM_IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_tblFreeOfChargeDiscountItem] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblContainment]    Script Date: 07/13/2012 16:55:04 ******/
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
	[IM_IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_tblContainment] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblProductPackaging]    Script Date: 07/13/2012 16:55:04 ******/
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
	[IM_IsActive] [bit] NOT NULL,
	[Containment] [uniqueidentifier] NULL,
	[ReturnableProduct] [uniqueidentifier] NULL,
 CONSTRAINT [PK_ProductPackaging] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblFreeOfChargeDiscount]    Script Date: 07/13/2012 16:55:04 ******/
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
	[IM_IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_tblFreeOfChargeDiscount] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblConsolidatedProductProducts]    Script Date: 07/13/2012 16:55:04 ******/
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
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblTargetPeriod]    Script Date: 07/13/2012 16:55:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblTargetPeriod](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [varchar](50) NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_tblTargetPeriod] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblTarget]    Script Date: 07/13/2012 16:55:04 ******/
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
	[IM_IsActive] [bit] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
 CONSTRAINT [PK_tblTarget] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
 CONSTRAINT [UNIQUE_tblTarget] UNIQUE NONCLUSTERED 
(
	[CostCentreId] ASC,
	[PeriodId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblTargetItem]    Script Date: 07/13/2012 16:55:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblTargetItem](
	[Id] [uniqueidentifier] NOT NULL,
	[TargetId] [uniqueidentifier] NOT NULL,
	[ProductId] [uniqueidentifier] NOT NULL,
	[Quantity] [decimal](18, 0) NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblReOrderLevel]    Script Date: 07/13/2012 16:55:04 ******/
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
	[IM_isActive] [bit] NOT NULL,
 CONSTRAINT [PK_tblReOrderLevel] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblRoutes]    Script Date: 07/13/2012 16:55:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblRoutes](
	[RouteID] [uniqueidentifier] NOT NULL,
	[Name] [varchar](250) NOT NULL,
	[DistributorID] [uniqueidentifier] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_IsActive] [bit] NOT NULL,
	[Code] [varchar](50) NULL,
 CONSTRAINT [PK_tblRoutes] PRIMARY KEY CLUSTERED 
(
	[RouteID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblSalemanRoute]    Script Date: 07/13/2012 16:55:04 ******/
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
	[IM_IsActive] [bit] NOT NULL,
 CONSTRAINT [PK__tblSalem__3214EC0709202D14] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblArea]    Script Date: 07/13/2012 16:55:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblArea](
	[id] [uniqueidentifier] NOT NULL,
	[Name] [varchar](50) NULL,
	[Description] [varchar](50) NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_IsActive] [bit] NOT NULL,
	[Region] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_Area] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblRetireDocumentSetting]    Script Date: 07/13/2012 16:55:04 ******/
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
	[IM_IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblSettings]    Script Date: 07/13/2012 16:55:04 ******/
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
	[IM_IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_[tblSettings] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblUserGroup]    Script Date: 07/13/2012 16:55:04 ******/
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
	[IM_IsActive] [bit] NOT NULL,
 CONSTRAINT [PK__tblUserG__3214EC0712A9974E] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblUsers]    Script Date: 07/13/2012 16:55:04 ******/
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
	[IM_IsActive] [bit] NOT NULL,
	[IM_DateLastUpdated] [datetime] NULL,
	[GroupId] [uniqueidentifier] NULL,
	[TillNumber] [nvarchar](250) NULL,
 CONSTRAINT [PK_tblUsers] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblUserTypes]    Script Date: 07/13/2012 16:55:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblUserTypes](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [varchar](max) NOT NULL,
	[Description] [text] NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_tblUserTypes] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[test]    Script Date: 07/13/2012 16:55:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[test](
	[Id] [uniqueidentifier] NOT NULL,
	[DocumentTypeId] [int] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_IsActive] [bit] NOT NULL,
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
	[OrderOrderTypeId] [int] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblContactType]    Script Date: 07/13/2012 16:55:04 ******/
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
	[IM_IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_tblContactType] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblBank]    Script Date: 07/13/2012 16:55:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblBank](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [varchar](150) NULL,
	[Code] [varchar](50) NULL,
	[Description] [varchar](150) NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_tblBank] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblAuditLog]    Script Date: 07/13/2012 16:55:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
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
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblAssetType]    Script Date: 07/13/2012 16:55:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblAssetType](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [varchar](50) NULL,
	[Code] [varchar](50) NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_tblAssetType] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblAssetStatus]    Script Date: 07/13/2012 16:55:04 ******/
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
	[IM_IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCompetitor]    Script Date: 07/13/2012 16:55:04 ******/
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
	[IM_IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_tblCompetitor] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblClientMasterDataTracker]    Script Date: 07/13/2012 16:55:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblClientMasterDataTracker](
	[CostCentreApplicationId] [uniqueidentifier] NOT NULL,
	[MasterDataId] [int] NOT NULL,
	[DateTimePushed] [datetime] NOT NULL,
	[DateTimePushConfirmed] [datetime] NULL,
	[IM_IsActive] [bit] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[Id] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK_tblClientMasterDataTracker] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCertainValueCertainProductDiscount]    Script Date: 07/13/2012 16:55:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblCertainValueCertainProductDiscount](
	[id] [uniqueidentifier] NOT NULL,
	[Value] [money] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_tblCertainValueCertainProductDiscount] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCertainValueCertainProductDiscountItem]    Script Date: 07/13/2012 16:55:04 ******/
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
	[IM_IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_tblCertainValueCertainProductDiscountItem] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblFiles]    Script Date: 07/13/2012 16:55:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblFiles](
	[Id] [uniqueidentifier] NOT NULL,
	[FileData] [varbinary](max) NOT NULL,
	[FileExtension] [varchar](20) NOT NULL,
	[FileType] [int] NOT NULL,
	[FileDescription] [varchar](200) NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblDocument]    Script Date: 07/13/2012 16:55:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblDocument](
	[Id] [uniqueidentifier] NOT NULL,
	[DocumentTypeId] [int] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_IsActive] [bit] NOT NULL,
	[DocumentReference] [varchar](200) NULL,
	[DocumentIssuerCostCentreId] [uniqueidentifier] NOT NULL,
	[DocumentIssuerUserId] [uniqueidentifier] NOT NULL,
	[DocumentDateIssued] [datetime] NULL,
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
 CONSTRAINT [PK_tblOrders] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblOutletVisitDay]    Script Date: 07/13/2012 16:55:04 ******/
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
	[IM_IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblChannelPackaging]    Script Date: 07/13/2012 16:55:04 ******/
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
	[IM_IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_tblChannelPackaging] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblOutletPriority]    Script Date: 07/13/2012 16:55:04 ******/
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
	[IM_IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblOutletAudit]    Script Date: 07/13/2012 16:55:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblOutletAudit](
	[Id] [uniqueidentifier] NOT NULL,
	[Question] [varchar](max) NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_tblOutletAudit] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblMarketAudit]    Script Date: 07/13/2012 16:55:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblMarketAudit](
	[Id] [uniqueidentifier] NOT NULL,
	[Question] [varchar](max) NULL,
	[StartDate] [datetime] NOT NULL,
	[EndDate] [datetime] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_tblMarketAudit] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblMaritalStatus]    Script Date: 07/13/2012 16:55:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblMaritalStatus](
	[id] [uniqueidentifier] NOT NULL,
	[Code] [nvarchar](250) NULL,
	[MaritalStatus] [nvarchar](250) NOT NULL,
	[Description] [nvarchar](350) NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_tblMaritalStatus] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblContact]    Script Date: 07/13/2012 16:55:04 ******/
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
	[MaritalStatus] [uniqueidentifier] NULL,
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
	[IM_IsActive] [bit] NOT NULL,
	[ContactClassification] [int] NULL,
 CONSTRAINT [PK_tblContact] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblLineItems]    Script Date: 07/13/2012 16:55:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblLineItems](
	[id] [uniqueidentifier] NOT NULL,
	[DocumentID] [uniqueidentifier] NULL,
	[ProductID] [uniqueidentifier] NULL,
	[Description] [nvarchar](150) NULL,
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
 CONSTRAINT [PK_tblLineItems] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblBankBranch]    Script Date: 07/13/2012 16:55:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblBankBranch](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [varchar](150) NULL,
	[Code] [varchar](50) NULL,
	[BankId] [uniqueidentifier] NOT NULL,
	[Description] [varchar](150) NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_tblBankBranch] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblAssetCategory]    Script Date: 07/13/2012 16:55:04 ******/
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
	[IM_IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[Name] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblProductDiscountGroup]    Script Date: 07/13/2012 16:55:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblProductDiscountGroup](
	[id] [uniqueidentifier] NOT NULL,
	[DiscountGroup] [uniqueidentifier] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_tblProductDiscountGroup] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblProductDiscountGroupItem]    Script Date: 07/13/2012 16:55:04 ******/
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
	[IM_IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_tblProductDiscountGroupItem] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblCompetitorProducts]    Script Date: 07/13/2012 16:55:04 ******/
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
	[IM_isActive] [bit] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
 CONSTRAINT [PK_tblCompetitorProducts] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblVATClassItem]    Script Date: 07/13/2012 16:55:04 ******/
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
	[IM_IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_tblVATClassItem] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblUserGroupRoles]    Script Date: 07/13/2012 16:55:04 ******/
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
	[IM_IsActive] [bit] NOT NULL,
 CONSTRAINT [PK__tblUserG__3214EC074905A7FF] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblSaleValueDiscount]    Script Date: 07/13/2012 16:55:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblSaleValueDiscount](
	[id] [uniqueidentifier] NOT NULL,
	[TierId] [uniqueidentifier] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_tblSaleValueDiscount] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblDiscounts]    Script Date: 07/13/2012 16:55:04 ******/
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
	[IM_IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_tblDiscounts] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblDiscountItem]    Script Date: 07/13/2012 16:55:04 ******/
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
	[IM_IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_tblDiscountItem] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblSaleValueDiscountItems]    Script Date: 07/13/2012 16:55:04 ******/
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
	[IM_IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_tblSaleValueDiscountItems] PRIMARY KEY CLUSTERED 
(
	[id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblProvince]    Script Date: 07/13/2012 16:55:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblProvince](
	[Id] [uniqueidentifier] NOT NULL,
	[Name] [varchar](50) NULL,
	[CountryId] [uniqueidentifier] NOT NULL,
	[Description] [varchar](150) NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_tblProvince] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblAsset]    Script Date: 07/13/2012 16:55:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
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
	[IM_IsActive] [bit] NOT NULL,
	[Name] [nvarchar](250) NULL,
	[AssetCategoryId] [uniqueidentifier] NULL,
	[AssetStatusId] [uniqueidentifier] NULL,
 CONSTRAINT [PK_tblAsset] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblDistrict]    Script Date: 07/13/2012 16:55:04 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblDistrict](
	[Id] [uniqueidentifier] NOT NULL,
	[ProvinceId] [uniqueidentifier] NOT NULL,
	[District] [varchar](250) NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_IsActive] [bit] NOT NULL,
 CONSTRAINT [PK_tblDistrict] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Default [DF__tblAssetC__IM_Da__205405E7]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblAssetCategory] ADD  DEFAULT (getdate()) FOR [IM_DateCreated]
GO
/****** Object:  Default [DF__tblAssetC__IM_Da__21482A20]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblAssetCategory] ADD  DEFAULT (getdate()) FOR [IM_DateLastUpdated]
GO
/****** Object:  Default [DF__tblAssetS__IM_Da__223C4E59]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblAssetStatus] ADD  DEFAULT (getdate()) FOR [IM_DateCreated]
GO
/****** Object:  Default [DF__tblAssetS__IM_Da__23307292]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblAssetStatus] ADD  DEFAULT (getdate()) FOR [IM_DateLastUpdated]
GO
/****** Object:  Default [DF__tblCostCe__IsApp__242496CB]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblCostCentre] ADD  DEFAULT ((0)) FOR [IsApproved]
GO
/****** Object:  Default [DF__tblFiles__IM_Dat__2518BB04]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblFiles] ADD  DEFAULT (getdate()) FOR [IM_DateCreated]
GO
/****** Object:  Default [DF__tblFiles__IM_Dat__260CDF3D]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblFiles] ADD  DEFAULT (getdate()) FOR [IM_DateLastUpdated]
GO
/****** Object:  Default [DF__tblInvent__Unava__27010376]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblInventory] ADD  DEFAULT ((0)) FOR [UnavailableBalance]
GO
/****** Object:  Default [DF__tblOutlet__IM_Da__27F527AF]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblOutletPriority] ADD  DEFAULT (getdate()) FOR [IM_DateCreated]
GO
/****** Object:  Default [DF__tblOutlet__IM_Da__28E94BE8]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblOutletPriority] ADD  DEFAULT (getdate()) FOR [IM_DateLastUpdated]
GO
/****** Object:  Default [DF__tblOutlet__IM_Da__29DD7021]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblOutletVisitDay] ADD  DEFAULT (getdate()) FOR [IM_DateCreated]
GO
/****** Object:  Default [DF__tblOutlet__IM_Da__2AD1945A]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblOutletVisitDay] ADD  DEFAULT (getdate()) FOR [IM_DateLastUpdated]
GO
/****** Object:  Default [DF__tblPaymen__Balan__2BC5B893]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblPaymentTracker] ADD  DEFAULT ((0)) FOR [Balance]
GO
/****** Object:  Default [DF__tblPaymen__Pendi__2CB9DCCC]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblPaymentTracker] ADD  DEFAULT ((0)) FOR [PendingConfirmBalance]
GO
/****** Object:  Default [DF__tblProduc__IM_Da__2E1BDC42]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblProduct] ADD  CONSTRAINT [DF__tblProduc__IM_Da__2E1BDC42]  DEFAULT (getdate()) FOR [IM_DateCreated]
GO
/****** Object:  Default [DF__tblProduc__IM_Da__2F10007B]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblProduct] ADD  CONSTRAINT [DF__tblProduc__IM_Da__2F10007B]  DEFAULT (getdate()) FOR [IM_DateLastUpdated]
GO
/****** Object:  Default [DF__tblProduc__IM_Is__300424B4]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblProduct] ADD  CONSTRAINT [DF__tblProduc__IM_Is__300424B4]  DEFAULT ((1)) FOR [IM_IsActive]
GO
/****** Object:  Default [DF_tblProduct_Capacity]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblProduct] ADD  CONSTRAINT [DF_tblProduct_Capacity]  DEFAULT ((0)) FOR [Capacity]
GO
/****** Object:  Default [DF__tblProduc__ExFac__317E91E9]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblProduct] ADD  DEFAULT ((0)) FOR [ExFactoryPrice]
GO
/****** Object:  Default [DF__tblProduc__IM_Da__2AF18FEB]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblProductBrand] ADD  CONSTRAINT [DF__tblProduc__IM_Da__2AF18FEB]  DEFAULT (getdate()) FOR [IM_DateCreated]
GO
/****** Object:  Default [DF__tblProduc__IM_Da__2BE5B424]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblProductBrand] ADD  CONSTRAINT [DF__tblProduc__IM_Da__2BE5B424]  DEFAULT (getdate()) FOR [IM_DateLastUpdated]
GO
/****** Object:  Default [DF__tblProduc__IM_Is__2CD9D85D]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblProductBrand] ADD  CONSTRAINT [DF__tblProduc__IM_Is__2CD9D85D]  DEFAULT ((1)) FOR [IM_IsActive]
GO
/****** Object:  Default [DF__tblProduc__IM_Da__33D4B598]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblProductFlavour] ADD  CONSTRAINT [DF__tblProduc__IM_Da__33D4B598]  DEFAULT (getdate()) FOR [IM_DateCreated]
GO
/****** Object:  Default [DF__tblProduc__IM_Da__34C8D9D1]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblProductFlavour] ADD  CONSTRAINT [DF__tblProduc__IM_Da__34C8D9D1]  DEFAULT (getdate()) FOR [IM_DateLastUpdated]
GO
/****** Object:  Default [DF__tblProduc__IM_Is__35BCFE0A]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblProductFlavour] ADD  CONSTRAINT [DF__tblProduc__IM_Is__35BCFE0A]  DEFAULT ((1)) FOR [IM_IsActive]
GO
/****** Object:  Default [DF__tblProduc__IM_Da__7B5B524B]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblProductPackaging] ADD  CONSTRAINT [DF__tblProduc__IM_Da__7B5B524B]  DEFAULT (getdate()) FOR [IM_DateCreated]
GO
/****** Object:  Default [DF__tblProduc__IM_Da__7C4F7684]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblProductPackaging] ADD  CONSTRAINT [DF__tblProduc__IM_Da__7C4F7684]  DEFAULT (getdate()) FOR [IM_DateLastUpdated]
GO
/****** Object:  Default [DF__tblProduc__IM_Is__7D439ABD]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblProductPackaging] ADD  CONSTRAINT [DF__tblProduc__IM_Is__7D439ABD]  DEFAULT ((1)) FOR [IM_IsActive]
GO
/****** Object:  Default [DF__tblProduc__IM_Da__7E37BEF6]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblProductPackagingType] ADD  CONSTRAINT [DF__tblProduc__IM_Da__7E37BEF6]  DEFAULT (getdate()) FOR [IM_DateCreated]
GO
/****** Object:  Default [DF__tblProduc__IM_Da__7F2BE32F]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblProductPackagingType] ADD  CONSTRAINT [DF__tblProduc__IM_Da__7F2BE32F]  DEFAULT (getdate()) FOR [IM_DateLastUpdated]
GO
/****** Object:  Default [DF__tblProduc__IM_Is__00200768]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblProductPackagingType] ADD  CONSTRAINT [DF__tblProduc__IM_Is__00200768]  DEFAULT ((1)) FOR [IM_IsActive]
GO
/****** Object:  Default [DF__tblProduc__IM_Da__3C69FB99]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblProductType] ADD  CONSTRAINT [DF__tblProduc__IM_Da__3C69FB99]  DEFAULT (getdate()) FOR [IM_DateCreated]
GO
/****** Object:  Default [DF__tblProduc__IM_Da__3D5E1FD2]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblProductType] ADD  CONSTRAINT [DF__tblProduc__IM_Da__3D5E1FD2]  DEFAULT (getdate()) FOR [IM_DateLastUpdated]
GO
/****** Object:  Default [DF__tblProduc__IM_Is__3E52440B]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblProductType] ADD  CONSTRAINT [DF__tblProduc__IM_Is__3E52440B]  DEFAULT ((1)) FOR [IM_IsActive]
GO
/****** Object:  Default [DF__tblRegion__IM_Da__3F466844]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblRegion] ADD  CONSTRAINT [DF__tblRegion__IM_Da__3F466844]  DEFAULT (getdate()) FOR [IM_DateCreated]
GO
/****** Object:  Default [DF__tblRegion__IM_Da__403A8C7D]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblRegion] ADD  CONSTRAINT [DF__tblRegion__IM_Da__403A8C7D]  DEFAULT (getdate()) FOR [IM_DateLastUpdated]
GO
/****** Object:  Default [DF__tblRegion__IM_Is__412EB0B6]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblRegion] ADD  CONSTRAINT [DF__tblRegion__IM_Is__412EB0B6]  DEFAULT ((1)) FOR [IM_IsActive]
GO
/****** Object:  Default [DF__tblRoutes__IM_Da__4222D4EF]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblRoutes] ADD  CONSTRAINT [DF__tblRoutes__IM_Da__4222D4EF]  DEFAULT (getdate()) FOR [IM_DateCreated]
GO
/****** Object:  Default [DF__tblRoutes__IM_Da__4316F928]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblRoutes] ADD  CONSTRAINT [DF__tblRoutes__IM_Da__4316F928]  DEFAULT (getdate()) FOR [IM_DateLastUpdated]
GO
/****** Object:  Default [DF__tblRoutes__IM_Is__440B1D61]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblRoutes] ADD  CONSTRAINT [DF__tblRoutes__IM_Is__440B1D61]  DEFAULT ((1)) FOR [IM_IsActive]
GO
/****** Object:  Default [DF__tblTarget__IM_Da__4679AECF]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblTargetItem] ADD  DEFAULT (getdate()) FOR [IM_DateCreated]
GO
/****** Object:  Default [DF__tblTarget__IM_Da__476DD308]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblTargetItem] ADD  DEFAULT (getdate()) FOR [IM_DateLastUpdated]
GO
/****** Object:  Default [DF__tblUserGr__CanAc__6E372CAE]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblUserGroupRoles] ADD  CONSTRAINT [DF__tblUserGr__CanAc__6E372CAE]  DEFAULT ((0)) FOR [CanAccess]
GO
/****** Object:  ForeignKey [FK_tblAccount_tblCostCentre]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblAccount]  WITH CHECK ADD  CONSTRAINT [FK_tblAccount_tblCostCentre] FOREIGN KEY([CostCenterId])
REFERENCES [dbo].[tblCostCentre] ([Id])
GO
ALTER TABLE [dbo].[tblAccount] CHECK CONSTRAINT [FK_tblAccount_tblCostCentre]
GO
/****** Object:  ForeignKey [FK_AccountTransaction_AccountTransaction]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblAccountTransaction]  WITH CHECK ADD  CONSTRAINT [FK_AccountTransaction_AccountTransaction] FOREIGN KEY([AccountId])
REFERENCES [dbo].[tblAccount] ([id])
GO
ALTER TABLE [dbo].[tblAccountTransaction] CHECK CONSTRAINT [FK_AccountTransaction_AccountTransaction]
GO
/****** Object:  ForeignKey [FK__tblAsset__AssetC__4B3E63EC]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblAsset]  WITH CHECK ADD FOREIGN KEY([AssetCategoryId])
REFERENCES [dbo].[tblAssetCategory] ([Id])
GO
/****** Object:  ForeignKey [FK__tblAsset__AssetC__4C328825]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblAsset]  WITH CHECK ADD FOREIGN KEY([AssetCategoryId])
REFERENCES [dbo].[tblAssetCategory] ([Id])
GO
/****** Object:  ForeignKey [FK__tblAsset__AssetS__4D26AC5E]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblAsset]  WITH CHECK ADD FOREIGN KEY([AssetStatusId])
REFERENCES [dbo].[tblAssetStatus] ([Id])
GO
/****** Object:  ForeignKey [FK__tblAsset__AssetS__4E1AD097]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblAsset]  WITH CHECK ADD FOREIGN KEY([AssetStatusId])
REFERENCES [dbo].[tblAssetStatus] ([Id])
GO
/****** Object:  ForeignKey [FK__tblAsset__AssetT__4F0EF4D0]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblAsset]  WITH CHECK ADD FOREIGN KEY([AssetTypeId])
REFERENCES [dbo].[tblAssetType] ([Id])
GO
/****** Object:  ForeignKey [FK__tblAsset__AssetT__50031909]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblAsset]  WITH CHECK ADD FOREIGN KEY([AssetTypeId])
REFERENCES [dbo].[tblAssetType] ([Id])
GO
/****** Object:  ForeignKey [FK_tblAsset_tblAssetType]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblAsset]  WITH CHECK ADD  CONSTRAINT [FK_tblAsset_tblAssetType] FOREIGN KEY([AssetTypeId])
REFERENCES [dbo].[tblAssetType] ([Id])
GO
ALTER TABLE [dbo].[tblAsset] CHECK CONSTRAINT [FK_tblAsset_tblAssetType]
GO
/****** Object:  ForeignKey [FK__tblAssetC__Asset__51EB617B]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblAssetCategory]  WITH CHECK ADD FOREIGN KEY([AssetTypeId])
REFERENCES [dbo].[tblAssetType] ([Id])
GO
/****** Object:  ForeignKey [FK__tblAssetC__Asset__52DF85B4]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblAssetCategory]  WITH CHECK ADD FOREIGN KEY([AssetTypeId])
REFERENCES [dbo].[tblAssetType] ([Id])
GO
/****** Object:  ForeignKey [FK_tblBankBranch_tblBank]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblBankBranch]  WITH CHECK ADD  CONSTRAINT [FK_tblBankBranch_tblBank] FOREIGN KEY([BankId])
REFERENCES [dbo].[tblBank] ([Id])
GO
ALTER TABLE [dbo].[tblBankBranch] CHECK CONSTRAINT [FK_tblBankBranch_tblBank]
GO
/****** Object:  ForeignKey [FK_tblCertainValueCertainProductDiscountItem_tblCertainValueCertainProductDiscount]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblCertainValueCertainProductDiscountItem]  WITH CHECK ADD  CONSTRAINT [FK_tblCertainValueCertainProductDiscountItem_tblCertainValueCertainProductDiscount] FOREIGN KEY([CertainValueCertainDiscountID])
REFERENCES [dbo].[tblCertainValueCertainProductDiscount] ([id])
GO
ALTER TABLE [dbo].[tblCertainValueCertainProductDiscountItem] CHECK CONSTRAINT [FK_tblCertainValueCertainProductDiscountItem_tblCertainValueCertainProductDiscount]
GO
/****** Object:  ForeignKey [FK_tblCertainValueCertainProductDiscountItem_tblProduct]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblCertainValueCertainProductDiscountItem]  WITH CHECK ADD  CONSTRAINT [FK_tblCertainValueCertainProductDiscountItem_tblProduct] FOREIGN KEY([Product])
REFERENCES [dbo].[tblProduct] ([id])
GO
ALTER TABLE [dbo].[tblCertainValueCertainProductDiscountItem] CHECK CONSTRAINT [FK_tblCertainValueCertainProductDiscountItem_tblProduct]
GO
/****** Object:  ForeignKey [FK_tblChannelPackaging_tblOutletType]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblChannelPackaging]  WITH CHECK ADD  CONSTRAINT [FK_tblChannelPackaging_tblOutletType] FOREIGN KEY([OutletTypeId])
REFERENCES [dbo].[tblOutletType] ([id])
GO
ALTER TABLE [dbo].[tblChannelPackaging] CHECK CONSTRAINT [FK_tblChannelPackaging_tblOutletType]
GO
/****** Object:  ForeignKey [FK_tblChannelPackaging_tblProductPackaging]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblChannelPackaging]  WITH CHECK ADD  CONSTRAINT [FK_tblChannelPackaging_tblProductPackaging] FOREIGN KEY([PackagingId])
REFERENCES [dbo].[tblProductPackaging] ([Id])
GO
ALTER TABLE [dbo].[tblChannelPackaging] CHECK CONSTRAINT [FK_tblChannelPackaging_tblProductPackaging]
GO
/****** Object:  ForeignKey [FK_tblCompetitorProducts_tblCompetitor]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblCompetitorProducts]  WITH CHECK ADD  CONSTRAINT [FK_tblCompetitorProducts_tblCompetitor] FOREIGN KEY([CompetitorId])
REFERENCES [dbo].[tblCompetitor] ([id])
GO
ALTER TABLE [dbo].[tblCompetitorProducts] CHECK CONSTRAINT [FK_tblCompetitorProducts_tblCompetitor]
GO
/****** Object:  ForeignKey [FK_tblCompetitorProducts_tblProductBrand]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblCompetitorProducts]  WITH CHECK ADD  CONSTRAINT [FK_tblCompetitorProducts_tblProductBrand] FOREIGN KEY([BrandId])
REFERENCES [dbo].[tblProductBrand] ([id])
GO
ALTER TABLE [dbo].[tblCompetitorProducts] CHECK CONSTRAINT [FK_tblCompetitorProducts_tblProductBrand]
GO
/****** Object:  ForeignKey [FK_tblCompetitorProducts_tblProductFlavour]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblCompetitorProducts]  WITH CHECK ADD  CONSTRAINT [FK_tblCompetitorProducts_tblProductFlavour] FOREIGN KEY([FlavourId])
REFERENCES [dbo].[tblProductFlavour] ([id])
GO
ALTER TABLE [dbo].[tblCompetitorProducts] CHECK CONSTRAINT [FK_tblCompetitorProducts_tblProductFlavour]
GO
/****** Object:  ForeignKey [FK_tblCompetitorProducts_tblProductPackaging]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblCompetitorProducts]  WITH CHECK ADD  CONSTRAINT [FK_tblCompetitorProducts_tblProductPackaging] FOREIGN KEY([PackagingId])
REFERENCES [dbo].[tblProductPackaging] ([Id])
GO
ALTER TABLE [dbo].[tblCompetitorProducts] CHECK CONSTRAINT [FK_tblCompetitorProducts_tblProductPackaging]
GO
/****** Object:  ForeignKey [FK_tblCompetitorProducts_tblProductPackagingType]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblCompetitorProducts]  WITH CHECK ADD  CONSTRAINT [FK_tblCompetitorProducts_tblProductPackagingType] FOREIGN KEY([PackagingTypeId])
REFERENCES [dbo].[tblProductPackagingType] ([id])
GO
ALTER TABLE [dbo].[tblCompetitorProducts] CHECK CONSTRAINT [FK_tblCompetitorProducts_tblProductPackagingType]
GO
/****** Object:  ForeignKey [FK_tblCompetitorProducts_tblProductType]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblCompetitorProducts]  WITH CHECK ADD  CONSTRAINT [FK_tblCompetitorProducts_tblProductType] FOREIGN KEY([ProductTypeId])
REFERENCES [dbo].[tblProductType] ([id])
GO
ALTER TABLE [dbo].[tblCompetitorProducts] CHECK CONSTRAINT [FK_tblCompetitorProducts_tblProductType]
GO
/****** Object:  ForeignKey [FK_tblConsolidatedProductProducts_tblProduct]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblConsolidatedProductProducts]  WITH CHECK ADD  CONSTRAINT [FK_tblConsolidatedProductProducts_tblProduct] FOREIGN KEY([ConsolidatedProductId])
REFERENCES [dbo].[tblProduct] ([id])
GO
ALTER TABLE [dbo].[tblConsolidatedProductProducts] CHECK CONSTRAINT [FK_tblConsolidatedProductProducts_tblProduct]
GO
/****** Object:  ForeignKey [FK_tblConsolidatedProductProducts_tblProduct1]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblConsolidatedProductProducts]  WITH CHECK ADD  CONSTRAINT [FK_tblConsolidatedProductProducts_tblProduct1] FOREIGN KEY([ProductId])
REFERENCES [dbo].[tblProduct] ([id])
GO
ALTER TABLE [dbo].[tblConsolidatedProductProducts] CHECK CONSTRAINT [FK_tblConsolidatedProductProducts_tblProduct1]
GO
/****** Object:  ForeignKey [FK_tblContact_tblContactType]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblContact]  WITH CHECK ADD  CONSTRAINT [FK_tblContact_tblContactType] FOREIGN KEY([ContactType])
REFERENCES [dbo].[tblContactType] ([id])
GO
ALTER TABLE [dbo].[tblContact] CHECK CONSTRAINT [FK_tblContact_tblContactType]
GO
/****** Object:  ForeignKey [FK_tblContact_tblCostCentre]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblContact]  WITH CHECK ADD  CONSTRAINT [FK_tblContact_tblCostCentre] FOREIGN KEY([CostCenterId])
REFERENCES [dbo].[tblCostCentre] ([Id])
GO
ALTER TABLE [dbo].[tblContact] CHECK CONSTRAINT [FK_tblContact_tblCostCentre]
GO
/****** Object:  ForeignKey [FK_tblContact_tblMaritalStatus]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblContact]  WITH CHECK ADD  CONSTRAINT [FK_tblContact_tblMaritalStatus] FOREIGN KEY([MaritalStatus])
REFERENCES [dbo].[tblMaritalStatus] ([id])
GO
ALTER TABLE [dbo].[tblContact] CHECK CONSTRAINT [FK_tblContact_tblMaritalStatus]
GO
/****** Object:  ForeignKey [FK_tblContainment_tblProduct]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblContainment]  WITH CHECK ADD  CONSTRAINT [FK_tblContainment_tblProduct] FOREIGN KEY([ReturnableProduct])
REFERENCES [dbo].[tblProduct] ([id])
GO
ALTER TABLE [dbo].[tblContainment] CHECK CONSTRAINT [FK_tblContainment_tblProduct]
GO
/****** Object:  ForeignKey [FK_tblContainment_tblProductPackagingType]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblContainment]  WITH CHECK ADD  CONSTRAINT [FK_tblContainment_tblProductPackagingType] FOREIGN KEY([ProductPackagingType])
REFERENCES [dbo].[tblProductPackagingType] ([id])
GO
ALTER TABLE [dbo].[tblContainment] CHECK CONSTRAINT [FK_tblContainment_tblProductPackagingType]
GO
/****** Object:  ForeignKey [FK_tblCostCentre_tblCostCentre]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblCostCentre]  WITH NOCHECK ADD  CONSTRAINT [FK_tblCostCentre_tblCostCentre] FOREIGN KEY([Id])
REFERENCES [dbo].[tblCostCentre] ([Id])
GO
ALTER TABLE [dbo].[tblCostCentre] CHECK CONSTRAINT [FK_tblCostCentre_tblCostCentre]
GO
/****** Object:  ForeignKey [FK_tblCostCentre_tblDiscountGroup]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblCostCentre]  WITH NOCHECK ADD  CONSTRAINT [FK_tblCostCentre_tblDiscountGroup] FOREIGN KEY([Outlet_DiscountGroupId])
REFERENCES [dbo].[tblDiscountGroup] ([id])
GO
ALTER TABLE [dbo].[tblCostCentre] CHECK CONSTRAINT [FK_tblCostCentre_tblDiscountGroup]
GO
/****** Object:  ForeignKey [FK_tblCostCentre_tblOutletCategory]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblCostCentre]  WITH NOCHECK ADD  CONSTRAINT [FK_tblCostCentre_tblOutletCategory] FOREIGN KEY([Outlet_Category_Id])
REFERENCES [dbo].[tblOutletCategory] ([id])
GO
ALTER TABLE [dbo].[tblCostCentre] CHECK CONSTRAINT [FK_tblCostCentre_tblOutletCategory]
GO
/****** Object:  ForeignKey [FK_tblCostCentre_tblOutletType]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblCostCentre]  WITH NOCHECK ADD  CONSTRAINT [FK_tblCostCentre_tblOutletType] FOREIGN KEY([Outlet_Type_Id])
REFERENCES [dbo].[tblOutletType] ([id])
GO
ALTER TABLE [dbo].[tblCostCentre] CHECK CONSTRAINT [FK_tblCostCentre_tblOutletType]
GO
/****** Object:  ForeignKey [FK_tblCostCentre_tblRegion]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblCostCentre]  WITH NOCHECK ADD  CONSTRAINT [FK_tblCostCentre_tblRegion] FOREIGN KEY([Distributor_RegionId])
REFERENCES [dbo].[tblRegion] ([id])
GO
ALTER TABLE [dbo].[tblCostCentre] CHECK CONSTRAINT [FK_tblCostCentre_tblRegion]
GO
/****** Object:  ForeignKey [FK_tblCostCentre_tblRoutes]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblCostCentre]  WITH NOCHECK ADD  CONSTRAINT [FK_tblCostCentre_tblRoutes] FOREIGN KEY([RouteId])
REFERENCES [dbo].[tblRoutes] ([RouteID])
GO
ALTER TABLE [dbo].[tblCostCentre] CHECK CONSTRAINT [FK_tblCostCentre_tblRoutes]
GO
/****** Object:  ForeignKey [FK_tblCostCentre_tblSocioEconomicStatus]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblCostCentre]  WITH NOCHECK ADD  CONSTRAINT [FK_tblCostCentre_tblSocioEconomicStatus] FOREIGN KEY([SocioEconomicStatus_id])
REFERENCES [dbo].[tblSocioEconomicStatus] ([id])
GO
ALTER TABLE [dbo].[tblCostCentre] CHECK CONSTRAINT [FK_tblCostCentre_tblSocioEconomicStatus]
GO
/****** Object:  ForeignKey [FK_tblCostCentre_tblVATClass]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblCostCentre]  WITH NOCHECK ADD  CONSTRAINT [FK_tblCostCentre_tblVATClass] FOREIGN KEY([VATClass_Id])
REFERENCES [dbo].[tblVATClass] ([id])
GO
ALTER TABLE [dbo].[tblCostCentre] CHECK CONSTRAINT [FK_tblCostCentre_tblVATClass]
GO
/****** Object:  ForeignKey [FK_tblCostCentreApplication_tblCostCentre]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblCostCentreApplication]  WITH CHECK ADD  CONSTRAINT [FK_tblCostCentreApplication_tblCostCentre] FOREIGN KEY([costcentreid])
REFERENCES [dbo].[tblCostCentre] ([Id])
GO
ALTER TABLE [dbo].[tblCostCentreApplication] CHECK CONSTRAINT [FK_tblCostCentreApplication_tblCostCentre]
GO
/****** Object:  ForeignKey [FK_tblCountry_tblTerritory]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblCountry]  WITH CHECK ADD  CONSTRAINT [FK_tblCountry_tblTerritory] FOREIGN KEY([Territory_ID])
REFERENCES [dbo].[tblTerritory] ([id])
GO
ALTER TABLE [dbo].[tblCountry] CHECK CONSTRAINT [FK_tblCountry_tblTerritory]
GO
/****** Object:  ForeignKey [FK_tblCustomerDiscount_tblCostCentre]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblCustomerDiscount]  WITH CHECK ADD  CONSTRAINT [FK_tblCustomerDiscount_tblCostCentre] FOREIGN KEY([Outlet])
REFERENCES [dbo].[tblCostCentre] ([Id])
GO
ALTER TABLE [dbo].[tblCustomerDiscount] CHECK CONSTRAINT [FK_tblCustomerDiscount_tblCostCentre]
GO
/****** Object:  ForeignKey [FK_tblCustomerDiscount_tblProduct]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblCustomerDiscount]  WITH CHECK ADD  CONSTRAINT [FK_tblCustomerDiscount_tblProduct] FOREIGN KEY([ProductRef])
REFERENCES [dbo].[tblProduct] ([id])
GO
ALTER TABLE [dbo].[tblCustomerDiscount] CHECK CONSTRAINT [FK_tblCustomerDiscount_tblProduct]
GO
/****** Object:  ForeignKey [FK_tblCustomerDiscountItem_tblCustomerDiscount]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblCustomerDiscountItem]  WITH CHECK ADD  CONSTRAINT [FK_tblCustomerDiscountItem_tblCustomerDiscount] FOREIGN KEY([CustomerDiscountId])
REFERENCES [dbo].[tblCustomerDiscount] ([id])
GO
ALTER TABLE [dbo].[tblCustomerDiscountItem] CHECK CONSTRAINT [FK_tblCustomerDiscountItem_tblCustomerDiscount]
GO
/****** Object:  ForeignKey [FK_tblDiscountItem_tblDiscounts]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblDiscountItem]  WITH CHECK ADD  CONSTRAINT [FK_tblDiscountItem_tblDiscounts] FOREIGN KEY([DiscountId])
REFERENCES [dbo].[tblDiscounts] ([id])
GO
ALTER TABLE [dbo].[tblDiscountItem] CHECK CONSTRAINT [FK_tblDiscountItem_tblDiscounts]
GO
/****** Object:  ForeignKey [FK_tblDiscounts_tblPricingTier]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblDiscounts]  WITH CHECK ADD  CONSTRAINT [FK_tblDiscounts_tblPricingTier] FOREIGN KEY([TierId])
REFERENCES [dbo].[tblPricingTier] ([id])
GO
ALTER TABLE [dbo].[tblDiscounts] CHECK CONSTRAINT [FK_tblDiscounts_tblPricingTier]
GO
/****** Object:  ForeignKey [FK_tblDistrict_tblProvince]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblDistrict]  WITH CHECK ADD  CONSTRAINT [FK_tblDistrict_tblProvince] FOREIGN KEY([ProvinceId])
REFERENCES [dbo].[tblProvince] ([Id])
GO
ALTER TABLE [dbo].[tblDistrict] CHECK CONSTRAINT [FK_tblDistrict_tblProvince]
GO
/****** Object:  ForeignKey [FK_tblFreeOfChargeDiscount_tblProduct]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblFreeOfChargeDiscount]  WITH CHECK ADD  CONSTRAINT [FK_tblFreeOfChargeDiscount_tblProduct] FOREIGN KEY([ProductRef])
REFERENCES [dbo].[tblProduct] ([id])
GO
ALTER TABLE [dbo].[tblFreeOfChargeDiscount] CHECK CONSTRAINT [FK_tblFreeOfChargeDiscount_tblProduct]
GO
/****** Object:  ForeignKey [fk_costcentre_pid]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblInventory]  WITH CHECK ADD  CONSTRAINT [fk_costcentre_pid] FOREIGN KEY([WareHouseId])
REFERENCES [dbo].[tblCostCentre] ([Id])
GO
ALTER TABLE [dbo].[tblInventory] CHECK CONSTRAINT [fk_costcentre_pid]
GO
/****** Object:  ForeignKey [FK_tblInventory_tblProduct]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblInventory]  WITH CHECK ADD  CONSTRAINT [FK_tblInventory_tblProduct] FOREIGN KEY([ProductId])
REFERENCES [dbo].[tblProduct] ([id])
GO
ALTER TABLE [dbo].[tblInventory] CHECK CONSTRAINT [FK_tblInventory_tblProduct]
GO
/****** Object:  ForeignKey [FK_tblInventoryTransaction_tblInventory]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblInventoryTransaction]  WITH CHECK ADD  CONSTRAINT [FK_tblInventoryTransaction_tblInventory] FOREIGN KEY([InventoryId])
REFERENCES [dbo].[tblInventory] ([id])
GO
ALTER TABLE [dbo].[tblInventoryTransaction] CHECK CONSTRAINT [FK_tblInventoryTransaction_tblInventory]
GO
/****** Object:  ForeignKey [FK_tblLineItems_tblDocument]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblLineItems]  WITH CHECK ADD  CONSTRAINT [FK_tblLineItems_tblDocument] FOREIGN KEY([DocumentID])
REFERENCES [dbo].[tblDocument] ([Id])
GO
ALTER TABLE [dbo].[tblLineItems] CHECK CONSTRAINT [FK_tblLineItems_tblDocument]
GO
/****** Object:  ForeignKey [FK_tblPaymentTracker_tblCostCentre]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblPaymentTracker]  WITH CHECK ADD  CONSTRAINT [FK_tblPaymentTracker_tblCostCentre] FOREIGN KEY([CostCenterId])
REFERENCES [dbo].[tblCostCentre] ([Id])
GO
ALTER TABLE [dbo].[tblPaymentTracker] CHECK CONSTRAINT [FK_tblPaymentTracker_tblCostCentre]
GO
/****** Object:  ForeignKey [FK_tblPricing_tblPricingTier]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblPricing]  WITH CHECK ADD  CONSTRAINT [FK_tblPricing_tblPricingTier] FOREIGN KEY([Tier])
REFERENCES [dbo].[tblPricingTier] ([id])
GO
ALTER TABLE [dbo].[tblPricing] CHECK CONSTRAINT [FK_tblPricing_tblPricingTier]
GO
/****** Object:  ForeignKey [FK_tblPricing_tblProduct]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblPricing]  WITH CHECK ADD  CONSTRAINT [FK_tblPricing_tblProduct] FOREIGN KEY([ProductRef])
REFERENCES [dbo].[tblProduct] ([id])
GO
ALTER TABLE [dbo].[tblPricing] CHECK CONSTRAINT [FK_tblPricing_tblProduct]
GO
/****** Object:  ForeignKey [FK__tblPricin__Prici__19218AB3]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblPricingItem]  WITH CHECK ADD  CONSTRAINT [FK__tblPricin__Prici__19218AB3] FOREIGN KEY([PricingId])
REFERENCES [dbo].[tblPricing] ([id])
GO
ALTER TABLE [dbo].[tblPricingItem] CHECK CONSTRAINT [FK__tblPricin__Prici__19218AB3]
GO
/****** Object:  ForeignKey [FK__tblPricin__Prici__1A15AEEC]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblPricingItem]  WITH CHECK ADD  CONSTRAINT [FK__tblPricin__Prici__1A15AEEC] FOREIGN KEY([PricingId])
REFERENCES [dbo].[tblPricing] ([id])
GO
ALTER TABLE [dbo].[tblPricingItem] CHECK CONSTRAINT [FK__tblPricin__Prici__1A15AEEC]
GO
/****** Object:  ForeignKey [FK_Product_ProductBrand]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblProduct]  WITH NOCHECK ADD  CONSTRAINT [FK_Product_ProductBrand] FOREIGN KEY([BrandId])
REFERENCES [dbo].[tblProductBrand] ([id])
GO
ALTER TABLE [dbo].[tblProduct] CHECK CONSTRAINT [FK_Product_ProductBrand]
GO
/****** Object:  ForeignKey [FK_Product_ProductFlavour]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblProduct]  WITH NOCHECK ADD  CONSTRAINT [FK_Product_ProductFlavour] FOREIGN KEY([FlavourId])
REFERENCES [dbo].[tblProductFlavour] ([id])
GO
ALTER TABLE [dbo].[tblProduct] CHECK CONSTRAINT [FK_Product_ProductFlavour]
GO
/****** Object:  ForeignKey [FK_Product_ProductPackaging]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblProduct]  WITH NOCHECK ADD  CONSTRAINT [FK_Product_ProductPackaging] FOREIGN KEY([PackagingId])
REFERENCES [dbo].[tblProductPackaging] ([Id])
GO
ALTER TABLE [dbo].[tblProduct] CHECK CONSTRAINT [FK_Product_ProductPackaging]
GO
/****** Object:  ForeignKey [FK_Product_ProductPackagingType]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblProduct]  WITH NOCHECK ADD  CONSTRAINT [FK_Product_ProductPackagingType] FOREIGN KEY([PackagingTypeId])
REFERENCES [dbo].[tblProductPackagingType] ([id])
GO
ALTER TABLE [dbo].[tblProduct] CHECK CONSTRAINT [FK_Product_ProductPackagingType]
GO
/****** Object:  ForeignKey [FK_Product_ProductType]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblProduct]  WITH NOCHECK ADD  CONSTRAINT [FK_Product_ProductType] FOREIGN KEY([ProductTypeId])
REFERENCES [dbo].[tblProductType] ([id])
GO
ALTER TABLE [dbo].[tblProduct] CHECK CONSTRAINT [FK_Product_ProductType]
GO
/****** Object:  ForeignKey [FK_tblProductBrand_tblSupplier]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblProductBrand]  WITH CHECK ADD  CONSTRAINT [FK_tblProductBrand_tblSupplier] FOREIGN KEY([SupplierId])
REFERENCES [dbo].[tblSupplier] ([id])
GO
ALTER TABLE [dbo].[tblProductBrand] CHECK CONSTRAINT [FK_tblProductBrand_tblSupplier]
GO
/****** Object:  ForeignKey [FK_tblProductDiscountGroup_tblDiscountGroup]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblProductDiscountGroup]  WITH CHECK ADD  CONSTRAINT [FK_tblProductDiscountGroup_tblDiscountGroup] FOREIGN KEY([DiscountGroup])
REFERENCES [dbo].[tblDiscountGroup] ([id])
GO
ALTER TABLE [dbo].[tblProductDiscountGroup] CHECK CONSTRAINT [FK_tblProductDiscountGroup_tblDiscountGroup]
GO
/****** Object:  ForeignKey [FK_tblProductDiscountGroupItem_tblProduct]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblProductDiscountGroupItem]  WITH CHECK ADD  CONSTRAINT [FK_tblProductDiscountGroupItem_tblProduct] FOREIGN KEY([ProductRef])
REFERENCES [dbo].[tblProduct] ([id])
GO
ALTER TABLE [dbo].[tblProductDiscountGroupItem] CHECK CONSTRAINT [FK_tblProductDiscountGroupItem_tblProduct]
GO
/****** Object:  ForeignKey [FK_tblProductDiscountGroupItem_tblProductDiscountGroup]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblProductDiscountGroupItem]  WITH CHECK ADD  CONSTRAINT [FK_tblProductDiscountGroupItem_tblProductDiscountGroup] FOREIGN KEY([ProductDiscountGroup])
REFERENCES [dbo].[tblProductDiscountGroup] ([id])
GO
ALTER TABLE [dbo].[tblProductDiscountGroupItem] CHECK CONSTRAINT [FK_tblProductDiscountGroupItem_tblProductDiscountGroup]
GO
/****** Object:  ForeignKey [FK_tblProductPackaging_tblContainment]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblProductPackaging]  WITH NOCHECK ADD  CONSTRAINT [FK_tblProductPackaging_tblContainment] FOREIGN KEY([Containment])
REFERENCES [dbo].[tblContainment] ([id])
GO
ALTER TABLE [dbo].[tblProductPackaging] CHECK CONSTRAINT [FK_tblProductPackaging_tblContainment]
GO
/****** Object:  ForeignKey [FK_tblProductPackaging_tblProduct]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblProductPackaging]  WITH NOCHECK ADD  CONSTRAINT [FK_tblProductPackaging_tblProduct] FOREIGN KEY([ReturnableProduct])
REFERENCES [dbo].[tblProduct] ([id])
GO
ALTER TABLE [dbo].[tblProductPackaging] CHECK CONSTRAINT [FK_tblProductPackaging_tblProduct]
GO
/****** Object:  ForeignKey [FK_tblPromotionDiscount_tblProduct]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblPromotionDiscount]  WITH CHECK ADD  CONSTRAINT [FK_tblPromotionDiscount_tblProduct] FOREIGN KEY([ProductRef])
REFERENCES [dbo].[tblProduct] ([id])
GO
ALTER TABLE [dbo].[tblPromotionDiscount] CHECK CONSTRAINT [FK_tblPromotionDiscount_tblProduct]
GO
/****** Object:  ForeignKey [FK_tblPromotionDiscountItem_tblPromotionDiscount]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblPromotionDiscountItem]  WITH CHECK ADD  CONSTRAINT [FK_tblPromotionDiscountItem_tblPromotionDiscount] FOREIGN KEY([PromotionDiscountId])
REFERENCES [dbo].[tblPromotionDiscount] ([id])
GO
ALTER TABLE [dbo].[tblPromotionDiscountItem] CHECK CONSTRAINT [FK_tblPromotionDiscountItem_tblPromotionDiscount]
GO
/****** Object:  ForeignKey [FK_tblProvince_tblProvince]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblProvince]  WITH CHECK ADD  CONSTRAINT [FK_tblProvince_tblProvince] FOREIGN KEY([CountryId])
REFERENCES [dbo].[tblCountry] ([id])
GO
ALTER TABLE [dbo].[tblProvince] CHECK CONSTRAINT [FK_tblProvince_tblProvince]
GO
/****** Object:  ForeignKey [FK_tblRegion_tblCountry]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblRegion]  WITH CHECK ADD  CONSTRAINT [FK_tblRegion_tblCountry] FOREIGN KEY([Country])
REFERENCES [dbo].[tblCountry] ([id])
GO
ALTER TABLE [dbo].[tblRegion] CHECK CONSTRAINT [FK_tblRegion_tblCountry]
GO
/****** Object:  ForeignKey [FK_tblReOrderLevel_tblProduct]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblReOrderLevel]  WITH CHECK ADD  CONSTRAINT [FK_tblReOrderLevel_tblProduct] FOREIGN KEY([ProductId])
REFERENCES [dbo].[tblProduct] ([id])
GO
ALTER TABLE [dbo].[tblReOrderLevel] CHECK CONSTRAINT [FK_tblReOrderLevel_tblProduct]
GO
/****** Object:  ForeignKey [FK_tblReOrderLevel_tblReOrderLevel]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblReOrderLevel]  WITH CHECK ADD  CONSTRAINT [FK_tblReOrderLevel_tblReOrderLevel] FOREIGN KEY([DistributorId])
REFERENCES [dbo].[tblCostCentre] ([Id])
GO
ALTER TABLE [dbo].[tblReOrderLevel] CHECK CONSTRAINT [FK_tblReOrderLevel_tblReOrderLevel]
GO
/****** Object:  ForeignKey [FK_tblRoutes_tblCostCentre]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblRoutes]  WITH CHECK ADD  CONSTRAINT [FK_tblRoutes_tblCostCentre] FOREIGN KEY([DistributorID])
REFERENCES [dbo].[tblCostCentre] ([Id])
GO
ALTER TABLE [dbo].[tblRoutes] CHECK CONSTRAINT [FK_tblRoutes_tblCostCentre]
GO
/****** Object:  ForeignKey [FK__tblSalema__Route__2C345F27]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblSalemanRoute]  WITH CHECK ADD  CONSTRAINT [FK__tblSalema__Route__2C345F27] FOREIGN KEY([RouteId])
REFERENCES [dbo].[tblRoutes] ([RouteID])
GO
ALTER TABLE [dbo].[tblSalemanRoute] CHECK CONSTRAINT [FK__tblSalema__Route__2C345F27]
GO
/****** Object:  ForeignKey [FK__tblSalema__Route__2D288360]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblSalemanRoute]  WITH CHECK ADD  CONSTRAINT [FK__tblSalema__Route__2D288360] FOREIGN KEY([RouteId])
REFERENCES [dbo].[tblRoutes] ([RouteID])
GO
ALTER TABLE [dbo].[tblSalemanRoute] CHECK CONSTRAINT [FK__tblSalema__Route__2D288360]
GO
/****** Object:  ForeignKey [FK_tblSaleValueDiscount_tblSaleValueDiscount]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblSaleValueDiscount]  WITH CHECK ADD  CONSTRAINT [FK_tblSaleValueDiscount_tblSaleValueDiscount] FOREIGN KEY([TierId])
REFERENCES [dbo].[tblPricingTier] ([id])
GO
ALTER TABLE [dbo].[tblSaleValueDiscount] CHECK CONSTRAINT [FK_tblSaleValueDiscount_tblSaleValueDiscount]
GO
/****** Object:  ForeignKey [FK_tblSaleValueDiscountItems_tblSaleValueDiscount]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblSaleValueDiscountItems]  WITH CHECK ADD  CONSTRAINT [FK_tblSaleValueDiscountItems_tblSaleValueDiscount] FOREIGN KEY([SaleValueId])
REFERENCES [dbo].[tblSaleValueDiscount] ([id])
GO
ALTER TABLE [dbo].[tblSaleValueDiscountItems] CHECK CONSTRAINT [FK_tblSaleValueDiscountItems_tblSaleValueDiscount]
GO
/****** Object:  ForeignKey [FK_tblTarget_tblCostCentre]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblTarget]  WITH CHECK ADD  CONSTRAINT [FK_tblTarget_tblCostCentre] FOREIGN KEY([CostCentreId])
REFERENCES [dbo].[tblCostCentre] ([Id])
GO
ALTER TABLE [dbo].[tblTarget] CHECK CONSTRAINT [FK_tblTarget_tblCostCentre]
GO
/****** Object:  ForeignKey [FK_tblTarget_tblTargetPeriod]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblTarget]  WITH CHECK ADD  CONSTRAINT [FK_tblTarget_tblTargetPeriod] FOREIGN KEY([PeriodId])
REFERENCES [dbo].[tblTargetPeriod] ([Id])
GO
ALTER TABLE [dbo].[tblTarget] CHECK CONSTRAINT [FK_tblTarget_tblTargetPeriod]
GO
/****** Object:  ForeignKey [FK__tblTarget__Produ__14AD4911]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblTargetItem]  WITH CHECK ADD FOREIGN KEY([ProductId])
REFERENCES [dbo].[tblProduct] ([id])
GO
/****** Object:  ForeignKey [FK__tblTarget__Produ__15A16D4A]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblTargetItem]  WITH CHECK ADD FOREIGN KEY([ProductId])
REFERENCES [dbo].[tblProduct] ([id])
GO
/****** Object:  ForeignKey [FK__tblTarget__Targe__16959183]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblTargetItem]  WITH CHECK ADD FOREIGN KEY([TargetId])
REFERENCES [dbo].[tblTarget] ([id])
GO
/****** Object:  ForeignKey [FK__tblTarget__Targe__1789B5BC]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblTargetItem]  WITH CHECK ADD FOREIGN KEY([TargetId])
REFERENCES [dbo].[tblTarget] ([id])
GO
/****** Object:  ForeignKey [FK__tblUserGr__Group__31ED387D]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblUserGroupRoles]  WITH CHECK ADD  CONSTRAINT [FK__tblUserGr__Group__31ED387D] FOREIGN KEY([GroupId])
REFERENCES [dbo].[tblUserGroup] ([Id])
GO
ALTER TABLE [dbo].[tblUserGroupRoles] CHECK CONSTRAINT [FK__tblUserGr__Group__31ED387D]
GO
/****** Object:  ForeignKey [FK__tblUsers__GroupI__34C9A528]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblUsers]  WITH CHECK ADD  CONSTRAINT [FK__tblUsers__GroupI__34C9A528] FOREIGN KEY([GroupId])
REFERENCES [dbo].[tblUserGroup] ([Id])
GO
ALTER TABLE [dbo].[tblUsers] CHECK CONSTRAINT [FK__tblUsers__GroupI__34C9A528]
GO
/****** Object:  ForeignKey [FK_tblUsers_tblUsers]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblUsers]  WITH CHECK ADD  CONSTRAINT [FK_tblUsers_tblUsers] FOREIGN KEY([CostCenterId])
REFERENCES [dbo].[tblCostCentre] ([Id])
GO
ALTER TABLE [dbo].[tblUsers] CHECK CONSTRAINT [FK_tblUsers_tblUsers]
GO
/****** Object:  ForeignKey [FK_tblVATClassItem_tblVATClass]    Script Date: 07/13/2012 16:55:04 ******/
ALTER TABLE [dbo].[tblVATClassItem]  WITH CHECK ADD  CONSTRAINT [FK_tblVATClassItem_tblVATClass] FOREIGN KEY([VATClassID])
REFERENCES [dbo].[tblVATClass] ([id])
GO
ALTER TABLE [dbo].[tblVATClassItem] CHECK CONSTRAINT [FK_tblVATClassItem_tblVATClass]
GO
