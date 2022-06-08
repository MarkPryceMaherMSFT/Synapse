declare @dynSQL varchar(4000)
declare @table varchar(50)

set @table = 't_supplier'

IF OBJECT_ID('tempdb..#col') IS NOT NULL
  BEGIN;
	DROP TABLE #col;
  END;

CREATE TABLE #col
WITH
(
	DISTRIBUTION   = HASH([seq_nmbr])
)
AS 
SELECT ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) AS [seq_nmbr],
  c.name nn
  , c.max_length
  , 0 as lenact 
  , -1 as minlen
  from sys.tables t 
  inner join sys.columns c on t.object_id = c.object_id
  join sys.types tt on tt.system_type_id = c.system_type_id 
  where t.name = 't_supplier'
 -- group by c.name


DECLARE
	@i INT = 1
	, @t INT = (SELECT COUNT(*) FROM #col)
	, @col_name varchar(255)
	, @ll int;

WHILE @i <= @t
  BEGIN
	
	SELECT  @col_name = nn , @ll = max_length
	FROM #col WHERE seq_nmbr = @i;

	print @col_name 

   set @dynSQL = 'update #col  set lenact  = (select max(len(' + @col_name + ')) from ' + @table + ') ,
							minlen =  (select min(len(' + @col_name + ')) from ' + @table + ')
			where nn = ''' + @col_name + ''''

		print	@dynSQL
		exec(@dynSQL)
	
	SET @i+=1;
END

select * from #col

DROP TABLE #col ;

--select max(len(s_comment)) from supplier



