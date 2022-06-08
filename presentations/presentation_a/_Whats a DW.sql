-- https://github.com/microsoft/sql-data-warehouse-samples

-- version
select @@version

-- size
SELECT DATABASEPROPERTYEX (DB_NAME(), 'ServiceObjective' ) as ServiceObjective

-- Run against master database
SELECT  db.name [Database]
,	    ds.edition [Edition]
,	    ds.service_objective [Service Objective]
FROM    sys.database_service_objectives   AS ds
JOIN    sys.databases                     AS db ON ds.database_id = db.database_id
;

-- How many nodes....
select * from sys.dm_pdw_nodes; -- DWU100 to DWU400

/*
DWU100-400
5	CONTROL	DB.5	NULL	0	NULL
5	COMPUTE	DB.5	NULL	0	NULL


26	CONTROL	DB.26	NULL	0	NULL
10	COMPUTE	DB.10	NULL	0	NULL

26	CONTROL	DB.26	NULL	0	NULL
10	COMPUTE	DB.10	NULL	0	NULL
17	COMPUTE	DB.17	NULL	0	NULL


*/



-- distributions
 select * from   sys.pdw_distributions

-- where is the data?
select * from [microsoft].[vw_table_sizes];

--
select * from [microsoft].[vw_table_space_summary]

-- current state
select * from sys.dm_pdw_sys_info ;

-- errors
select * from sys.dm_pdw_errors;

--
select * from sys.dm_pdw_lock_waits;

-- Sessions
select * from sys.dm_pdw_exec_sessions;

-- SQL Requests
select * from sys.dm_pdw_sql_requests;

-- polybase
select * from sys.dm_pdw_dms_external_work;

-- table types
 select * from  sys.pdw_table_distribution_properties
 
 -- real name for each table
 select * from   sys.pdw_table_mappings 


 -- view 
 select * from  sys.pdw_nodes_tables 

 --
 select * from   sys.dm_pdw_nodes_db_partition_stats








