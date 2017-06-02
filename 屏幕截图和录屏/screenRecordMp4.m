function screenRecordMp4(fname,FPS,Time)

robot=java.awt.Robot;

writerObj=VideoWriter(fname,'MPEG-4');
set(writerObj,'FrameRate',FPS);

t=timer;
t.ExecutionMode='fixedRate';
t.Period=1/FPS;
t.TasksToExecute=FPS*Time;
t.StartFcn=@(obj,event)StartFcn(obj,event,writerObj);
t.TimerFcn=@(obj,event)TimerFcn(obj,event,robot,writerObj);
t.StopFcn=@(obj,event)StopFcn(obj,event,writerObj,fname);

fprintf('Start record for Time=%d FPS=%d\n',Time,FPS);
start(t);
end
%--------------------------------------------------------------------------
function StartFcn(obj,~,writerObj)
obj.UserData=tic;
open(writerObj);
end
%--------------------------------------------------------------------------
function TimerFcn(~,~,robot,writerObj)
writeVideo(writerObj,myScreenCapture(robot));
end
%--------------------------------------------------------------------------
function StopFcn(obj,~,writerObj,fname)
close(writerObj);
fprintf('Stop record and saved as %s\n',fname);
toc(obj.userData);
winopen(fname);
clear java;
end