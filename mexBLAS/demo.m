clc,clear,close all;
% 官方文档推荐如果调用了 blas 则增加选项 -largeArrayDims
% mex -llibmwblas.lib -output gemm gemm.cpp
mex  -largeArrayDims  -llibmwblas.lib -output gemm gemm.cpp
A=rand(3,500);
B=rand(500,3);
disp(gemm(A,B)-A*B)