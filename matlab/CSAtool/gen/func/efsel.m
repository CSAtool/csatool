function [ef,csf] =  efsel(sel,Vdd,Vss,Nbit)

DV=Vdd-Vss;
switch sel
    case 1 %CBW - SE
        %ef=0.5*1.33*2^Nbit;
        ef = 0.66*2^Nbit; %LOTFI
        csf=2^Nbit;
    case 2 %SBW - SE
        %ef=0.5*0.83*2^Nbit;
        ef = 0.41*2^Nbit; %LOTFI
        csf=2^Nbit;
    case 3 %BWA - SE
        %ef=0.5*0.08*2^Nbit;
        ef = 1.25*2^(Nbit/2); %LOTFI
        csf=2^(Nbit/2);
    case 4 %CBW - FD
        %ef=1.33*2^Nbit;
        ef = 2*0.66*2^(Nbit/2);%LOTFI
        csf=2^Nbit;
    case 5 %SBW - FD
        %ef=0.83*2^Nbit;
        ef = 2*0.41*2^Nbit; %LOTFI
        csf=2^Nbit;
    case 6 %BWA - FD
        %ef=0.08*2^Nbit;
        ef = 2*1.25*2^(Nbit/2); %LOTFI
        csf=2^(Nbit/2);
    case 7 %Mono BW - FD
        ef = 2*1.25*2^(Nbit/2); %wrong
        csf=2^(Nbit/2);
    case 8 % Mono BWA - FD
        ef = 2*1.25*2^(Nbit/2); %wrong
        csf=2^(Nbit/2);
    case 9
        ef=0;
        csf=0;
    case 10
        ef=0;
        csf=0;
end