function [sigmaDNL,DNLmax]=pars2dnl(C,Cpar1,Cpar2,n,Vdd,Vss,kc,c_spec)


LSB=(Vdd-Vss)/(2^n);
[levels] = bccrdSARparas(n,Vdd,Vss,C,kc,c_spec,Cpar1,Cpar2);
[DNL,~]=levs2dnl(levels,LSB);
sigmaDNL=std(DNL);
DNLmax=max(DNL);

end