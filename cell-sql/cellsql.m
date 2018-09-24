function res = cellsql(data,cols,type,sql,tbnm)
% 在 cell 矩阵中执行 sql 查询语句
% 输入:
%     data  2维 cell 数组
%     cols  数据列名
%     type  数据类型, c=text d=double 
%     sql   sql 语句
%     tbnm  临时表名
% 输出:
%     res 查询结果
% 注意:
%     double 不支持 NaN 和 []
dbfile=sprintf('tmp%f.db',rand());
conn=sqlite(dbfile,'create');
tmap=containers.Map({'c','d'},{'text','double'});
dbct=[cols(:)';arrayfun(@(c){tmap(c)},type)];
dbct=sprintf('%s %s,',dbct{:});
dbct=sprintf('create table %s( %s );',tbnm,dbct(1:(end-1)));
exec(conn,dbct);
insert(conn,tbnm,cols,data);
res=fetch(conn,sql);
close(conn);
delete(dbfile);
end