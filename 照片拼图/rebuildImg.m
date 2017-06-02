function res = rebuildImg(imgs,IND,TS,outFile)
[bm,bn,~]=size(imgs{1});
[M,N]=size(IND);
rm=bm*M;
rn=bn*N;

fprintf('正在重建...\n');
tic
res=zeros([rm,rn,3],'uint8');
for i=1:M
    for j=1:N
         rInd=(i-1)*bm+(1:bm);
         cInd=(j-1)*bn+(1:bn);
         res(rInd,cInd,:)=getImg(imgs{IND(i,j)},TS{i,j});
    end
end
toc

fprintf('保存图片中...\n');
tic
imwrite(res,outFile);
toc
end