-- https://docs.microsoft.com/en-us/sql/relational-databases/system-functions/sys-fn-get-audit-file-transact-sql?view=sql-server-ver15

SELECT * FROM sys.fn_get_audit_file ('https://{storageacc}.blob.core.windows.net/sqldbauditlogs/{sqlservername}/{dbname}/SqlDbAuditing_Audit/2020-02-17',default,default);

SELECT convert(date,event_time) access_date, event_time, session_server_principal_name,  duration_milliseconds FROM sys.fn_get_audit_file ('https://{storageacc}.blob.core.windows.net/sqldbauditlogs/{sqlservername}/{dbname}/SqlDbAuditing_Audit/2020-02-17',default,default);

SELECT convert(date,event_time) access_date, count(*), session_server_principal_name,  sum(duration_milliseconds) FROM sys.fn_get_audit_file ('https://{storageacc}.blob.core.windows.net/sqldbauditlogs/{sqlservername}/{dbname}/SqlDbAuditing_Audit/2020-02-17',default,default)
group by convert(date,event_time), session_server_principal_name;


SELECT convert(date,event_time) access_date, server_instance_name,  session_server_principal_name,  sum(duration_milliseconds) total_duration_milliseconds,count(*) queries FROM sys.fn_get_audit_file ('https://{storageacc}.blob.core.windows.net/sqldbauditlogs/{sqlservername}/{dbname}/SqlDbAuditing_Audit',default,default)
where len(session_server_principal_name) > 0
group by convert(date,event_time), server_instance_name, session_server_principal_name
order by convert(date,event_time);

/*
There is something interesting happening with the below code.  If you remove the top 99999999 then 0 (zero) rows are inserted into the table
*/
drop table sql_audit_information

Create table sql_audit_information
with ( distribution = round_robin)
as
select top 99999999999 * from (
SELECT top 99999999999  * FROM sys.fn_get_audit_file ('https://csetestwsaudit.blob.core.windows.net/sqldbauditlogs/tpc-test/tpch/SqlDbAuditing_Audit_NoRetention/',default,default)) a;

select * from sql_audit_information;

select convert(date,event_time) access_date, event_time, session_server_principal_name,  duration_milliseconds 
from sql_audit_information;

SELECT convert(date,event_time) access_date, count(*) query_count, session_server_principal_name,  sum(duration_milliseconds) sum_duration_milliseconds FROM 
sql_audit_information
group by convert(date,event_time), session_server_principal_name;

SELECT convert(date,event_time) access_date, server_instance_name,  session_server_principal_name,  sum(duration_milliseconds) total_duration_milliseconds,count(*) queries FROM 
sql_audit_information
where len(session_server_principal_name) > 0
group by convert(date,event_time), server_instance_name, session_server_principal_name
order by convert(date,event_time);

/*
select top 50 c_phone from customer;

select  top 50 c_phone, [c_name]  from customer;
*/

select session_server_principal_name, statement,data_sensitivity_information  
from sql_audit_information where len(data_sensitivity_information) > 0

