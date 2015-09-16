function [ENOB] = enobst_met2(Nbit , FSR , dnl0 ,A1, A2, points, levels, OS)

n=Nbit;
fin_base= 1000;
fs=30000;



ncamp=2^12;
[fin,periods]=freqmax(fin_base,ncamp);

LSB=FSR/(2^n);
xlevels=levels;

if (A1~=A2)

Aa1=xlevels(round(A1*end));
if round(A2*length(xlevels))<=length(xlevels)
  Aa2=xlevels(round(A2*end));
else
  Aa2=xlevels(end)+5*LSB;
end

amp=linspace(Aa1,Aa2,points);
amp_index=1;

if OS~=0 %which is true in case of single ended topology
   amp=amp*0.5;
end


for z=1:points
   
      [sinput,t]=digitalsin(fin,fs,amp(z),OS,periods,0);
      %debug point
      %max(sinput)
      %mean(sinput)
      ADCout=zeros(max(size(sinput))-1,n);
      DACout=zeros(1,max(size(sinput))-1);
      i=1;
      for v=1:(max(size(sinput)))
         ADCout(i,1:n)=ADconversion(sinput(v),n,xlevels);
         DACout(i)= -FSR +LSB*bi2de(ADCout(i,1:n));
         i=i+1;
      end
   
      [PF,AF,freq]=FastFourierTransform(DACout,fs);
      %[SNDRa(amp_index),PN]=SNDR(PF,fin,fs);
      [SNDRa(amp_index),PN]=SNDRevaluate(PF,fin,fs,0,5e-2);
      ENOBa(amp_index)=(SNDRa(amp_index)-1.7609)/6.0206;
      amp_index = amp_index+1;
      
end


else
      amplitude=xlevels(round(A1*end));
      [sinput,t]=digitalsin(fin,fs,amplitude,OS,periods);
      ADCout=zeros(max(size(sinput))-1,n);
      DACout=zeros(1,max(size(sinput))-1);
      i=1;
      for v=1:(max(size(sinput)))
         ADCout(i,1:n)=ADconversion(sinput(v),n,xlevels);
         DACout(i)= -FSR +LSB*bi2de(ADCout(i,1:n));
         i=i+1;
      end

      [PF,AF,freq]=FastFourierTransform(DACout,fs);
      %[SNDRa(amp_index),PN]=SNDR(PF,fin,fs);
      [SNDRa,PN]=SNDRevaluate(PF,fin,fs,0,5e-2);
      ENOBa=(SNDRa-1.7609)/6.0206;
end
ENOB= max(ENOBa);
 
   
