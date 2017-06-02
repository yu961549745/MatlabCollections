function [ux,nx] = mxCounter(x)
% 计数函数
% 输入：
%   x  数据
% 输出：
%   ux 元素
%   nx 个数
[ux,~,ic] = unique(x(:));
ic=sort(ic);
ic=diff([0;ic;length(ux)+1]);
idx=find(ic==1);
nx=idx(2:end)-idx(1:(end-1));
end
