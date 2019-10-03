function y = RappMaxMedian(x)
%Calculate the Integrated EEG (IEEG)
y = max(envelope(x))/median(envelope(x));
end