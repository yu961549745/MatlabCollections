function s = getImg(s,t)
for k=1:3
    s(:,:,k)=s(:,:,k)*t(k);
end
end