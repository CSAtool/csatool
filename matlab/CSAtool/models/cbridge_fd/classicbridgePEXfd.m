function [levels] = classicbridgePEXfd(Nbit,Vdd,Vss,C,kc,misos,c_spec,cbridge,Cpar11,Cpar12,Cpar21,Cpar22,STP,SBP,STBP,PEX11,PEX12,PEX21,PEX22,PEXB)

%To run as a script
% clear all;
% clc;
% c_spec=1e-15;
% Nbit=10;
% Vdd=0.5;
% Vss=0;
% C=34e-15;
% kc=0;%0.0095;
% STP=0;
% SBP=0;
% STBP=0;
% PEX11=0;
% PEX12=0;
% PEX21=0;
% PEX22=0;
% PEXB=[0 0];
% cbridge=C;
% Cpar11=0;
% Cpar12=0;
% Cpar21=0;
% Cpar22=0;

m=Nbit/2;
sigmaC=kc/sqrt(2*C/c_spec)+misos;
sigmaCb=kc/sqrt(2*cbridge/c_spec)+misos;

utp=(C/c_spec)*STP;
utbp=(C/c_spec)*STBP;

btp=(cbridge/c_spec)*STP;
bbp=(cbridge/c_spec)*SBP;
btbp=(cbridge/c_spec)*STBP;


FSR=Vdd-Vss;


%----------------ARRAY & MISMATCH PARAMETERS EVALUATION-------------------%

CAR11=0; %initialization of the matrix describing the 2nd capacitor array;
CAR12=0;
CAR21=0;
CAR22=0; %initialization of the matrix describing the 2nd capacitor array;
  %stdev of capacitive relative mismatch;


Cb1=cbridge+normrnd(0,cbridge*sigmaCb) + btbp  + PEXB(1);
Cb2=cbridge+normrnd(0,cbridge*sigmaCb) + btbp  + PEXB(2);


%------------BUILDING REAL (with mismatches) CAPACITOR ARRAYS-------------%
%The single capacitor array is represented by a matrix in which rows are the
%capacitive functional blocks associated to the single bits of conversion,
%and columns represents the single unity capacitances (all in parallel)
%which constitute every single functional block;

%The capacitance of every single functional blocks is the sum of the unity 
%capacitors in parallel that constitutes the block,
%each one has a capacitance as the sum of the unity C plus a random gaussian 
%dC with std of sqrt(2^bit_i)*sigmaC;
CAR11=zeros(m,2^m);
CAR11(1,1)=C + utbp + normrnd(0,C*sigmaC); %first unity capacitor of the array with 
                                 %his mismatch
for i=1:m   
        for j=1:(2^(i-1))
        CAR11(i,j)=C+normrnd(0,C*sigmaC) + utbp ;
        end
end

CAR12=zeros(m,2^m);
CAR12(1,1)=C+normrnd(0,C*sigmaC); %first unity capacitor of the array with 
                                 %his mismatch
for i=1:m   
        for j=1:(2^(i-1))
        CAR12(i,j)=C+normrnd(0,C*sigmaC) + utbp;
        end
end

 

%Building the functional capcitor array;

%#1
CA11=zeros(1,m);
 for i=1:m
    for j=1:(2^(i-1))
        CA11(i)=CA11(i)+CAR11(i,j);
    end
 end
 
% #2
CA12=zeros(1,m);
 for i=1:m
    for j=1:(2^(i-1))
        CA12(i)=CA12(i)+CAR12(i,j);
    end
 end
 
 %total single-array capacitance NOT including PPEX parasitics
 CA11tot_nom=0;
 for i=1:m
      CA11tot_nom=CA11tot_nom+CA11(i);
 end
 CA12tot_nom=0;
 for i=1:m
     CA12tot_nom=CA12tot_nom+CA12(i);
 end

%Adding PPEX parasitics
CA11=CA11+fliplr(PEX11); 
CA12=CA12+fliplr(PEX12);


CA11=fliplr(CA11); 
CA12=fliplr(CA12); 

 %total single-array capacitance including PPEX parasitics
 CA11tot=0;
 for i=1:m
      CA11tot=CA11tot+CA11(i);
 end
 CA12tot=0;
 for i=1:m
     CA12tot=CA12tot+CA12(i);
 end


%Negative net array

CAR21=zeros(m,2^m);
CAR21(1,1)=C+normrnd(0,C*sigmaC); %first unity capacitor of the array with 
                                  %his mismatch
for i=1:m   
        for j=1:(2^(i-1))
        CAR21(i,j)=C+normrnd(0,C*sigmaC)+ utbp;
        end
end

CAR22=zeros(m,2^m);
CAR22(1,1)=C+normrnd(0,C*sigmaC); %first unity capacitor of the array with 
                                  %his mismatch
for i=1:m   
        for j=1:(2^(i-1))
        CAR22(i,j)=C+normrnd(0,C*sigmaC)+ utbp;
        end
end



%Bridge Capacitor (Already implemented at the top)

%Building the functional capcitor array;

%#1
CA21=zeros(1,m);
 for i=1:m
    for j=1:(2^(i-1))
        CA21(i)=CA21(i)+CAR21(i,j);
    end
 end
 
% #2

CA22=zeros(1,m);
 for i=1:m
    for j=1:(2^(i-1))
        CA22(i)=CA22(i)+CAR22(i,j);
    end
 end
 
 %total single-array capcitance
 
 %total single-array capacitance NOT including PPEX parasitics
 CA21tot_nom=0;
 for i=1:m
      CA21tot_nom=CA21tot_nom + CA21(i);
 end
 
 CA22tot_nom=0;
 for i=1:m
     CA22tot_nom =CA22tot_nom + CA22(i);
 end

%Adding PPEX parasitics
CA21=CA21+fliplr(PEX21); 
CA22=CA22+fliplr(PEX22);


%total single-array capacitance including PPEX parasitics
CA21tot=0;
for i=1:m
     CA21tot=CA21tot+CA21(i);
end
 
CA22tot=0;
for i=1:m
    CA22tot=CA22tot+CA22(i);
end




CA21=fliplr(CA21); %needs to be flipped for calculations
CA22=fliplr(CA22); %needs to be flipped for calculations



%--------------------------------%

Cpar11= Cpar11 + (round(CA11tot_nom/C))*(utp) + btp;
Cpar12= Cpar12 + (round(CA12tot_nom/C))*(utp) + bbp;
Cpar21= Cpar21 + (round(CA21tot_nom/C))*(utp) + btp;
Cpar22= Cpar22 + (round(CA22tot_nom/C))*(utp) + bbp;

Cx11 =( Cb1 * ( CA12tot + Cpar12 ) ) / ( Cb1 + CA12tot + Cpar12 );
Cx12 =( Cb1 * ( CA11tot + Cpar11 ) ) / ( Cb1 + CA11tot + Cpar11 );
Cx21 =( Cb2 * ( CA22tot + Cpar22 ) ) / ( Cb1 + CA22tot + Cpar22 );
Cx22 =( Cb2 * ( CA21tot + Cpar21 ) ) / ( Cb1 + CA21tot + Cpar21 );


%------------------------ CONVERSION VOLTAGE LEVELS EVALUATION  ----------%

RDAp=zeros(1,2^Nbit-1);
RDAn=zeros(1,2^Nbit-1);
RDA=zeros(1,2^Nbit-1);


for i=1:(2^Nbit-1)
    
    AUXp=fliplr(de2bi(i,Nbit))';
    AUXn=not(AUXp);
    
    AUX11=AUXp(1:m);
    AUX12=AUXp(m+1:Nbit);
    
    AUX21=AUXn(1:m);
    AUX22=AUXn(m+1:Nbit);
    
    RDAp(i)=FSR/(CA11tot+Cpar11+Cx11)*(CA11*AUX11) + Cb1/(CA11tot+Cb1+Cpar11)*(FSR/(CA12tot+Cpar12+Cx12)*(CA12*AUX12));
    
    RDAn(i)=FSR/(CA21tot+Cpar21+Cx21)*(CA21*AUX21) + Cb2/(CA21tot+Cb2+Cpar21)*(FSR/(CA22tot+Cpar22+Cx22)*(CA22*AUX22));
    
    RDA(i)=RDAp(i)-RDAn(i);    

end


%------------------------------INL AND DNL EVALUATION----------------------%


levels=RDA;






















% 


