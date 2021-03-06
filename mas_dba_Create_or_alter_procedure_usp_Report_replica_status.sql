/* 
Script:         mas_dba_Create_or_alter_usp_Report_replica_status
Author:         Marcy Ashley-Selleck
Revision Date:  04/30/2022

This script will perform the following:
	Create stored procedure for reporting out the replica status from DAXAGReFRESH.dbo.tb_AG_replica_status_log table.

*/
USE DAXAGReFRESH
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[usp_Report_replica_status]

AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;


SELECT TOP (3) * FROM [DAXAGReFRESH].[dbo].[tb_AG_replica_status_log]
  order by [replica_status_timestamp] DESC ;


  END
  GO