

create proc dbo.Create_cache_DMV
as
begin

DECLARE @sSQL varchar(8000);

if exists (select 1 from sys.schemas s inner join sys.tables t on s.schema_id = t.schema_id 
where s.name =   'dbo' and t.name = 'sys_schemas' )
BEGIN  set @sSQL = 'DROP TABLE [dbo].[sys_schemas];'  EXEC (@sSQL);  END

create table dbo.sys_schemas with (distribution=round_robin) as select * FROM sys.schemas; 

if exists (select 1 from sys.schemas s inner join sys.tables t on s.schema_id = t.schema_id 
where s.name =   'dbo' and t.name = 'sys_tables' )
BEGIN  set @sSQL = 'DROP TABLE [dbo].[sys_tables];'  EXEC (@sSQL);  END

create table dbo.sys_tables with (distribution=round_robin) as select * FROM sys.tables 

if exists (select 1 from sys.schemas s inner join sys.tables t on s.schema_id = t.schema_id 
where s.name =   'dbo' and t.name = 'sys_pdw_table_mappings' )
BEGIN  set @sSQL = 'DROP TABLE [dbo].[sys_pdw_table_mappings];'  EXEC (@sSQL);  END

create table dbo.sys_pdw_table_mappings with (distribution=round_robin) as select * FROM sys.pdw_table_mappings 

if exists (select 1 from sys.schemas s inner join sys.tables t on s.schema_id = t.schema_id 
where s.name =   'dbo' and t.name = 'sys_pdw_nodes_tables' )
BEGIN  set @sSQL = 'DROP TABLE [dbo].[sys_pdw_nodes_tables];'  EXEC (@sSQL);  END

create table dbo.sys_pdw_nodes_tables with (distribution=round_robin) as select * FROM sys.pdw_nodes_tables

if exists (select 1 from sys.schemas s inner join sys.tables t on s.schema_id = t.schema_id 
where s.name =   'dbo' and t.name = 'sys_dm_pdw_nodes_db_partition_stats' )
BEGIN  set @sSQL = 'DROP TABLE [dbo].[sys_dm_pdw_nodes_db_partition_stats];'  EXEC (@sSQL);  END

create table dbo.sys_dm_pdw_nodes_db_partition_stats with (distribution=round_robin) as select * FROM sys.dm_pdw_nodes_db_partition_stats 

if exists (select 1 from sys.schemas s inner join sys.tables t on s.schema_id = t.schema_id 
where s.name =   'dbo' and t.name = 'sys_indexes' )
BEGIN  set @sSQL = 'DROP TABLE [dbo].[sys_indexes];'  EXEC (@sSQL);  END

create table dbo.[sys_indexes]  with (distribution=round_robin, heap) as select * FROM sys.indexes 

if exists (select 1 from sys.schemas s inner join sys.tables t on s.schema_id = t.schema_id 
where s.name =   'dbo' and t.name = 'sys_pdw_table_distribution_properties' )
BEGIN  set @sSQL = 'DROP TABLE [dbo].[sys_pdw_table_distribution_properties];'  EXEC (@sSQL);  END

create table dbo.sys_pdw_table_distribution_properties with (distribution=round_robin) as select * FROM sys.pdw_table_distribution_properties 

if exists (select 1 from sys.schemas s inner join sys.tables t on s.schema_id = t.schema_id 
where s.name =   'dbo' and t.name = 'sys_dm_pdw_nodes' )
BEGIN  set @sSQL = 'DROP TABLE [dbo].[sys_dm_pdw_nodes];'  EXEC (@sSQL);  END

create table dbo.sys_dm_pdw_nodes with (distribution=round_robin) as select * FROM  sys.dm_pdw_nodes 

if exists (select 1 from sys.schemas s inner join sys.tables t on s.schema_id = t.schema_id 
where s.name =   'dbo' and t.name = 'sys_dm_pdw_nodes' )
BEGIN  set @sSQL = 'DROP TABLE [dbo].[sys_dm_pdw_nodes];'  EXEC (@sSQL);  END

create table dbo.sys_pdw_distributions with (distribution=round_robin) as select * FROM  sys.pdw_distributions 

if exists (select 1 from sys.schemas s inner join sys.tables t on s.schema_id = t.schema_id 
where s.name =   'dbo' and t.name = 'sys_pdw_column_distribution_properties' )
BEGIN  set @sSQL = 'DROP TABLE [dbo].[sys_pdw_column_distribution_properties];'  EXEC (@sSQL);  END

create table dbo.sys_pdw_column_distribution_properties with (distribution=round_robin) as select * FROM  sys.pdw_column_distribution_properties 

if exists (select 1 from sys.schemas s inner join sys.tables t on s.schema_id = t.schema_id 
where s.name =   'dbo' and t.name = 'sys_columns' )
BEGIN  set @sSQL = 'DROP TABLE [dbo].[sys_columns];'  EXEC (@sSQL);  END

create table dbo.sys_columns with (distribution=round_robin) as select * FROM  sys.columns c

end