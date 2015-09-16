%Confronto tra architetture rispetto alla stdev della DNL

%450 secondi ogni "unità" di iterazione;

%Parametri Comuni
clear all

Vdd=0.5;
Vss=0;
kc=0.0095;
runs=1200;
n=10;
c_spec=1.11e-15;


cstart=0.5e-15;
cstep=0.25e-15;
cstop=10e-15;
dim=(cstop-cstart)/cstep;

ADNLstd=zeros(dim,runs);
BDNLstd=zeros(dim,runs);

ADNL=zeros(dim,runs);
BDNL=zeros(1,runs);


k=0;
for C=cstart:cstep:cstop
    k=k+1;
    %Architettura #1
   

    for i=1:runs
        [DNLVec_A,DNL_A,INL_A,DNLstd_A]=bccrdSAR(n,Vdd,Vss,C,kc,c_spec);     
        ADNLstd(k,i)=DNLstd_A;  
        ADNL(k,i)=DNL_A;
    end





    %Architettura #2
  
   
    for i=1:runs
        [DNLVec_B,DNL_B,INL_B,DNLstd_B]=splitBridgeCapSAR(n,Vdd,Vss,C,kc,c_spec);       
        BDNLstd(k,i)=DNLstd_B;
        BDNL(k,i)=DNL_B;
    end
    
    
end

ASTD=mean(ADNLstd,2)';
BSTD=mean(BDNLstd,2)';

ASTD_dnlmax=std(ADNL,0,2)';
BSTD_dnlmax=std(BDNL,0,2)';

AAVG=mean(ADNL,2)';
BAVG=mean(BDNL,2)';

figure(1)
plot(cstart:cstep:cstop, ASTD,'--bs','LineWidth',1.5);
hold on
plot(cstart:cstep:cstop, BSTD,'--rs','LineWidth',1.5);
title('DNL standard deviation vs C_{unit} - Topologies Comparison');
xlabel('C_{unit}')
ylabel('DNL_{stdev}');
legend('Conventional','Split');
grid on;


%DEVE TORNARE IL RAPPORTO RADICE DI DUE PER LE CURVE DELLA FIGURA 2
%SOTTOSTANTE;

figure(2)
plot(cstart:cstep:cstop, ASTD_dnlmax,'--bs','LineWidth',1.5);
hold on
plot(cstart:cstep:cstop, BSTD_dnlmax,'--rs','LineWidth',1.5);
title('DNLmax standard deviation vs C_{unit} - Topologies Comparison');
xlabel('C_{unit}')
ylabel('max|DNL|_{stdev}');
legend('Conventional','Split');
grid on;


figure(3)
plot(cstart:cstep:cstop, AAVG,'--bs','LineWidth',1.5);
hold on
plot(cstart:cstep:cstop, BAVG,'--rs','LineWidth',1.5);
title('mean |DNL|_{max} vs C_{unit} - Topologies Comparison');
xlabel('C_{unit}')
ylabel('mean(|DNL|_{max})');
legend('Conventional','Split');
grid on;