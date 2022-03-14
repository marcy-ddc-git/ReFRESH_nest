/* 
Script:         mas_dba_Run_procedure_usp_Add_databases_to_AG.sql
Author:         Marcy Ashley-Selleck
Revision Date:  03/06/2022

This script will perform the following:
	Execute stored procedure for adding databases to an Availability Group for a database refresh.
*/

USE master
GO

EXEC [dbo].[usp_Add_databases_to_AG]  ;
