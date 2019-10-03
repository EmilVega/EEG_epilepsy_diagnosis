%x=señal, tf=tiempo final, tiempo total, fs=frecuencia de muestreo
function y = RMSDecPhaseLine(x,fs,tf,t)
[a,b]=max(x);
tmax=b*(1/fs);
l=max(envelope(x))-(max(envelope(x))/(tf-tmax))*t;
y =sqrt(conj(envelope(x)-l).^2);
end