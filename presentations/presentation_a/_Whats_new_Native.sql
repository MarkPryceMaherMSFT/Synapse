/*
https://docs.microsoft.com/en-us/azure/synapse-analytics/sql/develop-tables-external-tables?tabs=native#syntax-for-create-external-data-source
*/

drop table [dbo].[whats_new_hadoop_driver]

--drop external table [dbo].[whats_new_hadoop_driver]

CREATE EXTERNAL TABLE [dbo].[whats_new_hadoop_driver]
(
	[c_custkey] [bigint] NULL,
	[c_name] [varchar](25) NULL,
	[c_address] [varchar](40) NULL,
	[c_nationkey] [int] NULL,
	[c_phone] [char](15) NULL,
	[c_acctbal] [float] NULL,
	[c_mktsegment] [char](10) NULL,
	[c_comment] [varchar](117) NULL
)
WITH (DATA_SOURCE = [ds_monster_hadoop],
LOCATION = N'monster/temp/100000000/parquet_snappy',FILE_FORMAT = [parquet],
REJECT_TYPE = VALUE,REJECT_VALUE = 99999)
GO

drop  EXTERNAL TABLE [dbo].[whats_new_native_driver]
CREATE EXTERNAL TABLE [dbo].[whats_new_native_driver]
(
	[c_custkey] [bigint] NULL,
	[c_name] [varchar](25) NULL,
	[c_address] [varchar](40) NULL,
	[c_nationkey] [int] NULL,
	[c_phone] [char](15) NULL,
	[c_acctbal] [float] NULL,
	[c_mktsegment] [char](10) NULL,
	[c_comment] [varchar](117) NULL
)
WITH (DATA_SOURCE = [ds_monster_native10],
LOCATION = N'monster/temp/100000000/parquet_snappy/',FILE_FORMAT = [parquet])
GO

-- 100,000,000

select count(*) from [dbo].[whats_new_hadoop_driver]; 
-- about 30 seconds (dwu100)
-- about 14 seconds (dwu500)
-- about 19 seconds 

select count(*) from [dbo].[whats_new_native_driver]; 
-- about  10 seconds (dwu100)
-- about  3 seconds (dwu500)


---- 800,000,000
select count(*) from [dbo].[whats_new_hadoop_driver]; 
-- about .. seconds (dwu100)
--about 28 seconds ( dwu1000)


select count(*) from [dbo].[whats_new_native_driver]; 
-- about  10 seconds (dwu100)
-- about 4 seconds (dwu1000)


drop table dbo.whats_new_hadoop_driver_test ;
drop table  dbo.whats_new_native_driver_test ;

Create table dbo.whats_new_hadoop_driver_test 
with (distribution = round_robin) as  select * from [dbo].[whats_new_hadoop_driver]
-- about 

Create table dbo.whats_new_native_driver_test 
with (distribution = round_robin) as  select * from [dbo].[whats_new_native_driver]