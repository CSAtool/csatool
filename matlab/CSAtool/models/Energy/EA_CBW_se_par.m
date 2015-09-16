function [NormEN,codici]=EA_CBW_se_par(Nbit,Vdd,Vss,cunit,kc,misos,cspec,cbridge,Cpar11,Cpar12,Cpar21,Cpar22,STP,SBP,STBP,PEX11,PEX12,PEX21,PEX22,PEXB)


%stepwise option for MSB's; (1 is not stepwise)
steps=1;  

%------------------------------------------------------------------------%

n=Nbit;
FSR=Vdd-Vss;
C=cunit;

%-----------------------------------------------------------------------%

sigmaC=kc/sqrt(2*C/cspec)+misos;
 
utp=(C/cspec)*STP;
utbp=(C/cspec)*STBP;

%-----------------------------------------------------------------------%

CAR=zeros(n,2^n);
CAR(1,1)= C + utbp + normrnd(0,C*sigmaC); 

for i=1:n   
        for j=1:(2^(i-1))
        CAR(i+1,j)=C + normrnd(0,C*sigmaC)  + utbp;
        end
end


CA=zeros(1,n);
CA(1)=CAR(2,1);
for i=2:n
    for j=1:(2^(i-1))
        CA(i)=CA(i)+CAR(i+1,j);
    end
end

%total nominal array capacitance
CAtot_nom=CAR(1,1);
for i=1:n
    CAtot_nom=CAtot_nom+CA(i);
end


%adding ppex parasitics
CA = CA + fliplr(cat(2,PEX11,PEX12));

%total array capacitance inclding ppex parasitics
CAtot=CAR(1,1);
for i=1:n
    CAtot=CAtot+CA(i);
end


CA=fliplr(CA); 
Cpar11= Cpar11 + (round(CAtot_nom/C))*(utp);
%qui aggiungiamo Cpar11 all'ultima capacità dell'array, la più piccola)
CA(end)=CA(end)+Cpar11; %così viene tenuta in considerazione nel computo energetico

Vcm=0;
Dout=zeros(1,n);   
En=0;
k=1;
levs=2^n; %numero di livelli data la codifica;
%Dobbiamo testare l'energia data per ogni codice, quindi il codice
%dev'essere noto a priori
%Va considoerato ora il vettore (matrice se per ogni codice )
%delle tensioni al nodo di confronto Vx
%prima di ogni Switch di carica della capacità del bit da testare.
%Inizialmente:

%INDICI CHE TENGONO CONTO DELL'ACCENSIONE DI INTERRUTTORI
numero_switch=n;
SW=numero_switch*ones(1,levs);
%nella fase sampling si attivano tutti;
Cgate=1e-15;

En=zeros(levs,n);
Vtest=zeros(levs,n+1);
Vtest(:,1)=Vcm;
codici=0:1:(levs-1);


for cod=0:(levs-1)
    Dout=fliplr(de2bi(cod,n));
    Dtest=zeros(1,n); %vettore delle posiz di capacità connesse a Vdd;
    Dcod=zeros(1,n);
    Dcapref=zeros(1,n);
    for i=1:n
        j=i+1;
        %switchiamo la capacità del bit di interesse;
        SW(k)=SW(k)+1;
        Dtest(1:i)=Dout(1:i); %in Dtest memorizzo tutti i bit informativi del codice
        Dtest(i)=1;        
        if i==1
        Vtest(k,j)=Vcm+FSR*(CA*Dtest')/(CAtot+Cpar11);
        En_csw=(1/steps)*CA(i)*FSR*(FSR-Vtest(k,j)+Vcm);
        En_ref=0;
        else
            %Dtest(i-1)=1 %la capacità precedente si considera ancora in test;
            % A questo punto ho il vettore degli switch attivi pronto: Dtest;
            Dcapref=Dtest;
            Dcapref(i)=0;
            Dcapref(i-1)=0;
            CV=CA*Dcapref'; %le ALTRE capacità connesse a Vref (non Cbit, non Cbit-1);
            Vtest(k,j)=Vcm+FSR*(CA*Dtest')/(CAtot+Cpar11);
            En_csw= CA(i)*FSR*(FSR-Vtest(k,j)-(-Vtest(k,j-1)));
            if Dout(i-1)==1 %cioè SE LA CAPACITA DEL BIT PRECEDENTE RESTA CONNESSA A VREF...
                %la tensione X assume il valore post switching con la cap precedente a Vref;   
                %l'energia spesa è relativa alla capacità switchata come al
                %solito più alla variazione di tensione sulle capacità
                %precedenti connesse a Vref, compresa la Capacità del bit
                %precedente, che resta collegata a Vref;
                
                En_ref=(CA(i-1)+CV)*FSR*(-Vtest(k,j) + Vtest(k,j-1));              
            else %cioè SE INVECE TORNA CONNESSA A VSS(GND)...
                %l'energia spesa è relativa alla capacità switchata come al
                %solito più alla variazione di tensione sulle capacità
                %precedenti connesse a Vref, senza la Capacità del bit
                %precedente, che torna a gnd;
                SW(k)=SW(k)+1; %riaccendo lo switch verso Vss;
                En_ref=CV*FSR*(-Vtest(k,j) + Vtest(k,j-1));
                %Dtest(i-1)=Dout(i-1);
                %Vtest(k,j)=Vcm+FSR*(CA*Dtest')/CAtot;
            end
                
        end
        
        %Energia associata alla carica-scarica delle capacità conn. a Vdd;
        %Energia spesa nello step;
        En(k,i)=En_csw+En_ref;
    end
    k=k+1;
end


%-----------------------------------------------------------------%
   
EN=sum(En,2);%/max(sum(En,2)); %ENERGIA ASSOLUTA, SINGOLO ARRAY
AVG_EN=mean(EN);
MAX_EN=max(EN);

NormEN=EN/(C*FSR^2); %ENERGIA NORMALIZZATA A C*Vref^2 , SINGLE ENDED

NormEN_logic=(SW*(Cgate*Vdd^2)/(C*FSR^2))';
codici=0:1:length(NormEN);
% AVG_NormEN=mean(NormEN);
% Energia_media=AVG_NormEN*ones(1,length(codici));

