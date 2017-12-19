function t = readtext(f,encoding)
if nargin<2
    opts={};
else
    opts={'n',encoding};
end
fid=fopen(f,'r',opts{:});
t=textscan(fid,'%[^\n]');
fclose(fid);
t=t{1};
t=sprintf('%s\n',t{:});
end