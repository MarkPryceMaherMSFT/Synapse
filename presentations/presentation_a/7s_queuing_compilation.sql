select datediff(ms,submit_time,end_compile_time) compile_time_ms,
datediff(ms,end_compile_time,start_time) queuing_time_ms,
datediff(ms,start_time,end_time) execution_time_ms,
datediff(ms,submit_time,end_time) total_time_ms,
* from sys.dm_pdw_exec_requests

