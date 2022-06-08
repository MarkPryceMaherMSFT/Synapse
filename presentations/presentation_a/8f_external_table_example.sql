

CREATE DATABASE SCOPED CREDENTIAL sas10
WITH IDENTITY = 'SHARED ACCESS SIGNATURE',
SECRET = 'secret';

/****** Object:  ExternalDataSource [ds_monster_native5]    Script Date: 20/05/2022 22:03:28 ******/
CREATE EXTERNAL DATA SOURCE [ds_monster_native5] WITH 
(LOCATION = N'wasbs://public@publictpchdata.blob.core.windows.net',
CREDENTIAL = [sas2])
GO

CREATE EXTERNAL DATA SOURCE [ds_monster_native10] WITH 
(LOCATION = N'wasbs://public@publictpchdata.blob.core.windows.net',
CREDENTIAL = [sas10])
GO


CREATE TABLE XXXXX
