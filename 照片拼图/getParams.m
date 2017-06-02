function [im,blockSize,rebuildSize] = getParams(inFile,numGrids,minBlockWidth,minRebuildWidth)
% 参数估计
% 分块大小保持和图片大小具有相同的比例
im=imread(inFile);
imSize=imsize(im);

blockSize=round(imSize*(minBlockWidth/min(imSize)));
imSize=blockSize*numGrids;
im=imresize(im,imSize);

rebuildSize=round(blockSize*(minRebuildWidth/min(blockSize)));
end
%--------------------------------------------------------------------------
function sz = imsize(im)
sz=size(im);
sz=sz(1:2);
end