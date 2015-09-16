function [PEXM]=par2pexm(vpar,vpar2,Nbit)

%initialization of PEXmatrix and SplitPEXmatrix
m=Nbit/2;
PEXM=zeros(5,Nbit/2);
SPEX=zeros(2,13);


for i=1:m
        PEX12(i)=vpar(i);
        PEX11(i)=vpar(i+7);
        PEX22(i)=vpar2(i);
        PEX21(i)=vpar2(i+7);
end
pexbp=vpar(17);
pexbn=vpar(17);

PEXM=zeros(5,Nbit/2);
PEXM(1,1:m)= fliplr(PEX11);
PEXM(2,1:m)= fliplr(PEX12);
PEXM(3,1:m)= fliplr(PEX21);
PEXM(4,1:m)= fliplr(PEX22);
PEXM(5,1:2)=[pexbp pexbn];



end