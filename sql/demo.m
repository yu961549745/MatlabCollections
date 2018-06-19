clc,clear,close all;
javaaddpath('mysql.jar');% add class path of db driver
%% set preferences
prefs=setdbprefs('DataReturnFormat');
setdbprefs('DataReturnFormat','table');
%% connection
conn = database(...
    'sys',...% db name
    'root',...% user name
    '12345678',...% password
    'com.mysql.jdbc.Driver',...
    ['jdbc:mysql://localhost:3306/sys',...% db url
    '?useSSL=true&useUnicode=true&characterEncoding=utf8&']...% connection parameters
    );
disp(conn);
%% query
curs = exec(conn,'select * from sys_config;');
curs = fetch(curs);
data = curs.Data;
close(curs);
%% show data
disp(data);
%% close connection
close(conn);
%% reset preferences
setdbprefs('DataReturnFormat',prefs);
