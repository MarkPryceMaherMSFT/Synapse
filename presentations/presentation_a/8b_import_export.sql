--
-- export, customer2 nodes, csv , 150000000, 45 seconds  , 14 GB
drop EXTERNAL TABLE polybase_test
CREATE EXTERNAL TABLE polybase_test
WITH (
    LOCATION = 'cluster1/logs/lineitem',
    DATA_SOURCE = [AzureDataLakeStoredemo],  
    FILE_FORMAT = [csv2]
)  
AS
SELECT  * from [dbo].[lineitem]