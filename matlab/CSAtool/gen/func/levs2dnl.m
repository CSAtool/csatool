function [DNL,INL]=levs2dnl(levels,LSB)


rgaps=diff(levels);
DNL=(rgaps-LSB)/LSB;

for j=1:length(DNL)
    INL(j)=sum(DNL(1:j));
end