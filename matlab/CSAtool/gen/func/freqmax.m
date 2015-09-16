function [ftest,numerodiperiodi]=freqmax(freqtest,ncamp);

% genera la frequenza piu' vicina a quella impostata che abbia un numero di
% periodi intero e primo, all'interno della finestra di misura
% Numero di CAMPIONI * Periodo di CAMPIONAMENTO

% freqtest=input('frequenza di test');
% ncamp=input('numero di campioni');
% global OMEGATEST;
% fcamp=44100;
% 44100 programma originale , sostituisco con 1400000

fcamp=30000;   %frequenza di Nyquist = 30 kHz;
stoptimelow=(ncamp/fcamp)*8;
stoptimehi=(ncamp/fcamp)*4;
load primi.dat
if freqtest<(fcamp/ncamp)
   disp('aumentare la frequenza di test od il numero dei campioni');
else
ntest=round((freqtest*ncamp)/fcamp);
i=1;
while ntest>primi(i)
   i=i+1;
end
if ntest~=1
   diffsup=primi(i)-ntest;
   diffinf=ntest-primi(i-1);
   if diffsup>diffinf
      ntestprimo=primi(i-1);
   else
      ntestprimo=primi(i);
   end
else
   ntestprimo=1;
end
numerodiperiodi=ntestprimo;
ftest=(ntestprimo*fcamp)/ncamp;
%OMEGATEST=2*pi*ftest;
clear diffinf;
clear diffsup;
clear fcamp;
clear freqtest;
clear i;
clear ncamp;
clear ntest;
clear ntestprimo;
clear primi;
end
