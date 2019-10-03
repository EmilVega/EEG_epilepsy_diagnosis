function X =  features_dwt(x)

y=zeros(1,180);

[CC,LL]=wavedec(x,5,'db4');
A5 = CC(1 : LL(1));
D5 = CC(LL(1)+1 : LL(1)+LL(2) );
D4 = CC(LL(1) + LL(2) + 1 : LL(1) + LL(2) + LL(3)  );
D3 = CC(LL(1) + LL(2) + LL(3) + 1 : LL(1) + LL(2) + LL(3) + LL(4) );
D2 = CC(LL(1) + LL(2) + LL(3) + LL(4)+1 : LL(1) + LL(2) + LL(3) + LL(4) + LL(5));
D1 = CC(LL(1) + LL(2) + LL(3) + LL(4) + LL(5) + 1 : LL(1) + LL(2) + LL(3) + LL(4) + LL(5) + LL(6));

XA5 = features(A5);
XD5 = features(D5);
XD4 = features(D4);
XD3 = features(D3);
XD2 = features(D2);
XD1 = features(D1);

X = [XA5,XD5,XD4,XD3,XD2,XD1];

end