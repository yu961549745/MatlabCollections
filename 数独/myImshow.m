function fh = myImshow(im,newFigure,isgray)
if nargin<3
    isgray=true;
    if nargin<2
        newFigure=true;
    end
end
if newFigure
    figure('Position',[1 41 1366 650]);
end
if isgray
    imagesc(im,[0,1]);
else
    imagesc(im);
end
colormap gray;
axis equal;
axis tight;
drawnow;
fh=gcf;
end