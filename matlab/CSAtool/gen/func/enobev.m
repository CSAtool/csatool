function [enobv,sndrv,amp] = enobev( Nbit , FSR , levels , points, nin)


n=Nbit;
l=round(length(levels)/2);
xlevels=levels-levels(l);

OS=0;
fin_base=1000;
fs=30000;
ncamp=2^12;
[fin,periods]=freqmax(fin_base,ncamp);
LSB=FSR/(2^Nbit);

A1=0;
A2=xlevels(end)+2*LSB;

enobv=zeros(1,points);
sndrv=zeros(1,points);
amp=linspace(A1,A2,points);
amp_index=1;

for z=1:points
        
        [sinput,t]=digitalsin(fin,fs,amp(z),OS,periods,nin);
        ADCout=zeros(max(size(sinput))-1,n);
        DACout=zeros(1,max(size(sinput))-1);
        
        i=1;
        for v=1:(max(size(sinput)))
          ADCout(i,1:n)=ADconversion(sinput(v),n,xlevels);
          DACout(i)= -FSR + LSB*bi2de(ADCout(i,1:n));
          i=i+1;
        end
   
        [PF,AF,freq]=FastFourierTransform(DACout,fs);
        
        %%disp('MET1')
        %Method 1: SNDR function, picks 3 points orund the carrier peak
        %[sndrv(amp_index),PN]=SNDR(PF,fin,fs)
        
        %disp('MET2')
        %Method 2: SNDRevaluate function: iterative on SNDR with RelTol
        RelTol=5e-2;
        [sndrv(amp_index),PN]=SNDRevaluate(PF,fin,fs,0,RelTol);
        if (sndrv(amp_index) <= 0)
        sndrv(amp_index)=1.761;
        end
        enobv(amp_index)=(sndrv(amp_index)-1.7609)/6.0206;
        amp_index = amp_index+1;
        if amp_index <= points
        disp(strcat('Progress : ',num2str(100*amp_index/points),'%'))
        end
end

%If there is an Inf or Nan value in enobv (and so sndrv), it must be
%removed:

for i=1:length(enobv)
    if (enobv(i)>Nbit)
        enobv(i)=NaN;
        sndrv(i)=NaN;
    end
end

amp=amp/(0.5*FSR);

