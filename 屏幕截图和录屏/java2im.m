function [im,alpha] = java2im(jImg)
w=jImg.getWidth();
h=jImg.getHeight();
pixelsData=reshape(typecast(jImg.getRGB(0,0,w,h,[],0,w),'uint8'),4,w,h);
im=cat(3, ...
    reshape(pixelsData(3, :, :), w, h)', ...
    reshape(pixelsData(2, :, :), w, h)', ...
    reshape(pixelsData(1, :, :), w, h)');
alpha=reshape(pixelsData(4, :, :), w, h)';
end