function [NormEN,codici]=EA_MCBW(Nbit,Vdd,Vss,cunit,cbridge,cspec)


n=Nbit;
kc=0; 
c_spec=cspec;
C=cunit;
FSR=Vdd-Vss;

%stepwise option for MSB's; (1 is not stepwise)
steps=1;  
m=n;

%---------------- IDEAL CAPACITOR ARRAY BUILDING-------------------------%

%Mem. Alloc.;
iCARP1=zeros(m-1,2^(m-1));%initialization of the matrix describing the 1st capacitor array;
iCARN1=zeros(m-1,2^(m-1));%inizialization of the matrix describing the 3rd capacitor array;
iCARP1(1,1)=C;%first unity capacitor of the array with 
                                 %his mismatch
iCARN1(1,1)=C;%first unity capacitor of the array with 
                                 %his mismatch
for i=1:m-1 
        for j=1:(2^(i-1))
        iCARP1(i,j)=C;
        iCARN1(i,j)=C;
        end
end

%Logic capacitors blocks

%# 1-1
iCAP1=zeros(1,m-1);
 for i=1:m-1
    iCAP1(i)=sum(iCARP1(i,:));
 end
 iCAP1=fliplr(iCAP1);
 iCAP1tot=sum(iCAP1);

 % #2-1
iCAN1=zeros(1,m-1);
 
for i=1:m-1
    iCAN1(i)=sum(iCARN1(i,:));
end
iCAN1=fliplr(iCAN1);
iCAN1tot=sum(iCAN1);

iCndummy=C;
iCpdummy=C;



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
CPserie=zeros(NN+1,n);
CNserie=zeros(NN+1,n);

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
CapCode=ones(2,n-1);
iDACout_p(k,1) = FSR;
iDACout_n(k,1) = FSR;
iDACout(k,1)= iDACout_p(k,1) - iDACout_n(k,1);
Vcfr = -iDACout(k,1); %alla prima operazione tanto è zero...

if Vind>=0 %PRIMO QUADRANTE-----------------------------------------------%
        CapCode(:,1)=UPcode;
        ind=1;    
        CPserie(k,1)=0;
        CNserie(k,1)=0;
        
        for bit=2:n %l'ultimo serve solo a produrre l'LSB, che non rientra nel capcode;
             SW(k)=SW(k)+1; %che switch a massa o a Vref in un senso o nell'altro ,comunque si usa uno switch;
             AUXP=CapCode(1,:);
             AUXN=CapCode(2,:);
             
%             
%              
             iDACout_p(k,bit) = FSR*(iCAP1*AUXP' + iCpdummy)/(iCAP1tot+iCpdummy);
             iDACout_n(k,bit) = FSR*(iCAN1*AUXN' + iCndummy)/(iCAN1tot+iCndummy);     
             iDACout(k,bit)   = iDACout_p(k,bit) - iDACout_n(k,bit);% = -FSR*(iCAP1*AUXP' + iCpdummy)/(iCAP1tot+iCpdummy) + (FSR/(iCAN1tot+iCndummy)*(iCAN1*AUXN'+iCpdummy));         
             
             %calcolo dell'energia (dovuto al switch conseguente al confronto
             %dell'iterazione precedente;
         
             if ind==1
               En_p(k,bit)= FSR*(iCAP1*AUXP'+iCpdummy)*(iDACout_p(k,bit-1)-iDACout_p(k,bit));                                       
               En_n(k,bit)=0; 
               En(k,bit)=  En_p(k,bit);
             else
               En_n(k,bit)= FSR*(iCAN1*AUXN'+iCndummy)*(iDACout_n(k,bit-1)-iDACout_n(k,bit));
               En_p(k,bit)=0;
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
            SW(k)=SW(k)+1; %che switch a massa o a Vref in un senso o nell'altro ,comunque si usa uno switch;
            AUXP=CapCode(1,:);
            AUXN=CapCode(2,:);

            iDACout_p(k,bit) = FSR *(iCAP1*AUXP' + iCpdummy)/(iCAP1tot + iCpdummy);
            iDACout_n(k,bit) = FSR *(iCAN1*AUXN' + iCndummy)/(iCAN1tot + iCndummy); 
            iDACout(k,bit) = iDACout_p(k,bit) - iDACout_n(k,bit);% = -FSR*(iCAP1*AUXP' + iCpdummy)/(iCAP1tot+iCpdummy) + (FSR/(iCAN1tot+iCndummy)*(iCAN1*AUXN'+iCpdummy)); 
                        
            %Calcolo dell'energia (dovuto al switch conseguente al confronto
            %dell'iterazione precedente);
            if ind==1
                En_p(k,bit)= FSR*(iCAP1*AUXP'+iCpdummy)*(iDACout_p(k,bit-1)-iDACout_p(k,bit));                        
                En_n(k,bit) = 0 ; 
                En(k,bit) = En_p(k,bit);
            else
                En_n(k,bit)= FSR*(iCAN1*AUXN'+iCndummy)*(iDACout_n(k,bit-1)-iDACout_n(k,bit));   
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















