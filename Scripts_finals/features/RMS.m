function y = RMS(x)
%calcule the Root Mean Square RMS
y = sqrt(sum(x.^2)/length(x));
end