function y = gmmpdf(x,k,s1,s2)
% ·½²î s1^2 s2^2
y=(k*exp(-(abs(x)/s1).^2)/s1+(1-k)*exp(-(abs(x)/s2).^2)/s2)/sqrt(pi);
end