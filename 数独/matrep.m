function B = matrep(B,x)
ind=arrayfun(@(k)all(B(k,[1,2])==x([1,2])),(1:size(B,1)));
ind=find(ind);
if isempty(ind)
    B=[B;x];
else
    B(ind,:)=x;
end
end