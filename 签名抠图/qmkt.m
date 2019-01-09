function qmkt(inFile,outFile,varargin)
im=imread(inFile);
im=rgb2gray(im);
im=imbinarize(im);
figure;imshow(im);
mk=imdilate(~im,strel(varargin{:}));
figure;imshow(mk);
imwrite(double(repmat(im,[1,1,3])),outFile,'Alpha',double(mk));
end