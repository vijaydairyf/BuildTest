
GO
SET IDENTITY_INSERT [dbo].[tblUser] ON 

INSERT [dbo].[tblUser] ([Id], [Username], [FullName], [Email], [PhoneNo], [LastLogin], [Password], [HasChangePassword], [IM_DateCreated], [IM_DateUpdated], [IM_IsActive]) VALUES (7, N'admin', N'Administrator', N'Administrator@virtualcity.com', N'0722557538', CAST(0x0000A03700A2E68B AS DateTime), N'81dc9bdb52d04dc20036dbd8313ed055', 0, CAST(0x0000A03700A2E68B AS DateTime), CAST(0x0000A03700A2E68B AS DateTime), 1)
SET IDENTITY_INSERT [dbo].[tblUser] OFF
