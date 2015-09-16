function [PF,AF,freq]=FastFourierTransform(signal,fs)
%funzione che calcola la trasformata di fuorier veloce di un segnale 
%signal campionato a frequenza di campionamento fs.
%NB:è bene fornire in ingresso un segnale con numero di periodi esatto 
%(senza salti di fase, raccordo perfetto);

T = 1/fs;                      %Sample time
N = max(size(signal));         %Length of signal




AF=abs(fft(signal))/N;       %Spettro bilatero in ampiezza tra:
                               %0 Hz(campione 1) 
                               %fs (campione L); 
                             
                             
AF=2*AF(1:N/2);              %spettro unilatero di ampiezza;
                             
PF=(AF.^2)/2;                  %spettro unilatero di potenza: ogni bin
                               %contiene la potenza del segnale;

%NB: gli spettri sono normalizzati sul numero di campioni (dBc);
                               
freq=fs/2*linspace(0,1,N/2); %creiamo il vettore delle frequenze;

end
                             
                             

