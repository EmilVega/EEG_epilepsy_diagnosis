%x=señal, fs=frecuencia de muestreo,ts=tiempo de inicio, te=tiempo final
function y = AsDec(x)
te=length(x);
ts=0;
[a,b]=max(x);
tmax=b;
y = (tmax-ts)/(te-tmax);
end
