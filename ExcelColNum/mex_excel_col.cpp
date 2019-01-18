#include<mex.h>
#include<vector>
void toAZ(std::vector<char>& v, int x) {
	while (x > 0) {
		int rem = x % 26;
		if (rem == 0) rem = 26;
		v.push_back(rem - 1 + 'A');
		x = (x - rem) / 26;
	}
}
void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[]) {
	std::vector<char> v;
	toAZ(v, (int)(mxGetScalar(prhs[0])));
	char* str = new char[v.size() + 1];
	int k = 0;
	for (auto i = v.rbegin(); i != v.rend(); i++) str[k++] = *i;
	str[k] = '\0';
	plhs[0] = mxCreateString(str);
	delete str;
}