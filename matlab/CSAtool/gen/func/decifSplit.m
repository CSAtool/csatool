function [pos,par]=decif(stringa)

%arr says if it is the MSB (1) or the LSB (0) sub-array (for a BWA);

par=0;
pos=1;
while strcmp(stringa(1),' ')==1
      stringa=stringa(2:end);
end

i=1;
while strcmp(stringa(i),' ')==0
        cut=i;
        i=i+1;
end

%String of bit and string of par
stringa1=stringa(1:cut);
stringa2=strtrim(stringa(cut+1:end));



%Obtain parasitic
lst=length(stringa2)-1;
switch stringa2(end)
    
    case 'm'
        stringa2=strcat(stringa2(1:lst),'e-3');
    case 'u'
        stringa2=strcat(stringa2(1:lst),'e-6');
    case 'n'
        stringa2=strcat(stringa2(1:lst),'e-9');
    case 'p'
        stringa2=strcat(stringa2(1:lst),'e-12');
    case 'f'
        stringa2=strcat(stringa2(1:lst),'e-15');
    case 'a'
        stringa2=strcat(stringa2(1:lst),'e-18');
    case 'z'
        stringa2=strcat(stringa2(1:lst),'e-21');

end


par=str2num(stringa2);

switch stringa1
    
    case {'/MB<0>','/MB(0)'}
        pos=1;
        return
    case {'/MB<1>','/MB(1)'}
        pos=2;
        return
    case {'/MB<2>','/MB(2)'}
        pos=3;
        return
    case {'/MB<3>','/MB(3)'}
        pos=4;
        return
    case {'/MB<4>','/MB(4)'}
        pos=5;
        return
    case {'/MB<5>','/MB(5)'}
        pos=6;
        return
    case {'/MB<6>','/MB(6)'}
        pos=7;
        return
    case {'/MB<7>','/MB(7)'}
        pos=8;
        return
    case {'/MB<8>','/MB(8)'}
        pos=9;
        return
    case {'/MB<9>','/MB(9)'}
        pos=10;
        return
    case {'/MB<10>','/MB(10)'}
        pos=11;
        return
    case {'/MB<11>','/MB(11)'}
        pos=12;
        return
    case {'/MB<12>','/MB(12)'}
        pos=13;
        return
    case {'/MB<13>','/MB(13)'}
        pos=14;
        return

end
end
       


