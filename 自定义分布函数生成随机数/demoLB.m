clc,clear,close all;
x=rand([1,10000000]);
y=linspace(0,1,1000001);
lb1=getLB(x,y);
lb2=mgetLB(x,y);
isequal(lb1(:),lb2(:))