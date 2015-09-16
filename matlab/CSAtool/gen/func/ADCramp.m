function [rDACout] = ADCramp(Vdd,Vss,n,p,Levels)
%This m-file simulates the output of an ADC, re-converted with an ideal
%DAC to analog plottable values whit an ideal unitary ramp input
%Adc properties are specified as inputs.
% Inputs:
%        Vref=full scale range ;
%        n number of bits;
%        p points;
LSB=(Vdd-Vss)/2^n;      
i=1;
for v=Vss:((Vdd-Vss)/p):Vdd
    rADCout(i,1:n)=ADconversion(v,n,Levels);
    rDACout(i)=LSB*bi2de(rADCout(i,1:n));
    i=i+1;
end

end