# ReFRESH_nest
SDEV-435-81

Database refresh steps for databases in an Availability Group (AG):

	1.  Remove database from AG on primary 
	2.  Restore database on primary
	3.  Make sure restored database is in Full recovery mode on primary
	4.  Backup database and log on primary
	5.  Add database to AG on primary
	6.  Restore database and log on secondary
	7.  Join database to AG  (if time, automate this step also)
	8.  Repeat steps 6 and 7 for DR node.
	
