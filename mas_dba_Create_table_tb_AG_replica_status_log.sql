USE [DAXAGReFRESH]
GO

/*
ALTER TABLE [dbo].[tb_AG_replica_status_log] DROP CONSTRAINT [FK_tb_AG_replica_status_log_replica_server]

ALTER TABLE [dbo].[tb_AG_replica_status_log] DROP CONSTRAINT [FK_tb_AG_replica_status_log_refresh_group]
*/
DROP TABLE [dbo].[tb_AG_replica_status_log]
GO


SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tb_AG_replica_status_log](
	[refresh_group_ID] [int] NOT NULL,
	[replica_server_ID] [int] NOT NULL,
	[is_local] [bit] NOT NULL,
	[role] [tinyint] NULL,
	[role_desc] [nvarchar](60) NULL,
	[operational_state] [tinyint] NULL,
	[connected_state] [tinyint] NULL,
	[connected_state_desc] [nvarchar](60) NULL,
	[recovery_health] [tinyint] NULL,
	[recovery_health_desc] [nvarchar](60) NULL,
	[synchronization_health] [tinyint] NULL,
	[synchronization_health_desc] [nvarchar](60) NULL,
	[replica_status_timestamp] DATETIME NULL,
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[tb_AG_replica_status_log]  WITH CHECK ADD  CONSTRAINT [FK_tb_AG_replica_status_log_refresh_group] FOREIGN KEY([refresh_group_ID])
REFERENCES [dbo].[tb_AG_refresh_group] ([refresh_group_ID])
GO

ALTER TABLE [dbo].[tb_AG_replica_status_log] CHECK CONSTRAINT [FK_tb_AG_replica_status_log_refresh_group]
GO

ALTER TABLE [dbo].[tb_AG_replica_status_log]  WITH CHECK ADD  CONSTRAINT [FK_tb_AG_replica_status_log_replica_server] FOREIGN KEY([replica_server_ID])
REFERENCES [dbo].[tb_AG_replica_servers] ([replica_server_ID])
GO

ALTER TABLE [dbo].[tb_AG_replica_status_log] CHECK CONSTRAINT [FK_tb_AG_replica_status_log_replica_server]
GO

CREATE NONCLUSTERED INDEX IX_tb_AG_replica_status_log_exec_time ON tb_AG_replica_status_log ([replica_status_timestamp])
