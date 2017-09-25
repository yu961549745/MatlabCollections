function [x,f] = wolframTSP(d)
save graph.txt d -ascii -double
if ispc
    [~,cmdout]=system('wolfram -script tsp.wl');
else
    [~,cmdout]=system('wolframscript -file tsp.wl');
end
y=str2double(regexp(cmdout,'\d+(\.\d+)?','match'));
x=y(2:end-1);
f=y(1);
delete graph.txt
end