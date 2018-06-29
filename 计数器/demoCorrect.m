clc,clear,close all;
x=unidrnd(10,[10,1]);
[ux1,nx1]=mapCounter(x);
[ux1,ind]=sort(ux1);
nx1=nx1(ind);

[ux2,nx2]=sortCounter(x);
[ux3,nx3]=qsortCounter(x);
disp(isequal(ux1,ux2)&&isequal(ux2,ux3));
disp(isequal(nx1,nx2)&&isequal(nx2,nx3));
accumarray(x(:),1)% …Ò√ÿ”√∑®
