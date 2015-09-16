function [NormEN,codici]=EA_MBWA(Nbit,Vdd,Vss,cunit,cbridge,cspec)


n=Nbit;
kc=0; 
c_spec=cspec;
C=cunit;
FSR=Vdd-Vss;

%stepwise option for MSB's; (1 is not stepwise)
steps=1;  
m=Nbit/2;

%---------------- IDEAL CAPACITOR ARRAY BUILDING-------------------------%

%MSB arrays

%Mem. Alloc.;
iCARP1=zeros(m,2^(m));%initialization of the matrix describing the 1st capacitor array;
iCARN1=zeros(m,2^(m));%inizialization of the matrix describing the 3rd capacitor array;
iCARP1(1,1)=C;%first unity capacitor of the array with 
                                 %his mismatch
iCARN1(1,1)=C;%first unity capacitor of the array with 
                                 %his mismatch
for i=1:m 
        for j=1:(2^(i-1))
        iCARP1(i,j)=C;
        iCARN1(i,j)=C;
        end
end

%Logic capacitors blocks

%# 1-1
iCAP1=zeros(1,m);
 for i=1:m
    iCAP1(i)=sum(iCARP1(i,:));
 end
 iCAP1=fliplr(iCAP1);
 iCAP1tot=sum(iCAP1);

 % #2-1
iCAN1=zeros(1,m);
 
for i=1:m
    iCAN1(i)=sum(iCARN1(i,:));
end
iCAN1=fliplr(iCAN1);
iCAN1tot=sum(iCAN1);

iCndummy=C;
iCpdummy=C;




%LSB arrays

iCARP2=zeros(m,2^(m));%initialization of the matrix describing the 1st capacitor array;
iCARN2=zeros(m,2^(m));%inizialization of the matrix describing the 3rd capacitor array;

iCARP2(1,1)=C;%first unity capacitor of the array with 
                                 %his mismatch
iCARN2(1,1)=C;%first unity capacitor of the array with 
                                 %his mismatch
for i=1:m 
        for j=1:(2^(i-1))
        iCARP2(i,j)=C;
        iCARN2(i,j)=C;
        end
end

%Logic capacitors blocks

%# 1-1
iCAP2=zeros(1,m);
 for i=1:m
    iCAP2(i)=sum(iCARP2(i,:));
 end
 iCAP2=fliplr(iCAP2);
 iCAP2tot=sum(iCAP2);

 % #2-1
iCAN2=zeros(1,m);
 
for i=1:m
    iCAN2(i)=sum(iCARN2(i,:));
end
iCAN2=fliplr(iCAN2);
iCAN2tot=sum(iCAN2);


Cbp=C;
Cbn=C;
Cx1=Cbp*iCAP2tot/(Cbp+iCAP2tot);
Cy1=Cbp*iCAP1tot/(Cbp+iCAP1tot);

Cx2=Cbn*iCAN2tot/(Cbn + iCAN2tot);
Cy2=Cbn*iCAN1tot/(Cbn + iCAN1tot);



%-------------------BEHAVIOUR AND LEVELS EVALUATION----------------------%

%useful parameters
LSB=2*FSR/2^n;
UPcode=[0;1];
DNcode=[1,0];

% ------------------------ALGORITMO SAR MONOTONIC------------------------%
%To check the whole scale of conversion
instart=-FSR;
instop=FSR;
instep=LSB;
%
% %------------------------------CON CAP ARRAY IDEALE---------------------%
% %allocating memory;
%levs=zeros(1,(2^(n+2)*n));
NN=(instop-instart)/(instep);
iDACout=zeros(NN+1,n);
DACout_p=zeros(NN+1,n);
DACout_n=zeros(NN+1,n);
iDACout_p=zeros(NN+1,n);
iDACout_n=zeros(NN+1,n);
V_lsb_P=zeros(NN+1,n);
V_lsb_N=zeros(NN+1,n);


zeros(NN+1,n);

k=0;

%Energia: nella implementazione ideale è calcolata anche l'energia per 
%ogni codifica;
En=zeros(NN+1,n);
En_p=En;
En_n=En;
CPserie=zeros(NN+1,n);
CNserie=zeros(NN+1,n);


%INDICI CHE TENGONO CONTO DELL'ACCENSIONE DI INTERRUTTORI
numero_switch=n-1;
SW=numero_switch*ones(1,2^n+1);
%nella fase sampling si attivano tutti;
Cgate=1e-15;



for Vind=instart:instep:instop
k=k+1;
CapCode=ones(2,n);
iDACout_p(k,1) = FSR;
iDACout_n(k,1) = FSR;
V_lsb_P(k,1) = FSR;
V_lsb_N(k,1) = FSR; 

iDACout(k,1)= iDACout_p(k,1) - iDACout_n(k,1);
Vcfr = -iDACout(k,1); %alla prima operazione tanto è zero...

if Vind>=0 %PRIMO QUADRANTE-----------------------------------------------%
        CapCode(:,1)=UPcode;
        ind=1;    
        CPserie(k,1)=0;
        CNserie(k,1)=0;
        
        for bit=2:n %l'ultimo serve solo a produrre l'LSB, che non rientra nel capcode;
             SW(k)=SW(k)+1; %che switcha a massa o a Vref in un senso o nell'altro ,comunque si usa uno switch;
             AUXP1=CapCode(1,1:m);
             AUXN1=CapCode(2,1:m);
             
             AUXP2=CapCode(1,(m+1):n) ;
             AUXN2=CapCode(2,(m+1):n) ;
             
             iDACout_p(k,bit) = FSR*(iCAP1*AUXP1')/(iCAP1tot + Cx1) + FSR*(Cbp / (iCAP1tot + Cbp))*(iCAP2*AUXP2')/(iCAP2tot + Cy1) ; 
             iDACout_n(k,bit) = FSR*(iCAN1*AUXN1')/(iCAN1tot + Cx2) + FSR*(Cbn / (iCAN1tot + Cbn))*(iCAN2*AUXN2')/(iCAN2tot + Cy2) ;     
             iDACout(k,bit)   = iDACout_p(k,bit) - iDACout_n(k,bit) ; % = -FSR*(iCAP1*AUXP' + iCpdummy)/(iCAP1tot+iCpdummy) + (FSR/(iCAN1tot+iCndummy)*(iCAN1*AUXN'+iCpdummy));         
             
             V_lsb_P(k,bit) = FSR*(iCAP1*AUXP1')/(iCAP1tot + Cx1)*(Cbp / (iCAP2tot + Cbp)) + FSR*(iCAP2*AUXP2')/(iCAP2tot + Cy1) ; 
             V_lsb_N(k,bit) = FSR*(iCAN1*AUXN1')/(iCAN1tot + Cx2)*(Cbn / (iCAN2tot + Cbn)) + FSR*(iCAN2*AUXN2')/(iCAN2tot + Cy2) ; 
             
             
             %calcolo dell'energia (dovuto al switch conseguente al confrontodell'iterazione precedente; 
         
             if ind==1
               En_p(k,bit)= FSR*(iCAP1*AUXP1')*(iDACout_p(k,bit-1)-iDACout_p(k,bit)) + FSR*(iCAP2*AUXP2')*(V_lsb_P(k,bit-1)-V_lsb_P(k,bit)) ;                                       
               En_n(k,bit)= 0 ; 
               En(k,bit)=  En_p(k,bit);
             else
               En_n(k,bit)= FSR*(iCAN1*AUXN1')*(iDACout_n(k,bit-1)-iDACout_n(k,bit)) + FSR*(iCAN2*AUXN2')*(V_lsb_N(k,bit-1)-V_lsb_N(k,bit)) ;
               En_p(k,bit)= 0 ;
               En(k,bit)=  En_n(k,bit);          
             end

             Vcfr= -iDACout(k,bit);  
             
             %levs(p)=Vcfr;
             %p=p+1;
             
             if Vind>=Vcfr 
                ind=1; %indice che ricorda che l'energia è consumata sull'array P
                CapCode(:,bit)=UPcode;    
             else
                ind=0; %indice che ricorda che l'energia è consumata sull'array N
                CapCode(:,bit)=DNcode;
             end              
        end
         
else   %TERZO QUADRANTE---------------------------------------------------%
        ind=0;
        CapCode(:,1)=DNcode;
        CPserie(k,1)=0;
        CNserie(k,1)=0; 
        
        
        for bit=2:n %L'ultimo serve solo a produrre l'LSB, che non rientra nel capcode;
            
            SW(k)=SW(k)+1; %che switcha a massa o a Vref in un senso o nell'altro ,comunque si usa uno switch;
            
            AUXP1=CapCode(1,1:m);
            AUXN1=CapCode(2,1:m);
             
            AUXP2=CapCode(1,(m+1):n);
            AUXN2=CapCode(2,(m+1):n);
            
                              
            iDACout_p(k,bit) = FSR*(iCAP1*AUXP1')/(iCAP1tot + Cx1) + FSR*(Cbp / (iCAP1tot + Cbp))*(iCAP2*AUXP2')/(iCAP2tot + Cy1) ; 
            iDACout_n(k,bit) = FSR*(iCAN1*AUXN1')/(iCAN1tot + Cx2) + FSR*(Cbn / (iCAN1tot + Cbn))*(iCAN2*AUXN2')/(iCAN2tot + Cy2) ;     
            iDACout(k,bit)   = iDACout_p(k,bit) - iDACout_n(k,bit); % = -FSR*(iCAP1*AUXP' + iCpdummy)/(iCAP1tot+iCpdummy) + (FSR/(iCAN1tot+iCndummy)*(iCAN1*AUXN'+iCpdummy));    
         
             
            V_lsb_P(k,bit) = FSR*(iCAP1*AUXP1')/(iCAP1tot + Cx1)*( Cbp / (iCAP2tot + Cbp)) + FSR*(iCAP2*AUXP2')/(iCAP2tot + Cy1 ) ; 
            V_lsb_N(k,bit) = FSR*(iCAN1*AUXN1')/(iCAN1tot + Cx2)*( Cbn / (iCAN2tot + Cbn)) + FSR*(iCAN2*AUXN2')/(iCAN2tot + Cy2 ) ; 
            
            %Calcolo dell'energia (dovuto al switch conseguente al confronto
            %dell'iterazione precedente);
            
            if ind==1
                En_p(k,bit)= FSR*(iCAP1*AUXP1')*(iDACout_p(k,bit-1)-iDACout_p(k,bit)) + FSR*(iCAP2*AUXP2')*(V_lsb_P(k,bit-1)-V_lsb_P(k,bit));                          
                En_n(k,bit) = 0 ; 
                En(k,bit) = En_p(k,bit);
            else
                En_n(k,bit) =  FSR*(iCAN1*AUXN1')*(iDACout_n(k,bit-1)-iDACout_n(k,bit)) + FSR*(iCAN2*AUXN2')*(V_lsb_N(k,bit-1)- V_lsb_N(k,bit));
                En_p(k,bit) = 0;
                En(k,bit) =  En_n(k,bit);          
            end

            Vcfr= - iDACout(k,bit);
                if Vind>=Vcfr 
                   ind=1; %indice che ricorda che l'energia è consumata sull'array P
                   CapCode(:,bit)=UPcode;           
                else
                   ind=0; %indice che ricorda che l'energia è consumata sull'array N
                   CapCode(:,bit)=DNcode;           
                end
         end
end
  

end


Energy=sum(En,2);

%calcolo dell'energia media secondo la forumula data da Liu;

Eavg_liu=0;
for i=1:n-1
    Eavg_liu=Eavg_liu + 2^(n-i-2)*C*FSR^2;
end
 
NormEN=Energy/(C*FSR^2);
codici=0:1:length(NormEN);

%AVG_EN_Liu=Eavg_liu*ones(1,length(Energy));

%AVG_EN=mean(Energy);

%EN_logic=SW*Cgate*Vdd^2;

%NormEN_logic=(SW*(Cgate*Vdd^2)/(C*FSR^2))';
%NormEN_logic(2^n+1)=NormEN_logic(2^n);

%AVG_NormEN=mean(NormEN);
%Energia_media=AVG_NormEN*ones(1,length(Energy));
% AVG_EN=mean(EN);
% MAX_EN=max(EN);
% 
% AVG_NormEN=mean(NormEN);
% Energia_media=AVG_NormEN*ones(1,length(codici));














