#include<mex.h>
#include<stdlib.h>
#include<memory.h>

int sign(double x) {
	if (x > 0) return 1;
	else if (x < 0) return -1;
	else return 0;
}
int cmp(const void* a, const void* b) {
	return sign(*((double*)a) - *((double*)b));
}
void mexFunction(int nlhs, mxArray* plhs[], int nrhs, mxArray* prhs[]) {
	mxArray* mxX = prhs[0];
	int n = mxGetNumberOfElements(mxX);
	double* px = new double[n];
	memcpy(px, mxGetPr(mxX), n*sizeof(double));
	qsort(px, n, sizeof(double), cmp);

	double* ux = new double[n];
	double* nx = new double[n];
	for (int k = 0; k < n; k++){
		ux[k] = 0;
		nx[k] = 0;
	}

	ux[0] = px[0];
	nx[0] = 1;
	int m = 0;
	for (int k = 1; k < n; k++){
		if (px[k] == px[k - 1]){
			nx[m]++;
		}
		else{
			m++;
			ux[m] = px[k];
			nx[m] = 1;
		}
	}
	m++;
	
	mxArray* mxUX = mxCreateDoubleMatrix(m, 1, mxREAL);
	mxArray* mxNX = mxCreateDoubleMatrix(m, 1, mxREAL);
	plhs[0] = mxUX;
	plhs[1] = mxNX;

	memcpy(mxGetPr(mxUX), ux, m*sizeof(double));
	memcpy(mxGetPr(mxNX), nx, m*sizeof(double));

	delete[] px;
	delete[] ux;
	delete[] nx;
}