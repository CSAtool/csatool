function [Dout] = ADconversion(Vin,n,Levels)


%The function realizes the Analog-to-Digital conversion of a given analog
%value, using a virtual n bits A/D converter with conversion scale described
%by the vector Levels. 

%INPUTS:
%Vref: Full Scale Range;
%Vin: Voltage analog input;
%n: number of bits;
%Levels: voltage levels of the conversion scale;

Dout=zeros(1,n);

DLvec=Levels-Vin;
[minimo,posmin]=min(abs(DLvec));
if Vin<=Levels(2);
    Dout=zeros(1,n);
else 
    if posmin==1
       Dout=zeros(1,n);
    else
    
       if DLvec(posmin)>0
       Dout=de2bi(posmin-2,n);
       else 
       Dout=de2bi(posmin-1,n);
       end
    end
end

end



% if Vin==Vref
%     Dout=ones(1,n);
% else
%     for i=1:(2^n-1)
%              if Vin<Levels(i+1)
%                 Dout=de2bi(i-1,n);
%                 break;
%              end
%              if Vin>=Levels(2^n)
%                  Dout=ones(1,n);
%                  break;
%              end
%     end
% end
% 
% 
% end
%Conversione classica ideale;
% if Vin==Vref
%     Dout=ones(1,n);
% else
%     A=floor(Vin/LSB);
%     Dout=de2bi(A,n);
% end
%plot(V_lev);