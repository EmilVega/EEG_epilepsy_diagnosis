function [M2,y] = loadData(FileName, Path)
    % Load data
    clc
    fullPath = strcat(Path,FileName);
    M=csvread(fullPath,1,1);
    y = M(:,end);
    
    wb = waitbar(0,'Loading data...');
    
    for s = 1:500
        for i = 1:23
            EEGDB.(['subject' num2str(s)]).(['chunk' num2str(i)]).data = M((s-1)*23+i,1:178);
            EEGDB.(['subject' num2str(s)]).(['chunk' num2str(i) ]).label = M((s-1)*23+i,179);
        end
        waitbar(s/12000);
    end

    % Original Matrix Normalization

    M2=zeros(11500,179);

    for i = 1:11500
        Max_r=max(abs(M(i,:)));
        M2(i,:)=M(i,:)/Max_r;
        waitbar((i+500)/12000);
    end
    delete(wb);
    clear i Max_r s
end