function y = ggdpdf(x,b,s)
% 0均值方差为s的广义高斯分布的实随机变量pdf
a=sqrt(gamma(1/b)/gamma(3/b)*s);
y=b/(2*a*gamma(1/b))*exp(-(abs(x)/a).^b);
end