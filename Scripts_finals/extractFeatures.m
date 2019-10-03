function M3 = extractFeatures(M2)
    clc
    [lM2,n] = size(M2);
    M3=zeros(lM2,36);  % Characterication on original data
    
    wb = waitbar(0,'Extracting Features...');
    
    for i=1:lM2
        M3(i,1:32)=features(M2(i,1:178));
        M3(i,33:36)=features_fs(M2(i,1:178),178);
        waitbar(i/lM2);
    end
    
    delete(wb);
end