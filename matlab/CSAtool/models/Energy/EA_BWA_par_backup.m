function [NormEN,codici, NormEN_P, NormEN_N]=EA_BWA_par_backup(Nbit,Vdd,Vss,cunit,kc,misos,cspec,cbridge,Cpar11,Cpar12,Cpar21,Cpar22,STP,SBP,STBP,PEX11,PEX12,PEX21,PEX22,PEXB)

NormEN_P=0;
NormEN_N=0; %solo per compatiiblità con CSAtool mentre la intercambio con la funzione aggiornata 
%per debuggare.


%FULLY DIFFERENTIAL BWA ENERGY MODEL
steps=1;
n=Nbit;
c_spec=cspec;
C=cunit;
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

Cs=Cb1;
Cs2=Cb2;

CA11tot=CA11tot+Cpar11;
CA12tot=CA12tot+Cpar12;
CA21tot=CA21tot+Cpar21;
CA22tot=CA22tot+Cpar22;

%------------------------SAR ALGORYTHM-ENERGY-----------------------------%


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

%Energy associated to the swithcing of the p branch
En1=zeros(levs,n/2);
En2=zeros(levs,n/2);

%Energy associated to the swithcing of the n branch
En1n=zeros(levs,n/2);
En2n=zeros(levs,n/2);


Vta1=zeros(levs,n+1); %Vettore delle tensioni agli steps di test del nodo di confronto (array1)
Vtb1=zeros(levs,n+1); %Vettore delle tensioni ali steps di test al top dell'array2;
Vta1(:,1)=Vcm;
Vtb1(:,1)=Vcm;


%Sub-DAC of the second branch
Vta2=zeros(levs,n+1); %Vettore delle tensioni agli steps di test del nodo di confronto (array1)
Vtb2=zeros(levs,n+1); %Vettore delle tensioni ali steps di test al top dell'array2;
Vta2(:,1)=Vcm;
Vtb2(:,1)=Vcm;







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
     %Dcup=zeros(1,n/2); %giusto che sia commentato
      
      %PRIMO ARRAY:;
      for i=1:n/2;
            SW(k)=SW(k)+1;
            j=i+1;
            Dt1(1:i)=D1(1:i); %Connettiamo a Vref le previste capacità precedenti dell'array;
            Dt1(i)=1; %prevediamo di alzare la capacità dell'i-esimo bit per il test;
            
            %Aggiunta Fully differential:
            Dt1n(1:i)=not(D1(1:i)); %Connettiamo a Vref le previste capacità precedenti dell'array;
            Dt1n(i)=0; %prevediamo di abbassare la capacità dell'i-esimo bit per il test (sull'altro array è alzata);
            
            if i==1
              Vta1(k,j)=Vcm+FSR*(CA11*Dt1')/(CA11tot+Cx11);
              Vtb1(k,j)=Vta1(k,j)*(Cs/(Cs+CA12tot)); %per completezza
              
              
              
              En_csw=(1/steps)*CA11(i)*FSR*(FSR-Vta1(k,j)-(-Vcm));
              En_ref=0;
              
            else
               Dcup1=Dt1;
               Dcup1(i)=0;
               Dcup1(i-1)=0;
               CV1=CA11*Dcup1'; %le ALTRE capacità connesse a Vref (non Cbit, non Cbit-1);
               Vta1(k,j)=Vcm+FSR*(CA11*Dt1')/(CA11tot+Cx11);
               Vtb1(k,j)=Vta1(k,j)*(Cs/(Cs+CA12tot)); %MA PER ORA NON IMPORTA: non ci sono ancora capacità switchate nel secondo array, per cui c'è solo l'attenuazione alla kirchoff;
               En_csw= CA11(i)*FSR*(FSR-Vta1(k,j)-(-Vta1(k,j-1)));
               if D1(i-1)==1 %cioè SE LA CAPACITA DEL BIT PRECEDENTE RESTA CONNESSA A VREF...
                    %la tensione VA assume il valore post switching con la cap precedente a Vref;   
                    %l'energia spesa è relativa alla capacità switchata come al
                    %solito più alla variazione di tensione sulle capacità
                    %precedenti (solo array 1 per ora) connesse a Vref, compresa la Capacità del bit
                    %precedente, che resta , appunto, collegata a Vref;
                    En_ref=(CA11(i-1)+CV1)*FSR*(-Vta1(k,j) + Vta1(k,j-1));                                   
               else %cioè SE INVECE TORNA CONNESSA A VSS(GND)...
                    %l'energia spesa è relativa alla capacità switchata come al
                    %solito più alla variazione di tensione sulle capacità
                    %precedenti connesse a Vref, senza la Capacità del bit
                    %precedente, che torna a gnd;
                    En_ref=CV1*FSR*(-Vta1(k,j) + Vta1(k,j-1));                   
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
            CV1=CA11*D1'; %somma di tutte le capacità connesse a Vref del primo array,solo in base al codice;
                      
            Vta1(k,j)= Vcm + FSR*(CV1)/(CA11tot+Cx11) + ((FSR*CA12*Dt2'/(CA12tot+Cx12)))*(Cs/(Cs+CA11tot)); %Calcolato con la sovrapposizione degli effetti = Vta1\a + Vta1|b;
            
            Vtb1(k,j)= Vcm + FSR*CA12*Dt2'/(CA12tot+Cx12)+ FSR*(CV1)/(CA11tot+Cx11)*(Cs/(CA12tot+Cs)) ; %Calcolato con la sovrapposizione degli effetti =Vtb\va + Vtb\vb;
            
            
            if i==1       
              
              En_csw2=(1/steps)*CA12(i)*FSR*(FSR-Vtb1(k,j)-(-Vtb1(k,j-1))); 
              En_ref2=CV1*FSR*(-Vta1(k,j) + Vta1(k,j-1));                                 
              VX(k)=(-Vta1(k,j) + Vta1(k,j-1));
              VPX(k)=Vta1(k,j-1);
              VSX(k)=Vta1(k,j);
              ES(p)=En_csw2;
              ER(p)=En_ref2;
              EX(p)=En_ref2+En_csw2;
              p=p+1;
            else
                Dcup2=Dt2; 
                Dcup2(i-1)=0;
                Dcup2(i)=0;
                CV2=CA12*Dcup2'; %le ALTRE capacità connesse a Vref del secondo array (non Cbit, non Cbit-1);
              
                En_csw2= CA12(i)*FSR*(FSR-Vtb1(k,j)-(-Vtb1(k,j-1)));
                
                if D2(i-1)==1
                      
                      En_ref2=(CV1)*FSR*(-Vta1(k,j) + Vta1(k,j-1)) + FSR*(CV2+CA12(i-1))*(-Vtb1(k,j) + Vtb1(k,j-1)); 
               
                else
                      En_ref2=(CV1)*FSR*(-Vta1(k,j) + Vta1(k,j-1)) + FSR*(CV2)*(-Vtb1(k,j) + Vtb1(k,j-1)); 
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
NormEN=EN/(C*FSR^2); %ENERGIA NORMALIZZATA A CVREF^2 PER UN FULLY DIFF.(*2...)
codici=0:1:length(NormEN);
% AVG_EN=mean(EN);
% MAX_EN=max(EN);
% 
% AVG_NormEN=mean(NormEN);
% Energia_media=AVG_NormEN*ones(1,length(codici));











