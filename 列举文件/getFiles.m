function fs = getFiles(path,reg,exReg)
% ��ȡ�ļ����������ļ�
% �����ܹ�ͨ��������ʽ���й���
if nargin<3
    % Ĭ������ windows �µ� db �ļ�
    % �� mac �µ� . ��ͷ�������ļ�
    % �Լ� . �� .. 
    exReg='(.*\.db)|(^\.{1,2}.*)';
    if nargin<2
        reg='';
    end
end
% ���ļ���ɸѡ
fs=dir(path);
if isempty(fs)
    error('no file found.');
end
if ~isempty(reg)
    ind=arrayfun(@(s)~isempty(regexp(s.name,reg,'once')),fs);
else
    ind=true(size(fs));
end
if ~isempty(exReg)
    exInd=arrayfun(@(s)~isempty(regexp(s.name,exReg,'once')),fs);
else
    exInd=false(size(fs));
end
fs=fs(ind&(~exInd));
% ����·��
fs=arrayfun(@(f){fullfile(f.folder,f.name)},fs);
end
