#include<mex.h>
#include<opencv\highgui.h>
int m, n, step, chanels;
int mxInd(int i, int j, int k) {
	return i + j*m + k*m*n;
}
int cvInd(int i, int j, int k) {
	return i*step + j*chanels + (2 - k);
}
mxArray* cv2mx(IplImage* cvImg) {
	m = cvImg->height;
	n = cvImg->width;
	step = cvImg->widthStep;
	chanels = cvImg->nChannels;
	mwSize dims[] = { m, n, chanels };
	mxArray* mxImg = mxCreateNumericArray(3, dims, mxUINT8_CLASS, mxREAL);
	uchar* pMxImg = (uchar*)mxGetData(mxImg);
	uchar* pCvImg = (uchar*)cvImg->imageData;
	for (int i = 0; i < m; i++){
		for (int j = 0; j < n; j++){
			for (int k = 0; k < chanels; k++){
				pMxImg[mxInd(i, j, k)] = pCvImg[cvInd(i, j, k)];
			}
		}
	}
	return mxImg;
}
IplImage* mx2cv(mxArray* mxImg) {
	const mwSize* dims = mxGetDimensions(mxImg);
	mwSize ndims = mxGetNumberOfDimensions(mxImg);
	m = dims[0];
	n = dims[1];
	chanels = ndims >= 3 ? dims[2] : 1;
	CvSize sz;
	sz.width = n;
	sz.height = m;
	IplImage* cvImg = cvCreateImage(sz, IPL_DEPTH_8U, chanels);
	step = cvImg->widthStep;
	uchar* pMxImg = (uchar*)mxGetData(mxImg);
	uchar* pCvImg = (uchar*)cvImg->imageData;
	for (int i = 0; i < m; i++){
		for (int j = 0; j < n; j++){
			for (int k = 0; k < chanels; k++){
				pCvImg[cvInd(i, j, k)] = pMxImg[mxInd(i, j, k)];
			}
		}
	}
	return cvImg;
}
void cvimread(int nlhs, mxArray* plhs[], int nrhs, mxArray* prhs[]) {
	char* fname = mxArrayToString(prhs[0]);
	IplImage* cvImg = cvLoadImage(fname, CV_LOAD_IMAGE_COLOR);
	plhs[0] = cv2mx(cvImg);
	cvReleaseImage(&cvImg);
}
void cvimshow(int nlhs, mxArray* plhs[], int nrhs, mxArray* prhs[]) {
	mxArray* mxImg = prhs[0];
	char* figName = mxArrayToString(prhs[1]);
	IplImage* cvImg = mx2cv(mxImg);
	cvNamedWindow(figName, CV_WINDOW_AUTOSIZE);
	cvShowImage(figName, cvImg);
	//cvWaitKey(0);
	cvReleaseImage(&cvImg);
}
void mexFunction(int nlhs, mxArray* plhs[], int nrhs, mxArray* prhs[]) {
	cvimread(nlhs, plhs, nrhs, prhs);
}