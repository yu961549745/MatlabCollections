function mymex(fname)
% 对 Visual Stdio 的 C++ 项目进行编译
% 输入：
%   fname C++文件的路径
% 约定：设文件名为 path/fcn.cpp
%   1. 编译的结果函数为 fcn
%   2. 函数需在 stdafx.h 中声明
%   3. 函数原型为 void fcn(int nlhs,mxArray* plhs[],int nrhs,mxArray* prhs[])
%   4. 项目中不存在 __mexForCompile.cpp
[path,fcn,~]=fileparts(fname);
fprintf('正在编译 %s ...\n',fname);
opath=cd;
cd(path);
fname='__mexForCompile.cpp';
temp='#include"stdafx.h"\nvoid mexFunction(int nlhs,mxArray* plhs[],int nrhs,mxArray* prhs[]){%s(nlhs,plhs,nrhs,prhs);}';
fid=fopen(fname,'w');
fprintf(fid,temp,fcn);
fclose(fid);
fs=dir();
fs=arrayfun(@(s){s.name},fs(3:end));
isCpp=cellfun(@(s)~isempty(regexp(s,'.*\.cpp','once')),fs);
fs=fs(isCpp);
mex('-output',fcn,fs{:});
delete(fname);
mexName=[fcn,'.',mexext()];
clear(fcn);
movefile(mexName,fullfile(opath,mexName),'f');
cd(opath);
end

