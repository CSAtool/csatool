function [levels]=car2lev(car)

%script che data una caratteristica di ADC in ingresso ne calcola i livelli
%di tensione equivalenti corrispondenti ai gradini;

k=1;
for i=1:(length(car(:,2))-1)
    if car(i,2)~=car(i+1,2)
        levels(k)=car(i,1);
        k=k+1;
    end
end


