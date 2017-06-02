#include<mex.h>
#include<memory.h>
const double inf = mxGetInf();
// 这里要求 T~=0 ，一旦等于0，将出现不可预知的情况
double immatch2d(double* S, double* T, int N, double* t){
	double S2 = 0;
	double T2 = 0;
	double ST = 0;
	for (int k = 0; k < N; k++){
		S2 += S[k] * S[k];
		T2 += T[k] * T[k];
		ST += S[k] * T[k];
	}
	double v;
	v = S2*T2 - ST*ST;
	*t = ST / T2;
	return v;
}
double immatch(mxArray* mxS, mxArray* mxT, mxArray* mxt){
	double* S = mxGetPr(mxS);
	double* T = mxGetPr(mxT);
	const mwSize* sz = mxGetDimensions(mxS);
	int N = sz[0] * sz[1];
	double v = 0;
	double* t = mxGetPr(mxt);
	for (int k = 0; k < 3; k++){
		v += immatch2d(S + k*N, T + k*N, N, t + k);
	}
	return v;
}
void copyArrayTo(mxArray* from, mxArray* to){
	memcpy(mxGetPr(to), mxGetPr(from), mxGetNumberOfElements(from)*sizeof(double));
}
int imgsMatch(mxArray* imgs, mxArray* T, mxArray* minT){
	int n = mxGetNumberOfElements(imgs);
	double minV = inf;
	int minInd = -1;
	mxArray* tmpT = mxCreateDoubleMatrix(1, 3, mxREAL);
	for (int k = 0; k < n; k++){
		double v = immatch(T, mxGetCell(imgs, k), tmpT);
		if (v < minV){
			minV = v;
			minInd = k;
			copyArrayTo(tmpT, minT);
		}
	}
	return minInd + 1;
}
/*
function [ind,t] = imgsMatch(imgs,T)
*/
void mexFunction(int nlhs, mxArray* plhs[], int nrhs, mxArray* prhs[]){
	plhs[1] = mxCreateDoubleMatrix(1, 3, mxREAL);
	int ind = imgsMatch(prhs[0], prhs[1], plhs[1]);
	plhs[0] = mxCreateDoubleScalar(ind);
}