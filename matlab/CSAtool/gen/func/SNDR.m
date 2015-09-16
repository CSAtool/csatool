function [SNDR,PN]=SNDR(PF,fin,fs)


N=length(PF);
pos=round((fin*N)/(fs/2));    
%è uguale al numero di periodi N*fin/fs;
%cancelliamo i tre punti in cui c'è %la potenza della fondamentale;
%sostituiamo con il noise floor calcolato ai confini;

%NB questa funzione è efficace quando lo spettro è calcolato su un segnale
%perfettamente raccordato così che il picco della fondamentale 
%contiene solo 3 punti.

%calcoliamo la potenza della fondamentale (è posizionata a pos+1);
Pfund=PF(pos+1);


% mu=mean(PF((pos):length(PF)));
% dstd=std(PF((pos+DELTA):length(PF)));
% PNF=PF;
%  for i=(pos-DELTA):(pos+DELTA);
%      PF(i)=normrnd(mu,dstd);
%  end
PNF=PF;
PNF(pos+1)=0;
PNF(1)=0; 
% %cancelliamo anche la continua
%  for i=1:(pos+DELTA)
%      PNF(i)=normrnd(mu,dstd);
%  end


%figure()
%plot(freq,10*log10(PF));
%plot(freq,10*log10(PF));

%Rumore di qantizzazione;
% V;
% n=10;
% PQ=((Vdd-Vss/2^n)^2)/12
% 

%Calcoliamo la potenza del restante spettro; 

PN=sum(PNF);


%calcolo dell'SNDR;
SNDR=10*log10(Pfund/PN);
end