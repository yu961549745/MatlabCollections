clc,clear,close all;
p=rand(100,2);
d=pdist2(p,p);

tic
[x1,f] = wolframTSP(d);
fprintf('min distance = %f \n',f);
% disp(x(:)');
toc

tic
[x2,f] = tsp(d);
fprintf('min distance = %f \n',f);
% disp(x(:)');
toc

