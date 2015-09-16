function [DNLcar]=mask2dnl(dnlbase,mask)

%The function takes a dnl basic characteristics and then adds 
%a new gaussian contribution to each code_DNL on the basis of the 
%mask,
%which defines the std of the DNL for each code.
%Mask and DNL must be coherent in dimesnions.


for i=1:length(dnlbase)
    DNLcar(i)= dnlbase(i) + normrnd(0,mask(i));
end

DNLcar;