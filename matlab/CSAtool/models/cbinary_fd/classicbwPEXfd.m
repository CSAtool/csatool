function [levels] = classicbwPEXfd(Nbit,Vdd,Vss,C,kc,misos,cspec,cbridge,Cpar11,Cpar12,Cpar21,Cpar22,STP,SBP,STBP,PEX11,PEX12,PEX21,PEX22,PEXB)

%------------------------------------------------------------------------%

n=Nbit;
FSR=Vdd-Vss;

%-----------------------------------------------------------------------%

sigmaC=kc/sqrt(2*C/cspec)+misos;
utp=(C/cspec)*STP;
utbp=(C/cspec)*STBP;

%-----------------------------------------------------------------------%

CAR1=zeros(Nbit,2^Nbit);
CAR1(1,1)= C + utbp + normrnd(0,C*sigmaC); 

for i=1:n   
        for j=1:(2^(i-1))
        CAR1(i+1,j)=C + normrnd(0,C*sigmaC)  + utbp;
        end
end


CA1=zeros(1,n);
CA1(1)=CAR1(2,1);
for i=2:Nbit
    for j=1:(2^(i-1))
        CA1(i)=CA1(i)+CAR1(i+1,j);
    end
end

%nominal overall array capacitance
CA1tot_nom=CAR1(1,1);
for i=1:Nbit
    CA1tot_nom=CA1tot_nom+CA1(i);
end

%adding PPEx parasitics
CA1 = CA1 + fliplr(cat(2,PEX11,PEX12));

%overall array capacitance including parasitics
CA1tot=CAR1(1,1);
for i=1:Nbit
    CA1tot=CA1tot+CA1(i);
end


CA1=fliplr(CA1); 
Cpar11= Cpar11 + (round(CA1tot_nom/C))*(utp);

%-------------------------  Negative Net Array   -------------------------%

CAR2=zeros(Nbit,2^Nbit);
CAR2(1,1)= C + utbp + normrnd(0,C*sigmaC); 

for i=1:n   
        for j=1:(2^(i-1))
        CAR2(i+1,j)=C + normrnd(0,C*sigmaC)  + utbp;
        end
end


CA2=zeros(1,n);
CA2(1)=CAR2(2,1);
for i=2:Nbit
    for j=1:(2^(i-1))
        CA2(i)=CA2(i)+CAR2(i+1,j);
    end
end

%nominal overall array capacitance
CA2tot_nom=CAR2(1,1);
for i=1:Nbit
    CA2tot_nom=CA2tot_nom+CA2(i);
end

%adding PPEx parasitics
CA2 = CA2 + fliplr(cat(2,PEX21,PEX22));

%overall array capacitance including parasitics
CA2tot=CAR2(1,1);
for i=1:Nbit
    CA2tot=CA2tot+CA2(i);
end

CA2=fliplr(CA2); 
Cpar21= Cpar21 + (round(CA2tot_nom/C))*(utp);

%----------------------------------------------------------------------%

levels=zeros(1,2^Nbit-1); 

for i=1:(2^Nbit-1)
    
    AUX1=fliplr(de2bi(i,Nbit))';
    AUX2=not(AUX1);
    vp=(FSR/(CA1tot+Cpar11))*(CA1*AUX1);
    vn=(FSR/(CA2tot+Cpar21))*(CA2*AUX2);
    levels(i)=vp-vn;
    
end



