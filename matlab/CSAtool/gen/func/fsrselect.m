function [ FSR] = fsrselect(sel, Vdd, Vss)
    
switch sel
        case 1
            FSR=Vdd-Vss;
        case 2
            FSR=Vdd-Vss;
        case 3
            FSR=Vdd-Vss;
        case 4
            FSR=2*(Vdd-Vss);
        case 5
            FSR=2*(Vdd-Vss);
        case 6
            FSR=2*(Vdd-Vss);
        case 7
            %Monotonic BW
            FSR=2*(Vdd-Vss);
            %disp('Error: no model selected.');
            %return;
        case 8
            %Monotonic BWA
            FSR=2*(Vdd-Vss);
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

