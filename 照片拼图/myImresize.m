function im=myImresize(im,sz)
[M,N,~]=size(im);
m=sz(1);n=sz(2);
if (M-N)*(m-n)<0
    im=imrotate(im,90);
end
im=keepShapeResize(im,min(m,n));
[M,N,~]=size(im);
if all([M,N]==[m,n])
    return;
end
k1=max(M,N)/min(M,N);
k2=max(m,n)/min(m,n);
if k1<k2
    % 比例不足采用居中轴对称补全
    im=imAppend(im,m,n);
else
    % 比例有余采用居中裁剪
    im=keepShapeResize(im,min(m,n));
    im=centerCut(im,m,n);
end
end
function im = keepShapeResize(im,x)
[m,n,~]=size(im);
im=imresize(im,x/min(m,n));
end
function im = centerCut(im,m,n)
[M,N,~]=size(im);
sr=floor((M-m)/2)+(1:m);
sc=floor((N-n)/2)+(1:n);
im=im(sr,sc,:);
end
function im = imAppend(im,m,n)
if m>n
    im=imAppendRow(im,m,n);
else
    im=permute(im,[2,1,3]);
    im=imAppendRow(im,n,m);
    im=permute(im,[2,1,3]);
end
end
function im = imAppendRow(im,m,n)
[M,N,~]=size(im);
assert(n==N);

im(m,n,:)=0;

rInd=floor((m-M)/2)+(1:M);
cInd=1:N;
im(rInd,cInd,:)=im(1:M,1:N,:);

urInd=1:(rInd(1)-1);
im(urInd,cInd,:)=im(rInd(flip(urInd)),cInd,:);

drInd=(rInd(end)+1):m;
odrInd=flip(rInd);
im(drInd,cInd,:)=im(odrInd(1:length(drInd)),cInd,:);
end