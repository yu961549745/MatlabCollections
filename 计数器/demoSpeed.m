clc,clear,close all;
% 当ux较多时
% map性能最差
% sort最好
% qsort次之
% mx难得这么快
x=rand([1000000,1]);
tic
[~,~]=mapCounter(x);
toc
tic
[~,~]=sortCounter(x);
toc
tic
[~,~]=qsortCounter(x);
toc
tic
[~,~]=mxCounter(x);
toc
% 当ux较少时
% map和sort差不多
% qsort略差
% mx难得这么快
x=unidrnd(1000,[1000000,1]);
tic
[~,~]=mapCounter(x);
toc
tic
[~,~]=sortCounter(x);
toc
tic
[~,~]=qsortCounter(x);
toc
tic
[~,~]=mxCounter(x);
toc
% 总体来说还是选择sort最好