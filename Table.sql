CREATE TABLE [dbo].[tblAccounts](
	[AccID] [bigint] IDENTITY(1,1) NOT NULL,
	[AccTypeID] [tinyint] NOT NULL,
	[AccNumber] [nvarchar](50) NOT NULL,
	[SignQuantity] [tinyint] NOT NULL,
	[CreationDate] [datetime] NOT NULL,
	[AccountBalance]  AS ([dbo].[UdfGetAccBalance]([AccID])),
 CONSTRAINT [PK_tblAccounts] PRIMARY KEY CLUSTERED 
(
	[AccID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[tblAccounts]  WITH CHECK ADD  CONSTRAINT [FK_tblAccounts_tblAccountsType] FOREIGN KEY([AccTypeID])
REFERENCES [dbo].[tblAccountsType] ([AccTypeID])
GO

ALTER TABLE [dbo].[tblAccounts] CHECK CONSTRAINT [FK_tblAccounts_tblAccountsType]
GO







CREATE TABLE [dbo].[tblAccountsPayOrders](
	[PayOrderID] [bigint] IDENTITY(1,1) NOT NULL,
	[CNationalCode] [char](10) NOT NULL,
	[AccID] [bigint] NOT NULL,
	[PayOrderNote] [nvarchar](500) NOT NULL,
	[PayAcceptedBy] [bigint] NULL,
	[TotalAmount]  AS ([dbo].[GetTotalAmoutOfPayOrders]([PayOrderID])),
	[IsPaid] [bit] NOT NULL,
 CONSTRAINT [PK_tblAccountsPayOrders] PRIMARY KEY CLUSTERED 
(
	[PayOrderID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO






CREATE TABLE [dbo].[tblAccountsBill](
	[BillID] [bigint] IDENTITY(1,1) NOT NULL,
	[AccID] [bigint] NOT NULL,
	[IsDeposit] [bit] NOT NULL,
	[Price] [decimal](18, 2) NOT NULL,
	[DateOfTransaction] [datetime] NOT NULL,
	[Description] [nvarchar](500) NOT NULL,
 CONSTRAINT [PK_AccountsBill] PRIMARY KEY CLUSTERED 
(
	[BillID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[tblAccountsBill]  WITH CHECK ADD  CONSTRAINT [FK_AccountsBill_tblAccounts] FOREIGN KEY([AccID])
REFERENCES [dbo].[tblAccounts] ([AccID])
GO

ALTER TABLE [dbo].[tblAccountsBill] CHECK CONSTRAINT [FK_AccountsBill_tblAccounts]
GO












CREATE TABLE [dbo].[tblAccountsPayOrdersDetail](
	[PayOrderDetailID] [bigint] IDENTITY(1,1) NOT NULL,
	[PayOrderID] [bigint] NOT NULL,
	[DestinationAccID] [bigint] NOT NULL,
	[OrderAmout] [decimal](18, 2) NOT NULL,
	[IsDeposit] [bit] NULL,
 CONSTRAINT [PK_tblAccountsPayOrdersDetail] PRIMARY KEY CLUSTERED 
(
	[PayOrderDetailID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


ALTER TABLE [dbo].[tblAccountsPayOrdersDetail]  WITH CHECK ADD  CONSTRAINT [FK_tblAccountsPayOrdersDetail_tblAccountsPayOrders] FOREIGN KEY([PayOrderID])
REFERENCES [dbo].[tblAccountsPayOrders] ([PayOrderID])
GO

ALTER TABLE [dbo].[tblAccountsPayOrdersDetail] CHECK CONSTRAINT [FK_tblAccountsPayOrdersDetail_tblAccountsPayOrders]
GO











CREATE TABLE [dbo].[tblCustomers](
	[CustomerID] [bigint] IDENTITY(100000,1) NOT NULL,
	[CompanyID] [bigint] NOT NULL,
	[CUserName] [nvarchar](100) NOT NULL,
	[CUserPassword] [varbinary](max) NULL,
	[CName] [nvarchar](50) NOT NULL,
	[CSname] [nvarchar](50) NOT NULL,
	[CNationalCode] [char](10) NOT NULL,
 CONSTRAINT [PK_tblPersones] PRIMARY KEY CLUSTERED 
(
	[CustomerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[tblCustomers]  WITH CHECK ADD  CONSTRAINT [FK_tblCustomers_tblCompany] FOREIGN KEY([CompanyID])
REFERENCES [dbo].[tblCompany] ([CompanyID])
GO

ALTER TABLE [dbo].[tblCustomers] CHECK CONSTRAINT [FK_tblCustomers_tblCompany]
GO





CREATE TABLE [dbo].[tblAccountsOwners](
	[AccOwnerID] [bigint] IDENTITY(1,1) NOT NULL,
	[AccID] [bigint] NOT NULL,
	[CustomerID] [bigint] NOT NULL,
	[AccName] [nvarchar](100) NULL,
	[AccColour] [nvarchar](50) NULL,
 CONSTRAINT [PK_tblAccountsOwners] PRIMARY KEY CLUSTERED 
(
	[AccOwnerID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

EXEC sys.sp_addextendedproperty @name=N'MS_Description', @value=N'جدول صاحبان حساب  تاریخ ایجاد  1398/04/02' , @level0type=N'SCHEMA',@level0name=N'dbo', @level1type=N'TABLE',@level1name=N'tblAccountsOwners'
GO

ALTER TABLE [dbo].[tblAccountsOwners]  WITH CHECK ADD  CONSTRAINT [FK_tblAccountsOwners_tblAccounts] FOREIGN KEY([AccID])
REFERENCES [dbo].[tblAccounts] ([AccID])
GO

ALTER TABLE [dbo].[tblAccountsOwners] CHECK CONSTRAINT [FK_tblAccountsOwners_tblAccounts]
GO

ALTER TABLE [dbo].[tblAccountsOwners]  WITH CHECK ADD  CONSTRAINT [FK_tblAccountsOwners_tblCustomers] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[tblCustomers] ([CustomerID])
GO

ALTER TABLE [dbo].[tblAccountsOwners] CHECK CONSTRAINT [FK_tblAccountsOwners_tblCustomers]
GO









CREATE TABLE [dbo].[tblAccessLevelsTypes](
	[AccessLevelsTypeID] [smallint] IDENTITY(1,1) NOT NULL,
	[AccessLevelsDesc] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_tblAccessLevelsTypes] PRIMARY KEY CLUSTERED 
(
	[AccessLevelsTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO






CREATE TABLE [dbo].[tblAccountsOwnersAccessLevels](
	[AccOwnerAccessLevelsID] [bigint] IDENTITY(1,1) NOT NULL,
	[AccOwnerID] [bigint] NOT NULL,
	[AccessLevelID] [smallint] NOT NULL,
 CONSTRAINT [PK_tblAccountsOwnersAccessLevels] PRIMARY KEY CLUSTERED 
(
	[AccOwnerAccessLevelsID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[tblAccountsOwnersAccessLevels]  WITH CHECK ADD  CONSTRAINT [FK_tblAccountsOwnersAccessLevels_tblAccessLevelsTypes] FOREIGN KEY([AccessLevelID])
REFERENCES [dbo].[tblAccessLevelsTypes] ([AccessLevelsTypeID])
GO

ALTER TABLE [dbo].[tblAccountsOwnersAccessLevels] CHECK CONSTRAINT [FK_tblAccountsOwnersAccessLevels_tblAccessLevelsTypes]
GO

ALTER TABLE [dbo].[tblAccountsOwnersAccessLevels]  WITH CHECK ADD  CONSTRAINT [FK_tblAccountsOwnersAccessLevels_tblAccountsOwners] FOREIGN KEY([AccOwnerID])
REFERENCES [dbo].[tblAccountsOwners] ([AccOwnerID])
GO

ALTER TABLE [dbo].[tblAccountsOwnersAccessLevels] CHECK CONSTRAINT [FK_tblAccountsOwnersAccessLevels_tblAccountsOwners]
GO




CREATE TABLE [dbo].[tblAccountsType](
	[AccTypeID] [tinyint] IDENTITY(1,1) NOT NULL,
	[AccTypeDesc] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_tblAccountsType] PRIMARY KEY CLUSTERED 
(
	[AccTypeID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO





CREATE TABLE [dbo].[tblAccountsPayOrdersDetailSignatures](
	[PayOrderDetailSignID] [bigint] IDENTITY(1,1) NOT NULL,
	[SignedByID] [bigint] NOT NULL,
	[PayOrderID] [bigint] NOT NULL,
 CONSTRAINT [PK_tblAccountsPayOrdersDetailSignatures] PRIMARY KEY CLUSTERED 
(
	[PayOrderDetailSignID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO



ALTER TABLE [dbo].[tblAccountsPayOrdersDetailSignatures]  WITH CHECK ADD  CONSTRAINT [FK_tblAccountsPayOrdersDetailSignatures_tblAccountsPayOrders] FOREIGN KEY([PayOrderID])
REFERENCES [dbo].[tblAccountsPayOrders] ([PayOrderID])
GO

ALTER TABLE [dbo].[tblAccountsPayOrdersDetailSignatures] CHECK CONSTRAINT [FK_tblAccountsPayOrdersDetailSignatures_tblAccountsPayOrders]
GO

ALTER TABLE [dbo].[tblAccountsPayOrdersDetailSignatures]  WITH CHECK ADD  CONSTRAINT [FK_tblAccountsPayOrdersDetailSignatures_tblCustomers] FOREIGN KEY([SignedByID])
REFERENCES [dbo].[tblCustomers] ([CustomerID])
GO

ALTER TABLE [dbo].[tblAccountsPayOrdersDetailSignatures] CHECK CONSTRAINT [FK_tblAccountsPayOrdersDetailSignatures_tblCustomers]
GO








CREATE TABLE [dbo].[tblCustomersPhone](
	[CustomerPhoneID] [bigint] IDENTITY(1,1) NOT NULL,
	[CustomerID] [bigint] NOT NULL,
	[CustomerPhone] [nvarchar](50) NOT NULL,
 CONSTRAINT [PK_tblCustomersPhone] PRIMARY KEY CLUSTERED 
(
	[CustomerPhoneID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO


ALTER TABLE [dbo].[tblCustomersPhone]  WITH CHECK ADD  CONSTRAINT [FK_tblCustomersPhone_tblCustomers] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[tblCustomers] ([CustomerID])
GO

ALTER TABLE [dbo].[tblCustomersPhone] CHECK CONSTRAINT [FK_tblCustomersPhone_tblCustomers]
GO








CREATE TABLE [dbo].[tblCustomersAddress](
	[CustomerAddressID] [bigint] IDENTITY(1,1) NOT NULL,
	[CustomerID] [bigint] NOT NULL,
	[CustomerAddress] [nvarchar](1000) NOT NULL,
 CONSTRAINT [PK_tblCustomersAddress] PRIMARY KEY CLUSTERED 
(
	[CustomerAddressID] ASC
)WITH (PAD_INDEX  = OFF, STATISTICS_NORECOMPUTE  = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS  = ON, ALLOW_PAGE_LOCKS  = ON) ON [PRIMARY]
) ON [PRIMARY]

GO

ALTER TABLE [dbo].[tblCustomersAddress]  WITH CHECK ADD  CONSTRAINT [FK_tblCustomersAddress_tblCustomers] FOREIGN KEY([CustomerID])
REFERENCES [dbo].[tblCustomers] ([CustomerID])
GO

ALTER TABLE [dbo].[tblCustomersAddress] CHECK CONSTRAINT [FK_tblCustomersAddress_tblCustomers]
GO

