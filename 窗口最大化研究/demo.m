clc,clear,close all;

%% ¼òµ¥´Ö±©
figure('Position',[1,41,1920,1082])

%% ÓÐµãÆ«²î
figure('Position',get(0,'ScreenSize'))

%% User32 API maximize window
% but it just for the Windows OS
tic
h=figure;
maxWindow(h);
toc

tic
h=figure;
set(h,'Name','haha');
maxWindow(h);
toc

tic
h=figure;
set(h,'Name','haha','NumberTitle','off');
maxWindow(h);
toc

%% JavaFrame propertity to maximize the figure
% but the figure JavaFrame property is an unsupported feature 
% and will be removed in a future release. 
tic
h=figure;
maxWindowJ(h);
toc