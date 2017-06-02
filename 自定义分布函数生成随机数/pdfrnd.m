function [r,L,U] = pdfrnd(pdf,sz,m,e,mu)
% 自定义pdf生成连续的随机数
% 随机数范围为(-inf,inf)
% 采用区间离散化的方法，找到0-1分布的随机变量所属的区间，生成区间内的一个均匀分布的随机数
% 输入：
%   pdf 概率密度函数，值关于自变量，没有参数
%   sz  随机数矩阵大小
%   m   pdf采样点个数，可选，默认1e4
%   e   pdf采样点上下界处的pdf值，默认1e-3
%   mu  随机数均值，可选，默认0
% 输出：
%   r   满足条件的随机数矩阵
if nargin<5
    mu=0;
    if nargin<4
        e=1e-3;
        if nargin<3
            m=1e4;
        end
    end
end
n=prod(sz);
L=fzero(@(x)pdf(x)-e,mu-10);
U=fzero(@(x)pdf(x)-e,mu+10);
D=U-L;
while integral(pdf,L,U)<1-1/m
    L=L-D/10;
    U=U+D/10;
end
LL=L-(U-L)/m;
UU=U+(U-L)/m;
x=linspace(L,U,m);
y=pdf(x);
c=cumtrapz(x,y);
rc=(1-c(end))/2;
c=[0,c+rc,1];
x=[LL,x,UU];
ur=rand([1,n]);
[~,ind]=sort([c,ur]);
lb=mexGetLB(ind,length(c),length(ur));
r=unifrnd(x(lb),x(lb+1));
r=reshape(r,sz);
end