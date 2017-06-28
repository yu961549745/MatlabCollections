clc,clear,close all;
% 官方文档推荐如果调用了 blas 则增加选项 -largeArrayDims
if isunix
    mex -largeArrayDims -lmwblas gemm.cpp
else
    mex -largeArrayDims -llibmwblas.lib gemm.cpp
end
A=rand(3,500);
B=rand(500,3);
disp(gemm(A,B)-A*B)