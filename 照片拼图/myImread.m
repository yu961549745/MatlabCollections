function [X, map, alpha] = myImread(varargin)
% 在Matlab图片读取的基础上，根据照片的EXIF的Orientation属性，对照片进行旋转
% 1 不旋转
% 6 顺时针90度
% 8 逆时针90度
% 3 180度
% 2 水平翻转
% 4 垂直翻转
% 5 顺时针90度+水平翻转
% 7 顺时针90度+垂直翻转
% 因为这些参数是告诉显示器应该如何显示照片
% 因此按照属性说明的方向旋转即可
% 而不是反方向旋转照片
% 详情参考：http://blog.csdn.net/ouyangtianhan/article/details/29825885
[X,map,alpha]=imread(varargin{:});
info=imfinfo(varargin{1});
if isfield(info,'Orientation')
    switch info.Orientation
        case 1
        case 6
            X=imrotate(X,-90);
        case 8
            X=imrotate(X,90);
        case 3
            X=imrotate(X,180);
        case 2
            X=flip(X,2);
        case 4
            X=flip(X,1);
        case 5
            X=imrotate(X,-90);
            X=flip(X,2);
        case 7
            X=imrotate(X,-90);
            X=flip(X,1);
    end
    if ~isempty(alpha)
        switch info.Orientation
            case 1
            case 6
                alpha=imrotate(alpha,-90);
            case 8
                alpha=imrotate(alpha,90);
            case 3
                alpha=imrotate(alpha,180);
            case 2
                alpha=flip(alpha,2);
            case 4
                alpha=flip(alpha,1);
            case 5
                alpha=imrotate(alpha,-90);
                alpha=flip(alpha,2);
            case 7
                alpha=imrotate(alpha,-90);
                alpha=flip(alpha,1);
        end
    end
end
