

create PROC [dbo].[sp_tda_gather] AS

IF OBJECT_ID('dbo.tda_history') IS NOT NULL
  BEGIN;
	
	IF OBJECT_ID('dbo.tda') IS NOT NULL
		BEGIN;
			INSERT INTO dbo.tda_history
				SELECT * FROM dbo.tda where submit_time > (select isnull(max(submit_time),getdate()-999) from dbo.tda_history)
		END;
  END;

IF OBJECT_ID('dbo.tda') IS NOT NULL
  BEGIN;
	DROP TABLE dbo.tda;
  END;

Create table dbo.tda
WITH ( DISTRIBUTION = ROUND_ROBIN, heap) 
AS 
SELECT  getdate() as loaddate,
		cast(0 as bigint) as durationms,
		getdate() as last_update ,
		cast(''  as varchar(4000)) as [sqlscript]
,       DB_Name()                                                               AS [database_name]
,	* from sys.dm_pdw_exec_requests
	
IF OBJECT_ID('dbo.tda_history') IS  NULL
  BEGIN;
	CREATE TABLE dbo.tda_history with (distribution= round_robin, heap) as
		SELECT * FROM dbo.tda where 1=0;
  END;

  /*
  drop table dbo.tda
  drop table dbo.tda_history
  */



