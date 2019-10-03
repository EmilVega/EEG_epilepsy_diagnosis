function FrequencyFeatures(Sx,index)
       global FreqPKS Energy Power
        fs=160;
        nSamples=length(Sx);
        %n = 2 ^ nextpow2(nSamples);
        n=nSamples;
        yfft=2*abs(fft(Sx,n))/n;  %Calcula la FFT, divide entre el numero de muestras y multiplica por 2
        P1=yfft(1:n/2+1);      %Deja solo la mitad de la FFT
        f = fs * (0:(n/ 2))/n;
        plot(f,P1);
        pause(0.1);
        %Frecuencia pico
        [m,i]=max(P1);
        FreqPKS(index)=f(i);
        %Energia
        Energy(index)=sum(abs(P1).^2)*fs/n;
        %Potencia
        Power(index)=5.86;
end