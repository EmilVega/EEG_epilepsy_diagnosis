function y = Energy2_3Cor(x)
a=length(x)/3;
a=round(a);
x1=x(a+1:end);
y =sum(x1);
end