function f = showTable(name,data)
f=figure('Name',name);
table=uitable('Parent',f,'Data',data,'Units','normalized',...
    'Position',[0.02,0.12,0.96,0.86]);
uicontrol(f,'Style','pushbutton','String','±£´æÊý¾Ý',...
    'Units','normalized','Position',[0.02,0.02,0.15,0.08],...
    'Callback',@(hObject,handles)save(hObject,handles,table),...
    'FontSize',12);
end
function save(~,~,table)
[fname,pname]=uiputfile({'*.xls;*.xlsx;*.csv','Excel Files'});
if fname~=0
    T=get(table,'Data');
    xlswrite(strcat(pname,fname),T);
end
end