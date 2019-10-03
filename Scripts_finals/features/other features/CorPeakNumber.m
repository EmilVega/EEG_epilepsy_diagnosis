function y = CorPeakNumber(x)
[acf,lags,bounds]=autocorr(x);
[a,b]=size(lags);
y = a;
end