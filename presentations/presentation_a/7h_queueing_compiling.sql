-- queueing and compile times
		select  top 50
		  datediff(ms, submit_time, end_compile_time) compile_time_ms
		,  datediff(ms, end_compile_time, isnull(start_time,getdate())) queueing_ms
		,  datediff(ms, end_compile_time, end_time) query_time_ms
		,  datediff(ms, submit_time, end_time) execution_time_ms
		, * 
		from sys.dm_pdw_exec_requests 
		--where start_time!=end_compile_time
		--where status = 'Suspended'
		order by submit_time desc;


select * from sys.dm_pdw_exec_requests where status = 'Suspended'

-- looking for queued queries
SELECT r.request_id queuedRequest,r.[status] requestStatus,
r.command command, waits.[state] wait_state,waits.[resource_class]
,waits.[type]
FROM sys.dm_pdw_exec_requests r
INNER JOIN sys.dm_pdw_resource_waits waits
ON r.request_id=waits.request_id
WHERE waits.[state]='Queued' 
--waits.[type]='UserConcurrencyResourceType'
--AND ;

SELECT blockedReqs.*,blockingReqs.blockerRequest,blockingReqs.blockerRequestStatus,blockingReqs.blockerCommand
FROM
(SELECT r.request_id blockedRequest,r.[status] blockedRequestStatus,
r.command blockedCommand, waits.[type], waits.[object_type],waits.[object_name],waits.[state] FROM
sys.dm_pdw_exec_requests r
INNER JOIN sys.dm_pdw_lock_waits waits
ON r.request_id=waits.request_id
WHERE r.[status]='Running' AND waits.[state]='Queued') blockedReqs
INNER JOIN 
(SELECT r2.request_id blockerRequest,r2.[status] blockerRequestStatus,
r2.command blockerCommand, waits2.[type], waits2.[object_type],waits2.[object_name],waits2.[state] FROM
sys.dm_pdw_exec_requests r2
INNER JOIN sys.dm_pdw_lock_waits waits2
ON r2.request_id=waits2.request_id AND waits2.[state] ='Granted') blockingReqs
ON blockedReqs.[type]=blockingReqs.[type] AND blockedReqs.[object_type]=blockingReqs.[object_type] 
AND blockedReqs.[object_name]=blockingReqs.[object_name]
ORDER BY blockedReqs.blockedRequest;

SELECT wait_name, MAX(max_wait_time) max_wait_time, SUM(request_count) request_count, 
SUM(signal_time) signal_time, SUM(completed_count) completed_count, SUM(wait_time) wait_time
FROM sys.dm_pdw_wait_stats 
WHERE wait_name NOT IN (
        N'BROKER_EVENTHANDLER', N'BROKER_RECEIVE_WAITFOR', N'BROKER_TASK_STOP',
		N'BROKER_TO_FLUSH', N'BROKER_TRANSMITTER', N'CHECKPOINT_QUEUE',
        N'CHKPT', N'CLR_AUTO_EVENT', N'CLR_MANUAL_EVENT', N'CLR_SEMAPHORE',
        N'DBMIRROR_DBM_EVENT', N'DBMIRROR_EVENTS_QUEUE', N'DBMIRROR_WORKER_QUEUE',
		N'DBMIRRORING_CMD', N'DIRTY_PAGE_POLL', N'DISPATCHER_QUEUE_SEMAPHORE',
        N'EXECSYNC', N'FSAGENT', N'FT_IFTS_SCHEDULER_IDLE_WAIT', N'FT_IFTSHC_MUTEX',
        N'HADR_CLUSAPI_CALL', N'HADR_FILESTREAM_IOMGR_IOCOMPLETION', N'HADR_LOGCAPTURE_WAIT', 
		N'HADR_NOTIFICATION_DEQUEUE', N'HADR_TIMER_TASK', N'HADR_WORK_QUEUE',
        N'KSOURCE_WAKEUP', N'LAZYWRITER_SLEEP', N'LOGMGR_QUEUE', 
		N'MEMORY_ALLOCATION_EXT', N'ONDEMAND_TASK_QUEUE',
		N'PREEMPTIVE_OS_LIBRARYOPS', N'PREEMPTIVE_OS_COMOPS', N'PREEMPTIVE_OS_CRYPTOPS',
		N'PREEMPTIVE_OS_PIPEOPS', N'PREEMPTIVE_OS_AUTHENTICATIONOPS',
		N'PREEMPTIVE_OS_GENERICOPS', N'PREEMPTIVE_OS_VERIFYTRUST',
		N'PREEMPTIVE_OS_FILEOPS', N'PREEMPTIVE_OS_DEVICEOPS',
        N'PWAIT_ALL_COMPONENTS_INITIALIZED', N'QDS_PERSIST_TASK_MAIN_LOOP_SLEEP',
		N'QDS_ASYNC_QUEUE',
        N'QDS_CLEANUP_STALE_QUERIES_TASK_MAIN_LOOP_SLEEP', N'REQUEST_FOR_DEADLOCK_SEARCH',
		N'RESOURCE_QUEUE', N'SERVER_IDLE_CHECK', N'SLEEP_BPOOL_FLUSH', N'SLEEP_DBSTARTUP',
		N'SLEEP_DCOMSTARTUP', N'SLEEP_MASTERDBREADY', N'SLEEP_MASTERMDREADY',
        N'SLEEP_MASTERUPGRADED', N'SLEEP_MSDBSTARTUP', N'SLEEP_SYSTEMTASK', N'SLEEP_TASK',
        N'SLEEP_TEMPDBSTARTUP', N'SNI_HTTP_ACCEPT', N'SP_SERVER_DIAGNOSTICS_SLEEP',
		N'SQLTRACE_BUFFER_FLUSH', N'SQLTRACE_INCREMENTAL_FLUSH_SLEEP', N'SQLTRACE_WAIT_ENTRIES',
		N'WAIT_FOR_RESULTS', N'WAITFOR', N'WAITFOR_TASKSHUTDOWN', N'WAIT_XTP_HOST_WAIT',
		N'WAIT_XTP_OFFLINE_CKPT_NEW_LOG', N'WAIT_XTP_CKPT_CLOSE', N'XE_DISPATCHER_JOIN',
        N'XE_DISPATCHER_WAIT', N'XE_LIVE_TARGET_TVF', N'XE_TIMER_EVENT',
		N'SOS_SYNC_TASK_ENQUEUE_EVENT',N'CLR_MONITOR', N'CLR_TASK_START',N'CLR_CRST',N'PREEMPTIVE_XE_SESSIONCOMMIT',
        N'TDS_INIT',N'PREEMPTIVE_XE_TARGETINIT',N'PREEMPTIVE_XE_ENGINEINIT',N'PREEMPTIVE_XE_CALLBACKEXECUTE',
        N'XE_BUFFERMGR_ALLPROCESSED_EVENT',N'SNI_CONN_DUP',N'PREEMPTIVE_OS_QUERYREGISTRY',N'DAC_INIT',N'PREEMPTIVE_OS_DOMAINSERVICESOPS',
        N'SNI_TASK_COMPLETION')
AND completed_count > 0
GROUP BY wait_name
ORDER BY wait_time DESC;