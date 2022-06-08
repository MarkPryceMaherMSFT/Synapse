/* TPC_H  Query 1 - Pricing Summary Report */

/* 
-- https://docs.microsoft.com/en-us/azure/synapse-analytics/sql/develop-materialized-view-performance-tuning


1) What's a materialized view....
A materialized view pre-computes, stores, and maintains its data
in dedicated SQL pool just like a table. Recomputation isn't needed
each time a materialized view is used. That's why queries that use
all or a subset of the data in materialized views can gain faster
performance. Even better, queries can use a materialized view 
without making direct reference to it, so there's no need to 
change application code.

2) What's 'explain'
3) What's 'explain with_recommendations'
-- https://docs.microsoft.com/en-us/sql/t-sql/queries/explain-transact-sql?view=azure-sqldw-latest&preserve-view=true
4) 
*/
--explain with_recommendations

explain with_recommendations
select
    l_returnflag,
    l_linestatus,
    sum(l_quantity) as sum_qty,
    sum(l_extendedprice) as sum_base_price,
    sum(l_extendedprice * (1 - l_discount)) as sum_disc_price,
    sum(l_extendedprice * (1 - l_discount) * (1 + l_tax)) as sum_charge,
    avg(l_quantity) as avg_qty,
    avg(l_extendedprice) as avg_price,
    avg(l_discount) as avg_disc,
    count_big(*) as count_order
from
    lineitem
where
    l_shipdate <= dateadd(day,-90,cast ('1998-12-01' as date))
group by
    l_returnflag,
    l_linestatus
order by
    l_returnflag,
    l_linestatus


	/*
	drop view view1


	*/
	<?xml version="1.0" encoding="utf-8"?>  
	<dsql_query number_nodes="2" number_distributions="60" number_distributions_per_node="30">    <sql>select      l_returnflag,      l_linestatus,      sum(l_quantity) as sum_qty,      sum(l_extendedprice) as sum_base_price,      sum(l_extendedprice * (1 - l_discount)) as sum_disc_price,      sum(l_extendedprice * (1 - l_discount) * (1 + l_tax)) as sum_charge,      avg(l_quantity) as avg_qty,      avg(l_extendedprice) as avg_price,      avg(l_discount) as avg_disc,      count_big(*) as count_order  from      lineitem  where      l_shipdate &lt;= dateadd(day,-90,cast ('1998-12-01' as date))  group by      l_returnflag,      l_linestatus  order by      l_returnflag,      l_linestatus</sql>    <materialized_view_candidates>      
	<materialized_view_candidates with_constants="False">CREATE MATERIALIZED VIEW View1 WITH (DISTRIBUTION = HASH([Expr0])) AS  SELECT [tpch].[dbo].[lineitem].[l_returnflag] AS [Expr0],         [tpch].[dbo].[lineitem].[l_linestatus] AS [Expr1],         [tpch].[dbo].[lineitem].[l_shipdate] AS [Expr2],         SUM([tpch].[dbo].[lineitem].[l_quantity]) AS [Expr3],         SUM([tpch].[dbo].[lineitem].[l_extendedprice]) AS [Expr4],         SUM([tpch].[dbo].[lineitem].[l_extendedprice]*((1.0000000000000000e+000)-[tpch].[dbo].[lineitem].[l_discount])) AS [Expr5],         SUM([tpch].[dbo].[lineitem].[l_extendedprice]*((1.0000000000000000e+000)-[tpch].[dbo].[lineitem].[l_discount])*((1.0000000000000000e+000)+[tpch].[dbo].[lineitem].[l_tax])) AS [Expr6],         AVG([tpch].[dbo].[lineitem].[l_quantity]) AS [Expr7],         AVG([tpch].[dbo].[lineitem].[l_extendedprice]) AS [Expr8],         AVG([tpch].[dbo].[lineitem].[l_discount]) AS [Expr9],         COUNT_BIG(*) AS [Expr10]  FROM [dbo].[lineitem]  GROUP BY [tpch].[dbo].[lineitem].[l_returnflag],           [tpch].[dbo].[lineitem].[l_linestatus],           [tpch].[dbo].[lineitem].[l_shipdate]</materialized_view_candidates>      <materialized_view_candidates with_constants="True">CREATE MATERIALIZED VIEW View2 WITH (DISTRIBUTION = HASH([Expr0])) AS  SELECT [tpch].[dbo].[lineitem].[l_returnflag] AS [Expr0],         [tpch].[dbo].[lineitem].[l_linestatus] AS [Expr1],         SUM([tpch].[dbo].[lineitem].[l_quantity]) AS [Expr2],         SUM([tpch].[dbo].[lineitem].[l_extendedprice]) AS [Expr3],         SUM([tpch].[dbo].[lineitem].[l_extendedprice]*((1.0000000000000000e+000)-[tpch].[dbo].[lineitem].[l_discount])) AS [Expr4],         SUM([tpch].[dbo].[lineitem].[l_extendedprice]*((1.0000000000000000e+000)-[tpch].[dbo].[lineitem].[l_discount])*((1.0000000000000000e+000)+[tpch].[dbo].[lineitem].[l_tax])) AS [Expr5],         AVG([tpch].[dbo].[lineitem].[l_quantity]) AS [Expr6],         AVG([tpch].[dbo].[lineitem].[l_extendedprice]) AS [Expr7],         AVG([tpch].[dbo].[lineitem].[l_discount]) AS [Expr8],         COUNT_BIG(*) AS [Expr9]  FROM [dbo].[lineitem]  WHERE [tpch].[dbo].[lineitem].[l_shipdate]&lt;='1998-09-02'  GROUP BY [tpch].[dbo].[lineitem].[l_returnflag],           [tpch].[dbo].[lineitem].[l_linestatus]</materialized_view_candidates>    </materialized_view_candidates>    <dsql_operations total_cost="0" total_number_operations="1">      <dsql_operation operation_type="RETURN">        <location distribution="AllDistributions" />        <select>SELECT [T1_1].[Expr0] AS [Expr0], [T1_1].[Expr1] AS [Expr1], [T1_1].[col4] AS [col], [T1_1].[col5] AS [col1], [T1_1].[col6] AS [col2], [T1_1].[col7] AS [col3], [T1_1].[col] AS [col4], [T1_1].[col1] AS [col5], [T1_1].[col2] AS [col6], [T1_1].[col3] AS [col7] FROM (SELECT CASE   WHEN ([T2_1].[col] = CAST ((0) AS BIGINT)) THEN CAST (NULL AS FLOAT)   ELSE ([T2_1].[col1] / CONVERT (FLOAT, [T2_1].[col], 0))  END AS [col], CASE   WHEN ([T2_1].[col] = CAST ((0) AS BIGINT)) THEN CAST (NULL AS FLOAT)   ELSE ([T2_1].[col2] / CONVERT (FLOAT, [T2_1].[col], 0))  END AS [col1], CASE   WHEN ([T2_1].[col] = CAST ((0) AS BIGINT)) THEN CAST (NULL AS FLOAT)   ELSE ([T2_1].[col3] / CONVERT (FLOAT, [T2_1].[col], 0))  END AS [col2], [T2_1].[col] AS [col3], [T2_1].[Expr0] AS [Expr0], [T2_1].[Expr1] AS [Expr1], [T2_1].[col1] AS [col4], [T2_1].[col2] AS [col5], [T2_1].[col4] AS [col6], [T2_1].[col5] AS [col7] FROM (SELECT ISNULL([T3_1].[col], CONVERT (BIGINT, 0, 0)) AS [col], [T3_1].[col1] AS [col1], [T3_1].[col2] AS [col2], [T3_1].[col5] AS [col3], [T3_1].[Expr0] AS [Expr0], [T3_1].[Expr1] AS [Expr1], [T3_1].[col3] AS [col4], [T3_1].[col4] AS [col5] FROM (SELECT SUM([T4_1].[Expr7_sum_count]) AS [col], SUM([T4_1].[Expr3]) AS [col1], SUM([T4_1].[Expr4]) AS [col2], SUM([T4_1].[Expr5]) AS [col3], SUM([T4_1].[Expr6]) AS [col4], SUM([T4_1].[Expr9_sum]) AS [col5], [T4_1].[Expr0] AS [Expr0], [T4_1].[Expr1] AS [Expr1] FROM (SELECT [T5_1].[Expr1] AS [Expr1], [T5_1].[Expr0] AS [Expr0], [T5_1].[Expr3] AS [Expr3], [T5_1].[Expr4] AS [Expr4], [T5_1].[Expr5] AS [Expr5], [T5_1].[Expr6] AS [Expr6], [T5_1].[Expr7_sum_count] AS [Expr7_sum_count], [T5_1].[Expr9_sum] AS [Expr9_sum] FROM [tpch].[dbo].[View1] AS T5_1 WHERE ([T5_1].[Expr2] &lt;= CAST ('09-02-1998' AS DATE))) AS T4_1 GROUP BY [T4_1].[Expr0], [T4_1].[Expr1]) AS T3_1) AS T2_1 WHERE ([T2_1].[col] != CAST ((0) AS BIGINT))) AS T1_1 ORDER BY [T1_1].[Expr0] ASC, [T1_1].[Expr1] ASC  OPTION (MAXDOP 2)</select>      </dsql_operation>    </dsql_operations>  </dsql_query>

	/*
select count(*) from [dbo].[lineitem_load]
insert into lineitem select * from [dbo].[lineitem_load]
	*/
