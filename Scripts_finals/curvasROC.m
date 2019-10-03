function curvasROC (A,Wldc,Wqdc,Wknn,labelsSVM,SVMdata,C,Nc)

    [~,scoresSVM] = predict(SVMdata,labelsSVM(:,1:9));
    
    if (Nc==2)
        if(C==1)
            [X1,Y1]=perfcurve(labelsSVM(:,10),scoresSVM(:,2),1);
            C=2;
        elseif(C==2)
            [X1,Y1]=perfcurve(labelsSVM(:,10),scoresSVM(:,1),0);
            C=1;
        end
    else
        [X1,Y1]=perfcurve(labelsSVM(:,10),scoresSVM(:,C),C);
    end
    
    
    Eldc = prroc(A,Wldc,C,100);
    Eqdc = prroc(A,Wqdc,C,100);
    Eknn = prroc(A,Wknn,C,100);
   
    figure
    hold on
    plot(Eldc.xvalues, 1-Eldc.error)
    plot(Eqdc.xvalues, 1-Eqdc.error)
    plot(Eknn.xvalues, 1-Eknn.error)    
    plot(X1,Y1);
    legend('LDC','QDC','k-NN','SVM','Location','Best')
    xlabel('False positive rate'); ylabel('True positive rate');
    title('ROC Curves for LDC, QDC, k-NN and SVM Classification')
    hold off
end