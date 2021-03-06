USE [master]
GO
/****** Object:  Database [DAXAGReFRESH]    Script Date: 5/1/2022 9:04:55 PM ******/
CREATE DATABASE [DAXAGReFRESH]
 CONTAINMENT = NONE
 ON  PRIMARY 
( NAME = N'DAXDataRefresh', FILENAME = N'E:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER\MSSQL\Data\DAXAGReFRESH.mdf' , SIZE = 457728KB , MAXSIZE = UNLIMITED, FILEGROWTH = 1024KB )
 LOG ON 
( NAME = N'DAXDataRefresh_log', FILENAME = N'L:\SQLServerLogs\DAXAGReFRESH.ldf' , SIZE = 4102976KB , MAXSIZE = 20971520KB , FILEGROWTH = 10%)
GO
ALTER DATABASE [DAXAGReFRESH] SET COMPATIBILITY_LEVEL = 130
GO
IF (1 = FULLTEXTSERVICEPROPERTY('IsFullTextInstalled'))
begin
EXEC [DAXAGReFRESH].[dbo].[sp_fulltext_database] @action = 'enable'
end
GO
ALTER DATABASE [DAXAGReFRESH] SET ANSI_NULL_DEFAULT OFF 
GO
ALTER DATABASE [DAXAGReFRESH] SET ANSI_NULLS OFF 
GO
ALTER DATABASE [DAXAGReFRESH] SET ANSI_PADDING OFF 
GO
ALTER DATABASE [DAXAGReFRESH] SET ANSI_WARNINGS OFF 
GO
ALTER DATABASE [DAXAGReFRESH] SET ARITHABORT OFF 
GO
ALTER DATABASE [DAXAGReFRESH] SET AUTO_CLOSE OFF 
GO
ALTER DATABASE [DAXAGReFRESH] SET AUTO_SHRINK OFF 
GO
ALTER DATABASE [DAXAGReFRESH] SET AUTO_UPDATE_STATISTICS ON 
GO
ALTER DATABASE [DAXAGReFRESH] SET CURSOR_CLOSE_ON_COMMIT OFF 
GO
ALTER DATABASE [DAXAGReFRESH] SET CURSOR_DEFAULT  GLOBAL 
GO
ALTER DATABASE [DAXAGReFRESH] SET CONCAT_NULL_YIELDS_NULL OFF 
GO
ALTER DATABASE [DAXAGReFRESH] SET NUMERIC_ROUNDABORT OFF 
GO
ALTER DATABASE [DAXAGReFRESH] SET QUOTED_IDENTIFIER OFF 
GO
ALTER DATABASE [DAXAGReFRESH] SET RECURSIVE_TRIGGERS OFF 
GO
ALTER DATABASE [DAXAGReFRESH] SET  DISABLE_BROKER 
GO
ALTER DATABASE [DAXAGReFRESH] SET AUTO_UPDATE_STATISTICS_ASYNC OFF 
GO
ALTER DATABASE [DAXAGReFRESH] SET DATE_CORRELATION_OPTIMIZATION OFF 
GO
ALTER DATABASE [DAXAGReFRESH] SET TRUSTWORTHY OFF 
GO
ALTER DATABASE [DAXAGReFRESH] SET ALLOW_SNAPSHOT_ISOLATION OFF 
GO
ALTER DATABASE [DAXAGReFRESH] SET PARAMETERIZATION SIMPLE 
GO
ALTER DATABASE [DAXAGReFRESH] SET READ_COMMITTED_SNAPSHOT OFF 
GO
ALTER DATABASE [DAXAGReFRESH] SET HONOR_BROKER_PRIORITY OFF 
GO
ALTER DATABASE [DAXAGReFRESH] SET RECOVERY SIMPLE 
GO
ALTER DATABASE [DAXAGReFRESH] SET  MULTI_USER 
GO
ALTER DATABASE [DAXAGReFRESH] SET PAGE_VERIFY CHECKSUM  
GO
ALTER DATABASE [DAXAGReFRESH] SET DB_CHAINING OFF 
GO
ALTER DATABASE [DAXAGReFRESH] SET FILESTREAM( NON_TRANSACTED_ACCESS = OFF ) 
GO
ALTER DATABASE [DAXAGReFRESH] SET TARGET_RECOVERY_TIME = 60 SECONDS 
GO
ALTER DATABASE [DAXAGReFRESH] SET DELAYED_DURABILITY = DISABLED 
GO
EXEC sys.sp_db_vardecimal_storage_format N'DAXAGReFRESH', N'ON'
GO
ALTER DATABASE [DAXAGReFRESH] SET QUERY_STORE = OFF
GO
USE [DAXAGReFRESH]
GO
ALTER DATABASE SCOPED CONFIGURATION SET LEGACY_CARDINALITY_ESTIMATION = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET LEGACY_CARDINALITY_ESTIMATION = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 0;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET MAXDOP = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET PARAMETER_SNIFFING = ON;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET PARAMETER_SNIFFING = PRIMARY;
GO
ALTER DATABASE SCOPED CONFIGURATION SET QUERY_OPTIMIZER_HOTFIXES = OFF;
GO
ALTER DATABASE SCOPED CONFIGURATION FOR SECONDARY SET QUERY_OPTIMIZER_HOTFIXES = PRIMARY;
GO
USE [DAXAGReFRESH]
GO
/****** Object:  Table [dbo].[tb_AG_databases]    Script Date: 5/1/2022 9:04:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_AG_databases](
	[database_ID] [int] IDENTITY(1,1) NOT NULL,
	[refresh_group_ID] [int] NOT NULL,
	[database_name] [sysname] NOT NULL,
	[database_state_desc] [nvarchar](60) NULL,
 CONSTRAINT [PK_database_ID] PRIMARY KEY CLUSTERED 
(
	[database_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_AG_event_log]    Script Date: 5/1/2022 9:04:55 PM ******/
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
/****** Object:  Table [dbo].[tb_AG_refresh_group]    Script Date: 5/1/2022 9:04:55 PM ******/
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
 CONSTRAINT [PK_refresh_group_ID] PRIMARY KEY CLUSTERED 
(
	[refresh_group_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_AG_replica_servers]    Script Date: 5/1/2022 9:04:55 PM ******/
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
 CONSTRAINT [PK_replica_server_ID] PRIMARY KEY CLUSTERED 
(
	[replica_server_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_AG_replica_states]    Script Date: 5/1/2022 9:04:55 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_AG_replica_states](
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
	[synchronization_health_desc] [nvarchar](60) NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_AG_replica_status_log]    Script Date: 5/1/2022 9:04:55 PM ******/
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
	[replica_status_timestamp] [datetime] NULL
) ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_AG_script_error_log]    Script Date: 5/1/2022 9:04:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_AG_script_error_log](
	[error_log_ID] [int] IDENTITY(1,1) NOT NULL,
	[user_name] [varchar](100) NULL,
	[error_number] [int] NULL,
	[error_state] [int] NULL,
	[error_severity] [int] NULL,
	[error_line] [int] NULL,
	[error_procedure] [varchar](128) NULL,
	[error_message] [varchar](max) NULL,
	[error_timestamp] [datetime] NULL,
PRIMARY KEY CLUSTERED 
(
	[error_log_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
GO
/****** Object:  Table [dbo].[tb_AG_script_exec_log]    Script Date: 5/1/2022 9:04:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
CREATE TABLE [dbo].[tb_AG_script_exec_log](
	[script_exec_ID] [int] IDENTITY(1,1) NOT NULL,
	[server_name] [varchar](56) NOT NULL,
	[database_name] [varchar](56) NOT NULL,
	[refresh_group_ID] [int] NOT NULL,
	[script_name] [varchar](160) NOT NULL,
	[script_exec_timestamp] [datetime] NULL,
 CONSTRAINT [PK_script_exec_ID] PRIMARY KEY CLUSTERED 
(
	[script_exec_ID] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, IGNORE_DUP_KEY = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
) ON [PRIMARY]
GO
/****** Object:  Index [IX_tb_AG_replica_status_log_exec_time]    Script Date: 5/1/2022 9:04:56 PM ******/
CREATE NONCLUSTERED INDEX [IX_tb_AG_replica_status_log_exec_time] ON [dbo].[tb_AG_replica_status_log]
(
	[replica_status_timestamp] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
/****** Object:  Index [IX_tb_AG_script_exec_log_exec_time]    Script Date: 5/1/2022 9:04:56 PM ******/
CREATE NONCLUSTERED INDEX [IX_tb_AG_script_exec_log_exec_time] ON [dbo].[tb_AG_script_exec_log]
(
	[script_exec_timestamp] ASC
)WITH (PAD_INDEX = OFF, STATISTICS_NORECOMPUTE = OFF, SORT_IN_TEMPDB = OFF, DROP_EXISTING = OFF, ONLINE = OFF, ALLOW_ROW_LOCKS = ON, ALLOW_PAGE_LOCKS = ON) ON [PRIMARY]
GO
ALTER TABLE [dbo].[tb_AG_databases]  WITH CHECK ADD  CONSTRAINT [FK_tb_AG_databases_refresh_group] FOREIGN KEY([refresh_group_ID])
REFERENCES [dbo].[tb_AG_refresh_group] ([refresh_group_ID])
GO
ALTER TABLE [dbo].[tb_AG_databases] CHECK CONSTRAINT [FK_tb_AG_databases_refresh_group]
GO
ALTER TABLE [dbo].[tb_AG_replica_servers]  WITH CHECK ADD  CONSTRAINT [FK_tb_AG_replica_servers_refresh_group] FOREIGN KEY([refresh_group_ID])
REFERENCES [dbo].[tb_AG_refresh_group] ([refresh_group_ID])
GO
ALTER TABLE [dbo].[tb_AG_replica_servers] CHECK CONSTRAINT [FK_tb_AG_replica_servers_refresh_group]
GO
ALTER TABLE [dbo].[tb_AG_replica_states]  WITH CHECK ADD  CONSTRAINT [FK_tb_AG_replica_states_refresh_group] FOREIGN KEY([refresh_group_ID])
REFERENCES [dbo].[tb_AG_refresh_group] ([refresh_group_ID])
GO
ALTER TABLE [dbo].[tb_AG_replica_states] CHECK CONSTRAINT [FK_tb_AG_replica_states_refresh_group]
GO
ALTER TABLE [dbo].[tb_AG_replica_states]  WITH CHECK ADD  CONSTRAINT [FK_tb_AG_replica_states_replica_server] FOREIGN KEY([replica_server_ID])
REFERENCES [dbo].[tb_AG_replica_servers] ([replica_server_ID])
GO
ALTER TABLE [dbo].[tb_AG_replica_states] CHECK CONSTRAINT [FK_tb_AG_replica_states_replica_server]
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
ALTER TABLE [dbo].[tb_AG_script_exec_log]  WITH CHECK ADD  CONSTRAINT [FK_tb_AG_script_exec_log_refresh_group] FOREIGN KEY([refresh_group_ID])
REFERENCES [dbo].[tb_AG_refresh_group] ([refresh_group_ID])
GO
ALTER TABLE [dbo].[tb_AG_script_exec_log] CHECK CONSTRAINT [FK_tb_AG_script_exec_log_refresh_group]
GO
/****** Object:  StoredProcedure [dbo].[usp_Capture_replica_status]    Script Date: 5/1/2022 9:04:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



CREATE    PROC [dbo].[usp_Capture_replica_status]
AS

-- Capture AG replica status before script executes with insert into DAXAGReFRESH.dbo.tb_AG_replica_status_log table from DMV view

INSERT INTO DAXAGReFRESH.dbo.tb_AG_replica_status_log  -- replica 1
   (refresh_group_id, replica_server_ID, is_local, role, role_desc, operational_state, connected_state, connected_state_desc, recovery_health, recovery_health_desc, synchronization_health, synchronization_health_desc, replica_status_timestamp) 
SELECT 1 AS refresh_group_id, 1 AS replica_server_ID, is_local, role, role_desc, operational_state, connected_state, connected_state_desc, recovery_health, recovery_health_desc, synchronization_health, synchronization_health_desc, GETDATE() as replica_status_timestamp
  FROM sys.dm_hadr_availability_replica_states  where replica_id = '32D7DA54-4EAF-44E8-8D08-AEC7B27B6476' ;  
INSERT INTO DAXAGReFRESH.dbo.tb_AG_replica_status_log  -- replica 2
   (refresh_group_id, replica_server_ID, is_local, role, role_desc, operational_state, connected_state, connected_state_desc, recovery_health, recovery_health_desc, synchronization_health, synchronization_health_desc, replica_status_timestamp) 
SELECT 1 AS refresh_group_id, 2 AS replica_server_ID, is_local, role, role_desc, operational_state, connected_state, connected_state_desc, recovery_health, recovery_health_desc, synchronization_health, synchronization_health_desc, GETDATE() as replica_status_timestamp
  FROM sys.dm_hadr_availability_replica_states  where replica_id = '58492EF6-E7F6-40B4-B50D-D60D45A187AF' ;  
INSERT INTO DAXAGReFRESH.dbo.tb_AG_replica_status_log  -- replica 3
   (refresh_group_id, replica_server_ID, is_local, role, role_desc, operational_state, connected_state, connected_state_desc, recovery_health, recovery_health_desc, synchronization_health, synchronization_health_desc, replica_status_timestamp) 
SELECT 1 AS refresh_group_id, 3 AS replica_server_ID, is_local, role, role_desc, operational_state, connected_state, connected_state_desc, recovery_health, recovery_health_desc, synchronization_health, synchronization_health_desc, GETDATE() as replica_status_timestamp
  FROM sys.dm_hadr_availability_replica_states  where replica_id = '55F2D9B9-1486-4109-9DC9-F23274A3A6A6' ;  

GO
/****** Object:  StoredProcedure [dbo].[usp_Catch_error_messages]    Script Date: 5/1/2022 9:04:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


CREATE    PROC [dbo].[usp_Catch_error_messages]
AS

DECLARE @Timestamp DATETIME
;
SET @Timestamp = GETDATE()

  SELECT   
    @Timestamp,    
	ERROR_NUMBER() AS ErrorNumber,  
    ERROR_SEVERITY() AS ErrorSeverity,
    ERROR_STATE() AS ErrorState,
    ERROR_LINE () AS ErrorLine,
    ERROR_PROCEDURE() AS ErrorProcedure,
    ERROR_MESSAGE() AS ErrorMessage
	;

  INSERT INTO dbo.tb_AG_script_error_log
    VALUES
    (SUSER_SNAME(),
	 ERROR_NUMBER(),
     ERROR_STATE(),
     ERROR_SEVERITY(),
     ERROR_LINE(),
     ERROR_PROCEDURE(),
     ERROR_MESSAGE(),
     @Timestamp
	);  

GO
/****** Object:  StoredProcedure [dbo].[usp_Report_error_log_by_date]    Script Date: 5/1/2022 9:04:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[usp_Report_error_log_by_date]
	@ReportDate DATE = NULL

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	Set @ReportDate = ISNULL(@ReportDate, CONVERT(DATE, GETDATE()))



SELECT TOP (1000) 
    [error_timestamp],
	[error_log_ID],
    [error_number],
    [error_state],
    [error_severity],
    [error_line],
    [error_procedure],
    [error_message],
	[user_name]
  FROM [DAXAGReFRESH].[dbo].[tb_AG_script_error_log]
  WHERE error_timestamp >= @ReportDate
  ;

  END
GO
/****** Object:  StoredProcedure [dbo].[usp_Report_replica_status]    Script Date: 5/1/2022 9:04:56 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO

CREATE   PROCEDURE [dbo].[usp_Report_replica_status]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


SELECT TOP (3) * FROM [DAXAGReFRESH].[dbo].[tb_AG_replica_status_log]
  order by [replica_status_timestamp] DESC ;


  END
GO
USE [master]
GO
ALTER DATABASE [DAXAGReFRESH] SET  READ_WRITE 
GO
