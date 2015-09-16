function [enob,sndr] = enobevAmpSpec( Nbit , FSR , levels , amp, nin)


n=Nbit;
l=round(length(levels)/2);
xlevels=levels-levels(l);

OS=0;
fin_base=1000;
fs=30000;
ncamp=2^12;
[fin,periods]=freqmax(fin_base,ncamp);
LSB=FSR/(2^Nbit);


[sinput,t]=digitalsin(fin,fs,amp,OS,periods,nin);
ADCout=zeros(max(size(sinput))-1,n);
DACout=zeros(1,max(size(sinput))-1);
        
i=1;
for v=1:(max(size(sinput)))
  ADCout(i,1:n)=ADconversion(sinput(v),n,xlevels);
  DACout(i)= -FSR + LSB*bi2de(ADCout(i,1:n));
  i=i+1;
end

[PF,AF,freq]=FastFourierTransform(DACout,fs);



%Method 1: SNDR function, picks 3 points orund the carrier peak
%[sndr,PN]=SNDR(PF,fin,fs);

%Method 2: SNDRevaluate function: iterative on SNDR with RelTol
RelTol=5e-2;
[sndr,PN]=SNDRevaluate(PF,fin,fs,0,RelTol);





enob=(sndr-1.7609)/6.0206;



