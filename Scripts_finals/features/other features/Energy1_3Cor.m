function y = Energy1_3Cor(x)
a=length(x)/3;
a=round(a);
x1=x(1:a);
y =sum(x1);
end