function y = MedianFFT(x)
y = median(abs(fft(x)));
end