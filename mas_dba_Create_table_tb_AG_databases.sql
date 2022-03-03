USE [DAXAGReFRESH]
GO

/****** Object:  Table [dbo].[tb_AG_databases_tmp]    Script Date: 2/6/2022 9:09:15 PM ******/
DROP TABLE [dbo].[tb_AG_databases]
GO

/****** Object:  Table [dbo].[tb_AG_databases_tmp]    Script Date: 2/6/2022 9:09:15 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tb_AG_databases](
	[database_ID] [int] IDENTITY(1,1) NOT NULL,
	[refresh_group_ID] [int] NOT NULL,
	[database_name] [sysname] NOT NULL,
	[database_state_desc] [nvarchar](60) NULL,
	CONSTRAINT PK_database_ID PRIMARY KEY CLUSTERED (database_ID)
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tb_AG_databases]  WITH CHECK ADD  CONSTRAINT [FK_tb_AG_databases_refresh_group] FOREIGN KEY([refresh_group_ID])
REFERENCES [dbo].tb_AG_refresh_group ([refresh_group_ID])
GO


SET IDENTITY_INSERT [dbo].[tb_AG_databases] ON 
INSERT [dbo].[tb_AG_databases] ([database_id], [refresh_group_ID], [database_name], [database_state_desc]) VALUES (13, 1, N'DDC_AX_QA_STO', N'ONLINE')
INSERT [dbo].[tb_AG_databases] ([database_id], [refresh_group_ID], [database_name], [database_state_desc]) VALUES (14, 1, N'DDC_AX_QA_Baseline', N'ONLINE')
INSERT [dbo].[tb_AG_databases] ([database_id], [refresh_group_ID], [database_name], [database_state_desc]) VALUES (15, 1, N'DDC_AX_QA_model', N'ONLINE')
INSERT [dbo].[tb_AG_databases] ([database_id], [refresh_group_ID], [database_name], [database_state_desc]) VALUES (16, 1, N'DDC_AX_QA', N'ONLINE')
INSERT [dbo].[tb_AG_databases] ([database_id], [refresh_group_ID], [database_name], [database_state_desc]) VALUES (22, 1, N'ePay_epay-qa.man.co', N'ONLINE')
SET IDENTITY_INSERT [dbo].[tb_AG_databases] OFF