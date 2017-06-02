function [bw,mask] = cutBw(bw,mask)
if nargin<2
    mask=bw;
end
[sr,er]=findRange(mask,2);
bw=bw(sr:er,:,:);
mask=mask(sr:er,:,:);
[sc,ec]=findRange(mask,1);
bw=bw(:,sc:ec,:);
mask=mask(:,sc:ec,:);
end
function [s,e] = findRange(bw,dim)
x=any(bw,dim);
s=find(x,1,'first');
e=find(x,1,'last');
end