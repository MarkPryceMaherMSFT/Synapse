/*
Showing the combinations of round robin, replicated and hash tables
We can see which ones shuffle data and performance oif query without data movement
*/
/*
Creating RR copy of the table
create table part_rr with (distribution=round_robin) as select * from part;
create table partsupp_rr with (distribution=round_robin) as select * from partsupp;
create table part_d with (distribution=replicate) as select * from part;


select * from sys.dm_pdw_exec_requests order by start_time desc;

select * from sys.dm_pdw_exec_requests 
where status in ('Running') order by start_time desc;

select * from sys.dm_pdw_request_steps where request_id in ('QID6523432')

select * from sys.dm_pdw_sql_requests where request_id in ('QID6523432')
order by step_index desc

*/
select count_big(*) from part; -- 200,000,000
select count_big(*) from partsupp -- 800,000,000

-- joining two round_robin tables -- DONT RUN - it takes a while - (shuffling)
select * from part_rr p inner join partsupp_rr ps on p.p_partkey = ps.ps_partkey

--25 seconds (remember to turn off RSC)
select count_big(*) from (
select * from part_rr p inner join partsupp_rr ps on p.p_partkey = ps.ps_partkey
) a

-- joining a hash with a RR (shuffling)
select * from part_rr p inner join partsupp ps on p.p_partkey = ps.ps_partkey
select * from part p inner join partsupp_rr ps on p.p_partkey = ps.ps_partkey

-- 13 seconds
select count_big(*) from (
select * from part_rr p inner join partsupp ps on p.p_partkey = ps.ps_partkey
) a

-- both tables HASH ( no shuffling )
select * from part p inner join partsupp ps on p.p_partkey = ps.ps_partkey

-- 3 seconds
select count_big(*) from (
select * from part p inner join partsupp ps on p.p_partkey = ps.ps_partkey
) a

-- both tables RR with replicated (first run: shuffle on both) 
select * from part_d p inner join partsupp_rr ps on p.p_partkey = ps.ps_partkey

--1:22 seconds (first run) 
select count_big(*) from (
select * from part_d p inner join partsupp_rr ps on p.p_partkey = ps.ps_partkey
) a

-- both distributed  with replicated
select * from part p inner join partsupp_rr ps on p.p_partkey = ps.ps_partkey

--
select count_big(*) from (
select * from part p inner join partsupp_rr ps on p.p_partkey = ps.ps_partkey
) a

