function xls_merge_write(fname,x,rs,cs)
% 导出cell到Excel并合并单元格
% 输入：
%   fname   保存文件名
%   x       保存的数据，必须是cell
%   rs      需要合并的行
%   cs      需要合并的列
% 合并规则：
%   1. 先按行合并，在指定行内，cell=[]或NaN，则向左合并
%   2. 在按列合并，在指定列内，cell=[]或NaN，则向上合并
%   +. 这么写不能合并一个矩阵块
e=actxserver('Excel.Application');% Excel
w=e.Workbooks.Add;% Workbook
s=get(e.ActiveWorkbook.Sheets,'Item',1);% Sheet
[m,n]=size(x);
[startCell,stopCell]=getRange(s,1,1,m,n);
r=get(s,'Range',startCell,stopCell);
r.Value=x;
arrayfun(@(r)merge_row(s,r,x(r,:)),rs);
arrayfun(@(c)merge_col(s,c,x(:,c)),cs);
path=abspath(fname);
if exist(path,'file')
    delete(path);
end
SaveAs(w,path);
Close(w);
Quit(e);
delete(e);
end
%--------------------------------------------------------------------------
function [S,E]=getRange(s,i1,j1,i2,j2)
S=get(s.Cells,'Item',i1,j1);
E=get(s.Cells,'Item',i2,j2);
end
%--------------------------------------------------------------------------
function merge_col(s,col,data)
n=length(data);
data=data(:);
id=cellfun(@(x)~isempty(x)&&any(~isnan(x)),data);
st=[find(id);n+1];
m=length(st)-1;
for k=1:m
    if st(k+1)-st(k)>1
        [S,E]=getRange(s,st(k),col,st(k+1)-1,col);
        r=get(s,'Range',S,E);
        r.MergeCells=1;
    end
end
end
%--------------------------------------------------------------------------
function merge_row(s,row,data)
n=length(data);
data=data(:);
id=cellfun(@(x)~isempty(x)&&any(~isnan(x)),data);
st=[find(id);n+1];
m=length(st)-1;
for k=1:m
    if st(k+1)-st(k)>1
        [S,E]=getRange(s,row,st(k),row,st(k+1)-1);
        r=get(s,'Range',S,E);
        r.MergeCells=1;
    end
end
end
%--------------------------------------------------------------------------
function [absolutepath]=abspath(partialpath)
% parse partial path into path parts
[pathname, filename, ext] = fileparts(partialpath);
% no path qualification is present in partial path; assume parent is pwd, except
% when path string starts with '~' or is identical to '~'.
if isempty(pathname) && partialpath(1) ~= '~'
    Directory = pwd;
elseif isempty(regexp(partialpath,'^(.:|\\\\|/|~)','once'));
    % path did not start with any of drive name, UNC path or '~'.
    Directory = [pwd,filesep,pathname];
else
    % path content present in partial path; assume relative to current directory,
    % or absolute.
    Directory = pathname;
end
% construct absolute filename
absolutepath = fullfile(Directory,[filename,ext]);
end