function y = VarFFT(x)
y = var(abs(fft(x)));
end