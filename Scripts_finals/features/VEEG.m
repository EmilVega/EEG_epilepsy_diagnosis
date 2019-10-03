function y = VEEG(x)
%Calculate the Variance of EEG (VAR)
y = sum(x.^2)/(length(x)-1);
end