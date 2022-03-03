USE [DAXAGReFRESH]
GO

/****** Object:  Table [dbo].[tb_AG_refresh_group]    Script Date: 2/6/2022 7:57:52 PM ******/
DROP TABLE [dbo].[tb_AG_refresh_group]
GO

/****** Object:  Table [dbo].[tb_AG_refresh_group]    Script Date: 2/6/2022 7:57:52 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tb_AG_refresh_group](
	[refresh_group_ID] [int] IDENTITY(1,1) NOT NULL,
	[name] [sysname] NOT NULL,
	[failure_condition_level] [int] NOT NULL,
	[health_check_timeout] [int] NOT NULL,
	[db_failover] [bit] NOT NULL,
	[dtc_support] [bit] NOT NULL,
	[is_distributed] [bit] NOT NULL,
	CONSTRAINT PK_refresh_group_ID PRIMARY KEY CLUSTERED (refresh_group_ID)
) ON [PRIMARY]
GO

SET IDENTITY_INSERT [dbo].[tb_AG_refresh_group] ON 
INSERT [dbo].[tb_AG_refresh_group] ([refresh_group_ID], [name], [failure_condition_level], [health_check_timeout],[db_failover],[dtc_support],[is_distributed]) VALUES (1, N'AG_AX_QA', 3, 30000, 1, 1, 0)  ;
SET IDENTITY_INSERT [dbo].[tb_AG_refresh_group] OFF 