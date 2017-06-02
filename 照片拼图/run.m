clc,clear,close all;

% 参数设置
inFile='1.jpg';         % 输入图片
outFile='r1.jpg';       % 输出图片
inPath='./lib';         % 图片库
numGrids=70;            % 网格划分数，越大则图片越精细，但是生成图片也会变大
minBlockWidth=16;       % 拼图时的分块大小，越小速度越快
minRebuildWidth=128;    % 重建时的分块大小，越大生成的文件越大
usageRate=1/2.5;        % 图片利用率，越高，画面纯净度越低
gifName='res.gif';      % 保存生成过程为gif，名字为''则不保存
showPeriod=500;         % 生成过程中，每拼图多少张就显示一次


st=tic;

% 图片信息计算
[im,blockSize,rebuildSize] = getParams(...
    inFile,numGrids,minBlockWidth,minRebuildWidth);

% 内存信息计算
fs=getFiles(inPath);
numImgs=length(fs);
rebuildMem=prod(rebuildSize)*numGrids^2*3/1024^2;
imgMem=prod(rebuildSize)*3/1024^2*numImgs;
needMem=rebuildMem+imgMem;
[~,sys]=memory;
restMem=sys.PhysicalMemory.Available/1024^2;
fprintf('需要内存     \t%g M\n',needMem);
fprintf('系统剩余内存 \t%g M\n',restMem);
if needMem>restMem
    error(['内存不足，建议减少numGrids，或者减小minRebuildWidth,',...
        '或者增加minBlockWidth\n']);
end

% 准备图片
fprintf('正在读取图片...\n');
tic;
fs=getFiles(inPath);
imgs=cellfun(@(f){myImresize(imread(f),rebuildSize)},fs);
toc;

% 删除全0图片
fprintf('筛选图片中...\n');
tic
ind=cellfun(@(x)all(x(:)==0),imgs);
imgs(ind)=[];
toc

fprintf('正在生成拼图方块...\n');
tic;
mImgs=cellfun(@(x){im2double(imresize(x,blockSize))},imgs);
toc;

% 拼图
fprintf('正在拼图...\n');
tic
[IND,TS] = buildImg(im,mImgs,usageRate,gifName,showPeriod);
toc

% 重建
res=rebuildImg(imgs,IND,TS,outFile);

f=dir(outFile);
fprintf('输出图片大小为 %.1f M\n',f.bytes/1024^2);


% 九宫格切图上部
tic
fprintf('正在切图...\n');
if ~exist('res','dir')
    mkdir('res');
end
[m,n,~]=size(res);
w=floor(min([m,n])/3);
for i=1:3
    for j=1:3
        rInd=(i-1)*w+(1:w);
        cInd=(j-1)*w+(1:w);
        s=res(rInd,cInd,:);
        imwrite(s,sprintf('./res/%d.jpg',(i-1)*3+j));
    end
end
toc

fprintf('总共用时 %g 秒\n',toc(st));
fprintf('利用图片 %d/%d\n',length(unique(IND(:))),length(imgs));
