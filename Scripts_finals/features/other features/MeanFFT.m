function y = MeanFFT(x)
y = mean(abs(fft(x)));
end