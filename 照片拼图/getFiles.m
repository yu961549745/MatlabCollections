function fs = getFiles(path)
fs=dir(path);
fs=arrayfun(@(x){fullfile(path,x.name)},fs(3:end));
end