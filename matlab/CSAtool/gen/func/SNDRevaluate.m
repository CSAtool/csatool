function [SNDR,PN,PNF,pos]=SNDRevaluate(PF,fin,fs,ErrP,RelTol)

%Function:
%[SNDR,PN,PNF,pos]=SNDRev(PF,fin,fs,ErrP,RelTol)

%The function allows the evaluation of the SNDR given the output spectrum
%of a signal. It allows the posibility of correcting the extimation by
%subtracting the source noise power ErrP to the whole noise plus distortion
%power. If ErrP is equal to zero, no correction is performed.

%The function operates cyclically in order to guarantee the evaluation of
%SNDR even in case of spread-spectrums. The extimate does not stop till the
%error is major than the value specified in RelTol.


N=length(PF);

pos_nom=round((fin*N)/(fs/2));    
%è uguale al numero di periodi N*fin/fs;
%cancelliamo i tre punti in cui c'è %la potenza della fondamentale;
%sostituiamo con il noise floor calcolato ai confini;

%OPPURE PRENDIAMO IL MASSIMO
[massimo,posiz] = max(PF(4:end));
pos=posiz+1;
%delt=posiz-2;
%delt=round(posiz/5);
fprintf('The peak of the carrier frequency is located at the %d point on the freq axis\n', pos);
delt=1;
%calcoliamo la potenza della fondamentale (è posizionata a pos+1);


sndrErr = 1;
SNDR0 = 0;
 while (abs(sndrErr) > RelTol) || (delt>=pos);

    Pfund= sum(PF((pos-delt):(pos+delt)));
    PNF=PF;
    PNF(pos-delt:pos+delt)=zeros(1,2*delt+1);
    PNF(1:delt)=zeros(1,delt); 
    
    %Calcoliamo la potenza del restante spettro (THD+Noise); 
    PN=sum(PNF)-ErrP;
    
    %calcolo dell'SNDR;
    SNDR = 10*log10(Pfund/PN);
    sndrErr = abs((SNDR0-SNDR)/SNDR0);
    SNDR0 = SNDR;
    delt = delt+1;
    if delt>=(pos)
        delt=pos-1;
        fprintf('Error\n');
        break;
    end
 end
 
 fprintf('%d points canceld around the carrier\n', delt);
 
end