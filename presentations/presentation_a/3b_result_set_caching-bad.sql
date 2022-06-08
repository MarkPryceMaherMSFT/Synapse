/*   Example of where RSC makes things worse
-- 90 meg of data. 

SELECT name, is_result_set_caching_on FROM sys.databases;
ALTER DATABASE [oldgen2] SET RESULT_SET_CACHING off; -- use master
ALTER DATABASE [oldgen2] SET RESULT_SET_CACHING on;

select  total_elapsed_time / 1000 secs, *
from sys.dm_pdw_exec_requests where [label]='supplier test3' order by submit_time desc;

SELECT name, is_result_set_caching_on FROM sys.databases;

SELECT * FROM sys.dm_pdw_request_steps
WHERE request_id = 'QID32264'
ORDER BY step_index;

https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/performance-tuning-result-set-caching

The operations to create result set cache and retrieve data 
from the cache happen on the control node of a dedicated 
SQL pool instance. When result set caching is turned ON,
running queries that return large result set (for example, >1GB)
can cause high throttling on the control node and slow down
the overall query response on the instance. 
Those queries are commonly used during data exploration or 
ETL operations. To avoid stressing the control node and 
cause performance issue, users should turn OFF result 
set caching on the database before running those types of queries.

*/
drop table  dbo.tmp_supplier

create table dbo.tmp_supplier8 with (distribution=round_robin, heap) as
select top 4000000 * from [dbo].[supplier] option(label='supplier test3') -- over 5 minutes...

select * from tmp_supplier8

select * from  [microsoft].[vw_table_space_summary] where table_name = 'tmp_supplier8'

DBCC PDW_SHOWSPACEUSED('dbo.tmp_supplier2')





