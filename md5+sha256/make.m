clc,clear,close all;
% mex Брвы
mex md5.cpp

% java Брвы
!javac -d . *.java
!jar cf md.jar ecnu
rmdir ecnu s
javaaddpath md.jar
