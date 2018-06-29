#include<unordered_map>
#include<mex.h>
using namespace std;
void mexFunction(int nlhs, mxArray* plhs[], int nrhs, mxArray* prhs[]) {
	mxArray* mxX = prhs[0];

	unordered_map<double, int> xmap;
	double* px = mxGetPr(mxX);
	int n = mxGetNumberOfElements(mxX);
	for (int k = 0; k < n; k++) {
		xmap[px[k]]++;
	}
	int m = xmap.size();

	mxArray* mxUX = mxCreateDoubleMatrix(m, 1, mxREAL);
	mxArray* mxNX = mxCreateDoubleMatrix(m, 1, mxREAL);
	plhs[0] = mxUX;
	plhs[1] = mxNX;

	double* pUX = mxGetPr(mxUX);
	double* pNX = mxGetPr(mxNX);

	for (auto iter = xmap.begin(); iter != xmap.end();iter++) {
		*pUX = iter->first;
		*pNX = iter->second;
		pUX++;
		pNX++;
	}
}