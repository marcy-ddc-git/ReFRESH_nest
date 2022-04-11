USE [DAXAGReFRESH]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE TABLE [dbo].[tb_AG_event_log](
	[event_server] [nvarchar](max) NULL,
	[event_index] [int] NULL,
	[event_time_generated] [datetime2](7) NULL,
	[event_source] [varchar](max) NULL,
	[event_instance_ID] [bigint] NULL,
	[event_message] [varchar](max) NULL
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO


