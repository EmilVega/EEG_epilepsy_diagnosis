function y = int_ratio(x)
a=length(x)/3;
a=round(a);
x1=x(1:a);
x2=x(a+1:end);
y =sum(x1)/sum(x2);
end