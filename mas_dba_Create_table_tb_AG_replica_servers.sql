USE [DAXAGReFRESH]
GO

/****** Object:  Table [dbo].[tb_AG_replica_servers]    Script Date: 2/6/2022 7:31:44 PM ******/
DROP TABLE [dbo].[tb_AG_replica_servers]
GO

/****** Object:  Table [dbo].[tb_AG_replica_servers]    Script Date: 2/6/2022 7:31:44 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tb_AG_replica_servers](
	[replica_server_ID] [int] IDENTITY(1,1) NOT NULL,
	[refresh_group_ID] [int] NOT NULL,
	[replica_server_name] [nvarchar](256) NULL,
	[availability_mode] [tinyint] NULL,
	[availability_mode_desc] [nvarchar](60) NULL,
	[failover_mode] [tinyint] NULL,
	[failover_mode_desc] [nvarchar](60) NULL,
	[session_timeout] [int] NULL,
	[seeding_mode] [tinyint] NULL,
	[seeding_mode_desc] [nvarchar](60) NULL,
	CONSTRAINT PK_replica_server_ID PRIMARY KEY CLUSTERED (replica_server_ID)
) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tb_AG_replica_servers]  WITH CHECK ADD  CONSTRAINT [FK_tb_AG_replica_servers_refresh_group] FOREIGN KEY([refresh_group_ID])
REFERENCES [dbo].tb_AG_refresh_group ([refresh_group_ID])
GO

--next build in Primary and Foreign key constraints, so get temp table data and then recreate table
--select * into tb_AG_replica_servers_temp_addPK from tb_AG_replica_servers ;

SET IDENTITY_INSERT [dbo].[tb_AG_replica_servers] ON 
INSERT [dbo].[tb_AG_replica_servers] ([replica_server_ID], [refresh_group_ID], [replica_server_name], [availability_mode], [availability_mode_desc], [failover_mode], [failover_mode_desc], [session_timeout], [seeding_mode], [seeding_mode_desc]) VALUES (1, 1, N'N15W02ERPDZZ001', 1, N'SYNCHRONOUS_COMMIT', 1, N'MANUAL', 10, 1, N'MANUAL')
INSERT [dbo].[tb_AG_replica_servers] ([replica_server_ID], [refresh_group_ID], [replica_server_name], [availability_mode], [availability_mode_desc], [failover_mode], [failover_mode_desc], [session_timeout], [seeding_mode], [seeding_mode_desc]) VALUES (2, 1, N'N15W02ERPDZZ002', 1, N'SYNCHRONOUS_COMMIT', 0, N'AUTOMATIC', 10, 1, N'MANUAL')
INSERT [dbo].[tb_AG_replica_servers] ([replica_server_ID], [refresh_group_ID], [replica_server_name], [availability_mode], [availability_mode_desc], [failover_mode], [failover_mode_desc], [session_timeout], [seeding_mode], [seeding_mode_desc]) VALUES (3, 1, N'N15W02ERPDZZ003', 1, N'SYNCHRONOUS_COMMIT', 1, N'MANUAL', 10, 1, N'MANUAL')
SET IDENTITY_INSERT [dbo].[tb_AG_replica_servers] OFF
