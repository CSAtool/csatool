%function [DNLmedia, DNLstd]=2bridgecapADCist(runs,n,Vdd,Vss,C,kc,c_spec)
%[DNLmedia, DNLstd]=ADCist(runs)
%
%The function calculates and plots histograms chart for INL and DNL
%over "runs" cycles of a charge redistribution ADC whose architechture is
%described by the specific function utilized in the for cycle;
%It also gives as output two scalar: the mean maximum abs value of DNL and 
%its standard deviation;
clear all
C=20e-15;
Vdd=0.5;
Vss=0;
kc=0.0095;
runs=1000;
n=10;
c_spec=1.11e-15;

Vin=0.25; %just because the function in the for loop requires it, but it does not
%se it in these runs;
ADNL=zeros(1,runs);
AINL=zeros(1,runs);
Vecdnl=zeros(runs,2^10-1);

for i=1:runs
    [DNLVec,DNL,INL,DNLstandev]=twobccrdSAR(n,Vdd,Vss,C,kc,c_spec);
    Vecdnl(i,(1:length(DNLVec)))=DNLVec;
    ADNL(i)=DNL;
    AINL(i)=INL;
end

%Funzionamento classico---------------------------------------------------%
% DNLmedia è intesa come media(DNLmassima);
% INLmedia è intesa come media(INLmassima);
DNLmedia=mean(ADNL);
DNLstd=std(ADNL);
%INLmedia=mean(AINL);


%Funzionamento alternativo------------------------------------------------%
%Per calcolare invece la DNL media (non massima,ma media)
% DNLmedia=mean(mean(Vecdnl,1));
% DNLstd=mean(std(Vecdnl,1));

%--------------------------------------CHART SECTION----------------------%

figure;
title('DNL');
hist(ADNL,100)
xlabel('max(abs(DNL))');
ylabel('1000 runs');
figure(2)
title('INL');
hist(AINL,100)
xlabel('abs(max(INL))');
ylabel('1000 runs');


%end