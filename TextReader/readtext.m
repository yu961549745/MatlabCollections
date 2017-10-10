function x=readtext(fname,encode)
javaaddpath('JTXT.jar');
x=char(jtxt.Reader.read(fname,encode));
end