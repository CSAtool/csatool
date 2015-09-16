%function [DNLvec,DNL,INL,DNLstd]=binarySplitCapSAR(n,Vdd,Vss,C,kc,c_spec)
function [levels]=splitbwPEXfd(Nbit,Vdd,Vss,C,kc,misos,cspec,cbridge,Cpar11,Cpar12,Cpar21,Cpar22,STP,SBP,STBP,PEX11,PEX12,PEX21,PEX22,PEXB,SPEX)


%Versione update

%------------------------------------------------------------------------%

n=Nbit;
FSR=Vdd-Vss;

%-----------------------------------------------------------------------%

sigmaC=kc/sqrt(2*C/cspec)+misos;
utp=(C/cspec)*STP;
utbp=(C/cspec)*STBP;

%-----------------------------------------------------------------------%

%----------------------------------ARRAY P--------------------------------%

CAR=zeros(n-1,2^n);
CAR(1,1)=C+ utbp + normrnd(0,C*sigmaC); 
for i=1:n-1   
        for j=1:(2^(i-1))
        CAR(i+1,j)=C+ utbp + normrnd(0,C*sigmaC);
        end
end

CARMSB=zeros(n-1,2^n);
CARMSB(1,1)= C+ utbp + normrnd(0,C*sigmaC); 
for i=1:n-1   
        for j=1:(2^(i-1))
        CARMSB(i+1,j)= C + utbp + normrnd(0,C*sigmaC);
        end
end

CA=zeros(1,n-1);
CA(1)=CAR(2,1);
for i=2:n-1;
    for j=1:(2^(i-1))
        CA(i)=CA(i)+CAR(i+1,j);
    end
end

Cdummy = C + utbp + normrnd(0,C*sigmaC);

PEX=cat(2,PEX11,PEX12);

CA=CA+fliplr(PEX(2:end));
CA=fliplr(CA); 

CA(n)=Cdummy;

CMSB=zeros(1,n-1);
CMSB(1)=CARMSB(2,1);
for i=2:n-1;
    for j=1:(2^(i-1))
        CMSB(i)=CMSB(i)+CARMSB(i+1,j);
    end
end

Cmsbdummy=C + utbp + normrnd(0,C*sigmaC);

%Adding parasitics from PPEX
CMSB= CMSB + SPEX(1,1:(Nbit-1));
CMSB=fliplr(CMSB);

CMSB(n)=Cmsbdummy;

CAtot=0;
for i=1:n
    CAtot=CAtot+CA(i);
end

CMSBtot=0;
for i=1:n
    CMSBtot=CMSBtot+CMSB(i);
end

%for the role of utp parasitics the nominal total capacitance should be
%considered but here we perform the calculation roughly.....to be corrected
%in the future....
Cpar11 = Cpar11 + (round((CMSBtot+CAtot)/C))*utp;






%-------------------------------------ARRAY N----------------------------%
CAR2=zeros(n-1,2^n);
CAR2(1,1)=C+ utbp + normrnd(0,C*sigmaC); 
for i=1:n-1   
        for j=1:(2^(i-1))
        CAR2(i+1,j)=C+ utbp + normrnd(0,C*sigmaC);
        end
end

CARMSB2=zeros(n-1,2^n);
CARMSB2(1,1)= C+ utbp + normrnd(0,C*sigmaC); 
for i=1:n-1   
        for j=1:(2^(i-1))
        CARMSB2(i+1,j)= C + utbp + normrnd(0,C*sigmaC);
        end
end

CA2=zeros(1,n-1);
CA2(1)=CAR2(2,1);
for i=2:n-1;
    for j=1:(2^(i-1))
        CA2(i)=CA2(i)+CAR2(i+1,j);
    end
end

Cdummy2=C + utbp + normrnd(0,C*sigmaC);

PEX2=cat(2,PEX21,PEX22);

CA2=CA2+fliplr(PEX2(2:end));
CA2=fliplr(CA2); 

CA2(n)=Cdummy2;

CMSB2=zeros(1,n-1);
CMSB2(1)=CARMSB2(2,1);
for i=2:n-1;
    for j=1:(2^(i-1))
        CMSB2(i)=CMSB2(i)+CARMSB2(i+1,j);
    end
end

Cmsbdummy2=C + utbp + normrnd(0,C*sigmaC);
CMSB2= CMSB2 + SPEX(2,1:(Nbit-1));
CMSB2=fliplr(CMSB2);

CMSB2(n)=Cmsbdummy2;



CA2tot=0;
for i=1:n
    CA2tot=CA2tot+CA2(i);
end

CMSB2tot=0;
for i=1:n
    CMSB2tot=CMSB2tot+CMSB2(i);
end


%for the role of utp parasitics the nominal total capacitance should be
%considered but here we perform the calculation roughly.....to be corrected
%in the future....
Cpar21 = Cpar21 + (round((CMSB2tot+CA2tot)/C))*utp;



%--------------------------------LSB--------------------------------------%

levs=2^n; 

%caso reale:
Vtest=zeros(levs,n+1);
Vcm=0;
Dout=zeros(1,n);  


%------------------------------------------------------------------------%


VtestP(:,1)=Vcm;
VtestN(:,1)=Vcm;
k=1;
for cod=0:(levs-1)
    
    Dout=fliplr(de2bi(cod,n));
    DcaP=zeros(1,n); %vettore delle posiz di capacità connesse a Vdd;
    DmsbP=ones(1,n);
    DcaN=not(DcaP);
    DmsbN=not(DmsbP);
    
    for bit=1:n
       
        j=bit+1;        
        %switchiamo la capacità del bit di interesse;
        
        if bit==1 %test dell'MSB;
           %tutto l'array costituente la capacità dell'MSB è connesso a Vref;
           VtestP(k,j) = Vcm + FSR*(CMSB*DmsbP'+ CA*DcaP')/(CAtot+CMSBtot+Cpar11) ;         
           VtestN(k,j) = Vcm + FSR*(CMSB2*DmsbN'+ CA2*DcaN')/(CA2tot+CMSB2tot+Cpar21);  
           Vtest(k,j) = VtestP(k,j) - VtestN(k,j);
        else %test degli altri bit : bit >=2;             
            bitCA=bit-1;            
            if Dout(bit-1)==1
                DcaP(bitCA)=1;
                DcaN(bitCA)=0;
                VtestP(k,j) = FSR*( CMSB*DmsbP' + CA*DcaP' )/(CMSBtot+CAtot+Cpar11);                
                VtestN(k,j) = FSR*( CMSB2*DmsbN' + CA2*DcaN' )/(CMSB2tot+CA2tot+Cpar21);
                Vtest(k,j)=VtestP(k,j)-VtestN(k,j);
            else
                DmsbP(bitCA)=0;
                DmsbN(bitCA)=1;
                VtestP(k,j) = FSR*( CMSB*DmsbP' + CA*DcaP')/(CMSBtot+CAtot+Cpar11); 
                VtestN(k,j) = FSR*( CMSB2*DmsbN' + CA2*DcaN')/(CMSB2tot+CA2tot+Cpar21); 
                Vtest(k,j)=VtestP(k,j)-VtestN(k,j);
            end
         
        end  
    end
    k=k+1;
end

levels=sort(unique(Vtest(:,2:end)))';

%----------------------------INL AND DNL EVAL-----------------------------%







