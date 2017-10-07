function x=cellsort(x,cols)
% 对 cell 数组按列排序
% 输入：
%     x cell 数组
%     cols 列序号，按照指定列依次排序，正数表示升序，负数表示降序
% 输出：
%     x 排序结果
% 例：
%     cellsort(x,[2,1,-3]) 
% 依次按照第 2 1 3 列进行排序，其中 2 1 升序，3 降序
n=length(cols);
inds=cell(1,n);
dirs=cell(1,n);
for k=1:n
    if cols(k)>0
        dirs{k}='ascend';
    else
        dirs{k}='descend';
    end
    j=abs(cols(k));
    if iscellstr(x(:,j))
        [~,~,inds{k}]=unique(x(:,j));
    else
        [~,~,inds{k}]=unique(cell2mat(x(:,j)));
    end
end
[~,ind]=sortrows(cell2mat(inds),1:n,dirs);
x=x(ind,:);
end