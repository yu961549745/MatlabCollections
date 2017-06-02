#include<mex.h>
#include<Windows.h>

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, mxArray *prhs[]) {
	int N = mxGetN(prhs[0]) + 1;
	char* cname = (char *)malloc(N*sizeof(char));
	mxGetString(prhs[0], cname, N);
	LPCSTR lpName = (LPCSTR)cname;
	HWND hwnd = FindWindowA(NULL, lpName);
	plhs[0] = mxCreateDoubleMatrix(1, 1, mxREAL);
	double* r = mxGetPr(plhs[0]);
	int res = PostMessageA(hwnd, WM_SYSCOMMAND, SC_MAXIMIZE, 0);
	r[0]=res;
	free(cname);
}