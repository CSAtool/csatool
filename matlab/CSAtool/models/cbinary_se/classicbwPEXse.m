function [levels] = classicbwPEXse(Nbit,Vdd,Vss,C,kc,misos,cspec,cbridge,Cpar11,Cpar12,Cpar21,Cpar22,STP,SBP,STBP,PEX11,PEX12,PEX21,PEX22,PEXB)

%------------------------------------------------------------------------%

n=Nbit;
FSR=Vdd-Vss;

%-----------------------------------------------------------------------%

 
sigmaC=kc/sqrt(2*C/cspec)+misos;
 
utp=(C/cspec)*STP;
utbp=(C/cspec)*STBP;

%-----------------------------------------------------------------------%

CAR=zeros(n,2^n);
CAR(1,1)= C + utbp + normrnd(0,C*sigmaC); 

for i=1:n   
        for j=1:(2^(i-1))
        CAR(i+1,j)=C + normrnd(0,C*sigmaC)  + utbp;
        end
end


CA=zeros(1,n);
CA(1)=CAR(2,1);
for i=2:n
    for j=1:(2^(i-1))
        CA(i)=CA(i)+CAR(i+1,j);
    end
end

%total nominal array capacitance
CAtot_nom=CAR(1,1);
for i=1:n
    CAtot_nom=CAtot_nom+CA(i);
end


%adding ppex parasitics
CA = CA + fliplr(cat(2,PEX11,PEX12));

%total array capacitance inclding ppex parasitics
CAtot=CAR(1,1);
for i=1:n
    CAtot=CAtot+CA(i);
end


CA=fliplr(CA); 
Cpar11= Cpar11 + (round(CAtot_nom/C))*(utp);

%----------------------------------------------------------------------%

levels=zeros(1,2^n-1); 

for i=1:(2^n-1)
    AUX=fliplr(de2bi(i,n))';
    levels(i)=(FSR/(CAtot+Cpar11))*(CA*AUX);
end



