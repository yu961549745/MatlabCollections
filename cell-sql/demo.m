clc,clear,close all;
javaaddpath('sqlite.jar');
data={
    'A','B';
    'a',1;
    'a',2;
    'b',1;
    'b',3;
    'c',4;
    'a',4};
cells_sql(data,'cd','tmp','select A,max(B) from tmp group by A order by A')
cells_sql(data,'cd','tmp','select B,A from tmp order by B,A')
