function [pos,par]=decif(stringa,arr)

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
    
    case {'/B<0>','/B(0)'}
        pos=1;
        return
    case {'/B<1>','/B(1)'}
        pos=2;
        return
    case {'/B<2>','/B(2)'}
        pos=3;
        return
    case {'/B<3>','/B(3)'}
        pos=4;
        return
    case {'/B<4>','/B(4)'}
        pos=5;
        return
    case {'/B<5>','/B(5)'}
        pos=6;
        return
    case {'/B<6>','/B(6)'}
        pos=7;
        return
    case {'/B<7>','/B(7)'}
        pos=8;
        return
    case {'/B<8>','/B(8)'}
        pos=9;
        return
    case {'/B<9>','/B(9)'}
        pos=10;
        return
    case {'/B<10>','/B(10)'}
        pos=11;
        return
    case {'/B<11>','/B(11)'}
        pos=12;
        return
    case {'/B<12>','/B(12)'}
        pos=13;
        return
    case {'/B<13>','/B(13)'}
        pos=14;
        return
    case '/VSS'
        if arr==1
        pos=15;%cpar_msb
        else
        pos=18;%cpar_lsb
        end
        return
    case '/VDD'
        if arr==1
        pos=16;%cpar_msb
        else
        pos=19;%cpar_lsb
        end
        return
    case {'/TOP' , '/TOP_LSB'}
        pos=17; %cbridge
        return
 
        
end
end
       


