clc,clear,close all;
isstatic=true;
needcompile=true;

if needcompile
    if isstatic
        cv_static_mex('cvimshow.cpp');
    else
        cv_dynamic_mex('cvimshow.cpp');
    end
end
cvimshow(imread('1.png'),'cv');

if needcompile
    if isstatic
        cv_static_mex('cvimread.cpp');
    else
        cv_dynamic_mex('cvimread.cpp');
    end
end
imshow(cvimread('1.png'));