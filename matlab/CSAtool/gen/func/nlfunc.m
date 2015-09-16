function [DNL,INL,levels,err]=nlfunc(sel,Nbit,Vdd,Vss,cunit,cbridge,kc,misos,cspec,STP,SBP,STBP,Cpar11,Cpar12,Cpar21,Cpar22,PEX11,PEX12,PEX21,PEX22,PEXB,SPEX)


err=0;


switch sel
    case 1       
       %Classic BW - SE
       [levels]  = classicbwPEXse(Nbit,Vdd,Vss,cunit,kc,misos,cspec,cbridge,Cpar11,Cpar12,Cpar21,Cpar22,STP,SBP,STBP,PEX11,PEX12,PEX21,PEX22,PEXB);
       %[ilevels] = classicbwPEXse(Nbit,Vdd,Vss,cunit,kc,cspec,cbridge,0,0,0,0,0,0,0,zeros(1,Nbit/2),zeros(1,Nbit/2) ,zeros(1,Nbit/2) ,zeros(1,Nbit/2) ,zeros(1,Nbit/2));
    case 2
       %Split BW - SE 
       [levels]  = splitbwPEXse(Nbit,Vdd,Vss,cunit,kc,misos,cspec,cbridge,Cpar11,Cpar12,Cpar21,Cpar22,STP,SBP,STBP,PEX11,PEX12,PEX21,PEX22,PEXB,SPEX);
       %[ilevels] = splitbwPEXse(Nbit,Vdd,Vss,cunit,kc,cspec,cbridge,0,0,0,0,0,0,0,zeros(1,Nbit/2),zeros(1,Nbit/2) ,zeros(1,Nbit/2) ,zeros(1,Nbit/2) ,zeros(1,Nbit/2) , zeros(2,13));
    case 3
       %Classic Bridge - SE
       [levels] =  classicbridgePEXse(Nbit,Vdd,Vss,cunit,kc,misos,cspec,cbridge,Cpar11,Cpar12,Cpar21,Cpar22,STP,SBP,STBP,PEX11,PEX12,PEX21,PEX22,PEXB);
       %[ilevels] = classicbridgePEXse(Nbit,Vdd,Vss,cunit,kc,cspec,cbridge,0,0,0,0,0,0,0,zeros(1,Nbit/2),zeros(1,Nbit/2) ,zeros(1,Nbit/2) ,zeros(1,Nbit/2) ,zeros(1,Nbit/2));   
    case 4      
       %Classic BW - FD 
       [levels]  = classicbwPEXfd(Nbit,Vdd,Vss,cunit,kc,misos,cspec,cbridge,Cpar11,Cpar12,Cpar21,Cpar22,STP,SBP,STBP,PEX11,PEX12,PEX21,PEX22,PEXB);
       %[ilevels] =
       %classicbwPEXfd(Nbit,Vdd,Vss,cunit,kc,cspec,cbridge,0,0,0,0,0,0,0,zeros(1,Nbit/2),zeros(1,Nbit/2) ,zeros(1,Nbit/2) ,zeros(1,Nbit/2) ,zeros(1,Nbit/2));
    case 5
       %Split BW - FD 
       [levels]  = splitbwPEXfd(Nbit,Vdd,Vss,cunit,kc,misos,cspec,cbridge,Cpar11,Cpar12,Cpar21,Cpar22,STP,SBP,STBP,PEX11,PEX12,PEX21,PEX22,PEXB,SPEX);
       %[ilevels] =splitbwPEXse(Nbit,Vdd,Vss,cunit,kc,cspec,cbridge,0,0,0,0,0,0,0,zeros(1,Nbit/2),zeros(1,Nbit/2) ,zeros(1,Nbit/2) ,zeros(1,Nbit/2) ,zeros(1,Nbit/2) , zeros(2,13));     
    case 6 
       %Classic Bridge - FD
       [levels]  = classicbridgePEXfd(Nbit,Vdd,Vss,cunit,kc,misos,cspec,cbridge,Cpar11,Cpar12,Cpar21,Cpar22,STP,SBP,STBP,PEX11,PEX12,PEX21,PEX22,PEXB);
       %[ilevels] = classicbridgePEXfd(Nbit,Vdd,Vss,cunit,kc,cspec,cbridge,0,0,0,0,0,0,0,zeros(1,Nbit/2),zeros(1,Nbit/2) ,zeros(1,Nbit/2) ,zeros(1,Nbit/2) ,zeros(1,Nbit/2));
    case 7
       %Monotonic BW - FD 
       [levels]  = monotonicPEX(Nbit,Vdd,Vss,cunit,kc,cspec,cbridge,Cpar11,Cpar12,Cpar21,Cpar22,STP,SBP,STBP,PEX11,PEX12,PEX21,PEX22,PEXB);
       %[ilevels] = monotonicPEX(Nbit,Vdd,Vss,cunit,kc,cspec,cbridge,0,0,0,0,0,0,0,zeros(1,Nbit/2),zeros(1,Nbit/2) ,zeros(1,Nbit/2) ,zeros(1,Nbit/2) ,zeros(1,Nbit/2));      
       %%TO DEACTIVATE THE OPTION: UNCOMMENT THE FOLLOWING LINES, AND COMMENT THE PREVIOUS LINES
       %%Empty slot
       %        nomodel
       %        err=1;
       %        levels=linspace(0,Vdd,2^Nbit-1);   
    case 8 
       %Monotonic BWA - FD
       [levels]  = monobridgePEX(Nbit,Vdd,Vss,cunit,kc,cspec,cbridge,Cpar11,Cpar12,Cpar21,Cpar22,STP,SBP,STBP,PEX11,PEX12,PEX21,PEX22,PEXB);
       %[ilevels] = monobridgePEX(Nbit,Vdd,Vss,cunit,kc,cspec,cbridge,0,0,0,0,STP,SBP,STBP,zeros(1,Nbit/2),zeros(1,Nbit/2) ,zeros(1,Nbit/2) ,zeros(1,Nbit/2) ,zeros(1,Nbit/2));   
       %%TO DEACTIVATE THE OPTION: UNCOMMENT THE FOLLOWING LINES, AND COMMENT THE PREVIOUS LINES
       %%Empty slot
       %        nomodel
       %        err=1;
       %        levels=linspace(0,Vdd,2^Nbit-1);       
    case 9     
       %Monotonic BWA - FD
       [levels]  = monobridgemodPEX(Nbit,Vdd,Vss,cunit,kc,cspec,cbridge,Cpar11,Cpar12,Cpar21,Cpar22,STP,SBP,STBP,PEX11,PEX12,PEX21,PEX22,PEXB);
       %[ilevels] = monobridgemodPEX(Nbit,Vdd,Vss,cunit,kc,cspec,cbridge,0,0,0,0,STP,SBP,STBP,zeros(1,Nbit/2),zeros(1,Nbit/2) ,zeros(1,Nbit/2) ,zeros(1,Nbit/2) ,zeros(1,Nbit/2));   
       %%TO DEACTIVATE THE OPTION: UNCOMMENT THE FOLLOWING LINES, AND COMMENT THE PREVIOUS LINES
       %%Empty slot
       %        nomodel
       %        err=1;
       %        levels=linspace(0,Vdd,2^Nbit-1);   
       
    case 10
       
       %Empty slot
       nomodel
       err=1;
       levels=linspace(0,Vdd,2^Nbit-1);   
             
end


%--------------------------DNL INL EVALUATION---------------------------------%
% igaps=diff(ilevels);
rgaps=diff(levels);
%Gain error must not be considered in order to evaluate non-linearity
LSBrel=mean(rgaps); 
DNL=(rgaps-LSBrel)/LSBrel;
INL=cumsum(DNL);







