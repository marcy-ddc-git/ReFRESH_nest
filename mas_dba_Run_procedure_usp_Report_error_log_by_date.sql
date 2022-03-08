/* 
Script:         mas_dba_Run_procedure_usp_Report_error_log_by_date.sql
Author:         Marcy Ashley-Selleck
Revision Date:  03/06/2022

This script will perform the following:
	Execute stored procedure for reporting out the error messages from DAXAGReFRESH.dbo.tb_AG_script_error_log table
	Select error messages from the table with a date parameter using the current date.
*/
USE DAXAGReFRESH
GO

DECLARE @ReportDate  DATETIME
SET @ReportDate = GETDATE()  

EXEC [dbo].[usp_Report_error_log_by_date] @ReportDate   ;
