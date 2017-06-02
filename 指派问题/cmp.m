clc,clear,close all;
N=10;
D=rand(N,N);

tic
[x1,c]=assignmentProblemAuctionAlgorithm(D);
toc

tic
[x2,c]=munkres(D);
toc

isequal(x1,x2)