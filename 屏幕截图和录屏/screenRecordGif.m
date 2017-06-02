function screenRecordGif(fname,FPS,Time,imScale)

robot=java.awt.Robot;

t=timer;
t.ExecutionMode='fixedRate';
t.Period=1/FPS;
t.TasksToExecute=FPS*Time;
t.StartFcn=@(obj,event)StartFcn(obj,event,robot,fname,imScale);
t.TimerFcn=@(obj,event)TimerFcn(obj,event,robot,fname,imScale);
t.StopFcn=@(obj,event)StopFcn(obj,event,fname);

fprintf('Start record for Time=%d FPS=%d\n',Time,FPS);
start(t);
end
%--------------------------------------------------------------------------
function StartFcn(obj,~,robot,fname,imScale)
obj.UserData=tic;
im=myScreenCapture(robot);
im=imresize(im,imScale);
[A,map]=rgb2ind(im,256);
imwrite(A,map,fname,'gif','LoopCount',Inf,'DelayTime',obj.Period);
end
%--------------------------------------------------------------------------
function TimerFcn(obj,~,robot,fname,imScale)
im=myScreenCapture(robot);
im=imresize(im,imScale);
[A,map]=rgb2ind(im,256);
imwrite(A,map,fname,'gif','WriteMode','append','DelayTime',obj.Period);
end
%--------------------------------------------------------------------------
function StopFcn(obj,~,fname)
fprintf('Stop record and saved as %s\n',fname);
toc(obj.userData);
winopen(fname);
clear java;
end