function [ADNL,AINL,MDM,MDS,SDM,MIM,MIS,DSV,ISV,SIM,Vecdnl,Vecinl] = STAT(sel,runs,Nbit,Vdd,Vss,cunit,kc,misos,cspec,cbridge,Cpar11,Cpar12,Cpar21,Cpar22,STP,SBP,STBP,PEX11,PEX12,PEX21,PEX22,PEXB,SPEX)

%Statistical Analysis

ADNL=zeros(1,runs);
AINL=zeros(1,runs);
SDNL=zeros(1,runs);
Vecdnl=zeros(runs,2^Nbit-1);

switch sel
    
    case 1
         %CBW - SE
         for i=1:runs
         [levels]=classicbwPEXse(Nbit,Vdd,Vss,cunit,kc,misos,cspec,cbridge,Cpar11,Cpar12,Cpar21,Cpar22,STP,SBP,STBP,PEX11,PEX12,PEX21,PEX22,PEXB);
         rgaps=diff(levels);
         DNLvec=(rgaps-mean(rgaps))/(mean(rgaps));
         INLvec=cumsum(DNLvec);  
         DNL=max(abs(DNLvec));
         INL=max(abs(INLvec));
         DNLstd=std(DNLvec); %code direction;
         INLstd=std(INLvec); % code direction
         Vecdnl(i,(1:length(DNLvec)))=DNLvec;
         Vecinl(i,(1:length(INLvec)))=INLvec;
         ADNL(i)=DNL ;%già valore assoluto e massimo;
         AINL(i)=INL; %già valore assoluto e massimo;
         SDNL(i)=DNLstd;
         SINL(i)=INLstd;
         disp(strcat('Progress...', num2str(round(100*i/runs)),'%'))
         end

    case 2
         %SBW - SE
         for i=1:runs
         [levels]=splitbwPEXse(Nbit,Vdd,Vss,cunit,kc,misos,cspec,cbridge,Cpar11,Cpar12,Cpar21,Cpar22,STP,SBP,STBP,PEX11,PEX12,PEX21,PEX22,PEXB,SPEX);
         rgaps=diff(levels);
         DNLvec=(rgaps-mean(rgaps))/(mean(rgaps));
         INLvec=cumsum(DNLvec);  
         DNL=max(abs(DNLvec));
         INL=max(abs(INLvec));
         DNLstd=std(DNLvec); %code direction;
         INLstd=std(INLvec); % code direction
         Vecdnl(i,(1:length(DNLvec)))=DNLvec;
         Vecinl(i,(1:length(INLvec)))=INLvec;
         ADNL(i)=DNL ;%già valore assoluto e massimo;
         AINL(i)=INL; %già valore assoluto e massimo;
         SDNL(i)=DNLstd;
         SINL(i)=INLstd;
         disp(strcat('Progress...', num2str(round(100*i/runs)),'%'))
         end
        
    case 3
         %BWA - SE
         for i=1:runs
         [levels]=classicbridgePEXse(Nbit,Vdd,Vss,cunit,kc,misos,cspec,cbridge,Cpar11,Cpar12,Cpar21,Cpar22,STP,SBP,STBP,PEX11,PEX12,PEX21,PEX22,PEXB);
         rgaps=diff(levels);
         DNLvec=(rgaps-mean(rgaps))/(mean(rgaps));
         INLvec=cumsum(DNLvec);  
         DNL=max(abs(DNLvec));
         INL=max(abs(INLvec));
         DNLstd=std(DNLvec); %code direction;
         INLstd=std(INLvec); % code direction
         Vecdnl(i,(1:length(DNLvec)))=DNLvec;
         Vecinl(i,(1:length(INLvec)))=INLvec;
         ADNL(i)=DNL ;%già valore assoluto e massimo;
         AINL(i)=INL; %già valore assoluto e massimo;
         SDNL(i)=DNLstd;
         SINL(i)=INLstd;
         disp(strcat('Progress...', num2str(round(100*i/runs)),'%'))
         end
   
        
              
        
    case 4
         %CBW - FD
         for i=1:runs
         [levels]=classicbwPEXfd(Nbit,Vdd,Vss,cunit,kc,misos,cspec,cbridge,Cpar11,Cpar12,Cpar21,Cpar22,STP,SBP,STBP,PEX11,PEX12,PEX21,PEX22,PEXB);
         rgaps=diff(levels);
         DNLvec=(rgaps-mean(rgaps))/(mean(rgaps));
         INLvec=cumsum(DNLvec);  
         DNL=max(abs(DNLvec));
         INL=max(abs(INLvec));
         DNLstd=std(DNLvec); %code direction;
         INLstd=std(INLvec); % code direction
         Vecdnl(i,(1:length(DNLvec)))=DNLvec;
         Vecinl(i,(1:length(INLvec)))=INLvec;
         ADNL(i)=DNL ;%già valore assoluto e massimo;
         AINL(i)=INL; %già valore assoluto e massimo;
         SDNL(i)=DNLstd;
         SINL(i)=INLstd;
         disp(strcat('Progress...', num2str(round(100*i/runs)),'%'))
         end
        
    case 5
         %SBW - FD
         for i=1:runs
         [levels]=splitbwPEXfd(Nbit,Vdd,Vss,cunit,kc,misos,cspec,cbridge,Cpar11,Cpar12,Cpar21,Cpar22,STP,SBP,STBP,PEX11,PEX12,PEX21,PEX22,PEXB,SPEX);
         rgaps=diff(levels);
         DNLvec=(rgaps-mean(rgaps))/(mean(rgaps));
         INLvec=cumsum(DNLvec);  
         DNL=max(abs(DNLvec));
         INL=max(abs(INLvec));
         DNLstd=std(DNLvec); %code direction;
         INLstd=std(INLvec); % code direction
         Vecdnl(i,(1:length(DNLvec)))=DNLvec;
         Vecinl(i,(1:length(INLvec)))=INLvec;
         ADNL(i)=DNL ;%già valore assoluto e massimo;
         AINL(i)=INL; %già valore assoluto e massimo;
         SDNL(i)=DNLstd;
         SINL(i)=INLstd;
         disp(strcat('Progress...', num2str(round(100*i/runs)),'%'))
         end

    case 6
        %BWA - FD
         for i=1:runs
         [levels]=classicbridgePEXfd(Nbit,Vdd,Vss,cunit,kc,misos,cspec,cbridge,Cpar11,Cpar12,Cpar21,Cpar22,STP,SBP,STBP,PEX11,PEX12,PEX21,PEX22,PEXB);
         rgaps=diff(levels);
         DNLvec=(rgaps-mean(rgaps))/(mean(rgaps));
         INLvec=cumsum(DNLvec);  
         DNL=max(abs(DNLvec));
         INL=max(abs(INLvec));
         DNLstd=std(DNLvec); %code direction;
         INLstd=std(INLvec); % code direction
         Vecdnl(i,(1:length(DNLvec)))=DNLvec;
         Vecinl(i,(1:length(INLvec)))=INLvec;
         ADNL(i)=DNL ;%già valore assoluto e massimo;
         AINL(i)=INL; %già valore assoluto e massimo;
         SDNL(i)=DNLstd;
         SINL(i)=INLstd;
         disp(strcat('Progress...', num2str(round(100*i/runs)),'%'))
         end
     case 7
         %Monotonic - FD
         for i=1:runs
         [levels]=monotonicPEX(Nbit,Vdd,Vss,cunit,kc,cspec,cbridge,Cpar11,Cpar12,Cpar21,Cpar22,STP,SBP,STBP,PEX11,PEX12,PEX21,PEX22,PEXB);
         rgaps=diff(levels);
         DNLvec=(rgaps-mean(rgaps))/(mean(rgaps));
         INLvec=cumsum(DNLvec);  
         DNL=max(abs(DNLvec));
         INL=max(abs(INLvec));
         DNLstd=std(DNLvec); %code direction;
         INLstd=std(INLvec); % code direction
         Vecdnl(i,(1:length(DNLvec)))=DNLvec;
         Vecinl(i,(1:length(INLvec)))=INLvec;
         ADNL(i)=DNL ;%già valore assoluto e massimo;
         AINL(i)=INL; %già valore assoluto e massimo;
         SDNL(i)=DNLstd;
         SINL(i)=INLstd;
         disp(strcat('Progress...', num2str(round(100*i/runs)),'%'))
         end       
         
%            ADNL=zeros(1,Nbit);
%            AINL=zeros(1,Nbit);
%            SDNL=zeros(1,Nbit);
%            SINL=zeros(1,Nbit);

    case 8 % Monotonic BWA - FD    
         for i=1:runs
         [levels]=monobridgePEX(Nbit,Vdd,Vss,cunit,kc,cspec,cbridge,Cpar11,Cpar12,Cpar21,Cpar22,STP,SBP,STBP,PEX11,PEX12,PEX21,PEX22,PEXB);
         rgaps=diff(levels);
         DNLvec=(rgaps-mean(rgaps))/(mean(rgaps));
         INLvec=cumsum(DNLvec);  
         DNL=max(abs(DNLvec));
         INL=max(abs(INLvec));
         DNLstd=std(DNLvec); %code direction;
         INLstd=std(INLvec); % code direction
         Vecdnl(i,(1:length(DNLvec)))=DNLvec;
         Vecinl(i,(1:length(INLvec)))=INLvec;
         ADNL(i)=DNL ;%già valore assoluto e massimo;
         AINL(i)=INL; %già valore assoluto e massimo;
         SDNL(i)=DNLstd;
         SINL(i)=INLstd;
         disp(strcat('Progress...', num2str(round(100*i/runs)),'%'))
         end 
        
%          ADNL=zeros(1,Nbit);
%          AINL=zeros(1,Nbit);
%          SDNL=zeros(1,Nbit);
%          SINL=zeros(1,Nbit);
    case 9 % Modified Monotonic BWA - FD    
         for i=1:runs
         [levels]=monobridgemodPEX(Nbit,Vdd,Vss,cunit,kc,cspec,cbridge,Cpar11,Cpar12,Cpar21,Cpar22,STP,SBP,STBP,PEX11,PEX12,PEX21,PEX22,PEXB);
         rgaps=diff(levels);
         DNLvec=(rgaps-mean(rgaps))/(mean(rgaps));
         INLvec=cumsum(DNLvec);  
         DNL=max(abs(DNLvec));
         INL=max(abs(INLvec));
         DNLstd=std(DNLvec); %code direction;
         INLstd=std(INLvec); % code direction
         Vecdnl(i,(1:length(DNLvec)))=DNLvec;
         Vecinl(i,(1:length(INLvec)))=INLvec;
         ADNL(i)=DNL ;%già valore assoluto e massimo;
         AINL(i)=INL; %già valore assoluto e massimo;
         SDNL(i)=DNLstd;
         SINL(i)=INLstd;
         disp(strcat('Progress...', num2str(round(100*i/runs)),'%'))
         end 
        
%          ADNL=zeros(1,Nbit);
%          AINL=zeros(1,Nbit);
%          SDNL=zeros(1,Nbit);
%          SINL=zeros(1,Nbit);
    case 10 % EMPTY SLOT 
         ADNL=zeros(1,Nbit);
         AINL=zeros(1,Nbit);
         SDNL=zeros(1,Nbit);
         SINL=zeros(1,Nbit);
end
%------------------------------------------------------------------------%
% DNLmedia è intesa come media(DNLmassima);
% INLmedia è intesa come media(INLmassima);
maxDNL_media=mean(ADNL);
maxDNL_std=std(ADNL);
stdDNL_media=mean(SDNL);
stdINL_media=mean(SINL);
maxINL_media=mean(AINL);
maxINL_std=std(AINL);
%------------------------------------------------------------------------%

%close(statduration)

MDM=maxDNL_media;
MDS=maxDNL_std; 

SDM=stdDNL_media;
SIM=stdINL_media;

MIM=maxINL_media;
MIS=maxINL_std;

DSV=std(Vecdnl);
ISV=std(Vecinl);



