classdef Robot < handle
    % 键盘鼠标控制器
    properties(Access=private)
        r
    end
    methods
        function r = Robot()
            javaaddpath('RBT.jar');
            r.r=rbt.Rbt();
        end
        function type(r,varargin)
            % 按键：键值为字符串，
            % 以java.awt.event.KeyEvent中的常量名为准
            % 例如按键 'A' 对应java中的'VK_A'，使用时为
            %       r.type('A')
            % 支持同时按多个键，例如
            %       r.type('CONTROL','A')
            n=length(varargin);
            for i=1:n
                r.r.press(varargin{i});
            end
            for i=1:n
                r.r.release(varargin{i});
            end
        end
        function click(r,p)
            % 鼠标点击，坐标以屏幕左上角为原点，宽度为x轴，高度为y轴
            r.r.click(p(1),p(2));
        end
    end
end