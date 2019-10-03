function y = VAR(x)
%Calculate the Variance (VAR)
u = sum(x)/length(x);
y = sum(abs(x-u).^2)/(length(x)-1);
end