function [NormEN,codici]=EA_BWA(Nbit,Vdd,Vss,cunit,cbridge,cspec)


n=Nbit;
kc=0; 
c_spec=cspec;
C=cunit;
FSR=Vdd-Vss;

%stepwise option for MSB's; (1 is not stepwise)
steps=1;  


%----------------ARRAY & MISMATCH PARAMETERS EVALUATION-------------------%


sigmaC=0;  %stdev of capacitive relative mismatch;
m=n/2;

%------------BUILDING REAL (with mismatches) CAPACITOR ARRAYS-------------%
%The single capacitor array is represented by a matrix in which rows are the
%capacitive functional blocks associated to the single bits of conversion,
%and columns represents the single unity capacitances (all in parallel)
%which constitute every single functional block;

%The capacitance of every single functional blocks is the sum of the unity 
%capacitors in parallel that constitutes the block,
%each one has a capacitance as the sum of the unity C plus a random gaussian 
%dC with std of sqrt(2^bit_i)*sigmaC;
CAR1=zeros(m,2^m);
CAR1(1,1)=C+normrnd(0,C*sigmaC); %first unity capacitor of the array with 
                                 %his mismatch
for i=1:m   
        for j=1:(2^(i-1))
        CAR1(i,j)=C+normrnd(0,C*sigmaC);
        end
end

CAR2=zeros(m,2^m);
CAR2(1,1)=C+normrnd(0,C*sigmaC); %first unity capacitor of the array with 
                                 %his mismatch
for i=1:m   
        for j=1:(2^(i-1))
        CAR2(i,j)=C+normrnd(0,C*sigmaC);
        end
end

Cs=C+normrnd(0,C*sigmaC);      %Split Capacitor

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
 
 %total single-array capcitance
 CA1tot=0;
 for i=1:m
      CA1tot=CA1tot+CA1(i);
 end
 CA2tot=0;
 for i=1:m
     CA2tot=CA2tot+CA2(i);
 end



CA1=fliplr(CA1); %needs to be flipped for calculations
CA2=fliplr(CA2); %needs to be flipped for calculations

Cx1=C;%(Cs*CA2tot)/(Cs+CA2tot);
Cx2=(Cs*CA1tot)/(Cs+CA1tot);

%-----------BUILDING IDEAL (No Mismatch) FUNC. CAPACITOR ARRAYS-----------%

CAid=zeros(1,m);
for i=1:m
    CAid(i)=C*2^(i-1);
end
CAid=fliplr(CAid);
%CA1id o CA2id sono = se non ci sono mismatch

% total single array capacitance
CAtotid=0;
for i=1:m
    CAtotid=CAtotid+CAid(i);
end
Csid=C;

Cxid=(C*CAtotid)/(C+CAtotid);

%------------------------SAR ALGORYTHM-ENERGY-----------------------------%

CD1=CA1tot+Cx1; %Capacità totale vista al primo array;
CD2=CA2tot+Cx2; %Capacità totale vista al secondo array;
D1=zeros(1,m); %initialization of the vector of the "on" switches of the 1array 
D2=zeros(1,m); %initialization of the vector of the "on" switches of the 2array 
Analog_out=zeros(1,n);
levs=2^n; %numero di livelli dati i bit;

%Dobbiamo testare l'energia data per ogni codice, quindi il codice
%dev'essere noto a priori
%Va considoerato ora il vettore (matrice se per ogni codice )
%delle tensioni al nodo di confronto Vx
%prima di ogni Switch di carica della capacità del bit da testare.
%Inizialmente:
LSB=FSR/2^n;
Vcm=0;
k=0;
En=zeros(levs,n);
En1=zeros(levs,n/2);
En2=zeros(levs,n/2);
Vta=zeros(levs,n+1); %Vettore delle tensioni agli steps di test del nodo di confronto (array1)
Vtb=zeros(levs,n+1); %Vettore delle tensioni ali steps di test al top dell'array2;
Vta(:,1)=Vcm;
Vtb(:,1)=Vcm;
codici=0:1:(levs-1);
En_csw=0;
En_csw2=0;
En_ref=0;
En_ref2=0;

%INDICI CHE TENGONO CONTO DELL'ACCENSIONE DI INTERRUTTORI
numero_switch=n;
SW=numero_switch*ones(1,levs);
%nella fase sampling si attivano tutti;
Cgate=1e-15;

p=1;
for cod=(levs-levs):(levs-1)  %scorrono i livelli;
    k=k+1; %contatore che indica a che numero di livello si è in ogni iterazione
    Dout=fliplr(de2bi(cod,n));
      D1=Dout(1:n/2);
      D2=Dout(n/2+1:n);
      Dt1=zeros(1,n/2);
      Dt2=zeros(1,n/2);
     % Dcup=zeros(1,n/2);
      
      %PRIMO ARRAY:;
      for i=1:n/2;
            SW(k)=SW(k)+1;
            j=i+1;
            Dt1(1:i)=D1(1:i); %Connettiamo a Vref le previste capacità precedenti dell'array;
            Dt1(i)=1; %prevediamo di alzare la capacità dell'i-esimo bit per il test;
            if i==1
              Vta(k,j)=Vcm+FSR*(CA1*Dt1')/(CA1tot+Cx1);
              Vtb(k,j)=Vta(k,j)*(Cs/(Cs+CA2tot)); %per completezza
              
              En_csw=(1/steps)*CA1(i)*FSR*(FSR-Vta(k,j)-(-Vcm));
              
              En_ref=0;
            else
               Dcup1=Dt1;
               Dcup1(i)=0;
               Dcup1(i-1)=0;
               CV1=CA1*Dcup1'; %le ALTRE capacità connesse a Vref (non Cbit, non Cbit-1);
               Vta(k,j)=Vcm+FSR*(CA1*Dt1')/(CA1tot+Cx1);
               Vtb(k,j)=Vta(k,j)*(Cs/(Cs+CA2tot)); %MA PER ORA NON IMPORTA: non ci sono ancora capacità switchate nel secondo array, per cui c'è solo l'attenuazione alla kirchoff;
               En_csw= CA1(i)*FSR*(FSR-Vta(k,j)-(-Vta(k,j-1)));
               if D1(i-1)==1 %cioè SE LA CAPACITA DEL BIT PRECEDENTE RESTA CONNESSA A VREF...
                    %la tensione VA assume il valore post switching con la cap precedente a Vref;   
                    %l'energia spesa è relativa alla capacità switchata come al
                    %solito più alla variazione di tensione sulle capacità
                    %precedenti (solo array 1 per ora) connesse a Vref, compresa la Capacità del bit
                    %precedente, che resta , appunto, collegata a Vref;
                    En_ref=(CA1(i-1)+CV1)*FSR*(-Vta(k,j) + Vta(k,j-1));                                   
               else %cioè SE INVECE TORNA CONNESSA A VSS(GND)...
                    %l'energia spesa è relativa alla capacità switchata come al
                    %solito più alla variazione di tensione sulle capacità
                    %precedenti connesse a Vref, senza la Capacità del bit
                    %precedente, che torna a gnd;
                    En_ref=CV1*FSR*(-Vta(k,j) + Vta(k,j-1));                   
                    %Dt1(i-1)=D1(i-1);
               end
                 
            end
            En1(k,i)=En_csw + En_ref;
      end
      En_csw2=0;
      En_ref2=0;
      
      
      %SECONDO ARRAY
      
      for i=1:n/2
            SW(k)=SW(k)+1;
            j=1+i+n/2;
            Dt2(1:i)=D2(1:i); %Connettiamo a Vref le previste capacità precedenti dell'array;
            Dt2(i)=1; %prevediamo di alzare la capacità dell'i-esimo bit per il test;
            CV1=CA1*D1'; %somma di tutte le capacità connesse a Vref del primo array,solo in base al codice;
                      
            Vta(k,j)= Vcm + FSR*(CV1)/(CA1tot+Cx1) + ((FSR*CA2*Dt2'/(CA2tot+Cx2)))*(Cs/(Cs+CA1tot)); %Calcolato con la sovrapposizione degli effetti = Vta\a + Vta|b;
            
            Vtb(k,j)= Vcm + FSR*CA2*Dt2'/(CA2tot+Cx2)+ FSR*(CV1)/(CA1tot+Cx1)*(Cs/(CA2tot+Cs)) ; %Calcolato con la sovrapposizione degli effetti =Vtb\va + Vtb\vb;
            
            
            if i==1       
              
              En_csw2=(1/steps)*CA2(i)*FSR*(FSR-Vtb(k,j)-(-Vtb(k,j-1))); 
              En_ref2=CV1*FSR*(-Vta(k,j) + Vta(k,j-1));                                 
              VX(k)=(-Vta(k,j) + Vta(k,j-1));
              VPX(k)=Vta(k,j-1);
              VSX(k)=Vta(k,j);
              ES(p)=En_csw2;
              ER(p)=En_ref2;
              EX(p)=En_ref2+En_csw2;
              p=p+1;
            else
                Dcup2=Dt2; 
                Dcup2(i-1)=0;
                Dcup2(i)=0;
                CV2=CA2*Dcup2'; %le ALTRE capacità connesse a Vref del secondo array (non Cbit, non Cbit-1);
              
                En_csw2= CA2(i)*FSR*(FSR-Vtb(k,j)-(-Vtb(k,j-1)));
                
                if D2(i-1)==1
                      
                      En_ref2=(CV1)*FSR*(-Vta(k,j) + Vta(k,j-1)) + FSR*(CV2+CA2(i-1))*(-Vtb(k,j) + Vtb(k,j-1)); 
               
                else
                      En_ref2=(CV1)*FSR*(-Vta(k,j) + Vta(k,j-1)) + FSR*(CV2)*(-Vtb(k,j) + Vtb(k,j-1)); 
                end
                
            end
     %Energia associata alla carica-scarica delle capacità conn. a Vdd;
     %Energia spesa nello step;
     En2(k,i)=En_csw2+En_ref2;  
     end
          
end
        
      



EN1=sum(En1,2);
% figure(2)
% plot(codici,EN1,'LineWidth',1.5);
% title('Energy consumption vs Output Code - MSBs Array');
% grid on;

EN2=sum(En2,2);
% figure(3)
% plot(codici,EN2,'LineWidth',1.5)
% title('Energy Consupmtion vs Output Code - LSBs Array')
% grid on;

EN=EN1+EN2;%/max(sum(En,2)); %ENERGIA ASSOLUTA ARRAY SINGLE ENDED
NormEN_logic=(SW*(Cgate*Vdd^2)/(C*FSR^2))';
NormEN=2*EN/(C*FSR^2); %ENERGIA NORMALIZZATA A CVREF^2 PER UN FULLY DIFF.(*2...)
codici=0:1:length(NormEN);
% AVG_EN=mean(EN);
% MAX_EN=max(EN);
% 
% AVG_NormEN=mean(NormEN);
% Energia_media=AVG_NormEN*ones(1,length(codici));














