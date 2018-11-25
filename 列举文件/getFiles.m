function fs = getFiles(path,reg,exReg)
% 获取文件夹下所有文件
% 并且能够通过正则表达式进行过滤
if nargin<3
    % 默认无视 windows 下的 db 文件
    % 和 mac 下的 . 开头的索引文件
    exReg='(.*\.db)|(^\..*)';
    if nargin<2
        reg='';
    end
end
% 按文件名筛选
sfs=dir(path);
fs=arrayfun(@(f){f.name},sfs);
fds=arrayfun(@(f){f.folder},sfs);
dfs=arrayfun(@(f)f.isdir,sfs);
fs=fs(~dfs);
fds=fds(~dfs);
if ~isempty(reg)
    ind=cellfun(@(s)~isempty(regexp(s,reg,'once')),fs);
else
    ind=true(size(fs));
end
if ~isempty(exReg)
    exInd=cellfun(@(s)~isempty(regexp(s,exReg,'once')),fs);
else
    exInd=false(size(fs));
end
fs=fs(ind&(~exInd));
fds=fds(ind&(~exInd));
fs=cellfun(@(p,f){fullfile(p,f)},fds,fs);
end
