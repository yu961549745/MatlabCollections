function maxWindowJ(h)
drawnow;
warning('off','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');
jFrame=get(h,'JavaFrame');
set(jFrame,'Maximized',true);
warning('on','MATLAB:HandleGraphics:ObsoletedProperty:JavaFrame');
drawnow;
end