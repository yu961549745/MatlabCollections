function insert_cells(conn,varargin)
% 后续参数为 data type tbnm 的重复
if mod(length(varargin),3)~=0
    error('invalid input parameters.');
end
for k=1:length(varargin)/3
    insert_cell(conn,varargin{3*k-2},varargin{3*k-1},varargin{3*k});
end
end
function insert_cell(conn,data,type,tbnm)
cols=data(1,:);
data(1,:)=[];
sql=gen_table(tbnm,cols,type);
exec(conn,sprintf('drop table if exists %s;',tbnm));
exec(conn,sql);
insert(conn,tbnm,cols,data);
end
function sql = gen_table(tbnm,cols,type)
tmap=containers.Map({'c','d'},{'text','double'});
sql=[cols(:)';arrayfun(@(c){tmap(c)},type)];
sql=sprintf('%s %s,',sql{:});
sql=sprintf('create table %s( %s );',tbnm,sql(1:(end-1)));
end