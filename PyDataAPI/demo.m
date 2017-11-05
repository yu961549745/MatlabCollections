clc,clear,close all;
addpath PyData

x=reshape(1:24,[4,3,2]);
y=pydata.toPy(x);
z=pydata.fromPy(y);
isequal(x,z)

im=imread('1.png');
npim=pydata.toPy(im,'uint8');
rim=uint8(pydata.fromPy(npim));
isequal(im,rim)

py.PIL.Image.fromarray(npim,'RGB').save('py.png');
pim=imread('py.png');
isequal(im,pim)