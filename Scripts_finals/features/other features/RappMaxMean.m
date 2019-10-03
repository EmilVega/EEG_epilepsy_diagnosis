function y = RappMaxMean(x)
%Calculate the Integrated EEG (IEEG)
y = max(envelope(x))/mean(envelope(x));
end