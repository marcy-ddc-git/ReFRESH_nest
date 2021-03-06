/* 
Script:         mas_dba_Create_or_alter_usp_Report_error_log_by_date
Author:         Marcy Ashley-Selleck
Revision Date:  03/06/2022

This script will perform the following:
	Create stored procedure for reporting out the error messages from DAXAGReFRESH.dbo.tb_AG_script_error_log table
	Select error messages from the table with a date parameter.
*/
USE DAXAGReFRESH
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[usp_Report_error_log_by_date]
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