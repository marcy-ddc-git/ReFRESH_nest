/* 
Script:         mas_dba_Run_procedure_usp_Report_replica_status.sql
Author:         Marcy Ashley-Selleck
Revision Date:  04/30/2022

This script will perform the following:
	Execute stored procedure for reporting the replica status after removing databases from or adding to an AG for a database refresh.
*/

USE DAXAGReFRESH
GO

EXEC [dbo].[usp_Report_replica_status]  ;
