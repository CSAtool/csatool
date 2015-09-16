function [vpar]=importpar(bwa,file1,file2)
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

if bwa==1;

% Import the file number 2 - LSB
rawData2 = importdata(file2, DELIMITER, HEADERLINES);

% For some simple files (such as a CSV or JPEG files), IMPORTDATA might
% return a simple array.  If so, generate a structure so that the output
% matches that from the Import Wizard.
[~,name] = fileparts(file2);
newData2.(genvarname(name)) = rawData2;

vars2 = fieldnames(newData2);

outdata2=newData2.(vars2{1});
outdata2=outdata2(3:end,1);

end


vpar=zeros(1,19);
for i=1:length(outdata1)
    cell=outdata1(i);
    stringa=cell{1};
    [pos,par]=decif(stringa,1);
    vpar(pos)=par;
end

%If a BWA architecture was Chosen

if bwa==1;

vpar2=zeros(1,19);
for i=1:length(outdata2)
    cell=outdata2(i);
    stringa=cell{1};
    [pos,par]=decif(stringa,0);
    vpar2(pos)=par;
end

for i=1:18
    vpar(i)=vpar(i)+vpar2(i);
end
vpar=vpar';
end
