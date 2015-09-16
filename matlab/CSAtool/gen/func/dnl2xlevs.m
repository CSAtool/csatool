function [levels]=dnl2xlevs(dnl,FSR,n)


LSB=(FSR)/2^n;
levels(1)= -0.5*FSR + LSB*(1+dnl(1)); 

for i=2:length(dnl)
    levels(i)=levels(i-1)+LSB*(1+dnl(i));
end
levels=levels+0.5*(FSR/2-max(levels));