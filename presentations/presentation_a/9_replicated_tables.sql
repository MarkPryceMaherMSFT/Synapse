


IF OBJECT_ID('tempdb..#reptables') IS NOT NULL
  BEGIN;
	DROP TABLE #reptables;
  END;

CREATE TABLE #reptables
WITH
(
	DISTRIBUTION   = HASH([seq_nmbr])
)
AS 
SELECT ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) AS [seq_nmbr],
				[ReplicatedTable] = quotename(schema_name(t.schema_id)) + '.' + quotename(t.[name])
                FROM sys.tables t  
                JOIN sys.pdw_replicated_table_cache_state c  
                  ON c.object_id = t.object_id 
                JOIN sys.pdw_table_distribution_properties p 
                  ON p.object_id = t.object_id 
                WHERE 1 =1 
				AND c.[state] = 'NotReady'
                  AND p.[distribution_policy_desc] = 'REPLICATE'

DECLARE
	@i INT = 1
	, @t INT = (SELECT COUNT(*) FROM #reptables)
	, @statement NVARCHAR(4000)   = N''
	, @table_name varchar(255)
	, @StartTime datetime2
	, @EndTime datetime2
WHILE @i <= @t
  BEGIN
	
	SELECT @table_name = ReplicatedTable
		FROM #reptables WHERE seq_nmbr = @i;

	set @StartTime = getdate()
	set @statement = 'SELECT top 1 * from ' + @table_name

    BEGIN TRY
		print 'Start Time ' + convert(varchar(20),@StartTime)
		PRINT @statement
		/* Uncomment the line below to make the script work
		EXEC sp_executesql @statement
		*/
		set @EndTime = getdate()

    END TRY
	BEGIN CATCH
		PRINT 'Opps - something went wrong....'
			set @EndTime = getdate()
	END CATCH

	print 'End Time ' + convert(varchar(20), @EndTime) 

	SET @i+=1;
END

DROP TABLE #reptables ;