function fs = getFiles(path,reg,exReg)
% 获取文件夹下所有文件
% 并且能够通过正则表达式进行过滤
if nargin<3
    % 默认无视 windows 下的 db 文件
    % 和 mac 下的 . 开头的索引文件
    % 以及 . 和 .. 
    exReg='(.*\.db)|(^\.{1,2}.*)';
    if nargin<2
        reg='';
    end
end
% 按文件名筛选
fs=dir(path);
if isempty(fs)
    error('no file found.');
end
if ~isempty(reg)
    ind=arrayfun(@(s)~isempty(regexp(s.name,reg,'once')),fs);
else
    ind=true(size(fs));
end
if ~isempty(exReg)
    exInd=arrayfun(@(s)~isempty(regexp(s.name,exReg,'once')),fs);
else
    exInd=false(size(fs));
end
fs=fs(ind&(~exInd));
% 加上路径
fs=arrayfun(@(f){fullfile(f.folder,f.name)},fs);
end
