-- round robin?
-- is it really a round robin

/*
-- https://docs.microsoft.com/en-us/azure/synapse-analytics/sql-data-warehouse/sql-data-warehouse-tables-distribute

A round-robin distributed table distributes table rows 
evenly across all distributions. 
The assignment of rows to distributions is random. 
Unlike hash-distributed tables, rows with equal values are not 
guaranteed to be assigned to the same distribution.
*/
/*
drop table [dbo].[round_robin_test1] 

truncate table [dbo].[round_robin_test1] 

create table [dbo].[round_robin_test1]  
with ( distribution = round_robin) as select * from customer where 1=0

--- Shhhh - its really 60 tables.
select object_id, * from sys.tables where name like '%round_robin_test1%'

select * from   sys.pdw_table_mappings where object_id in (select object_id from sys.tables where name like '%round_robin_test1%')

insert into [dbo].[round_robin_test1] select top 121 * from customer

truncate table [dbo].[round_robin_test1] 

insert into [dbo].[round_robin_test1] select top 500  * from customer

truncate table [dbo].[round_robin_test1] 

print  60 * 121
-- 60 * 74 = 7260

insert into [dbo].[round_robin_test1] select top 7260  * from customer
truncate table [dbo].[round_robin_test1] 

insert into [dbo].[round_robin_test1] select top (7260 + 121)  * from supplier
*/


SELECT
    [Entity Name]                   = QUOTENAME(s.name) + '.' + QUOTENAME(t.name),
    [Current Distribution Method]   = tp.distribution_policy_desc,
    [Current Distribution Column]   = c.name,
    [Distribution Name]             = di.name,
    [Row Count]                     = nps.row_count
from
    sys.schemas AS s
    INNER JOIN sys.tables AS t
        ON s.schema_id = t.schema_id
    INNER JOIN sys.indexes AS i
        ON t.object_id = i.object_id
        AND i.index_id <= 1
    INNER JOIN sys.pdw_table_distribution_properties AS tp
        ON  t.object_id = tp.object_id
    INNER JOIN sys.pdw_table_mappings AS tm
        ON t.object_id = tm.object_id
    INNER JOIN sys.pdw_nodes_tables AS nt
        ON tm.physical_name = nt.name
    INNER JOIN sys.dm_pdw_nodes AS pn
        ON nt.pdw_node_id = pn.pdw_node_id
    INNER JOIN sys.pdw_distributions AS di
        ON nt.distribution_id = di.distribution_id
    INNER JOIN
    (
        SELECT
            object_id                       = object_id,
            pdw_node_id                     = pdw_node_id,
            distribution_id                 = distribution_id,
            row_count                       = SUM(row_count),
            in_row_data_page_count          = SUM(in_row_data_page_count),
            row_overflow_used_page_count    = SUM(row_overflow_used_page_count),
            lob_used_page_count             = SUM(lob_used_page_count),
            reserved_page_count             = SUM(reserved_page_count),
            used_page_count                 = SUM(used_page_count)
        FROM
            sys.dm_pdw_nodes_db_partition_stats
        GROUP BY
            object_id,
            pdw_node_id,
            distribution_id
    ) AS nps
        ON nt.object_id = nps.object_id
        AND nt.pdw_node_id = nps.pdw_node_id
        AND nt.distribution_id = nps.distribution_id
    LEFT JOIN
    (
        SELECT
            object_id,
            column_id
        FROM
            sys.pdw_column_distribution_properties
        WHERE
            distribution_ordinal = 1
    ) AS cdp
        ON t.object_id = cdp.object_id
    LEFT JOIN sys.columns as c with(nolock)
        ON cdp.object_id = c.object_id
        AND cdp.column_id = c.column_id
WHERE  QUOTENAME(s.name) + '.' + QUOTENAME(t.name)  = '[dbo].[round_robin_test1]' and
    pn.type = 'COMPUTE'
	order by nps.row_count desc;
