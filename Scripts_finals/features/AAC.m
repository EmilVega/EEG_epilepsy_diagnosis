function y = AAC(x)
%Calcute the Averange Amplitude Change AAC
l = length(x);
b=0;
for i=1:l-1
    a=abs(x(i+1)-x(i));
    b=b+a;
end
y = b/l;
end