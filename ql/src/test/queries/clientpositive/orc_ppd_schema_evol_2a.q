set hive.cli.print.header=true;
set hive.metastore.disallow.incompatible.col.type.changes=false;
set hive.optimize.ppd=false;
set hive.optimize.index.filter=false;
set hive.input.format=org.apache.hadoop.hive.ql.io.CombineHiveInputFormat;



create table unique_1( 
i int, 
d string, 
s string) 
row format delimited 
fields terminated by '|' 
stored as textfile;

load data local inpath '../../data/files/unique_1.txt' into table unique_1;

create table test1 stored as orc as select * from unique_1 order by d;

alter table test1 replace columns (i int, d double, s string);

set hive.optimize.ppd=false;
set hive.optimize.index.filter=false;
set hive.input.format=org.apache.hadoop.hive.ql.io.CombineHiveInputFormat;

select s from test1 where d = -4996703.42;

set hive.input.format=org.apache.hadoop.hive.ql.io.HiveInputFormat;

select s from test1 where d = -4996703.42;

set hive.optimize.ppd=true;
set hive.optimize.index.filter=true;
set hive.input.format=org.apache.hadoop.hive.ql.io.CombineHiveInputFormat;

select s from test1 where d = -4996703.42;

set hive.input.format=org.apache.hadoop.hive.ql.io.HiveInputFormat;

select s from test1 where d = -4996703.42;