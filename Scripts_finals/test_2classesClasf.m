function [CP_total, res, A,Wldc,Wqdc,Wknn,extraccionP,SVMdata, error_table, SeSp_table, LDCconf, QDCconf, KNNconf, SVMconf]=test_2classesClasf(filename,columnas)
    %% Initialize variables.
    clc
%   filename = 'FeatNorm_2.csv';
    delimiter = ',';
    startRow = 2;
    % Format for each line of text:
    formatSpec = '%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%[^\n\r]';
    % Open the text file.
    fileID = fopen(filename,'r');
    % Read columns of data according to the format.
    dataArray = textscan(fileID, formatSpec, 'Delimiter', delimiter, 'TextType', 'string', 'EmptyValue', NaN, 'HeaderLines' ,startRow-1, 'ReturnOnError', false, 'EndOfLine', '\r\n');
    % Close the text file.
    fclose(fileID);
    % Create output variable
    dataF = [dataArray{1:end-1}];
    % Clear temporary variables
    clearvars filename delimiter startRow formatSpec fileID dataArray ans;

    X=dataF(:,1:(end-1));
    Y=dataF(:,end);
    wp=waitbar(0, 'Classification SVM...');
    
    clc
    clear res
    j=0.8;   %Porcentaje de entrenamiento
    for i=1:10
        trainingData = [X(:,columnas) Y==1];
        n=unique(trainingData(:,end));
        extraccionE=[];
        extraccionP=[];
        for m=1:length(n)
            prueba=trainingData(trainingData(:,end)==n(m),:);
            p=j;
            a=size(prueba(:,1));
            Vector1=randperm(a(1));
            tama=round(round(a(1)*p));
            Vector2=Vector1(1:tama);
            Vector1=Vector1((tama+1):end);

            extraccionE=[extraccionE;prueba(Vector2,:)];
            extraccionP=[extraccionP;prueba(Vector1,:)];
        end
        trainingData=extraccionE;

        % Model
        [trainedClassifierSVM, SVMdata]= trainClassifierSVM(trainingData);
        %SVMdata2=trainedClassifierSVM.ClassificationSVM;
        m01=trainedClassifierSVM.predictFcn(extraccionP(:,1:9));
        %disp(i);
        
        res(i,1)=sum(extraccionP(:,10)==m01)/length(extraccionP);
        waitbar(i/10);
    end
    delete(wp);

    %% Classification 

    X=X(:,columnas);
    y=Y==1;

    [A,Wldc,Wqdc, Wknn, error_total, CP_total, Atest]=ldc_qdc_knn(X,y);
    
    labelLDC=labeld(Atest,Wldc);
    LDCconf=confmat(Atest.nlab,labelLDC);
    
    labelQDC=labeld(Atest,Wqdc);
    QDCconf=confmat(Atest.nlab,labelQDC);
    
    labelKNN = labeld(Atest,Wknn);
    KNNconf=confmat(Atest.nlab,labelKNN);
    
    SVMconf=confmat(extraccionP(:,10),m01);
    
    %% Tables Mean and Std
    
    error_total=[error_total 1-res];
    
    error_table{1,1} ='Classifier'; error_table{1,2} ='Mean'; error_table{1,3} ='Standard Deviation.';
    error_table{2,1} ='LDC'; error_table{3,1} ='QDC'; error_table{4,1} ='KNN'; error_table{5,1} ='SVM';    
    for i = 2:5 
        error_table{i,2} =mean(error_total(:,i-1));
        error_table{i,3} =std(error_total(:,i-1));
    end
    
    %% Tables Sensitivity and Specificity
    
    SpSVM=SVMconf(1,1)/(SVMconf(1,1)+SVMconf(1,2));
    SeSVM=SVMconf(2,2)/(SVMconf(2,2)+SVMconf(2,1));
    
    LDCres=Atest*Wldc;
    [SeLDC,SpLDC]=testc(LDCres,'sensitivity',1);
    
    QDCres=Atest*Wqdc;
    [SeQDC,SpQDC]=testc(QDCres,'sensitivity',1);
    
    KNNres=Atest*Wknn;
    [SeKNN,SpKNN]=testc(KNNres,'sensitivity',1);
    
    SeSp_table{1,1} ='Classifier'; SeSp_table{1,2} ='Sensitivity'; SeSp_table{1,3} ='Specificity';
    SeSp_table{2,1} ='LDC'; SeSp_table{3,1} ='QDC'; SeSp_table{4,1} ='KNN'; SeSp_table{5,1} ='SVM'; 
    SeSp_table{2,2} =SeLDC; SeSp_table{3,2} =SeQDC; SeSp_table{4,2} =SeKNN; SeSp_table{5,2} =SeSVM;
    SeSp_table{2,3} =SpLDC; SeSp_table{3,3} =SpQDC; SeSp_table{4,3} =SpKNN; SeSp_table{5,3} =SpSVM;

    
end

