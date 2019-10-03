function TimeFeatures(Sx,index)
       global MaxValue MinValue RMSValue MEDValue CounterPKS
       %Maximos
        MaxValue(index)=max(Sx);
        %Minimos
        MinValue(index)=min(Sx);
        %Voltaje RMS
        RMSValue(index)=rms(Sx);
        %Promedio
        MEDValue(index)=mean(Sx);
        %Conteo de picos
        [pks,locs] = findpeaks(Sx);
        CounterPKS(index) =size(pks,1);
end