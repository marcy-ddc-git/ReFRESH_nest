<# 
Script:         mas_dba_PowerShell_function_Get-ExecuteAGScripts.ps1
Author:         Marcy Ashley-Selleck
Revision Date:  03/26/2022

This script will perform the following:
    Create PowerShell function Get-ExecuteAGScripts to deploy T-SQL scripts used to manage databases in an Availablility Group.
    Function Get-ExecuteAGScripts will create a SQL database connection to the DAXAGReFRESH database, read the table 
	DAXAGReFRESH.dbo.tb_AG_script_exec_log, and determine if there are T-SQL scripts staged for deployment
    Table DAXAGReFRESH.dbo.tb_AG_script_exec_log will contain a row for every T-SQL script staged for deployment and
	this is determined by checking the execution timestamp on the row; if NULL then the script is ready for
	deployment
    The function will create a connection to the SQL database DAXAGReFRESH
    For each script to deploy, the functon will then execute the script using the PowerShell command Invoke-SqlCmd
    Error handling within a try...catch block will report any errors executing the T-SQL script
    If successful, the DAXAGReFRESH.dbo.tb_AG_script_exec_log table will be updated with the script execution timestamp
    Error handling within a try...catch block for the SQL table update will report any errors updating the table.
#>


<#  Create function Get-ExecuteAGScripts to deploy T-SQL scripts used to manage databases in an Availablility Group
#>
Function Get-ExecuteAGScripts {
    Param(
        [Parameter(Mandatory=$true)][string]$server_name,
        [Parameter(Mandatory=$true)][string]$database_name
    )

<#  Read table DAXAGReFRESH.dbo.tb_AG_script_exec_log and determine if there are T-SQL scripts staged for deployment
	based on the execution timestamp
#>
    Process
    {
        $getscriptinfo = "
        SELECT script_exec_ID, server_name, database_name, script_name AS Script FROM tb_AG_script_exec_log WHERE script_exec_timestamp IS NULL
        "

<#  Create a connection to the SQL server and database
       script will prompt for server name and database name, here it is database DAXAGReFRESH
#>        
        $scriptscon = New-Object System.Data.SqlClient.SqlConnection
        $scriptscon.ConnectionString = "Data Source=$server_name;Initial Catalog=$database_name;Integrated Security=true"

        $scriptcmd = New-Object System.Data.SqlClient.SqlCommand
        $scriptcmd.Connection = $scriptscon
        $scriptcmd.CommandText = $getscriptinfo
        $scriptcmd.CommandTimeout = 0

	$scriptupdate = New-Object System.Data.SqlClient.SqlCommand
	$scriptupdate.Connection = $scriptscon


<#  Try..catch block to report any errors executing the T-SQL script
#> 
        try
        {
            $scriptscon.Open()
            $scriptdetails = $scriptcmd.ExecuteReader()

            $scriptdatatable = New-Object System.Data.DataTable
            $scriptdatatable.Load($scriptdetails)

            foreach ($scriptrow in $scriptdatatable.Rows)
            {
                $scriptid = $scriptrow["script_exec_ID"]
                $scriptsrv = $scriptrow["server_name"]
                $scriptdb = $scriptrow["database_name"]
                $scriptfile = $scriptrow["Script"]

<#  Write informational message to the PowerShell ISE with the name of T-SQL script that will execute
	then execute the script
#> 
                Write-Host "Execute $scriptfile on server $scriptsrv.$scriptdb (ID of $scriptid)"
  Invoke-SqlCmd -ServerInstance $scriptsrv -Database $scriptdb -inputfile $scriptfile 

<#  If the script executes successfully, update the DAXAGReFRESH.dbo.tb_AG_script_exec_log table with the execution timestamp
#> 
  $scriptupdate.CommandText = "UPDATE tb_AG_script_exec_log SET script_exec_timestamp = GETDATE() WHERE script_exec_ID = $scriptid"


<#  Try..catch block to report any errors updating the table
#> 
  try
  {
      $scriptupdate.ExecuteNonQuery() | Out-Null
  }
  catch [Exception]
  {
      Write-Warning "Get-ExecuteAGScripts (Connection: [$server_name].[$database_name])"
      Write-Warning $_.Exception.Message
      Write-Warning "Query: UPDATE tb_AG_script_exec_log SET script_exec_timestamp = GETDATE() WHERE script_exec_ID = $scriptid"
  }
            }
        }
        catch [Exception]
        {
            Write-Warning "Get-ExecuteAGScripts (Connection: [$server_name].[$database_name])"
            Write-Warning $_.Exception.Message
            Write-Warning "Query: $getscriptinfo --script_exec_ID $scriptid"
        }
        finally
        {
            $scriptscon.Dispose()
            $scriptcmd.Dispose()
        }
    }
}


<#  Execute the function
#> 
Get-ExecuteAGScripts 