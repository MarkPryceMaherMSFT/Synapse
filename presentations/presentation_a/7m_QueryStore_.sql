/*
ALTER DATABASE tpch
SET QUERY_STORE = ON;
*/

SELECT *
FROM sys.query_store_plan AS Pl
INNER JOIN sys.query_store_query AS Qry
    ON Pl.query_id = Qry.query_id
INNER JOIN sys.query_store_query_text AS Txt
    ON Qry.query_text_id = Txt.query_text_id
	order by plan_id desc;

select top 01 * from [dbo].[replicated_test1]

insert into [dbo].[replicated_test1] select * from [dbo].[replicated_test1];

/*
select * from sys.dm_pdw_nodes_exec_query_stats qs
inner join sys.dm_pdw_nodes_exec_query_statistics_xml qp on
qs.sql_handle = qp.sql_handle


select * from sys.dm_pdw_nodes_exec_query_profiles;
select * from sys.dm_pdw_nodes_exec_query_statistics_xml;

*/
select count(*) from [dbo].[orders]
