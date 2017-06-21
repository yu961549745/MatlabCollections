function fs = getFiles(path,reg)
% 获取文件夹下所有文件
% 并且能够通过正则表达式进行过滤
if nargin<2
    reg='';
end
fs=dir(path);
fs=arrayfun(@(f){fullfile(path,f.name)},fs(3:end));
if ~isempty(reg)
    ind=cellfun(@(c)~isempty(regexp(c,reg,'once')),fs);
    fs=fs(ind);
end
end
