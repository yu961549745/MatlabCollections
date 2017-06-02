function [IND,TS] = buildImg(im,imgs,usageRate,gifName,showPeriod)
[bm,bn,~]=size(imgs{1});
im=im2double(im);
res=zeros(size(im));
[m,n,~]=size(im);
M=m/bm;
N=n/bn;

IND=zeros(M,N);
TS=cell(M,N);
L=length(imgs);
counts=zeros(1,L);
restImgInd=1:L;
maxCount=ceil(M*N/L/usageRate);

p=randperm(M*N);
[IS,JS]=ind2sub([M,N],p);

figure('Position',[676,33,691,650]);
myImshow(res);
writeGif(gifName,res);
drawnow;
for k=1:M*N
    i=IS(k);j=JS(k);
    rInd=(i-1)*bm+(1:bm);
    cInd=(j-1)*bn+(1:bn);
    T=im(rInd,cInd,:);
    [ind,t]=mexImgsMatch(imgs,T);
    res(rInd,cInd,:)=getImg(imgs{ind},t);
    id=restImgInd(ind);
    IND(i,j)=id;
    TS{i,j}=t;
    counts(id)=counts(id)+1;
    if counts(id)>=maxCount
        imgs(ind)=[];
        restImgInd(ind)=[];
    end
    if mod(k,showPeriod)==0
        myImshow(res);
        writeGif(gifName,res);
        drawnow;
    end
end
myImshow(res);
writeGif(gifName,res);
drawnow;
end
function writeGif(fname,im)
if isempty(fname)
    return;
end
[ind,cm]=rgb2ind(im,256);
if ~exist(fname,'file')
    imwrite(ind,cm,fname);
else
    imwrite(ind,cm,fname,'WriteMode','append');
end
end
