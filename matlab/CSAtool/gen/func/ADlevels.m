function [Levels]=ADlevels(Vdd,Vss,n,SG)
%This functions generates the conversion scale of an A/D converter in which
%every level is contamined by a normal-random delta distributed with 0-mean
%and given SG std deviation in order to simulate a DNL;



LSB=(Vdd-Vss)/2^n;

Levels=zeros(1,2^n);
for i=0:2^n-1
    Levels(i+1)=Vss+i*LSB+LSB*normrnd(0,SG);
end
Levels(2:2^n)=Levels(2:2^n)-LSB/2;
end