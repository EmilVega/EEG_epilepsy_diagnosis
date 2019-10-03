function y = SSI2(x)
%Calculate the Simple Square Integral SSI
y = sum((abs(x)).^2)/length(x);
end