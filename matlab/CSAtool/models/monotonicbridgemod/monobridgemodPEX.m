function [levels] = monobridgePEX(n,Vdd,Vss,C,kc,c_spec,cbridge,Cpar11,Cpar12,Cpar21,Cpar22,STP,SBP,STBP,PEX11,PEX12,PEX21,PEX22,PEXB)


FSR=Vdd-Vss;
m=n/2;
LSB=2*FSR/2^n; 

%----------------ARRAY & MISMATCH PARAMETERS EVALUATION-------------------%

sigmaC=kc/sqrt(2*C/c_spec);  %stdev of capacitive relative mismatch;
sigmaCB=kc/sqrt(2*cbridge/c_spec); 

utp=(C/c_spec)*STP;
utbp=(C/c_spec)*STBP;

btp=(cbridge/c_spec)*STP;
bbp=(cbridge/c_spec)*SBP;
btbp=(cbridge/c_spec)*STBP;


CAR11=zeros(m,2^m);
CAR11(1,1) = C + utbp + normrnd(0,C*sigmaC); 
for i=1:m   
        for j=1:(2^(i-1))
            CAR11(i,j)= C + utbp + normrnd(0,C*sigmaC);
        end
end

CAR12=zeros(m,2^m);
CAR12(1,1)= C+ utbp   + normrnd(0,C*sigmaC); 
for i=1:m   
        for j=1:(2^(i-1))
            CAR12(i,j)= C + utbp  + normrnd(0,C*sigmaC);
        end
end

%------------------------------------------%

CAR21=zeros(m,2^m);
CAR21(1,1)= C +  utbp   + normrnd(0,C*sigmaC); 
for i=1:m   
        for j=1:(2^(i-1))
        CAR21(i,j)= C + utbp + normrnd(0,C*sigmaC);
        end
end

CAR22=zeros(m,2^m);
CAR22(1,1)= C +   utbp + normrnd(0,C*sigmaC); 
for i=1:m   
        for j=1:(2^(i-1))
        CAR22(i,j)= C + utbp + normrnd(0,C*sigmaC);
        end
end


Cb1=cbridge+ normrnd(0,cbridge*sigmaCB) + btbp + PEXB(1) ;  
Cb2=cbridge+ normrnd(0,cbridge*sigmaCB) + btbp + PEXB(2) ;  



CA11=zeros(1,m);
 for i=1:m
    for j=1:(2^(i-1))
        CA11(i)=CA11(i)+CAR11(i,j);
    end
 end
 

CA12=zeros(1,m);
 for i=1:m
    for j=1:(2^(i-1))
        CA12(i)=CA12(i)+CAR12(i,j);
    end
 end
 
 
 
 %Overall array capacitance NOT including PPEX parasitics
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
 
 %----------------%

 
 %Overall array capacitance including PPEX parasitics
 CA11tot=0;
 for i=1:m
      CA11tot=CA11tot+CA11(i);
 end
 CA12tot=0;
 for i=1:m
     CA12tot=CA12tot+CA12(i);
 end



CA21=zeros(1,m);
 for i=1:m
    for j=1:(2^(i-1))
        CA21(i)=CA21(i)+CAR21(i,j);
    end
 end
 

CA22=zeros(1,m);
 for i=1:m
    for j=1:(2^(i-1))
        CA22(i)=CA22(i)+CAR22(i,j);
    end    
 end
 
 
 %Overall array capacitance NOT including PPEX parasitics
 CA21tot_nom=0;
 
 for i=1:m
      CA21tot_nom=CA21tot_nom+CA21(i);
 end
 
 CA22tot_nom=0;
 
 for i=1:m
     CA22tot_nom=CA22tot_nom+CA22(i);
 end
 
 %Adding PPEX parasitics
 CA21=CA21+fliplr(PEX21);
 CA22=CA22+fliplr(PEX22);

 
 %Overall array capacitance including PPEX parasitics
 CA21tot=0;
 for i=1:m
      CA21tot=CA21tot+CA21(i);
 end
 
 CA22tot=0;
 for i=1:m
     CA22tot=CA22tot+CA22(i);
 end

%---------------%

CA11=fliplr(CA11); %needs to be flipped for calculations
CA12=fliplr(CA12); %needs to be flipped for calculations
CA21=fliplr(CA21); %needs to be flipped for calculations
CA22=fliplr(CA22); %needs to be flipped for calculations

Cpar11= Cpar11 + (round(CA11tot_nom/C))*(utp) + btp;
Cpar12= Cpar12 + (round(CA12tot_nom/C))*(utp) + bbp;
Cpar21= Cpar21 + (round(CA21tot_nom/C))*(utp) + btp;
Cpar22= Cpar22 + (round(CA22tot_nom/C))*(utp) + bbp;

Cx11 =( Cb1 * ( CA12tot + Cpar12 ) ) / ( Cb1 + CA12tot + Cpar12 );
Cx12 =( Cb1 * ( CA11tot + Cpar11 ) ) / ( Cb1 + CA11tot + Cpar11 );
Cx21 =( Cb2 * ( CA12tot + Cpar12 ) ) / ( Cb1 + CA12tot + Cpar12 );
Cx22 =( Cb2 * ( CA11tot + Cpar11 ) ) / ( Cb1 + CA11tot + Cpar11 );


Cmono = C + utbp + normrnd(0,C*sigmaC); 

CA12(m) = Cmono ;
CA22(m) = Cmono ;



%------------CONVERSION VOLTAGE LEVELS EVALUATION ------------------------%

UPcode=[0;1];
DNcode=[1;0];

           
k=0;

%allocating memory;
instart=-FSR;
instop=FSR;
instep=LSB/5;
NN=(instop-instart)/(instep);

DACout=zeros(NN+1,n);
DACout_p=zeros(NN+1,n);
DACout_n=zeros(NN+1,n);
DigitalOut=zeros(NN+1,n);
for Vind=instart:instep:instop
k=k+1;
CapCode=ones(2,n);
CapCode(:,1)=[0;0]; %Modification from monotonic classical algorithm is here

DACout_p(k,1)=FSR;
DACout_n(k,1)=FSR;
DACout(k,1)= DACout_p(k,1) - DACout_n(k,1);

if Vind>=0
    CapCode(:,1)=UPcode;
    for bit=2:n 

    AUX1= CapCode(1,1:m)';
    AUX2= CapCode(1,(m+1):n)';
    NAUX1= CapCode(2,1:m)';
    NAUX2= CapCode(2,(m+1):n)';
    
    DACout_p(k,bit) = Vdd * (CA11*AUX1) / (CA11tot + Cx11 + Cpar11) + Cb1 /( CA11tot + Cb1 + Cpar11 )* Vdd *(CA12*AUX2) /( CA12tot + Cx12 + Cpar12 );
    DACout_n(k,bit) = Vdd * (CA21*NAUX1) / (CA21tot + Cx21 + Cpar21) + Cb2 /( CA21tot + Cb2 + Cpar21 )* Vdd *(CA22*NAUX2) /( CA22tot + Cx22 + Cpar22 );
    
    DACout(k,bit)= DACout_p(k,bit) - DACout_n(k,bit);  
    Vdiff = DACout(k,bit);  
         if (Vind + Vdiff )>= 0 
            CapCode(:,bit)=UPcode;
          else
            CapCode(:,bit)=DNcode;
          end              
    end
else
    CapCode(:,1)=DNcode;
    for bit=2:n %l'ultimo serve solo a produrre l'LSB, che non rientra nel capcode;
    
    AUX1= CapCode(1,1:m)';
    AUX2= CapCode(1,(m+1):n)';
    NAUX1= CapCode(2,1:m)';
    NAUX2= CapCode(2,(m+1):n)';
   
    DACout_p(k,bit) = Vdd * (CA11*AUX1) / (CA11tot + Cx11 + Cpar11) + Cb1 /( CA11tot + Cb1 + Cpar11 )* Vdd *(CA12*AUX2) /( CA12tot + Cx12 + Cpar12 );
    DACout_n(k,bit) = Vdd * (CA21*NAUX1) / (CA21tot + Cx21 + Cpar21) + Cb2 /( CA21tot + Cb2 + Cpar21 )* Vdd *(CA22*NAUX2) /( CA22tot + Cx22 + Cpar22 );
    
    DACout(k,bit)= DACout_p(k,bit) - DACout_n(k,bit);  % DACout(k,bit)= -FSR*(CAP1*AUXP' + Cpdummy)/(CAP1tot+Cpdummy) + (FSR/(CAN1tot+Cndummy)*(CAN1*AUXN'+Cpdummy));
         
    Vdiff = DACout(k,bit);
    if (Vind + Vdiff )>= 0 
           CapCode(:,bit) = UPcode;
         else
           CapCode(:,bit) = DNcode;
    end
    end
DigitalOut(k,:) = CapCode(2,:) ;  
end
  

end

%levels=sort(unique(levs));
levels=unique(-DACout)';


