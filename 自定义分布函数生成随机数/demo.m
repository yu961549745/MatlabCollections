clc,clear,close all;
f=@(x)gmmpdf(x,0.5,10,1);
% f=@(x)ggdpdf(x,10,1);
[r,L,U] = pdfrnd(f,[1,100000]);
x=linspace(L,U,1e4);
figure;
hold on;
histogram(r,'Normalization','pdf');
plot(x,f(x));
box on;
axis tight;
