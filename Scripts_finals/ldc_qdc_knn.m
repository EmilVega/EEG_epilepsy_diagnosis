function [A, Wldc, Wqdc, Wknn, error_total, CP_total, Atest]=ldc_qdc_knn(X,y)
%     if graph_op == 1
%         %subplot(131)
%         figure
%         imagesc(y)
%         %subplot(132)
%         figure
%         hist(y)
%         %subplot(133)
%         f = [1 2 3];
%         figure
%         scatter3(X(:,f(1)),X(:,f(2)),X(:,f(3)),50,y,'fill')
%         xlabel(['Feature' num2str(f(1))])
%         ylabel(['Feature' num2str(f(2))])
%         zlabel(['Feature' num2str(f(3))])
%     end

    A = prdataset(X,y);
    Niter = 10;
    for i = 1:Niter
        [Atrain,Atest] = gendat(A,0.8);
        %scatterd(Atrain)
        %scatterd(Atest)

        Wldc                  = ldc(Atrain);
        Wqdc                  = qdc(Atrain);
        Wknn                  = knnc(Atrain);
        Wtotal                = {Wldc, Wqdc, Wknn};
        error_total(i,:)      = testc(Atest*Wtotal);
        CP_total(i,:)         = 1-testc(Atest*Wtotal);
    end
    % scatterd(Atest)
    % plotc(Wtotal)
end