function test_3classes(filename,columnas)
    %% Initialize variables.
    clc
    
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

    % Graph representation
    v1=132;
    v2=151;
    v3=196;

    X=dataF(:,1:(end-1));
    Y=dataF(:,end);

    scatter3(X(:,v1),X(:,v2),X(:,v3),5,Y>1);

    clc
    clear res
    j=0.8;          % Training percentage
    for i=1:10
        trainingData = [X(:,columnas) Y];
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
        
        [trainedClassifierSVM, SVMdata] = trainClassifierSVM_3classes(trainingData);
        
        m01=trainedClassifierSVM.predictFcn(extraccionP(:,1:9));
        m02=string(m01);
        m02=double(m02);
        res(i,1)=sum(extraccionP(:,10)==m02)/length(extraccionP);
    end


    %% Classification 
    
    X=X(:,columnas);
    y=Y;

    [A,Wldc,Wqdc, Wknn, error_total, CP_total, Atest]=ldc_qdc_knn(X,y);
    
    labelLDC=labeld(Atest,Wldc);
    confmat(Atest.nlab,labelLDC);
    
    labelQDC=labeld(Atest,Wqdc);
    confmat(Atest.nlab,labelQDC);
    
    labelKNN = labeld(Atest,Wknn);
    confmat(Atest.nlab,labelKNN);
    
    SVMconf=confmat(extraccionP(:,10),m02);

    %%
    figure
    boxplot([CP_total*100 res*100])
    ylim([50 100])
    
    CP_total2=[CP_total*100 res*100];
    
    %% ROC curves
    class=input('Ingrese la clase a evaluar: ');
    curvasROC (A,Wldc,Wqdc,Wknn,extraccionP,SVMdata,class,3)
    
    %% Tables Mean and Std
    
    error_total=[error_total 1-res];
    
    error_table{1,1} ='Classifier'; error_table{1,2} ='Mean'; error_table{1,3} ='Standard Deviation.';
    error_table{2,1} ='LDC'; error_table{3,1} ='QDC'; error_table{4,1} ='KNN'; error_table{5,1} ='SVM';    
    for i = 2:5 
        error_table{i,2} =mean(error_total(:,i-1));
        error_table{i,3} =std(error_total(:,i-1));
    end
    disp(error_table);
    
    % To save the table in latex format
    % cell2latextable(error_table,'tablas_latex','errorEx5');   
    
    %% Tables Sensitivity and Specificity
    
    SeSVM1=SVMconf(1,1)/(SVMconf(1,1)+SVMconf(1,2)+SVMconf(1,3));
    SpSVM1 = (SVMconf(2,2) + SVMconf(2,3) + SVMconf(3,2) + SVMconf(3,3)) / (SVMconf(2,2) + SVMconf(2,3) + SVMconf(3,2) + SVMconf(3,3) + SVMconf(2,1) + SVMconf(3,1));
    
    SeSVM2=SVMconf(2,2)/(SVMconf(2,2)+SVMconf(2,1)+SVMconf(2,3));
    SpSVM2 = (SVMconf(1,1) + SVMconf(1,3) + SVMconf(3,1) + SVMconf(3,3)) / (SVMconf(1,1) + SVMconf(1,3) + SVMconf(3,1) + SVMconf(3,3) + SVMconf(1,2) + SVMconf(3,2));
    
    SeSVM3=SVMconf(3,3)/(SVMconf(3,3)+SVMconf(3,1)+SVMconf(3,2));
    SpSVM3 = (SVMconf(1,1) + SVMconf(1,2) + SVMconf(2,1) + SVMconf(2,2)) / (SVMconf(1,1) + SVMconf(1,2) + SVMconf(2,1) + SVMconf(2,2) + SVMconf(1,3) + SVMconf(2,3));
    
    LDCres=Atest*Wldc;
    [SeLDC1,SpLDC1]=testc(LDCres,'sensitivity',1);
    [SeLDC2,SpLDC2]=testc(LDCres,'sensitivity',2);
    [SeLDC3,SpLDC3]=testc(LDCres,'sensitivity',3);
    
    QDCres=Atest*Wqdc;
    [SeQDC1,SpQDC1]=testc(QDCres,'sensitivity',1);
    [SeQDC2,SpQDC2]=testc(QDCres,'sensitivity',2);
    [SeQDC3,SpQDC3]=testc(QDCres,'sensitivity',3);
    
    KNNres=Atest*Wknn;
    [SeKNN1,SpKNN1]=testc(KNNres,'sensitivity',1);
    [SeKNN2,SpKNN2]=testc(KNNres,'sensitivity',2);
    [SeKNN3,SpKNN3]=testc(KNNres,'sensitivity',3);
    
    SeSp_table{1,1} ='Classifier'; SeSp_table{1,2} ='Class 1'; SeSp_table{1,4} ='Class 2'; SeSp_table{1,6} ='Class 3';
    
    SeSp_table{2,2} ='Se'; SeSp_table{2,3} ='Sp'; SeSp_table{2,4} ='Se';
    SeSp_table{2,5} ='Sp'; SeSp_table{2,6} ='Se'; SeSp_table{2,7} ='Sp';
    
    SeSp_table{3,1} ='LDC'; SeSp_table{4,1} ='QDC'; SeSp_table{5,1} ='KNN'; SeSp_table{6,1} ='SVM'; 
    
    SeSp_table{3,2} =SeLDC1; SeSp_table{4,2} =SeQDC1; SeSp_table{5,2} =SeKNN1; SeSp_table{6,2} =SeSVM1;
    SeSp_table{3,3} =SpLDC1; SeSp_table{4,3} =SpQDC1; SeSp_table{5,3} =SpKNN1; SeSp_table{6,3} =SpSVM1;
    
    SeSp_table{3,4} =SeLDC2; SeSp_table{4,4} =SeQDC2; SeSp_table{5,4} =SeKNN2; SeSp_table{6,4} =SeSVM2;
    SeSp_table{3,5} =SpLDC2; SeSp_table{4,5} =SpQDC2; SeSp_table{5,5} =SpKNN2; SeSp_table{6,5} =SpSVM2;
    
    SeSp_table{3,6} =SeLDC3; SeSp_table{4,6} =SeQDC3; SeSp_table{5,6} =SeKNN3; SeSp_table{6,6} =SeSVM3;
    SeSp_table{3,7} =SpLDC3; SeSp_table{4,7} =SpQDC3; SeSp_table{5,7} =SpKNN3; SeSp_table{6,7} =SpSVM3;
    
    disp(SeSp_table);
    
    % To save the table in latex format
    % cell2latextable(SeSp_table,'tablas_latex','SeSpEx5');

end