--
-- export, customer2 nodes, csv , 150,000,000, 45 seconds  , 14 GB
drop EXTERNAL TABLE polybase_test
CREATE EXTERNAL TABLE polybase_test
WITH (
    LOCATION = 'cluster1/logs/customer/run1',
    DATA_SOURCE = [AzureDataLakeStoredemo],  
    FILE_FORMAT = [csv2]
)  
AS
SELECT  * from [dbo].[customer]

-- query the filesystem
select count(*) from polybase_test --38 seconds

-- import rows from a file.
-- 47 seconds to import 14 GB.
drop table polybase_test_tbl;

create table polybase_test_tbl with ( distribution = round_robin, heap ) 
as select * from polybase_test;



