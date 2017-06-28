clc,clear,close all;
mex  -largeArrayDims  -llibmwblas.lib -output gemm gemm.cpp
A=rand(3,500);
B=rand(500,3);
disp(gemm(A,B)-A*B)