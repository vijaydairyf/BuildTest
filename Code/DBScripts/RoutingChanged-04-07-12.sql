
GO
/****** Object:  Table [dbo].[tblDistributrCommand]    Script Date: 07/04/2012 16:52:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblDistributrCommand](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[CommandId] [uniqueidentifier] NOT NULL,
	[DocumentId] [uniqueidentifier] NOT NULL,
	[DocumentParentId] [uniqueidentifier] NULL,
	[IsRetired] bit NOT NULL default 0,
	[DateCommandInserted] [datetime] NOT NULL,
	[CommandGeneratedByCostCentreApplicationId] [uniqueidentifier] NOT NULL,
	[CommandGeneratedByUserId] [uniqueidentifier] NOT NULL,
	[CommandType] [nvarchar](50) NOT NULL,
	[JsonCommand] [nvarchar](2000) NOT NULL,
	
 CONSTRAINT [PK__tblDistr__3214EC077F60ED59] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblRoutingStatus]    Script Date: 07/04/2012 16:52:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblRoutingStatus](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[DistributorCommandId] [bigint] NOT NULL,
	[DestinationCostCentreApplicationId] [uniqueidentifier] NOT NULL,
	[Delivered] [bit] NOT NULL,
	[DateDelivered] [datetime] NULL,
	[Executed] [bit] NOT NULL,
	[DateExecuted] [datetime] NULL,
 CONSTRAINT [PK__tblRouti__3214EC0707F6335A] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tblRoutingCentre]    Script Date: 07/04/2012 16:52:47 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tblRoutingCentre](
	[Id] [bigint] IDENTITY(1,1) NOT NULL,
	[DistributorCommandId] [bigint] NOT NULL,
	[RoutingCostCentreId] [uniqueidentifier] NOT NULL,
 CONSTRAINT [PK__tblRouti__3214EC0703317E3D] PRIMARY KEY CLUSTERED 
(
	[Id] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  ForeignKey [FK__tblRoutin__Distr__0519C6AF]    Script Date: 07/04/2012 16:52:47 ******/
ALTER TABLE [dbo].[tblRoutingCentre]  WITH CHECK ADD  CONSTRAINT [FK__tblRoutin__Distr__0519C6AF] FOREIGN KEY([DistributorCommandId])
REFERENCES [dbo].[tblDistributrCommand] ([Id])
GO
ALTER TABLE [dbo].[tblRoutingCentre] CHECK CONSTRAINT [FK__tblRoutin__Distr__0519C6AF]
GO
/****** Object:  ForeignKey [FK__tblRoutin__Distr__09DE7BCC]    Script Date: 07/04/2012 16:52:47 ******/
ALTER TABLE [dbo].[tblRoutingStatus]  WITH CHECK ADD  CONSTRAINT [FK__tblRoutin__Distr__09DE7BCC] FOREIGN KEY([DistributorCommandId])
REFERENCES [dbo].[tblDistributrCommand] ([Id])
GO
ALTER TABLE [dbo].[tblRoutingStatus] CHECK CONSTRAINT [FK__tblRoutin__Distr__09DE7BCC]
GO
