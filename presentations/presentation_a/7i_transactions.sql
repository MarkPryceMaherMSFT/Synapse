/*
transactions
*/

/*
SELECT  requests.session_id,   waits.request_id,  
      requests.command,
      requests.status,
      requests.start_time,  
      waits.type,
      waits.state,
      waits.object_type,
      waits.object_name
FROM   sys.dm_pdw_waits waits
   JOIN  sys.dm_pdw_exec_requests requests
   ON waits.request_id=requests.request_id
WHERE waits.[type] = 'ExclusiveUpdate'
*/

begin transaction
--delete from [dbo].[round_robin_test1]
rollback 

