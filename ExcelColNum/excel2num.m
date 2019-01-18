function r = excel2num(s)
n=length(s);
r=0;
for k=1:n
    r=r*26+s(k)-'A'+1;
end
end