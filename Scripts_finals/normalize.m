function X = normalize(M3,M4)
    clc
    X = [M3,M4];        % Feature matrix
    [i,j]=size(X);
    posc=[];
    
    for f=1:i
        for c=1:j
                if(isinf(X(f,c))==1)
                    posc=[posc(:,:),c];
                end
        end
    end

    X(:,posc) = [];     % Final feature matrix without INF values

    % Normalization of features
    X= X./repmat(max(abs(X)),size(X,1),1);
    msgbox('Done','Mensaje');
    
    clear c f i j posc
end