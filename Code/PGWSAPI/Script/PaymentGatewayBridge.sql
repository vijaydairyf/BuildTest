
/****** Object:  Table [dbo].[tblRequestResponce]    Script Date: 07/29/2013 11:27:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblRequestResponce](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ReferenceId] [nvarchar](50) NOT NULL,
	[MessageId] [nvarchar](50) NULL,
	[StatusCode] [nvarchar](50) NULL,
	[StatusDetails] [nvarchar](500) NULL,
	[Vesion] [nvarchar](10) NULL,
	[DateCreated] [datetime] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[ReferenceId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblRequest]    Script Date: 07/29/2013 11:27:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblRequest](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[ReferenceId] [nvarchar](50) NULL,
	[Amount] [decimal](18, 0) NOT NULL,
	[MessageType] [int] NOT NULL,
	[Payee] [nvarchar](100) NULL,
	[Smsc_TillNumber] [nvarchar](50) NULL,
	[Smsc_PhoneNumber] [nvarchar](25) NULL,
	[DateCreated] [datetime] NOT NULL,
	[ApplicationId] [uniqueidentifier] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[ReferenceId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblPaymentResponse]    Script Date: 07/29/2013 11:27:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblPaymentResponse](
	[Id] [uniqueidentifier] NOT NULL,
	[DistributorCostCenterId] [uniqueidentifier] NOT NULL,
	[TransactionRefId] [nvarchar](50) NULL,
	[SDPTransactionRefId] [nvarchar](50) NULL,
	[SDPReferenceId] [nvarchar](50) NULL,
	[BusinessNumber] [nvarchar](50) NULL,
	[Amount] [float] NULL,
	[Currency] [nchar](10) NULL,
	[StatusCode] [nvarchar](50) NULL,
	[StatusDetail] [nvarchar](max) NULL,
	[ShortDescription] [nvarchar](max) NULL,
	[LongDescription] [nvarchar](max) NULL,
	[TimeStamp] [datetime2](7) NULL,
	[DateCreated] [datetime] NULL,
	[ClientRequestResponseTypeId] [int] NULL,
 CONSTRAINT [PK_tblPaymentResponse] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblPaymentRequest]    Script Date: 07/29/2013 11:27:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblPaymentRequest](
	[Id] [uniqueidentifier] NOT NULL,
	[DistributorCostCenterId] [uniqueidentifier] NOT NULL,
	[TransactionRefId] [nvarchar](50) NOT NULL,
	[SDPTransactionRefId] [nvarchar](50) NULL,
	[SDPReferenceId] [nvarchar](50) NULL,
	[SubscriberName] [nvarchar](250) NULL,
	[ReceiptNumber] [nvarchar](100) NULL,
	[ClientRequestResponseTypeId] [int] NULL,
	[ApplicationId] [nvarchar](50) NULL,
	[SubscriberId] [nvarchar](100) NULL,
	[PaymentInstrumentName] [nvarchar](50) NULL,
	[AccountId] [nchar](50) NULL,
	[Amount] [float] NULL,
	[TotalAmount] [float] NULL,
	[BalanceDue] [float] NULL,
	[MerchantBalance] [float] NULL,
	[Currency] [nchar](25) NULL,
	[InvoiceNumber] [nvarchar](50) NULL,
	[OrderNumber] [nvarchar](50) NULL,
	[StatusCode] [nvarchar](50) NULL,
	[StatusDetail] [nvarchar](max) NULL,
	[Extra] [nvarchar](max) NULL,
	[Date] [datetime2](7) NULL,
	[Time] [datetime2](7) NULL,
	[TimeStamp] [datetime2](7) NULL,
	[DateCreated] [datetime2](7) NOT NULL,
 CONSTRAINT [PK_tblPaymentRequest] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblFarmers]    Script Date: 07/29/2013 11:27:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblFarmers](
	[Id] [uniqueidentifier] NOT NULL,
	[Code] [nvarchar](50) NOT NULL,
	[FullName] [nvarchar](150) NOT NULL,
	[FactoryCode] [nvarchar](50) NOT NULL,
	[FactoryId] [uniqueidentifier] NOT NULL,
	[FactoryUrl] [nvarchar](max) NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateLastUpdated] [datetime] NOT NULL,
	[IM_Status] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblAuditLog]    Script Date: 07/29/2013 11:27:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblAuditLog](
	[Id] [uniqueidentifier] NOT NULL,
	[DistributorCostCenterId] [uniqueidentifier] NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[Type] [nvarchar](100) NULL,
	[Direction] [nvarchar](100) NULL,
	[Description] [nvarchar](max) NULL,
	[Module] [int] NULL,
 CONSTRAINT [PK_tblPaymentAuditLog] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblUser]    Script Date: 07/29/2013 11:27:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblUser](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](30) NOT NULL,
	[FullName] [varchar](50) NOT NULL,
	[Email] [varchar](50) NOT NULL,
	[PhoneNo] [varchar](20) NOT NULL,
	[LastLogin] [datetime] NOT NULL,
	[Password] [varchar](200) NOT NULL,
	[HasChangePassword] [bit] NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateUpdated] [datetime] NOT NULL,
	[IM_IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblSms]    Script Date: 07/29/2013 11:27:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblSms](
	[Id] [uniqueidentifier] NOT NULL,
	[DistributorCostCenterId] [uniqueidentifier] NULL,
	[TransactionRefId] [nvarchar](100) NULL,
	[ClientRequestResponseType] [int] NULL,
	[DocumentId] [uniqueidentifier] NULL,
	[DocumentType] [int] NULL,
	[Recipients] [nvarchar](max) NULL,
	[SMSBody] [nvarchar](300) NULL,
	[SmsStatus] [nchar](10) NULL,
	[SdpRequestId] [nvarchar](50) NULL,
	[SdpDestinationResponses] [nvarchar](max) NULL,
	[SdpVersion] [nvarchar](50) NULL,
	[SdpStatusCode] [nvarchar](50) NULL,
	[SdpStatusString] [nvarchar](250) NULL,
	[DateCreated] [datetime] NULL,
	[DateLastUpdated] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblServiceProvider]    Script Date: 07/29/2013 11:27:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblServiceProvider](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[SDP_APP_ID] [varchar](50) NOT NULL,
	[SDP_Password] [varchar](50) NOT NULL,
	[SubscriberId] [varchar](50) NOT NULL,
	[Currecy] [varchar](20) NOT NULL,
	[AllowPartialPayment] [bit] NOT NULL,
	[AllowOverPayment] [bit] NOT NULL,
	[SPName] [varchar](50) NOT NULL,
	[SPCode] [varchar](50) NOT NULL,
	[SPId] [nvarchar](50) NOT NULL,
	[IM_DateCreated] [datetime] NOT NULL,
	[IM_DateUpdated] [datetime] NOT NULL,
	[IM_IsActive] [bit] NOT NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY],
UNIQUE NONCLUSTERED 
(
	[SPId] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Table [dbo].[tblRequestResponceDestination]    Script Date: 07/29/2013 11:27:30 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
SET ANSI_PADDING ON
GO
CREATE TABLE [dbo].[tblRequestResponceDestination](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[Address] [nvarchar](50) NULL,
	[ResponseTimeStamp] [nvarchar](50) NULL,
	[RequestResponceId] [int] NOT NULL,
	[DateCreated] [datetime] NOT NULL,
	[MessageId] [varchar](50) NULL,
	[StatusCode] [varchar](50) NULL,
	[StatusDetails] [varchar](100) NULL,
PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
SET ANSI_PADDING OFF
GO
/****** Object:  Default [DF__tblReques__DateC__1BFD2C07]    Script Date: 07/29/2013 11:27:30 ******/
ALTER TABLE [dbo].[tblRequest] ADD  DEFAULT (getdate()) FOR [DateCreated]
GO
/****** Object:  Default [DF__tblReques__DateC__1CF15040]    Script Date: 07/29/2013 11:27:30 ******/
ALTER TABLE [dbo].[tblRequestResponce] ADD  DEFAULT (getdate()) FOR [DateCreated]
GO
/****** Object:  Default [DF__tblReques__DateC__1DE57479]    Script Date: 07/29/2013 11:27:30 ******/
ALTER TABLE [dbo].[tblRequestResponceDestination] ADD  DEFAULT (getdate()) FOR [DateCreated]
GO
/****** Object:  Default [DF__tblServic__Allow__628FA481]    Script Date: 07/29/2013 11:27:30 ******/
ALTER TABLE [dbo].[tblServiceProvider] ADD  DEFAULT ((0)) FOR [AllowPartialPayment]
GO
/****** Object:  Default [DF__tblServic__Allow__6383C8BA]    Script Date: 07/29/2013 11:27:30 ******/
ALTER TABLE [dbo].[tblServiceProvider] ADD  DEFAULT ((0)) FOR [AllowOverPayment]
GO
/****** Object:  Default [DF__tblServic__IM_Da__6477ECF3]    Script Date: 07/29/2013 11:27:30 ******/
ALTER TABLE [dbo].[tblServiceProvider] ADD  DEFAULT (getdate()) FOR [IM_DateCreated]
GO
/****** Object:  Default [DF__tblServic__IM_Da__656C112C]    Script Date: 07/29/2013 11:27:30 ******/
ALTER TABLE [dbo].[tblServiceProvider] ADD  DEFAULT (getdate()) FOR [IM_DateUpdated]
GO
/****** Object:  Default [DF__tblServic__IM_Is__66603565]    Script Date: 07/29/2013 11:27:30 ******/
ALTER TABLE [dbo].[tblServiceProvider] ADD  DEFAULT ((0)) FOR [IM_IsActive]
GO
/****** Object:  Default [DF__tblUser__HasChan__239E4DCF]    Script Date: 07/29/2013 11:27:30 ******/
ALTER TABLE [dbo].[tblUser] ADD  DEFAULT ((0)) FOR [HasChangePassword]
GO
/****** Object:  Default [DF__tblUser__IM_Date__24927208]    Script Date: 07/29/2013 11:27:30 ******/
ALTER TABLE [dbo].[tblUser] ADD  DEFAULT (getdate()) FOR [IM_DateCreated]
GO
/****** Object:  Default [DF__tblUser__IM_Date__25869641]    Script Date: 07/29/2013 11:27:30 ******/
ALTER TABLE [dbo].[tblUser] ADD  DEFAULT (getdate()) FOR [IM_DateUpdated]
GO
/****** Object:  Default [DF__tblUser__IM_IsAc__267ABA7A]    Script Date: 07/29/2013 11:27:30 ******/
ALTER TABLE [dbo].[tblUser] ADD  DEFAULT ((0)) FOR [IM_IsActive]
GO
/****** Object:  ForeignKey [FK__tblReques__Reque__276EDEB3]    Script Date: 07/29/2013 11:27:30 ******/
ALTER TABLE [dbo].[tblRequestResponceDestination]  WITH CHECK ADD FOREIGN KEY([RequestResponceId])
REFERENCES [dbo].[tblRequestResponce] ([Id])
GO
