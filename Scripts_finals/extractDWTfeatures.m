function M4 = extractDWTfeatures(M2)
    clc
    [lM2,n] = size(M2);
    M4=zeros(lM2,192);     % Charactirzation on dwt data
    
    wb = waitbar(0,'Extracting DWT Features...');
    
    for i=1:lM2
        M4(i,:)=features_dwt(M2(i,1:178));
        waitbar(i/lM2);
    end
    
    delete(wb);
    clear i lM2 n
end