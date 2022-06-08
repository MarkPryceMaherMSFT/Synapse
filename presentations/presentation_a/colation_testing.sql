select * from fn_helpcollations()
where name like 'Latin1_General_100_BIN2_UTF8'

Latin1_General_100_BIN2_UTF8


create table col_test 
(
	cola varchar(50),
	colb varchar(50) collate Latin1_General_100_BIN2_UTF8
)
create table col_test 
(
	cola varchar(50),
	colb varchar(50) collate Latin1_General_100_BIN2_UTF8
)

create table col_test 
(
	cola varchar(50),
	colb varchar(50) collate Latin1_General_BIN
)


CREATE DATABASE TestDW COLLATE Latin1_General_BIN
( EDITION = 'datawarehouse', SERVICE_OBJECTIVE = 'DW1000');