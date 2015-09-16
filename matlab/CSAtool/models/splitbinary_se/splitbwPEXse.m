function [levels]=splitbwPEXse(Nbit,Vdd,Vss,C,kc,misos,cspec,cbridge,Cpar11,Cpar12,Cpar21,Cpar22,STP,SBP,STBP,PEX11,PEX12,PEX21,PEX22,PEXB,SPEX)




%------------------------------------------------------------------------%

n=Nbit;
FSR=Vdd-Vss;

%-----------------------------------------------------------------------%

sigmaC=kc/sqrt(2*C/cspec)+misos;
utp=(C/cspec)*STP;
utbp=(C/cspec)*STBP;

%-----------------------------------------------------------------------%

%-----------------------------------------------------------------------%

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

Cdummy=C + utbp + normrnd(0,C*sigmaC);

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


Cpar11 = Cpar11 + (round((CMSBtot+CAtot)/C))*utp;


%--------------------------------LSB--------------------------------------%


levs=2^n; 

Vtest=zeros(levs,n+1);
Vcm=0;
Dout=zeros(1,n);  


%------------------------------------------------------------------------%


Vtest(:,1)=Vcm;
k=1;
for cod=0:(levs-1)
    
    Dout=fliplr(de2bi(cod,n));
    Dca=zeros(1,n); 
    Dmsb=ones(1,n);
    for bit=1:n
        j=bit+1;        
           if bit==1 
           Vtest(k,j) = Vcm + FSR*(CMSB*Dmsb')/(CAtot+CMSBtot+Cpar11);          
           else              
             bitCA=bit-1;
                      
            if Dout(bit-1)==1
                Dca(bitCA)=1;
                Vtest(k,j)=FSR*( CMSB*Dmsb' + CA*Dca' )/(CMSBtot+CAtot+Cpar11);                
                 
            else
                Dmsb(bitCA)=0;
                Vtest(k,j)=FSR*(CMSB*Dmsb' + CA*Dca')/(CMSBtot+CAtot+Cpar11);            
            end
         
           end
        end
    k=k+1;
    
end

levels=sort(unique(Vtest(:,2:end)))';

%----------------------------INL AND DNL EVAL-----------------------------%







