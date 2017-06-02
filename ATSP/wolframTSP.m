function [x,f] = wolframTSP(d)
save graph.txt d -ascii -double
[~,cmdout]=system('wolfram -script tsp.wl');
y=str2double(regexp(cmdout,'\d+(\.\d+)?','match'));
x=y(2:end-1);
f=y(1);
delete graph.txt
end