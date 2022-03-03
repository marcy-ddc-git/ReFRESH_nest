USE [DAXAGReFRESH]
GO

-- From https://www.mssqltips.com/sqlservertip/5236/execute-and-track-tsql-script-executions-with-powershell/

--DROP TABLE [dbo].[tb_AG_script_exec_log]
GO

CREATE TABLE tb_AG_script_exec_log(
 [script_exec_ID] [int] IDENTITY(1,1) NOT NULL,
 [refresh_group_ID] [int] NOT NULL,
 [script_name] VARCHAR(100) NOT NULL,
 [script_exec_timestamp] DATETIME NULL,
 CONSTRAINT PK_script_exec_ID PRIMARY KEY CLUSTERED (script_exec_ID)
)
ALTER TABLE [dbo].tb_AG_script_exec_log  WITH CHECK ADD  CONSTRAINT [FK_tb_AG_script_exec_log_refresh_group] FOREIGN KEY([refresh_group_ID])
REFERENCES [dbo].tb_AG_refresh_group ([refresh_group_ID])
GO

CREATE NONCLUSTERED INDEX IX_tb_AG_script_exec_log_exec_time ON tb_AG_script_exec_log ([script_exec_timestamp])