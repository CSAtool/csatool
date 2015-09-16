function [levels]  = classicbridgePEXse(Nbit,Vdd,Vss,C,kc,misos,cspec,cbridge,Cpar11,Cpar12,Cpar21,Cpar22,STP,SBP,STBP,PEX11,PEX12,PEX21,PEX22,PEXB)

%------------------------------------------------------------------------%

n=Nbit;
FSR=Vdd-Vss;

%-----------------------------------------------------------------------%

 
sigmaC=kc/sqrt(2*C/cspec)+misos;
sigmaCB=kc/sqrt(2*cbridge/cspec)+misos; 

utp=(C/cspec)*STP;
utbp=(C/cspec)*STBP;

btp=(cbridge/cspec)*STP;
bbp=(cbridge/cspec)*SBP;
btbp=(cbridge/cspec)*STBP;
m=Nbit/2;
%-----------------------------------------------------------------------%

CAR1=zeros(m,2^m);
CAR1(1,1)=C+normrnd(0,C*sigmaC); %first unity capacitor of the array with 
                                 %his mismatch
for i=1:m   
        for j=1:(2^(i-1))
        CAR1(i,j)=C + utbp + normrnd(0,C*sigmaC);
        end
end

CAR2=zeros(m,2^m);
CAR2(1,1)=C + utbp +normrnd(0,C*sigmaC); %first unity capacitor of the array with 
                                 %his mismatch
for i=1:m   
        for j=1:(2^(i-1))
        CAR2(i,j)=C + utbp + normrnd(0,C*sigmaC);
        end
end

Cb = cbridge + normrnd(0,cbridge*sigmaCB) + btbp + PEXB(1);     

%Building the functional capcitor array;

%#1
CA1=zeros(1,m);
 for i=1:m
    for j=1:(2^(i-1))
        CA1(i)=CA1(i)+CAR1(i,j);
    end
 end
 
% #2
CA2=zeros(1,m);
 for i=1:m
    for j=1:(2^(i-1))
        CA2(i)=CA2(i)+CAR2(i,j);
    end
 end
 
 %total single-array capcitance NOT including PPEX parasitics
 CA1tot_nom=0;
 for i=1:m
      CA1tot_nom=CA1tot_nom+CA1(i);
 end
 CA2tot_nom=0;
 for i=1:m
     CA2tot_nom=CA2tot_nom+CA2(i);
 end

 
%Adding PPEX parasitics
 
CA1 = CA1 + fliplr(PEX11);
CA2 = CA2 + fliplr(PEX12);


%total single-array capcitance including PPEX parasitics
 CA1tot=0;
 for i=1:m
      CA1tot=CA1tot+CA1(i);
 end
 CA2tot=0;
 for i=1:m
     CA2tot=CA2tot+CA2(i);
 end


CA1 = fliplr(CA1); 
CA2 = fliplr(CA2); 


Cpar11 = Cpar11 + (round(CA1tot_nom/C))*utp + btp;
Cpar12 = Cpar12 + (round(CA2tot_nom/C))*utp + bbp;

Cx1=( Cb * ( CA2tot + Cpar12 ) ) / ( Cb + CA2tot + Cpar12 );
Cx2=( Cb * ( CA1tot + Cpar11 ) ) / ( Cb + CA1tot + Cpar11 );

%----------------------------------------------------%

levels=zeros(1,2^n-1);

for i=1:(2^n-1)
    AUX=fliplr(de2bi(i,n))';
    AUX1=AUX(1:m);
    AUX2=AUX(m+1:n);
    levels(i)=( FSR * (CA1*AUX1) / (CA1tot + Cx1 + Cpar11) + Cb /( CA1tot + Cb + Cpar11 )*( FSR*(CA2*AUX2) /( CA2tot + Cx2 + Cpar12 )) );
end


levels=levels;




