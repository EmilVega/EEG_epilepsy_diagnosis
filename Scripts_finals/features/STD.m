function y = STD(x)
%Calculate the Standard Deviation (STD)
u = sum(x)/length(x);
y = sqrt(sum(abs(x-u).^2)/(length(x)-1));
end