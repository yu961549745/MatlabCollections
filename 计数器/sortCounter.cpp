#include<mex.h>
#include<memory.h>
#include<algorithm>
using namespace std;

void mexFunction(int nlhs, mxArray* plhs[], int nrhs, mxArray* prhs[]) {
	mxArray* mxX = prhs[0];
	int n = mxGetNumberOfElements(mxX);
	double* px = new double[n];
	memcpy(px, mxGetPr(mxX), n*sizeof(double));
	sort(px, px + n);

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