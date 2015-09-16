function [veclev] = STATswe(sel,runs,Nbit,Vdd,Vss,cunit,kc,misos,cspec,cbridge,Cpar11,Cpar12,Cpar21,Cpar22,STP,SBP,STBP,PEX11,PEX12,PEX21,PEX22,PEXB,SPEX)

%Statistical Analysis for Weep function


veclev=zeros(runs,2^Nbit-1);

switch sel
    
    case 1
         %CBW - SE
         for i=1:runs
         [levels]=classicbwPEXse(Nbit,Vdd,Vss,cunit,kc,misos,cspec,cbridge,Cpar11,Cpar12,Cpar21,Cpar22,STP,SBP,STBP,PEX11,PEX12,PEX21,PEX22,PEXB);
         veclev(i,(1:length(veclev)))=levels;
         disp(strcat('Progress...', num2str(round(100*i/runs)),'%'))
         end

    case 2
         %SBW - SE
         for i=1:runs
         [levels]=splitbwPEXse(Nbit,Vdd,Vss,cunit,kc,misos,cspec,cbridge,Cpar11,Cpar12,Cpar21,Cpar22,STP,SBP,STBP,PEX11,PEX12,PEX21,PEX22,PEXB,SPEX);
         veclev(i,(1:length(veclev)))=levels;
         disp(strcat('Progress...', num2str(round(100*i/runs)),'%'))
         end
        
    case 3
         %BWA - SE
         for i=1:runs
         [levels]=classicbridgePEXse(Nbit,Vdd,Vss,cunit,kc,misos,cspec,cbridge,Cpar11,Cpar12,Cpar21,Cpar22,STP,SBP,STBP,PEX11,PEX12,PEX21,PEX22,PEXB);
         veclev(i,(1:length(veclev)))=levels;
         disp(strcat('Progress...', num2str(round(100*i/runs)),'%'))
         end
          
        
    case 4
         %CBW - FD
         for i=1:runs
         [levels]=classicbwPEXfd(Nbit,Vdd,Vss,cunit,kc,misos,cspec,cbridge,Cpar11,Cpar12,Cpar21,Cpar22,STP,SBP,STBP,PEX11,PEX12,PEX21,PEX22,PEXB);
         veclev(i,(1:length(veclev)))=levels;
         disp(strcat('Progress...', num2str(round(100*i/runs)),'%'))
         end
        
    case 5
         %SBW - FD
         for i=1:runs
         [levels]=splitbwPEXfd(Nbit,Vdd,Vss,cunit,kc,misos,cspec,cbridge,Cpar11,Cpar12,Cpar21,Cpar22,STP,SBP,STBP,PEX11,PEX12,PEX21,PEX22,PEXB,SPEX);
         veclev(i,(1:length(veclev)))=levels;
         disp(strcat('Progress...', num2str(round(100*i/runs)),'%'))
         end

    case 6
         %BWA - FD
         for i=1:runs
         [levels]=classicbridgePEXfd(Nbit,Vdd,Vss,cunit,kc,misos,cspec,cbridge,Cpar11,Cpar12,Cpar21,Cpar22,STP,SBP,STBP,PEX11,PEX12,PEX21,PEX22,PEXB);
         veclev(i,(1:length(veclev)))=levels;
         disp(strcat('Progress...', num2str(round(100*i/runs)),'%'))
         end
    case 7 
         %Monotonic BW - FD
         for i=1:runs
         [levels]=monotonicPEX(Nbit,Vdd,Vss,cunit,kc,misos,cspec,cbridge,Cpar11,Cpar12,Cpar21,Cpar22,STP,SBP,STBP,PEX11,PEX12,PEX21,PEX22,PEXB);
         veclev(i,(1:length(veclev)))=levels;
         disp(strcat('Progress...', num2str(round(100*i/runs)),'%'))
         end

    case 8 
         %Monotonic BWA - FD
          for i=1:runs
         [levels]=monobridgePEX(Nbit,Vdd,Vss,cunit,kc,misos,cspec,cbridge,Cpar11,Cpar12,Cpar21,Cpar22,STP,SBP,STBP,PEX11,PEX12,PEX21,PEX22,PEXB);
         veclev(i,(1:length(veclev)))=levels;
         disp(strcat('Progress...', num2str(round(100*i/runs)),'%'))
         end
         
    case 9 % EMPTY SLOT

         
    case 10 % EMPTY SLOT 


end








% %------------------------------------------------------------------------%
% % DNLmedia è intesa come media(DNLmassima);
% % INLmedia è intesa come media(INLmassima);
% maxDNL_media=mean(ADNL);
% maxDNL_std=std(ADNL);
% stdDNL_media=mean(SDNL);
% maxINL_media=mean(AINL);
% maxINL_std=std(AINL);
% %------------------------------------------------------------------------%
% 
% close(statduration)
% 
% MDM=maxDNL_media;
% MDS=maxDNL_std; 
% 
% SDM=stdDNL_media;
% 
% MIM=maxINL_media;
% MIS=maxINL_std;
% 
% DSV=std(Vecdnl);
% ISV=std(Vecinl);



