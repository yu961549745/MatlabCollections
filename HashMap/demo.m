clc,clear,close all;
k={1,'1','abc',ones(2)};
v={2,'dfadf',zeros(3),1};
map=kv2map(k,v);
disp(map)

map.get(1)
map.get('1')
map.get('abc')
map.get(k{4})
map.get('hahaah')
