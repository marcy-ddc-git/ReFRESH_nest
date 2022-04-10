# ReFRESH_nest
SDEV-435-81  Marcy Ashley-Selleck
Revision date:	4-10-2022

The goal of my project is to add automation to several of the database refresh steps for databases in a SQL Server AlwaysOn Availability Group (AG). An AG is a data replication technology implementation for High Availability and Disaster Recovery for SQL Server databases that groups databases together for easier management of data replication and database failover scenarios.  

By automating several of these steps, a Database Administrator (DBA) can perform a faster, more accurate data refresh of a QA environment from Production data.  Using the AG and automation to perform the steps saves the DBA from having to manually perform the steps for every database.

These are my database refresh steps for databases in an Availability Group (AG):

	1.  Remove database from AG on primary 
	2.  Restore database on primary
	3.  Make sure restored database is in Full recovery mode on primary
	4.  Backup database and log on primary
	5.  Add database to AG on primary
	6.  Restore database and log on secondary
	7.  Join database to AG  (if time, automate this step also)
	8.  Repeat steps 6 and 7 for DR node.
	
The code in this project provides automation for steps 1 and 5: removing databases from an AG prior to a data refresh, and adding databases back to an AG after a data refresh.
