function [DNLvec,DNL,INL,DNLstd,levels] = monotonicPEXstat(n,Vdd,Vss,C,kc,c_spec,cbridge,Cpar11,Cpar12,Cpar21,Cpar22,STP,SBP,STBP,PEX11,PEX12,PEX21,PEX22,PEXB)


%-------------------------------------------------------------------------%

FSR=Vdd-Vss;
LSB=2*FSR/(2^Nbit);

%-------------------------------------------------------------------------%

sigmaC=kc/sqrt(2*C/cspec);
 
utp=(C/cspec)*STP;
utbp=(C/cspec)*STBP;

%------------------------------------------------------------------------%

CAR1=zeros(Nbit-1,2^(Nbit-1));
CAR2=zeros(Nbit-1,2^(Nbit-1));
CAR1(1,1)=C+normrnd(0,C*sigmaC);
CAR2(1,1)=C+normrnd(0,C*sigmaC);
                                 
for i=1:Nbit-1 
        for j=1:(2^(i-1))
        CAR1(i,j)=C + normrnd(0,C*sigmaC);
        CAR2(i,j)=C + normrnd(0,C*sigmaC);
        end
end

CA1=zeros(1,Nbit-1);
 for i=1:Nbit-1
    CA1(i)=sum(CAR1(i,:));
 end
CA1tot=sum(CA1);

CA2=zeros(1,Nbit-1);
for i=1:Nbit-1
    CA2(i)=sum(CAR2(i,:));
end
CA2tot=sum(CA2);

CA1=CA1+fliplr(cat(2,PEX11,PEX12(1:end-1)));
CA2=CA2+fliplr(cat(2,PEX21,PEX22(1:end-1)));
CA1=fliplr(CA1);
CA2=fliplr(CA2);

Cpar11 = Cpar11 + (round(CA1tot/C))*(utp);
Cpar21 = Cpar21 + (round(CA2tot/C))*(utp);

Cmono1= C + utbp + normrnd(0,C*sigmaC) + PEX12(end);
Cmono2= C + utbp + normrnd(0,C*sigmaC) + PEX22(end);

%-------------------BEHAVIOUR AND LEVELS EVALUATION----------------------%

UPcode=[0,1];
DNcode=[1,0];

instart=-FSR;
instop=FSR;
instep=LSB/2;
NN=(instop-instart)/(instep);

k=0;
DACout=zeros(NN+1,Nbit);

for Vind=instart:instep:instop
k=k+1;
CapCode=ones(2,Nbit-1);

DACout_p(k,1)=FSR;
DACout_n(k,1)=FSR;
DACout(k,1)= DACout_p(k,1) - DACout_n(k,1);

if Vind>=0
    CapCode(:,1)=UPcode;
    for bit=2:Nbit 
       
       AUX1=CapCode(1,:);
       AUX2=CapCode(2,:);
       
       DACout_p(k,bit)= FSR*( CA1*AUX1' + Cmono1)/(Cpar11 + CA1tot+Cmono1);
       DACout_n(k,bit)= FSR*( CA2*AUX2' + Cmono2)/(Cpar21 + CA2tot+Cmono2); 
       DACout(k,bit)= DACout_p(k,bit) - DACout_n(k,bit);  % DACout(k,bit)= -FSR*(CA1*AUX1' + Cmono1)/(CA1tot+Cmono1) + (FSR/(CA2tot+Cmono2)*(CA2*AUX2'+Cmono1));     
       Vcfr= - DACout(k,bit);  
     
       if Vind>=Vcfr 
            CapCode(:,bit)=UPcode;
       else
            CapCode(:,bit)=DNcode;
       end              
    end
else
    
    CapCode(:,1)=DNcode;
    
    for bit=2:Nbit 
    
        AUX1=CapCode(1,:);
        AUX2=CapCode(2,:);
    
        DACout_p(k,bit)= FSR*(CA1*AUX1' + Cmono1)/(CA1tot + Cmono1 + Cpar11);
        DACout_n(k,bit)= FSR*(CA2*AUX2' + Cmono2)/(CA2tot + Cmono2 + Cpar21); 
        DACout(k,bit)= DACout_p(k,bit) - DACout_n(k,bit);           
        Vcfr= - DACout(k,bit);
    
        if Vind>=Vcfr 
           CapCode(:,bit) = UPcode;
        else
           CapCode(:,bit) = DNcode;
        end
     end
end
  

end

levels=unique(-DACout)';

%DNL and INL charachteristics evaluation
rgaps=diff(levels);
DNLvec=(rgaps-mean(rgaps))/(mean(rgaps));
INLvec=cumsum(DNLvec);

%Generazione outputs principali.
DNL=max(abs(DNLvec));
INL=max(abs(INLvec));
DNLstd=std(DNLvec);

