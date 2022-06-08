
CREATE EXTERNAL TABLE nation_dump_parquet
WITH (
    LOCATION = 'data_dump/tpch/orc/nation/',
    DATA_SOURCE = [AzureDataLakeStoredemo],  
    FILE_FORMAT = [orcfile1]
)  
AS
SELECT  * from [dbo].[nation]


CREATE EXTERNAL TABLE cust_dump_orc
WITH (
    LOCATION = 'data_dump/tpch/orc/customer/',
    DATA_SOURCE = [AzureDataLakeStoredemo],  
    FILE_FORMAT = [orcfile1]
)  
AS
SELECT  * from [dbo].[customer]

CREATE EXTERNAL TABLE supplier_dump_orc
WITH (
    LOCATION = 'data_dump/tpch/orc/supplier/',
    DATA_SOURCE = [AzureDataLakeStoredemo],  
    FILE_FORMAT = [orcfile1]
)  
AS
SELECT  * from [dbo].supplier



CREATE EXTERNAL TABLE line_item_dump_orc
WITH (
    LOCATION = 'data_dump/tpch/orc/lineitem/',
    DATA_SOURCE = [AzureDataLakeStoredemo],  
    FILE_FORMAT = [orcfile1]
)  
AS
SELECT  * from [dbo].[lineitem]



CREATE EXTERNAL TABLE orders_dump_orc
WITH (
    LOCATION = 'data_dump/tpch/orc/orders/',
    DATA_SOURCE = [AzureDataLakeStoredemo],  
    FILE_FORMAT = [orcfile1]
)  
AS
SELECT  * from [dbo].[orders]

CREATE EXTERNAL TABLE part_dump_orc
WITH (
    LOCATION = 'data_dump/tpch/orc/part/',
    DATA_SOURCE = [AzureDataLakeStoredemo],  
    FILE_FORMAT = [orcfile1]
)  
AS
SELECT  * from [dbo].[part]

CREATE EXTERNAL TABLE partsupp_dump_orc
WITH (
    LOCATION = 'data_dump/tpch/orc/partsupp/',
    DATA_SOURCE = [AzureDataLakeStoredemo],  
    FILE_FORMAT = [orcfile1]
)  
AS
SELECT  * from [dbo].[partsupp]



