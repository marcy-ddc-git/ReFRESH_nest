/* 
Script:         Create_or_alter_procedure_usp_Add_databases_to_AG.sql
Author:         Marcy Ashley-Selleck
Revision Date:  03/12/2022

This script will perform the following:
	Create stored procedure dbo.usp_Add_databases_to_AG
    Retrieve the name of the Availability Group (AG) from DAXAGReFRESH.dbo.tb_AG_refresh_group table
	Validate the AG exists on the replica server
    Retrieve the list of databases in DAXAGReFRESH.dbo.tb_AG_databases table 
	Validate the database exists and is accessible
	Add the database from the AG if no errors during processing commands
	Catch error messages and show in output to screen and write to an error log table.
*/

USE master
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

CREATE OR ALTER PROCEDURE [dbo].[usp_Add_databases_to_AG]

AS
BEGIN

DECLARE @refreshAGname      VARCHAR(128) ;
DECLARE @runAGrefresh       BIT          ;
DECLARE @valid_AG           VARCHAR(128) ;
DECLARE @databaseRowCount   BIGINT = 0 ;
DECLARE @errorStatus        NVARCHAR(128)


/*  Set @runAGrefresh bit flag to run the database add to AG step: 0 = test mode, 1 = run mode
*/
SET @runAGrefresh = 0  ;  -- 0 = test mode, 1 = run mode


/*  Get AG name from table tb_AG_refresh_group and validate AG is accessible
	The AG is valid if found on this replica server in master.sys.availability_groups
*/
SELECT @refreshAGname = name FROM DAXAGReFRESH.dbo.tb_AG_refresh_group ;  -- assumes one AG, check could be made if more than 1 row returned

 print @refreshAGname ;

 SET @valid_AG = isnull((select name from master.sys.availability_groups AS ag where ag.name = @refreshAGname ), '1')

 print @valid_AG ;
 
BEGIN TRY
  SELECT @errorStatus =  'Availablity group name is not a valid Availability Group.' ;
	  
  IF (SELECT COUNT(*) [AGcount] FROM (select name from master.sys.availability_groups where name = @refreshAGname) as validAGcount) < 1
    RAISERROR(@errorStatus,16,1)  ;

END TRY

BEGIN CATCH
  exec DAXAGReFRESH.dbo.usp_Catch_error_messages  ;

END CATCH


 /* Countinue if the AG is validated
 */
IF @refreshAGname = @valid_AG

  BEGIN

  /* Get count of database names list to eyeball count in output is what is expected
  */
  SELECT @databaseRowCount = COUNT(0) FROM DAXAGReFRESH.dbo.tb_AG_databases ;

   print @databaseRowCount ;


  DECLARE @database_ID          INT
  DECLARE @database_name        NVARCHAR(128)
  DECLARE @valid_database_name  VARCHAR(128) 
  DECLARE @database_state_desc  NVARCHAR(60)
  DECLARE @sql_command          VARCHAR(MAX)


  /* Get database names list for AG from table tb_AG_databases
     Fetch each row with cursor and validate the database name to ensure it is available and accessible  
  */
  DECLARE cursorAGdatabases CURSOR LOCAL FAST_FORWARD FOR 
  SELECT database_ID, database_name, database_state_desc 
  FROM DAXAGReFRESH.dbo.tb_AG_databases 

  OPEN cursorAGdatabases
 
  FETCH NEXT FROM cursorAGdatabases INTO @database_ID, @database_name, @database_state_desc

  WHILE @@FETCH_STATUS = 0

    BEGIN
	  print @database_name ;

	  SET @valid_database_name = (select DB_NAME(@database_ID) AS db)

	  print @valid_database_name ;

	  BEGIN TRY
		SELECT @errorStatus =  'Database name is not a valid database.' ;
				
		IF @database_name != @valid_database_name
		  RAISERROR(@errorStatus,16,1)  ;
	  
	  END TRY

	  BEGIN CATCH
        exec DAXAGReFRESH.dbo.usp_Catch_error_messages  ;

	  END CATCH

  /* Add the database from the AG if it is a valid database and run mode = 1
  */
	  IF @database_name = @valid_database_name AND @runAGrefresh = 1 
	    
		BEGIN TRY
		  print @refreshAGname  ;
		  print @database_name  ;

		  SET @sql_command = 'ALTER AVAILABILITY GROUP [' + @refreshAGname + '] ADD DATABASE [' + @database_name + '] ;' ;
		  EXEC (@sql_command) ;
		
		END TRY

		BEGIN CATCH
          exec DAXAGReFRESH.dbo.usp_Catch_error_messages  ;

	    END CATCH

	  FETCH NEXT FROM cursorAGdatabases INTO @database_ID, @database_name, @database_state_desc

    END
 
  CLOSE cursorAGdatabases
  DEALLOCATE cursorAGdatabases




  END
;

  END
  GO

