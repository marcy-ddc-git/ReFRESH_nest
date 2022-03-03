USE [DAXAGReFRESH]
GO

CREATE TABLE [dbo].[tb_AG_event_log](
   [event_timestamp] [varchar](255) NOT NULL,
   [event_level] [varchar](255) NOT NULL,
   [event_message] [ntext] NOT NULL,
 );
