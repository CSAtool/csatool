function [mask]=maskselect(sel,Nbit)

switch sel
    case 1 %CBW SE
        switch Nbit
            case 6
                load('mask_bwSE6.mat')
                
            case 8
                load('mask_bwSE8.mat')
                
            case 10
                load('mask_bwSE10.mat')
                
            case 12
                load('mask_bwSE12.mat')
                
            case 14
                load('mask_bwSE14.mat')
                
        end
    case 2 %SBW - SE
         switch Nbit
            case 6
                load('mask_bwSE6.mat')
                
            case 8
                load('mask_bwSE8.mat')
                
            case 10
                load('mask_bwSE10.mat')
                
            case 12
                load('mask_bwSE12.mat')
                
            case 14
                load('mask_bwSE14.mat')
                
        end
    case 3 %BWA -SE
         switch Nbit
            case 6
                load('mask_clabridgeSE6.mat')
                
            case 8
                load('mask_clabridgeSE8.mat')
                
            case 10
                load('mask_clabridgeSE10.mat')
                
            case 12
                load('mask_clabridgeSE12.mat')
                
            case 14
                load('mask_clabridgeSE14.mat')
           
        end
    case 4 
         switch Nbit
            case 6
                load('mask_bwSE6.mat')
                
            case 8
                load('mask_bwSE8.mat')
                
            case 10
                load('mask_bwSE10.mat')
                
            case 12
                load('mask_bwSE12.mat')
                
            case 14
                load('mask_bwSE14.mat')
                
        end
    case 5
         switch Nbit
            case 6
                load('mask_bwSE6.mat')
                
            case 8
                load('mask_bwSE8.mat')
                
            case 10
                load('mask_bwSE10.mat')
                
            case 12
                load('mask_bwSE12.mat')
                
            case 14
                load('mask_bwSE14.mat')
                
        end
    case 6
         switch Nbit
            case 6
                load('mask_clabridgeSE6.mat')
                
            case 8
                load('mask_clabridgeSE8.mat')
                
            case 10
                load('mask_clabridgeSE10.mat')
                
            case 12
                load('mask_clabridgeSE12.mat')
                
            case 14
                load('mask_clabridgeSE14.mat')
           
        end
    case 7
         %disp('Mask Error: no model selected.');
         %return;
         switch Nbit
            case 6
                load('unimask6.mat')
                
            case 8
                load('unimask8.mat')
                
            case 10
                load('unimask10.mat')
                
            case 12
                load('unimask12.mat')
                
            case 14
                load('unimask14.mat')   
         end
    case 8
        %disp('Mask Error: no model selected.');
        %return;
         switch Nbit
            case 6
                load('unimask6.mat')
                
            case 8
                load('unimask8.mat')
                
            case 10
                load('unimask10.mat')
                
            case 12
                load('unimask12.mat')
                
            case 14
                load('unimask14.mat')
         end     
    case 9
         disp('Mask Error: no model selected.');
         return;
         switch Nbit
            case 6
                load('unimask6.mat')
                
            case 8
                load('unimask8.mat')
                
            case 10
                load('unimask10.mat')
                
            case 12
                load('unimask12.mat')
                
            case 14
                load('unimask14.mat')
                
        end
    case 10
         disp('Mask Error: no model selected.');
         return;
         switch Nbit
            case 6
                load('unimask6.mat')    
                
            case 8
                load('unimask8.mat')
                
            case 10
                load('unimask10.mat')
                
            case 12
                load('unimask12.mat')
                
            case 14
                load('unimask14.mat')
                
        end
end

if length(mask)<(2^Nbit-1)
    d=(2^(Nbit)-1)-length(mask);
    mask(end+d)=0;
end

