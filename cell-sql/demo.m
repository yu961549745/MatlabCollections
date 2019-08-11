clc,clear,close all;
dbfile='tmp.db';
if exist(dbfile,'file')
    delete(dbfile)
end
conn = sqlite('tmp.db','create');
conn.exec('create table test (name string, value double)');
data={
    'a',1;
    'a',2;
    'b',1;
    'b',3;
    'c',4;
    'a',4};
conn.insert('test',{'name','value'},data)
res = conn.fetch('select name,sum(value) from test group by name');
disp(res)
delete(dbfile)
conn.close()

