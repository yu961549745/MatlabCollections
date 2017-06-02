function [im] = myScreenCapture(robot)
ssz=get(0,'screenSize');
jRect=java.awt.Rectangle(ssz(1)-1,ssz(2)-1,ssz(3),ssz(4));
jImg=robot.createScreenCapture(jRect);
im=java2im(jImg);
end
