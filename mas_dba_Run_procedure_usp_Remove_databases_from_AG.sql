/* 
Script:         mas_dba_Run_procedure_usp_Remove_databases_from_AG.sql
Author:         Marcy Ashley-Selleck
Revision Date:  03/06/2022

This script will perform the following:
	Execute stored procedure for removing databases from an Availability Group for a database refresh.
*/

USE master
GO

EXEC [dbo].[usp_Remove_databases_from_AG]  ;
