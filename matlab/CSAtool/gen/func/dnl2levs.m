function [levels]=dnl2levs(dnl,Vdd,Vss,n)

FSR=(Vdd-Vss);%*2;
LSB=(FSR)/2^n;
%levels(1)=-0.5*FSR+LSB*(1+dnl(1)); % Fully Differential;
levels(1)= Vss+LSB*(1+dnl(1)); % S. Ended;
for i=2:length(dnl)
    levels(i)=levels(i-1)+LSB*(1+dnl(i));
end
levels=levels+0.5*(Vdd-max(levels));