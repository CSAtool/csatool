function [NormEN,codici]=EA_SBW(Nbit,Vdd,Vss,cunit,cbridge,cspec)

n=Nbit;
kc=0; 
c_spec=cspec;
C=cunit;
FSR=Vdd-Vss;

%stepwise option for MSB's; (1 is not stepwise)
steps=1;  
sigmaC=0;

%Building of the capacitor array with mismatches
CAR=zeros(n-1,2^n);
CAR(1,1)=C+normrnd(0,C*sigmaC); %first unity capacitor of the array with 
                                %his mismatch
for i=1:n-1   
        for j=1:(2^(i-1))
        CAR(i+1,j)=C+normrnd(0,C*sigmaC);
        end
end

%Building the MSB of the capacitor array, with mismatches;
CARMSB=zeros(n-1,2^n);
CARMSB(1,1)=C+normrnd(0,C*sigmaC); %first unity capacitor of the array with 
                                %his mismatch
for i=1:n-1   
        for j=1:(2^(i-1))
        CARMSB(i+1,j)=C+normrnd(0,C*sigmaC);
        end
end

%A capacitor array is represented by a matrix in which rows are the
%capacitive functional blocks associated to the single bits of conversion,
%and columns represents the single unity capacitances (all in parallel)
%which constitute every single functional block;
%now we define the capacitance of every single functional blocks (it could
%be simplified by calculating directly as the sum of unity capacitors plus
%a random C with std of sqrt(2^bit_i)*sigmaC;


%Building the functional capcitor array;
CA=zeros(1,n-1);
CA(1)=CAR(2,1);
for i=2:n-1;
    for j=1:(2^(i-1))
        CA(i)=CA(i)+CAR(i+1,j);
    end
end


Cdummy= C + normrnd(0,C*sigmaC);
CA=fliplr(CA); %needs to be flipped for calculations
CA(n)=Cdummy;


%Building the functional capcitor array for the MSB;
CMSB=zeros(1,n-1);
CMSB(1)=CARMSB(2,1);
for i=2:n-1;
    for j=1:(2^(i-1))
        CMSB(i)=CMSB(i)+CARMSB(i+1,j);
    end
end
Cmsbdummy=C + normrnd(0,C*sigmaC);
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



LSB=FSR/2^n;

%SPLIT CAPACITOR TECHNIQUE------------------------------------------------%

% CMSB=zeros(1,n)
% CMSB(1)=;
% for i=2:n
%     for j=1:(2^(i-1))
%         CA(i)=CA(i)+CAR(i+1,j);
%     end
% end
% CAtot=CAR(1,1);
% for i=1:n
%     CAtot=CAtot+CA(i);
% end

Vcm=0;
Dout=zeros(1,n);   
En=0;

levs=2^n; %numero di livelli data la codifica;
%Dobbiamo testare l'energia data per ogni codice, quindi il codice
%dev'essere noto a priori
%Va considoerato ora il vettore (matrice se per ogni codice )
%delle tensioni al nodo di confronto Vx
%prima di ogni Switch di carica della capacità del bit da testare.
%Inizialmente:


%INDICI CHE TENGONO CONTO DELL'ACCENSIONE DI INTERRUTTORI
numero_switch= 2*n - 1 ;
SW=numero_switch*ones(1,levs);
%nella fase sampling si attivano tutti;
Cgate=1e-15;

En=zeros(levs,n);
Vtest=zeros(levs,n+1);
Vtest(:,1)=Vcm;
codici=0:1:(levs-1);
k=1;
for cod=0:(levs-1)
    
    Dout=fliplr(de2bi(cod,n));
    Dca=zeros(1,n); %vettore delle posiz di capacità connesse a Vdd;
    Dmsb=ones(1,n);
    
    %Dcod=zeros(1,n);
    %Dcapref=zeros(1,n);
    for bit=1:n
       
        j=bit+1;        
        %switchiamo la capacità del bit di interesse;
        
        if bit==1 %test dell'MSB;
           %tutto l'array costituente la capacità dell'MSB è connesso a Vref;
           SW(k)=SW(k)+n;
           Vtest(k,j) = Vcm + FSR*(CMSB*Dmsb')/(CAtot+CMSBtot);
          
           %consumo di base l'energia per connettere la totale capacità msb a
           %Vref;
        
           En_csw = CMSBtot*FSR*(FSR-Vtest(k,j)+Vcm);
        
           En_ref=0;
           
        else %test degli altri bit : bit >=2;
             Dmsb;
             Dca;
             bitCA=bit-1;
             SW(k)=SW(k)+1;
            %Dca(1:bitCA)=Dout(2:bit); %in Dca memorizzo tutti i bit informativi del codice;            
            if Dout(bit-1)==1
                
                Dca(bitCA)=1;
                Vtest(k,j)=FSR*( CMSB*Dmsb' + CA*Dca' )/(CMSBtot+CAtot);                
                En_csw = ( CA(bitCA) )*FSR*(FSR-Vtest(k,j) + Vtest(k,j-1));
                En_ref = ( CMSB*Dmsb'+CA*Dca'-CA(bitCA))*FSR*(-Vtest(k,j) + Vtest(k,j-1)); 
            else
                Dmsb(bitCA)=0;
                Vtest(k,j)=FSR*(CMSB*Dmsb' + CA*Dca')/(CMSBtot+CAtot); 
                En_csw=0;
                En_ref = FSR*(CMSB*Dmsb' + CA*Dca'  )*(-Vtest(k,j) + Vtest(k,j-1));
                
            end
         
        end
        En(k,bit)=En_csw + En_ref;
    end
    k=k+1; 
end

%-----------------------------------------------------------------%
   
NormEN_logic=(SW*(Cgate*Vdd^2)/(C*FSR^2))';
EN=sum(En,2);%/max(sum(En,2)); %ENERGIA ASSOLUTA, SINGOLO ARRAY
AVG_EN=mean(EN);
MAX_EN=max(EN);
CAtot;
NormEN=EN/(C*FSR^2); %ENERGIA NORMALIZZATA A C*Vref^2 , SINGLE ENDED
codici=0:1:length(NormEN); 
% AVG_NormEN=mean(NormEN);
% Energia_media=AVG_NormEN*ones(1,length(codici));



