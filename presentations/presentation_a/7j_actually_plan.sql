SET QUERY_DIAGNOSTICS ON
go
 
SELECT * from tbl;
 
SET QUERY_DIAGNOSTICS OFF
Go



DBCC GET_QUERY_INFO('SELECT * from tbl;')

