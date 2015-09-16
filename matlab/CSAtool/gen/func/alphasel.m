function [alpha]=alphasel(sel,Nbit)

alpha=1;
switch sel
    case 1
        alpha=2^(Nbit/2);
    case 2
        alpha=2^(Nbit/2)/sqrt(2);
    case 3
        alpha=2^(3*Nbit/4);
    case 4
        alpha=2^(3*Nbit/4)/sqrt(2);
    case 5
        alpha=2^(3*Nbit/4)/2;
    case 6
        alpha=2^(Nbit/2)/sqrt(2);
    case 7
        alpha=2^(Nbit/2)/sqrt(2);
    case 8
        alpha=2^(3*Nbit/4)/sqrt(2);
    case 9
        alpha=2^(Nbit/2)/2;
    case 10
        alpha=2^(3*Nbit/4)/2;
end