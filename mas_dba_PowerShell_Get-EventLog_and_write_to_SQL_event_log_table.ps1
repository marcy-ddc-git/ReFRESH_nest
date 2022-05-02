<# 
Script:         mas_dba_PowerShell_Get-EventLog_and_write_to_SQL_event_log_table.ps1
Author:         Marcy Ashley-Selleck
Revision Date:  04/10/2022

This script will perform the following:
    Retrieve specific events from the Windows application event log and write them to a SQL table in the DAXAGReFRESH database.
    Events that contain a source of MSSQLSERVER and occur after the event date specified will be retrieved
    Event messages and timestamps will be loaded into a data table that is then imported into the SQL database 
	table DAXAGReFRESH.dbo.tb_AG_event_log.
#>


Import-Module -Name SQLServer

$dt = new-object "System.Data.DataTable"


<#  Retrieve specific events from the Windows application event log 
#>
foreach ($server_name in Get-Content "C:\Users\ddcmarcys\tempservers.txt") 
    { 

<#  Clear the host console and print the server name to be used to retrieve the Windows event log data
#>
    Clear-Host
    $server_name
    $dt = Get-Eventlog -computername $server_name -logname application -Source "*MSSQLSERVER*" -After "04-30-2022" 
    }

<#  Use the cmdlet Write-SqlTableData to write the data to the DAXAGReFRESH.dbo.tb_AG_event_log table
#>
    $dt | select @{Expression={$($server_name) }; Label = "ComputerName"},Index,TimeGenerated,Source,InstanceID,Message |
        Write-SqlTableData -ServerInstance "N15W02ERPDZZ001" -DatabaseName "DAXAGReFRESH" -SchemaName "dbo" -TableName "tb_AG_event_log"

    

