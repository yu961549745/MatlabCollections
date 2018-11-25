function s = getMD5(fname)
if ~ischar(fname)
    error('必须输入文件名');
end
if ~exist(fname,'file')
    error('文件不存在: %s',fname);
end
s=char(ecnu.yjt.MessageDigestFuncs.md5(fname));
end