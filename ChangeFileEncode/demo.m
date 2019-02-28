clc,clear,close all;
javaaddpath('lib.jar');
yjt.ChangeFileEncode.convert('./fs/1.csv','windows-1252','./fs/2.csv','utf8');
