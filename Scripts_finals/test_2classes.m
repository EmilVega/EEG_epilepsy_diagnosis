function test_2classes(filename,columnas)
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
        m01=trainedClassifierSVM.predictFcn(extraccionP(:,1:9));
        res(i,1)=sum(extraccionP(:,10)==m01)/length(extraccionP);
    end


    %% Classification 
    
    X=X(:,columnas);
    y=Y==1;

    [A,Wldc,Wqdc, Wknn, error_total, CP_total, Atest]=ldc_qdc_knn(X,y);
    
    [a,b]=size(CP_total)
    [c,d]=size(res)
    
    labelLDC=labeld(Atest,Wldc);
    confmat(Atest.nlab,labelLDC);
    
    labelQDC=labeld(Atest,Wqdc);
    confmat(Atest.nlab,labelQDC);
    
    labelKNN = labeld(Atest,Wknn);
    confmat(Atest.nlab,labelKNN);
    
    SVMconf=confmat(extraccionP(:,10),m01);

    %% Plotting boxplot
    figure
    boxplot([CP_total*100 res*100])
    ylim([70 100])
    
    CP_total2=[CP_total*100 res*100];
    
    %% ROC curves
    class=input('Ingrese la clase a evaluar: ');
    
    curvasROC (A,Wldc,Wqdc,Wknn,extraccionP,SVMdata,class,2)
   
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
    % cell2latextable(error_table,'tablas_latex','errorEx2');
    
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
    disp(SeSp_table);
    
    % To save the table in latex format
    % cell2latextable(SeSp_table,'tablas_latex','SeSpEx2');
    
end

