clc,clear,close all;
data={'a',1;
    'b',-1;
    'c',3;
    'e',2;
    'd',3};
cellsql(data,{'A','B'},'cd','select * from tmp where B>1 order by B,A','tmp')
