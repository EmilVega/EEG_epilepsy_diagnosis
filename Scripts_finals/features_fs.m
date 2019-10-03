function y = features_fs(x,fs)
n=length(x);
y=zeros(1,4);

X2=2*abs(fft(x,n))/n;      % Calculate the FFT, divide the number of samples y multiply by 2
P1=X2(1:n/2+1);            % Leave just the half of FFT
f = fs * (0:(n/ 2))/n;    
[m,~]=max(P1);

y(1) = m;  % Peak frequency
y(2) = mean(P1);     % Mean Frequency
y(3) = sum(abs(P1).^2)*fs/n;     % Energy
y(4) = FMaxFFT(x,fs); % Max FFT
end