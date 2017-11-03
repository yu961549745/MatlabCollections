function imCut9(inFile,outPath)
% æ≈π¨∏Ò«–Õº
res=imread(inFile);
if ~exist(outPath,'dir')
    mkdir(outPath);
end
[m,n,~]=size(res);
w=floor(min([m,n])/3);
for i=1:3
    for j=1:3
        rInd=(i-1)*w+(1:w);
        cInd=(j-1)*w+(1:w);
        s=res(rInd,cInd,:);
        imwrite(s,fullfile(outPath,sprintf('%d.JPG',(i-1)*3+j)),'Quality',100);
    end
end
end