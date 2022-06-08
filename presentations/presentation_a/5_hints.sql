/* HINTs */
--https://docs.microsoft.com/en-us/sql/t-sql/queries/hints-transact-sql-query?view=sql-server-ver15#:~:text=%27FORCE_LEGACY_CARDINALITY_ESTIMATION%27%20Forces%20the%20Query%20Optimizer%20to%20use%20Cardinality,Database%20Scoped%20Configuration%20setting%20LEGACY_CARDINALITY_ESTIMATION%20%3D%20ON.%20%27QUERY_OPTIMIZER_COMPATIBILITY_LEVEL_n%27
-- https://docs.microsoft.com/en-us/sql/t-sql/queries/from-transact-sql?view=sql-server-ver15#examples--and
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
	option(MAXDOP 1, 
		label='hint test1', 
		FORCE ORDER, ----- ONLY use when there are lots of tables
					----- stops the optimizer trying lots of options
		USE HINT ('FORCE_LEGACY_CARDINALITY_ESTIMATION'),
		-- use the old estimation model
		USE HINT('allow_batch_mode'), -- stops plans from going into ROW mode
		USE HINT('ENABLE_PARALLEL_PLAN_PREFERENCE') 
		)



		option(
		label='hint test1', 
		FORCE ORDER, ----- ONLY use when there are lots of tables
					----- stops the optimizer trying lots of options
		USE HINT ('FORCE_LEGACY_CARDINALITY_ESTIMATION')
		)

