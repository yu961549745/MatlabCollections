clc,clear,close all;
% fname='1.bmp';
fname='4.png';

im=imread(fname);
oim=im;
im=rgb2gray(im);
im=~im2bw(im,graythresh(im));
% im=im==0;

% cut image
[oim,im]=cutBw(oim,im);

% remove lines
ir=all(im,2);
ic=all(im,1);
im(ir,:)=0;
im(:,ic)=0;

% filter
[m,n]=size(im);
im=bwareafilt(im,[10,inf]);
myImshow(im);

% ocr block by block
p=regionprops(im,'BoundingBox','Image');
N=length(p);
B=zeros(N,3);
myImshow(oim);
hold on;
for k=1:N
    r=ocr(~p(k).Image,'TextLayout','Word','Characters','123456789');
    b=p(k).BoundingBox;
    t=strtrim(r.Text);
    if isempty(t)
        r=ocr(~bwmorph(p(k).Image,'thin',inf),'TextLayout','Word','Characters','123456789');
        b=p(k).BoundingBox;
        t=strtrim(r.Text);
    end
    if isempty(t)
        h=myImshow(~p(k).Image);
        t=inputdlg('识别为:','人工识别',1);
        close(h);
        t=t{1};
    end
    rr=ceil(b(2)/m*9);
    cc=ceil(b(1)/n*9);
    text(b(1)+b(3)/2,b(2),sprintf('%s',t),...
        'HorizontalAlignment','center',...
        'VerticalAlignment','bottom',...
        'FontSize',16,...
        'Color','r');
    B(k,:)=[rr,cc,str2double(t)];
end
axis off;

% check result
while true
    s=inputdlg('row column value','fix result',1);
    s=s{1};
    if isempty(s)
        break;
    end
    B=matrep(B,sscanf(s,'%d')');
end

% solve sudoku
drawSudoku(B)
S=sudokuEngine(B);
drawSudoku(S)