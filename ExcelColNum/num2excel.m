function s = num2excel(n)
s="";
while n>0
    r=mod(n,26);
    if r==0
        r=26;
    end
    s=char('A'+r-1)+s;
    n=(n-r)/26;
end
s=char(s);
end