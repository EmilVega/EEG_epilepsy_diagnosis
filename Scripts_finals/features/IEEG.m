function y = IEEG(x)
%Calculate the Integrated EEG (IEEG)
y = sum(abs(x));
end