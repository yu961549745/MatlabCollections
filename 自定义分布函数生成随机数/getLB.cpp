/*
function lb = getLB(x,y)
找到x在y中下界的下标
*/
#include<mex.h>
#include<algorithm>
using namespace std;
void mexFunction(int nlhs, mxArray* plhs[], int nrhs, mxArray* prhs[]) {
	mxArray* mxX = prhs[0];
	mxArray* mxY = prhs[1];
	int m = mxGetNumberOfElements(mxX);
	int n = mxGetNumberOfElements(mxY);
	mxArray* mxLB = mxCreateDoubleMatrix(m, 1, mxREAL);
	plhs[0] = mxLB;

	double* x = mxGetPr(mxX);
	double* y = mxGetPr(mxY);
	double* z = mxGetPr(mxLB);
	double* p;
	for (int i = 0; i < m; i++){
		p = upper_bound(y, y + n, x[i]);
		z[i] = p - y;
	}
}