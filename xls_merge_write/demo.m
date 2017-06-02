%% 读取数据
clc,clear,close all;
[~,~,x]=xlsread('1.xlsx');
%% 提取数据
y=str2double(x(1,3:end));% 年份
x(1,:)=[];
ck=x(:,1);% 出口国
jk=x(:,2);% 进口国
d=x(:,3:end);% 提取数据，这时候是cell，内含字符串和数字，不能直接 cell2mat
[m,n]=size(d);
dd=zeros(m,n);
for i=1:m
    for j=1:n
        if isscalar(d{i,j})
            dd(i,j)=d{i,j};
        else
            dd(i,j)=NaN;
        end
    end
end
%% 提取国家和年份
[uck,~,id]=unique(ck);
yid=[1,11,21,31:37];
nc=length(uck);
ny=length(yid);
%% 存储结果的格式
res=cell(nc,1);
%% 数据处理
for i=1:nc
    ind=id==i;% 提取从某个国家出口的所有数据行的编号
    xx=dd(id==i,yid);% 对应数据
    sgj=jk(ind);% 对应国家
    [sj,ii]=sort(-xx);% 按列排序，从大到小，NaN排最后，获取排序的编号
    gj=sgj(ii);% 将国家按顺序排列，这里应用了向量的矩阵下标访问规则
    sj=num2cell(-sj);% 将数据从矩阵变成cell
    % 这个时候，要把gj 和 sj 交错排列才是你要的结果，对吧，那么长度是 2*ny
    nn=length(gj);% 这个国家共有多少个出口国
    rr=cell(nn,2*ny);
    for j=1:ny
        rr(:,2*j-1)=gj(:,j);% 奇数列是国家
        rr(:,2*j)=sj(:,j);
    end
    cks=cell(nn,1);
    cks{1}=ck{ind};
    res{i}=[cks,...% 补上出口国
        num2cell((1:nn)'),...% 补上排名
        rr];% 这就是这个国家的结果
end
%% 最后将结果进行拼接并输出
res=cat(1,res{:});
% 然后补上行名和列名
% 出口国，排名，1980，空，1990，空，……
ys=[num2cell(y(yid));cell(1,ny)];
lm1=[{'出口国','排名'},ys(:)'];
% 空，空， 国家，依存度，国家，依存度，……
lm2=[cell(1,2),repmat({'国家','依存度'},[1,ny])];
res=[lm1;lm2;res];
%% 保存
% xlswrite('res.xlsx',res);
xls_merge_write('./res.xlsx',res,1,[1,2]);