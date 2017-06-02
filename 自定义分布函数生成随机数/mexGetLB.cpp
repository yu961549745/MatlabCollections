/*
function lb = getLB(ind,m,n)
找到小于数据点的最后一个分割点的下标
ind 从小大大排序后的指标向量
m	分隔点的个数
n	数据点的个数
*/
#include<mex.h>
void mexFunction(int nlhs, mxArray* plhs[], int nrhs, mxArray* prhs[]) {
	int m = mxGetScalar(prhs[1]);
	int n = mxGetScalar(prhs[2]);
	double* ind = mxGetPr(prhs[0]);
	mxArray* mxLB = mxCreateDoubleMatrix(1, n, mxREAL);
	double* lb = mxGetPr(mxLB);
	double cind = 0;
	for (int k = 0; k < n + m; k++){
		if (ind[k] <= m){
			cind = ind[k];
		}
		else{
			lb[(int)ind[k] - m - 1] = cind;
		}
	}
	plhs[0] = mxLB;
}