%script che calcola la DNL e l'INL a partire dalla caratteristica dell'ADC
% e successivamente nel calcola l'EnOB.


%DATI
Vdd=0.5;
Vstart=-Vdd;
LSB=2*Vdd/2^10;

%car=load('output.dat');
in=car(:,1);
DACout=car(:,2);
p=max(size(car));



deltaIn=(Vdd-Vstart)/p;
gaps=diff(DACout);
pos=find(gaps > 0);
D=diff(pos);
LSBrel = mean(D)*deltaIn;
relDNL =(diff(pos)*deltaIn - LSBrel) / LSBrel ;
DNL=(diff(pos)*deltaIn - LSB) / LSB ;


levels=car2lev(car)


% A UNA DATA AMPIEZZA:

A=0.478;
fin=1000;
fs=30000;
OS=0;
Vss=0;
i=1;

for A=0:0.00025:0.5
    ENOB(i,1)=A; 
    ENOB(i,2)=enob_eval(A,fin,fs,OS,Vdd,Vss,levels);
    i=i+1;
end