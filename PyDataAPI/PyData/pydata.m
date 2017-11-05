classdef pydata
    % Matlab 和 NumPy 数据转换的接口
    methods(Static)
        function y = toPy(x,dtype)
            % 将 Matlab 矩阵转化为 NumPy 矩阵
            if nargin<2
                dtype='double';
            end
            y = py.PyData.DataParser.mx2py(mat2py(x),dtype);
        end
        function y = fromPy(x)
            % 将 NumPy 矩阵转化为 Matlab 矩阵
            y = py2mat(py.PyData.DataParser.mxArray(x));
        end
        function savePy(x,fname,dtype)
            % 将 Matlab 矩阵转化为 NumPy 矩阵
            if nargin<3
                dtype='double';
            end
            py.numpy.save(fname,pydata.toPy(x,dtype));
        end
        function x = loadPy(fname)
            % 将 Numpy 格式矩阵数据读取为 MATLAB 矩阵
            x = pydata.fromPy(py.numpy.load(fname));
        end
        function y = imgsToPy(x)
            % 将 MATLAB 的 图片 cell 转化为 BatchSize*M*N*3 的格式
            % 不管输入是什么，输出的都是 uint8 格式的
            % 自动删除空 cell 
            x=x(:);
            x(cellfun(@isempty,x))=[];
            x=cellfun(@(t){reshape(im2uint8(t),[1,size(t)])},x);
            y=cat(1,x{:});
        end
    end
end
function z = mat2py(x)
% 将 MATLAB 矩阵转换为一个结构体
z.data=x(:)';
z.shape=size(x);
end
function y = py2mat(x)
% 将 Python 中的  mxArray 对象转化为 MATLAB 矩阵
sz=cellfun(@double,cell(x.shape));
y=cellfun(@double,cell(x.data));
y=reshape(y,sz);
end