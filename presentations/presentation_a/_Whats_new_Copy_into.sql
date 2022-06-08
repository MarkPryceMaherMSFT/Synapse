
drop table [dbo].[Copy_into_example_a]

CREATE TABLE [dbo].[Copy_into_example_f]
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
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	HEAP
)
GO


COPY INTO [dbo].[Copy_into_example_a] 
FROM 'https://publictpchdata.blob.core.windows.net/public/monster/temp/1000000/csv/QID513791_20220305_225654_0.txt'
with (
	FILE_TYPE = 'CSV',
    CREDENTIAL=(IDENTITY= 'Shared Access Signature', SECRET='sv=2020-08-04&ss=bfqt&srt=sco&sp=rwdlacupx&se=2022-12-21T05:54:22Z&st=2022-05-20T20:54:22Z&spr=https&sig=spMFngRssK3LnmcKgQ%2BPldEPvcxJL6Ok3MFsGcu0UYE%3D')
	)

select count_big(*) from [dbo].[Copy_into_example_a] ;


drop table [dbo].[Copy_into_example_b]
drop table [dbo].[Copy_into_example_c]


---- doesn't work, not sure why.
COPY INTO [dbo].[Copy_into_example_b] 
FROM 'https://publictpchdata.blob.core.windows.net/public/monster/temp/1000000/csv/QID513791_20220305_225654_0.txt'
with (
	FILE_TYPE = 'CSV',
    CREDENTIAL=(IDENTITY= 'Shared Access Signature', SECRET='sv=2020-08-04&ss=bfqt&srt=sco&sp=rwdlacupx&se=2022-12-21T05:54:22Z&st=2022-05-20T20:54:22Z&spr=https&sig=spMFngRssK3LnmcKgQ%2BPldEPvcxJL6Ok3MFsGcu0UYE%3D')
	,AUTO_CREATE_TABLE = 'ON'
	)

	COPY INTO [dbo].[Copy_into_example_c] 
FROM 'https://publictpchdata.blob.core.windows.net/public/monster/temp/1000000/parquet/QID513670_20220305_225603_0.parq.gz'
with (
	FILE_TYPE = 'Parquet',
    CREDENTIAL=(IDENTITY= 'Shared Access Signature', SECRET='sv=2020-08-04&ss=bfqt&srt=sco&sp=rwdlacupx&se=2022-12-21T05:54:22Z&st=2022-05-20T20:54:22Z&spr=https&sig=spMFngRssK3LnmcKgQ%2BPldEPvcxJL6Ok3MFsGcu0UYE%3D')
	,AUTO_CREATE_TABLE = 'ON'
	)

/*


CREATE TABLE [dbo].[Copy_into_example_a]
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
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	HEAP
)
GO

CREATE TABLE [dbo].[Copy_into_example_c]
(
	[c_custkey] [bigint] NULL,
	[c_name] [varchar](max) NULL,
	[c_address] [varchar](max) NULL,
	[c_nationkey] [int] NULL,
	[c_phone] [varchar](max) NULL,
	[c_acctbal] [float] NULL,
	[c_mktsegment] [varchar](max) NULL,
	[c_comment] [varchar](max) NULL
)
WITH
(
	DISTRIBUTION = ROUND_ROBIN,
	HEAP
)
GO

*/
