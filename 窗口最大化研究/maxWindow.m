function r = maxWindow(h)
% 窗口最大化
% 输入：
%   h 窗口句柄
% 输出：
%   r 是否成功，0表示失败，1表示成功
%
% Maximize the window of figure
%
% Input:
%   h handle of Figure
% Output:
%   r 0 for unsucceed, 1 for succeed
%
% Syntax:
%   maxWindow(h)
%   r=maxWindow(h)
%
% Example:
%   h=figure;
%   maxWindow(h);
%
% More About:
% This function used the mex-file named "mexWindowMax.mexw64". 
% If your system is not 64-bit Windows, you can compile "mexWindowMax.cpp"
% by yourself, use:
%   mex mexWindowMax.cpp
% or do static compile use:(use Visual Studio as the compiler)
%   mex mexWindowMax.cpp 'COMPFLAGS="/Zp8 /GR /W3 /EHs /nologo /MT"'
% See Also:
% figure|mex

name=get(h,'Name');
if isempty(name)
    name=sprintf('Figure %d',get(h,'Number'));
else
    if strcmp(get(h,'NumberTitle'),'on')
        name=sprintf('Figure %d: %s',get(h,'Number'),name);
    end
end
drawnow;
r=mexWindowMax(name);
end
