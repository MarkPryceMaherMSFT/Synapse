select total_elapsed_time / 1000 [perf_s], * from sys.dm_pdw_exec_requests where [label]='supplier test3' order by submit_time desc;

-- hot query ( rsc off)
SELECT * FROM sys.dm_pdw_request_steps
WHERE request_id = 'QID6364008'
ORDER BY step_index;

-- hot query ( caching result set)
SELECT * FROM sys.dm_pdw_request_steps
WHERE request_id = 'QID6364066'
ORDER BY step_index;

-- hot query ( hitting  result set cache)
SELECT * FROM sys.dm_pdw_request_steps
WHERE request_id = 'QID6364096'
ORDER BY step_index;
/*


/*
select * from sys.dm_pdw_request_steps where operation_type = 'PartitionMoveOperation' and location_type = 'Control'  
select * from sys.dm_pdw_request_steps where operation_type = 'PartitionMoveOperation' and location_type = 'Compute'  

select sum(total_elapsed_time) from sys.dm_pdw_request_steps where operation_type = 'PartitionMoveOperation' and location_type = 'Control'  
 
 */