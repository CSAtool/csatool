function [NormEN,codici, NormEN_P, NormEN_N]=EA_BWA_par(Nbit,Vdd,Vss,cunit,kc,misos,cspec,cbridge,Cpar11,Cpar12,Cpar21,Cpar22,STP,SBP,STBP,PEX11,PEX12,PEX21,PEX22,PEXB)

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
disp('FD')
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
D1n=not(D1);
D2n=not(D2);

%SMARTAROC
D1n=(D1);
D2n=(D2);



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

%Energy associated to the swithcing of the P branch
En1=zeros(levs,n/2);
En2=zeros(levs,n/2);

%Energy associated to the swithcing of the N branch
En1n=zeros(levs,n/2);
En2n=zeros(levs,n/2);


VtaP=zeros(levs,n+1); %Vettore delle tensioni agli steps di test del nodo di confronto (array1)
VtbP=zeros(levs,n+1); %Vettore delle tensioni ali steps di test al top dell'array2;
VtaP(:,1)=Vcm;
VtbP(:,1)=Vcm;


%Sub-DAC of the second branch
VtaN=zeros(levs,n+1); %Vettore delle tensioni agli steps di test del nodo di confronto (array1)
VtbN=zeros(levs,n+1); %Vettore delle tensioni ali steps di test al top dell'array2;
VtaN(:,1)=Vcm;
VtbN(:,1)=Vcm;

codici=0:1:(levs-1);

En_csw=0;
En_csw2=0;
En_ref=0;
En_ref2=0;

En_csw_n=0;
En_csw2_n=0;
En_ref_n=0;
En_ref2_n=0;

p=1;

for cod=(levs-levs):(levs-1)  %Scanning levels according to the traditional switching algorthm;
      k=k+1; %Counter of the level number at each iteration
      Dout=fliplr(de2bi(cod,n));
      
      %Fully differential - Branch P
      D1=Dout(1:n/2);
      D2=Dout(n/2+1:n);
      
%       %Fully differential - Branch N 
%       D1n=not(D1);
%       D2n=not(D2);
      
      %Fully differential - Branch N - SMARTAROC
      D1n=D1;
      D2n=D2;
      
      
      %----------------------------%
      
      %Fully differential - Branch P
      Dt1=zeros(1,n/2);
      Dt2=zeros(1,n/2);
      
%       %Fully differential - Branch N
%       Dt1n=not(Dt1); 
%       Dt2n=not(Dt2); 
      
      %Fully differential - Branch N - SMARTAROC
      Dt1n=Dt1; 
      Dt2n=Dt2; 
      
      %-----------------------------%
      
    
      
      %PRIMO ARRAY:;
      for i=1:n/2;
            
            j=i+1;
            
            %Branch P
            Dt1(1:i)=D1(1:i);   %Connettiamo a Vref le previste capacità precedenti dell'array;
            Dt1(i)=1;           %prevediamo di alzare la capacità dell'i-esimo bit per il test;
            
%             %Fully differential - Branch N:
%             Dt1n(1:i)=D1n(1:i); %Connettiamo a Vss le previste capacità precedenti dell'array;
%             Dt1n(i)=0;
            
            %Fully differential - Branch N - SMART TAROC
            Dt1n(1:i)=D1(1:i); %Connettiamo a Vss le previste capacità precedenti dell'array;
            Dt1n(i)=1;
            
            %--------------------%
             
            
            if i==1
                
              %Fully differential - Branch P
              VtaP(k,j)=Vcm+FSR*(CA11*Dt1')/(CA11tot+Cx11);
              VtbP(k,j)=VtaP(k,j)*(Cs/(Cs+CA12tot));    %per completezza
              
              %Fully differential - Branch N
              VtaN(k,j)=Vcm+FSR*(CA21*Dt1n')/(CA21tot+Cx21);
              VtbN(k,j)=VtaN(k,j)*(Cs2/(Cs2+CA22tot));  %per completezza
              
              
              %--------------------%
              
              %Fully differential - Branch P
              En_csw=(1/steps)*CA11(i)*FSR*(FSR-VtaP(k,j)-(-Vcm));
              En_ref=0;
              
              %Fully differential - Branch N
              En_csw_n=(1/steps)*CA21(i)*FSR*(FSR-VtaN(k,j)-(-Vcm));
              En_ref_n=0;
              %--------------------%
              

            else
               %Fully differential - Branch P
               Dcup1=Dt1;
               Dcup1(i)=0;
               Dcup1(i-1)=0;
               
%                %Fully differential - Branch N
%                Dcup1n=Dt1n;
%                Dcup1n(i-1)=1;
%                Dcup1n(i)=1;
                
               
               %Fully differential - Branch N - SMARTAROC
               Dcup1n=Dt1;
               Dcup1n(i-1)=0;
               Dcup1n(i)=0;
               
               
               
               
               %Fully differential - Branch P
               CV1=CA11*Dcup1'; %le ALTRE capacità connesse a Vref (non Cbit, non Cbit-1);
               
               %Fully differential - Branch N
               CV1n=CA21*Dcup1n';
               %------------------%
               
               
               
               %Fully differential- Branch P
               VtaP(k,j) = Vcm + FSR*(CA11*Dt1')/(CA11tot+Cx11);
               VtbP(k,j) = VtaP(k,j)*(Cs/(Cs+CA12tot)); %Not important at this step , since still there isn't any cap switched in the sub-DAC, only attenuation effect;
               
               
               %Fully differential- Branch N
               VtaN(k,j) = Vcm + FSR*(CA21*Dt1n')/(CA21tot+Cx21);
               VtbN(k,j) = VtaN(k,j)*(Cs2/(Cs2+CA22tot));  %Not important at this step , since still there isn't any cap switched in the sub-DAC, only attenuation effect;
               %-------------------------------%
               
               
               %Fully differential - Branch P
               En_csw = CA11(i)*FSR*(FSR-VtaP(k,j)-(-VtaP(k,j-1)));
               
               %Fully differential - Branch N
               En_csw_n = CA21(i)*FSR*(FSR-VtaN(k,j)-(-VtaN(k,j-1)));
               
               if D1(i-1)==1 %cioè SE LA CAPACITA DEL BIT PRECEDENTE RESTA CONNESSA A VREF...
                    %la tensione VA assume il valore post switching con la cap precedente a Vref;   
                    %l'energia spesa è relativa alla capacità switchata come al
                    %solito più alla variazione di tensione sulle capacità
                    %precedenti (solo array 1 per ora) connesse a Vref, compresa la Capacità del bit
                    %precedente, che resta , appunto, collegata a Vref;
                    
                    %Fully differential - Branch P
                    En_ref = (CA11(i-1)+CV1)*FSR*(-VtaP(k,j) + VtaP(k,j-1));   
                    
                    %Fully differential - Branch N
                    En_ref_n = (CA21(i-1)+CV1n)*FSR*(-VtaN(k,j) + VtaN(k,j-1));   
                    
                    
               else %cioè SE INVECE TORNA CONNESSA A VSS(GND)...
                    %l'energia spesa è relativa alla capacità switchata come al
                    %solito più alla variazione di tensione sulle capacità
                    %precedenti connesse a Vref, senza la Capacità del bit
                    %precedente, che torna a gnd;
                    
                    %Fully differential - Branch P
                    En_ref= CV1 * FSR* (-VtaP(k,j) + VtaP(k,j-1));                   
                    %Dt1(i-1)=D1(i-1);
                    
                    %Fully differential - Branch N
                    En_ref_n= CV1n * FSR * (-VtaN(k,j) + VtaN(k,j-1)); 
                    
               end
                 
            end
            
            En1(k,i) = En_csw + En_ref;
            %Fully differential
            En1n(k,i) = En_csw_n + En_ref_n;
            
            %% Branch Sum
            %En1(k,i)=En1(k,i)+En1n(k,i);
            %--------------------%
            %Only n - 4 debug
            %En1(k,i)=En1n(k,i);
      end
      
      En_csw2=0;
      En_ref2=0;
      En_csw2_n=0;
      En_ref2_n=0;
      
      %SECONDO ARRAY
      
      for i=1:n/2
            %SW(k)=SW(k)+1; %useless trial to take into account logic dissipation
            j=1+i+n/2;
            
            % Fully differential - Branch P
            Dt2(1:i)=D2(1:i); %Connettiamo a Vref le previste capacità precedenti dell'array;
            Dt2(i)=1; %prevediamo di alzare la capacità dell'i-esimo bit per il test;
            
%             % Fully differential - Branch N  - CASO SIMMETRICO RIGOROSO
%             % (CHE NON FUNZIONA...)
%             Dt2n(1:i)=D2n(1:i); %Connettiamo a Vss le previste capacità precedenti dell'array;
%             Dt2n(i)=0; %prevediamo di abbassare la capacità dell'i-esimo bit per il test (sull'altro array è alzata);
            
            % Fully differential - Branch N  - SMART TAROC
            Dt2n(1:i)=D2(1:i); %Connettiamo a Vss le previste capacità precedenti dell'array;
            Dt2n(i)=1; %prevediamo di abbassare la capacità dell'i-esimo bit per il test (sull'altro array è alzata);
            
            
            %Fully differential - Branch P
            CV1=CA11*D1'; %somma di tutte le capacità connesse a Vref del primo array,solo in base al codice;
            
            %Fully differential - Branch N
            CV1n=CA21*D1n';
            %----------------------%
            
            %Fully differential - Branch P 
            VtaP(k,j)= Vcm + FSR*(CV1)/(CA11tot+Cx11) + ((FSR*CA12*Dt2'/(CA12tot+Cx12)))*(Cs/(Cs+CA11tot)); %Calcolato con la sovrapposizione degli effetti = VtaP\a + VtaP|b;
            VtbP(k,j)= Vcm + FSR*CA12*Dt2'/(CA12tot+Cx12)+ FSR*(CV1)/(CA11tot+Cx11)*(Cs/(CA12tot+Cs)) ; %Calcolato con la sovrapposizione degli effetti =Vtb\va + Vtb\vb;
            
            %Fully differential - Branch N
            VtaN(k,j)= Vcm + FSR*(CV1n)/(CA21tot+Cx21) + ((FSR*CA22*Dt2n'/(CA22tot+Cx22)))*(Cs2/(Cs2+CA21tot)); %Calcolato con la sovrapposizione degli effetti = VtaP\a + VtaP|b;
            VtbN(k,j)= Vcm + FSR*CA22*Dt2n'/(CA22tot+Cx22)+ FSR*(CV1n)/(CA21tot+Cx21)*(Cs2/(CA22tot+Cs2)) ; %Calcolato con la sovrapposizione degli effetti =Vtb\va + Vtb\vb;
            
            if i==1       
              
              %Fully differential - Branch P  
              En_csw2=(1/steps)*CA12(i)*FSR*(FSR-VtbP(k,j)-(-VtbP(k,j-1))); 
              En_ref2=CV1*FSR*(-VtaP(k,j) + VtaP(k,j-1));                                 
              
              %Fully differential - Branch N
              En_csw2_n=(1/steps)*CA22(i)*FSR*(FSR-VtbN(k,j)-(-VtbN(k,j-1))); 
              En_ref2_n=CV1n*FSR*(-VtaN(k,j) + VtaN(k,j-1));  
              %-----------------%
              
              p=p+1;
              
            else
                %Fully differential - Branch p
                Dcup2=Dt2; 
                Dcup2(i-1)=0;
                Dcup2(i)=0;
                
%                 %Fully differential - Branch N
%                 Dcup2n=Dt2n;
%                 Dcup2n(i-1)=1;
%                 Dcup2n(i)=1;
                
                %Fully differential - Branch N - SMARTAROC
                Dcup2n=Dt2;
                Dcup2n(i-1)=0;
                Dcup2n(i)=0;
                
                CV2=CA12*Dcup2'; %le ALTRE capacità connesse a Vref del secondo array (non Cbit, non Cbit-1);
                
                %Fully differential - Branch N
                CV2n=CA22*Dcup2n'; %le ALTRE capacità connesse a Vref del secondo array (non Cbit, non Cbit-1);

                En_csw2= CA12(i)*FSR*(FSR-VtbP(k,j)-(-VtbP(k,j-1)));
                %Fully differential - branch N
                En_csw2_n= CA22(i)*FSR*(FSR-VtbN(k,j)-(-VtbN(k,j-1))); 
                %-----------------------%
                
                if D2(i-1)==1
                      
                      %Fully differential - branch P
                      En_ref2=(CV1)*FSR*(-VtaP(k,j) + VtaP(k,j-1)) + FSR*(CV2+CA12(i-1))*(-VtbP(k,j) + VtbP(k,j-1)); 
                      
                      %Fully differential - branch N
                      En_ref2_n=(CV1n)*FSR*(-VtaN(k,j) + VtaN(k,j-1)) + FSR*(CV2n+CA22(i-1))*(-VtbN(k,j) + VtbN(k,j-1)); 
                      %-----------------------%
                      
                else
                      %Fully differential - branch P
                      En_ref2=(CV1)*FSR*(-VtaP(k,j) + VtaP(k,j-1)) + FSR*(CV2)*(-VtbP(k,j) + VtbP(k,j-1));
                      
                      %Fully differential - branch N
                      En_ref2_n=(CV1n)*FSR*(-VtaN(k,j) + VtaN(k,j-1)) + FSR*(CV2n)*(-VtbN(k,j) + VtbN(k,j-1));    
                      %-----------------------%
                      
                end
                
            end
            
     %Energia associata alla carica-scarica delle capacità conn. a Vdd;
     %Energia spesa nello step;
     En2(k,i)=En_csw2 + En_ref2;  
     
     %Fully differential - Branch n
     En2n(k,i)= En_csw2_n + En_ref2_n;
     
     %%Fully differential - Branches sum
     %En2(k,i)= En2(k,i) + En2n(k,i);
     
     %Only n - 4 debug
     %En2(k,i)=En2n(k,i);
     
     end
          
end
        
      

EN1=sum(En1,2) +sum(En1n,2);
% figure(2)
% plot(codici,EN1,'LineWidth',1.5);
% title('Energy consumption vs Output Code - MSBs Array');
% grid on;
EN1_P=sum(En1,2);
EN1_N=sum(En1n,2);


EN2=sum(En2,2)+sum(En2n,2);
% figure(3)
% plot(codici,EN2,'LineWidth',1.5)
% title('Energy Consupmtion vs Output Code - LSBs Array')
% grid on;
EN2_P=sum(En2,2);
EN2_N=sum(En2n,2);






EN=EN1+EN2;%/max(sum(En,2)); %ENERGIA ASSOLUTA ARRAY SINGLE ENDED
%NormEN_logic=(SW*(Cgate*Vdd^2)/(C*FSR^2))';
EN_P=EN1_P+EN2_P;
EN_N=EN1_N+EN2_N;

%NormEN=2*EN/(C*FSR^2); %ENERGIA NORMALIZZATA A CVREF^2 PER UN FULLY
%differential, prima si moltiplicava per 2.

NormEN=EN/(C*FSR^2); %ENERGIA NORMALIZZATA A CVREF^2 PER UN FULLY DIFF.(*2...)

NormEN_P = EN_P/(C*FSR^2);
NormEN_N = EN_N/(C*FSR^2);

codici=0:1:length(NormEN);
% AVG_EN=mean(EN);
% MAX_EN=max(EN);
% 
% AVG_NormEN=mean(NormEN);
% Energia_media=AVG_NormEN*ones(1,length(codici));











