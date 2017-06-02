#include<stdlib.h>
#include<memory.h>
#include<mex.h>
void swap(int*x, int i, int j) { int t = x[i]; x[i] = x[j]; x[j] = t; }
void reverse(int*x, int n) {
	int s = 0, e = n - 1;
	while (s<e)swap(x, s++, e--);
}
int next(int*x, int n) {
	int k;
	for (k = n - 2; k >= 0; k--)
	if (x[k]<x[k + 1])break;
	if (k >= 0){
		int mv = x[k + 1], mi = k + 1;
		for (int i = k + 2; i<n; i++)
		if (x[i]>x[k] && x[i]<mv){ mv = x[i]; mi = i; }
		swap(x, k, mi);
		reverse(x + k + 1, n - k - 1);
		return 1;
	}
	return 0;
}
int sub(int i, int j, int n) { return i + j*n; }
double tsp2ind(double* d, int* ind, int n) {
	double s = 0;
	for (int i = 0; i < n; i++)
		s += d[sub(ind[i%n], ind[(i + 1)%n], n)];
	return s;
}
int* tsp(double* d, double* v, int n) {
	int* ind = (int*)malloc(n*sizeof(int));
	for (int k = 0; k < n; k++) ind[k] = k;
	double md = tsp2ind(d, ind, n);
	int* bind = (int*)malloc(n*sizeof(int));
	memcpy(bind, ind, n*sizeof(int));
	while (next(ind, n)){
		double td = tsp2ind(d, ind, n);
		if (td < md) {
			md = td;
			memcpy(bind, ind, n*sizeof(int));
		}
	}
	free(ind);
	*v = md;
	return bind;
}
void mexFunction(int nlhs, mxArray *plhs[], int nrhs, mxArray *prhs[]) {
	mxArray* dis = prhs[0];
	int n = mxGetN(dis);
	double* d = mxGetPr(dis);
	double val;
	int* ind = tsp(d, &val, n);
	mxArray* mxVal = mxCreateDoubleScalar(val);
	mxArray* mxInd = mxCreateDoubleMatrix(n, 1, mxREAL);
	double* mxIndPr = mxGetPr(mxInd);
	for (int k = 0; k < n; k++) mxIndPr[k] = ind[k] + 1;
	plhs[0] = mxInd;
	plhs[1] = mxVal;
	free(ind);
}