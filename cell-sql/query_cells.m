function res = query_cells(conn,varargin)
% 后续参数为 data type tbnm 的重复, 最后一个参数是 sql
if mod(length(varargin)-1,3)~=0
    error('invalid input parameters.');
end
insert_cells(conn,varargin{1:(end-1)});
sql=varargin{end};
sqls=strsplit(sql,';');
sqls(cellfun(@(s)isempty(strtrim(s)),sqls))=[];
for k=1:(length(sqls)-1)
    exec(conn,sqls{k});
end
res=fetch(conn,sqls{end});
end