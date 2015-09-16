function [SPEX]=par2spex(vpar,Nbit)

%initialization of PEXmatrix and SplitPEXmatrix
m=Nbit/2;
SPEX=zeros(2,13);

for i=1:(Nbit-1)
spexP(i)=vpar(i);
spexN(i)=spexP(1,i);
end



SPEX(1,1:length(spexP))=fliplr(spexP);
SPEX(2,1:length(spexN))=fliplr(spexN);

end