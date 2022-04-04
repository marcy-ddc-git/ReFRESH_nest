USE [DAXAGReFRESH]
GO


/****** Object:  Table [dbo].[tb_AG_script_exec_log]    Script Date: 3/26/2022 10:37:07 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tb_AG_script_exec_log](
	[script_exec_ID] [int] IDENTITY(1,1) NOT NULL,
	[server_name] VARCHAR(56) NOT NULL,
    [database_name] VARCHAR(56) NOT NULL,
	[refresh_group_ID] [int] NOT NULL,
	[script_name] [varchar](160) NOT NULL,
	[script_exec_timestamp] [datetime] NULL,
 CONSTRAINT [PK_script_exec_ID] PRIMARY KEY CLUSTERED 
(
	[script_exec_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO

ALTER TABLE [dbo].[tb_AG_script_exec_log]  WITH CHECK ADD  CONSTRAINT [FK_tb_AG_script_exec_log_refresh_group] FOREIGN KEY([refresh_group_ID])
REFERENCES [dbo].[tb_AG_refresh_group] ([refresh_group_ID])
GO

ALTER TABLE [dbo].[tb_AG_script_exec_log] CHECK CONSTRAINT [FK_tb_AG_script_exec_log_refresh_group]
GO


