function [OS] = osselect(sel, Vdd, Vss)
    
switch sel
        case 1
            FSR=Vdd-Vss;
            OS=FSR/2;
        case 2
            FSR=Vdd-Vss;
            OS=FSR/2;
        case 3
            FSR=Vdd-Vss;
            OS=FSR/2;
        case 4
            FSR=2*(Vdd-Vss);
            OS=0;
        case 5
            FSR=2*(Vdd-Vss);
            OS=0;
        case 6
            FSR=2*(Vdd-Vss);
            OS=0;
        case 7
            %Monotonic BW
            FSR=2*(Vdd-Vss);
            OS=0;
            %disp('Error: no model selected.');
            %return;
        case 8
            %Monotonic BWA
            FSR=2*(Vdd-Vss);
            OS=0;
            %disp('Error: no model selected.');
            %return;
        case 9
            disp('Error: no model selected.');
            return;
        case 10
            disp('Error: no model selected.');
            return;
    end

end

