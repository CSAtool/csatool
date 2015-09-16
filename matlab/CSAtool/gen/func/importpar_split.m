function [vpar]=importpar_split(file1)
%IMPORTFILE(FILETOREAD1)
%  Imports data from the specified file
%  FILETOREAD1:  file to read


DELIMITER = ' ';
HEADERLINES = 11;

% Import the file number 1 - MSB
rawData1 = importdata(file1, DELIMITER, HEADERLINES);

% For some simple files (such as a CSV or JPEG files), IMPORTDATA might
% return a simple array.  If so, generate a structure so that the output
% matches that from the Import Wizard.
[~,name] = fileparts(file1);
newData1.(genvarname(name)) = rawData1;

vars1 = fieldnames(newData1);

outdata1=newData1.(vars1{1});
outdata1=outdata1(3:end,1);

vpar=zeros(1,14);
for i=1:length(outdata1)
    cell=outdata1(i);
    stringa=cell{1};
    [pos,par]=decifSplit(stringa,1); %we are managing the split array of the MSB
    vpar(pos)=par;
end




