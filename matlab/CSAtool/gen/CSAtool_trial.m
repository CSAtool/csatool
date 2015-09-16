function varargout = CSAtool(varargin)
% CSATOOL M-file for CSAtool.fig
%      CSATOOL, by itself, creates a new CSATOOL or raises the existing
%      singleton*.
%
%      H = CSATOOL returns the handle to a new CSATOOL or the handle to
%      the existing singleton*.
%
%      CSATOOL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in CSATOOL.M with the given input arguments.
%
%      CSATOOL('Property','Value',...) creates a new CSATOOL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before CSAtool_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to CSAtool_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help CSAtool

% Last Modified by GUIDE v2.5 14-Jul-2014 14:24:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @CSAtool_OpeningFcn, ...
                   'gui_OutputFcn',  @CSAtool_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before CSAtool is made visible.
function CSAtool_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure




handles.output = hObject;
% reset handles structure
guidata(hObject, handles);

%Global variables for model parameters
global Nbit;
Nbit=10;
global Vdd;
global Vss;
global Cpar11;
global Cpar12;
global Cpar21;
global Cpar22;
global kc;
global misos;
global cspec;
global cunit;
global cbridge;
global SCP;
global ipex;
global PEXM;
global PEXB;
global sel;
global STP;
global SBP;
global STBP;
global SPEX;
global sel;

global SAinput;
global nin;

sel=0;
kc=0;
misos=0;
cspec=1e-15;
%Global Variables for model features selection
global usndr;
global usndrSpec
global usc;
global umis;
global upar;
global levelsmat;
global noiseSel;

usc=0;
umis=0;
upar=0;

%Global Variables for SNDR evaluation management
global enobv;
global sndrv;
global amp;


%Global Variables for figure windows management
global dnapp;
global inapp;
global sndrmat;
global enobmat;
global indice;
global colm;
global colmB;

%memory
global pmeters
global indiceB;
indice=0;
indiceB=0;
pmeters=zeros(1,19);


%---------------------%

logocsa = imread( 'CSAtool.png' );
imshow(logocsa,'Parent',handles.logo);


%------------------%
clc

disp('%----------- CSA - Charge redistribution SAR ADC tool -----------%')
disp('Created by Stefano Brenna (Politecnico di Milano) and Andrea Bonetti (EPFL)')
disp('Contacts:')
disp('Web: https://csatool.wordpress.com/')
disp('E-mail: crsaradctool@gmail.com')
disp('GitHub: https://github.com/csatool/')
disp('...')
disp('------------------------------------------')
disp('Starting New Session...')
disp('Ready: choose your CR SAR ADC array features, simulate and')
disp('please watch at the MATlab command window as a log.')



%------------------%

amp=0;
sndrv=0;
enobv=0;
SAinput=0;
nin=0;
usndr=0;
usndrSpec=0;
noiseSel=0;
colm=zeros(indice,3);
colmB=zeros(indiceB,3);
inapp=zeros(1,2^Nbit-2);
dnapp=zeros(1,2^Nbit-2);
ipex=0;
set(handles.plotoptions,'Value',2);
set(handles.DNLbox,'LineWidth',2);
set(handles.INLbox,'LineWidth',2);
set(handles.sndrplot,'LineWidth',2);

axes(handles.sndrplot)
ylabel('SNDR [dB]','FontSize',8,'FontWeight','bold');
xlabel('Input Amplitude [%FSR]','FontSize',8,'FontWeight','bold');

axes(handles.DNLbox)
ylabel('LSB','FontSize',8,'FontWeight','bold');
xlabel('Output Level','FontSize',8,'FontWeight','bold');
title('Coarse DNL','FontSize',8,'FontWeight','bold');

axes(handles.INLbox)
ylabel('LSB','FontSize',8,'FontWeight','bold');
xlabel('Output Level','FontSize',8,'FontWeight','bold');
title('Coarse INL','FontSize',8,'FontWeight','bold');
% UIWAIT makes CSAtool wait for user response (see UIRESUME)
% uiwait(handles.figure1);

% --- Outputs from this function are returned to the command line.
function varargout = CSAtool_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)






%---------LICENSE MANAGEMENT MODULE-----------%

%Licenses parameters initialization
LN=50; %Number of Licenses 
LL=20; %License Length
codematrix=zeros(LN,LL);
iniz=1;
cmi=1;
status=0;
s=zeros(LL*LN,1);



%Read authorized licenses from stp server
sin = urlread('ftp://ftp.elet.polimi.it/users/Stefano.Brenna/CSA_tool/CSAtoolics.txt');

k=1;
for j=1:length(sin)
if ( isempty(str2double(sin(j))) || isnan(str2double(sin(j))) );
    %Nothing to do
else
    s(k)=str2double(sin(j));
    k=k+1;
end
end

%Read customer license file
lic=fileread('CSAtool/lic/lic.txt');
licode=zeros(1,length(lic));
for j=1:(length(lic))
    licode(j)=str2double(lic(j));
end
%lic
%licode

for i=1:LN*LL
    if mod(i,LL)==0
        fine=i;
        
        for j=1:LL
        codematrix(cmi,j)=s(iniz+j);
        end
        
        iniz=fine;
%         codematrix(cmi,:)
        %codematrix
        if codematrix(cmi,:)==licode;
            status=1;
        end
        cmi=cmi+1;
    end
end


%Result
if status==1
    fprintf('Authorization found\n')
else
    fprintf('ERROR: Could not get authorization to run the program\n')
    close all
end

clear LL LN iniz cmi status s lic licode codematrix
%--------------------------------------%
%---------END OF LICENSE MODULE--------%




varargout{1} = handles.output;

% --- Executes on selection change in listbox1.
function listbox1_Callback(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global sel;
sel=get(handles.listbox1,'Value');
boxset(hObject,eventdata,handles);

% --- Executes during object creation, after setting all properties.
function listbox1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to listbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function cp11_Callback(hObject, eventdata, handles)
% hObject    handle to cp11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes during object creation, after setting all properties.
function cp11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cp11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function cp12_Callback(hObject, eventdata, handles)
% hObject    handle to cp12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes during object creation, after setting all properties.
function cp12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cp12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%---------------------------------------------------------------------%
%---------------------------------------------------------------------%

function cp21_Callback(hObject, eventdata, handles)
% hObject    handle to cp21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes during object creation, after setting all properties.
function cp21_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cp21 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function cp22_Callback(hObject, eventdata, handles)
% hObject    handle to cp22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% --- Executes during object creation, after setting all properties.
function cp22_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cp22 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function cunit_Callback(hObject, eventdata, handles)
% hObject    handle to cunit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function cunit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cunit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cbridge_Callback(hObject, eventdata, handles)
% hObject    handle to cbridge (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



% --- Executes during object creation, after setting all properties.
function cbridge_CreateFcn(hObject, eventdata, handles)
% hObject    handle to cbridge (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function kc_Callback(hObject, eventdata, handles)
% hObject    handle to kc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%returns contents of kc as a double


% --- Executes during object creation, after setting all properties.
function kc_CreateFcn(hObject, eventdata, handles)
% hObject    handle to kc (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function cspec_Callback(hObject, eventdata, handles)
% hObject    handle to cspec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function cspec_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function STP_Callback(hObject, eventdata, handles)


function STP_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Nbit_Callback(hObject, eventdata, handles)



function Nbit_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Vdd_Callback(hObject, eventdata, handles)
% hObject    handle to Vdd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Vdd as text
%        str2double(get(hObject,'String')) returns contents of Vdd as a double


% --- Executes during object creation, after setting all properties.
function Vdd_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Vdd (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Vss_Callback(~, eventdata, handles)
% hObject    handle to Vss (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Vss as text
%        str2double(get(hObject,'String')) returns contents of Vss as a double


% --- Executes during object creation, after setting all properties.
function Vss_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Vss (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in runbutton.
function runbutton_Callback(hObject, eventdata, handles, ipex)
% hObject    handle to runbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp('...')
disp('%-------------------NEW RUN------------------------&')
disp('...')
c=clock;
disp(cat(2, date, ' || Time:    ', num2str(c(4)), ':' , num2str(c(5)) , ':',num2str(c(6))))
disp('Current array configuration - Single Run')

global Nbit;
global Vdd;
global Vss;
global Cpar11;
global Cpar12;
global Cpar21;
global Cpar22;
global kc;
global misos;
global cspec;
global cunit;
global cbridge;
global ipex;
global PEXM;
global sel;
global STP;
global SBP;
global STBP;
global SPEX;
global misos;

global upar;
global umis;
global usc;
global usndr;
global usndrSpec;
global noiseSel;
global nin;

global dnapp;
global inapp;
global sndrmat;
global enobmat;
global po;
global colm;
global colmB;
global levelsmat;





global enobv
global sndrv;
global amp;
global SAinput;
global nin;

global pmeters;
global indice;
global indiceB;



% Getting/updating basic design parameters;
Vss=str2double(get(handles.Vss,'String'));
Vdd=str2double(get(handles.Vdd,'String'));
Cpar11 = upar * str2double(get(handles.cp11,'String'));
Cpar12 = upar * str2double(get(handles.cp12,'String'));
Cpar21 = upar * str2double(get(handles.cp21,'String'));
Cpar22 = upar * str2double(get(handles.cp22,'String'));
kc = umis * str2double(get(handles.kc,'String'));
misos= umis * str2double(get(handles.mos,'String'));
cspec=str2double(get(handles.cspec,'String'));
cunit=str2double(get(handles.cunit,'String'));
cbridge=str2double(get(handles.cbridge,'String'));
STP  = usc * str2double(get(handles.STP,'String'));
SBP  = usc * str2double(get(handles.SBP,'String'));
STBP = usc *str2double(get(handles.STBP,'String'));
xNbit=str2double(get(handles.Nbit,'String'));


% if xNbit ~= Nbit
%      inapp=zeros(1,2^Nbit-2);
%      dnapp=zeros(1,2^Nbit-2);
%      indice=0;
%      colm=zeros(indice+1,3);
% end

Nbit=xNbit;

if sel==0
    disp('ERROR: No topology is selected')
    disp('Select a topology and Run again')
    disp('Simulation aborted')
    return;
end

upar = get(handles.usepar,'Value');
usc = get(handles.usesc,'Value');
umis = get(handles.usemis,'Value');
usndr = get(handles.evalsndr,'Value');
usndrSpec =get(handles.evalsndrSpec,'Value');
noiseSel=get(handles.chnoise,'Value');



disp(get(handles.text1,'String'))
disp(cat(2,num2str(Nbit),' bit'))
if upar == 1
    disp('External Parasitics taken into account');
else
    disp('External Parasitics NOT taken into account');
end
if usc == 1
    disp('Specific Parasitics taken into account');
else
    disp('Specific Parasitics NOT taken into account');
end
if umis == 1
    disp('Mismatch taken into account');
else
    disp('Mismatch NOT taken into account');
end

sel=get(handles.listbox1,'Value');
fs=1000*str2double(get(handles.fsam,'String'));

%Checking the Numbr of bits;
if (mod(Nbit,2)~=0)&&(Nbit<14)&&(Nbit>6)
    Nbit=10;
    set(handles.Nbit,'String','10')
    else if Nbit<6
        Nbit=6;
        set(handles.Nbit,'String','6')
        else if Nbit>14
             Nbit=14;
             set(handles.Nbit,'String','14')
             end
    end
end


if  ((STBP/cspec)>=1)||((STP/cspec)>=1)||((SBP/cspec)>=1)
      error2
      return;
end


%Saving the workspace;
nomefile = 'last';
savefile = nomefile ;
save(['CSAtool/work/' savefile '.mat'], 'Vss', 'Vdd', 'Cpar11', 'Cpar22', 'Cpar21','Cpar22','kc','misos','cspec','cunit','cbridge','STP','SBP','STBP','Nbit');


%Graphic colours Settings;
dnlcol=get(handles.color,'Value');
inlcol=dnlcol;

pcolor=zeros(6,3);
pcolor(1,:)=[1 0 0]; %red
pcolor(2,:)=[0 1 0]; %green
pcolor(3,:)=[0 0 1]; %blue
pcolor(4,:)=[0 0 0]; %yellow
pcolor(5,:)=[1 1 0]; %black
pcolor(6,:)=[1 0 1]; %magenta

%All'interno della funzione RUN tutte le variabili sono disponibili quindi
%qui posso lanciare le varie funzioni a seconda dell'ADC scelto

po=get(handles.plotoptions,'Value');


%Design parameters from PPEXtool
%initialization
PEX11=zeros(1,Nbit/2);    
PEX12=zeros(1,Nbit/2);  
PEX21=zeros(1,Nbit/2);  
PEX22=zeros(1,Nbit/2);  
PEXB=zeros(1,Nbit/2);  

%only if PPEX tool is used;
if ipex==1
        m=Nbit/2;
%         Nbit
%         m
%         ipex
        %PEXM=get(PPEXtool, 'UserData') ;
        PEX11=PEXM(1,1:m);
        PEX12=PEXM(2,1:m);
        PEX21=PEXM(3,1:m);
        PEX22=PEXM(4,1:m);
        PEXB=PEXM(5,1:2);
else
        SPEX=zeros(2,13);
end

%end PPEXtool input management
    global DNL;
    global INL; 
    disp('Evaluating non linearities...it may takes a few seconds...')
    [DNL,INL,levels,err]=nlfunc(sel,Nbit,Vdd,Vss,cunit,cbridge,kc,misos,cspec,STP,SBP,STBP,Cpar11,Cpar12,Cpar21,Cpar22,PEX11,PEX12,PEX21,PEX22,PEXB,SPEX);
    
    if err==0
        if min(DNL)<(-1) 
        disp('WARNING: NON MONOTONIC IO-characteristic and/or MISSING CODES')
        else
        
            if length(levels)==(2^Nbit-1)
            disp('Transition levels had been successfully evaluated')
            else
            disp('WARNING: Transition levels evaluation failed: NON MONOTONIC IO-characteristic and/or MISSING CODES')
            end
            if length(DNL)==(2^Nbit-2)
            disp('DNL has been successfully evaluated')
            else
            disp('WARNING: DNL evaluation failed: NON MONOTONIC IO-characteristic and/or MISSING CODES')
            end
            if length(INL)==(2^Nbit-2)
            disp('INL has been successfully evaluated')
            c=clock;
            disp(cat(2, date, ' || Time:    ', num2str(c(4)), ':' , num2str(c(5)) , ':',num2str(c(6))))
            else
            disp('WARNING: INL evaluation failed: NON MONOTONIC IO-characteristic and/or MISSING CODES')
            end
       end
    else
    disp('ERROR: No Model')
    return;
       
 end

%overall runs management
if (po==1)
      hold on;
      if indice==0
         indice=1;
         %param management
         pmeters=[ Nbit,Vdd,Vss,kc,misos,cspec,cunit,cbridge,Cpar11,Cpar12,Cpar21,Cpar22,STBP,STP,SBP,sel,umis,usc,upar];
         %plot management
         dnapp=zeros(1,2^Nbit-2);
         dnapp(1,1:length(DNL))=DNL;
         inapp=zeros(1,2^Nbit-2);
         inapp(1,1:length(INL))=INL;        
         
         levelsmat=zeros(1,2^Nbit-1);
         levelsmat(1,1:length(levels))=levels;  
         
         colm=pcolor(dnlcol,:);
      else
         indice=indice+1;
         %parameters management
         if ( Nbit ~= pmeters(indice-1,1))
            indice=indice-1;
            disp('Cannot run with "append" plot option when Nbit has changed')
            disp('Keep the same Nbit or select "replace" plot option')
            return
         end  
         pmeters=[ pmeters(1:indice-1,:) ; Nbit,Vdd,Vss,kc,misos,cspec,cunit,cbridge,Cpar11,Cpar12,Cpar21,Cpar22,STBP,STP,SBP,sel,umis,usc,upar];
         
  
         %plot management
         dnapp=([dnapp(1:indice-1,:); zeros(1,length(dnapp(1,:)))]);
         dnapp(indice,1:length(DNL))=DNL;
         
         inapp=([inapp(1:indice-1,:); zeros(1,length(inapp(1,:)))]);
         inapp(indice,1:length(INL))=INL;     
         
         levelsmat=([levelsmat(1:indice-1,:); zeros(1,length(levelsmat(1,:)))]);
         levelsmat(indice,1:length(levels))=levels;  
         
         colm=[ colm(1:indice-1,:) ; pcolor(dnlcol,:)];
      end 
   else
       indice=1;
       %par man.
       pmeters=[ Nbit,Vdd,Vss,kc,misos,cspec,cunit,cbridge,Cpar11,Cpar12,Cpar21,Cpar22,STBP,STP,SBP,sel,umis,usc,upar];
       %plot man.
       dnapp=DNL;
       inapp=INL;
       levelsmat=levels;
       colm=pcolor(dnlcol,:);
end
    



min(dnapp);

min(inapp);



%-------------Graphics
      %---DNL plot;
    axes(handles.DNLbox);
      if (po==1)
        hold on;
      else
        hold off;
      end
      stem(0:(length(DNL)-1),DNL,'Linewidth',1,'color',pcolor(dnlcol,:));
      grid on;
      axis([0 length(DNL) (-0.1+min(min(dnapp))) (0.1+max(max(dnapp)))])
      title('Coarse DNL','FontSize',8,'FontWeight','bold');
      xlabel('Output Level','FontSize',8,'FontWeight','bold')
      ylabel('LSB','FontSize',8,'FontWeight','bold');
      set(handles.DNLbox,'LineWidth',2);
     
     
     %---INL plot;
     axes(handles.INLbox);
     if (po==1)
      hold on;
     else
         hold off;
     end
     plot(0:(length(INL)-1),INL,'Linewidth',1,'color',pcolor(inlcol,:));
     grid on;
     grid on;
     axis([0 length(INL) (-0.1+min(min(inapp))) (0.1+max(max(inapp)))])
     title('Coarse INL','FontSize',8,'FontWeight','bold');
     xlabel('Output Level','FontSize',8,'FontWeight','bold');
     ylabel('LSB','FontSize',8,'FontWeight','bold');
     set(handles.INLbox,'LineWidth',2);
    
%------------------------------------------------------------------------%
 
%SNDR and ENOB;

points=15;
if usndr == 1
    set(handles.enobAin,'String',num2str( 0 ));
    disp('Current array configuration - SNDR evaluation vs sinusoidal-input amplitude\n') 
    if noiseSel==1
        disp('Noise is included');
        nin=str2double(get(handles.noisein,'string'));
    else
        nin=0;
    end
    FSR=fsrselect(sel,Vdd,Vss);
    deltaAin=str2double(get(handles.dain,'string'));
    points=round(1/deltaAin);
    disp(cat(2,'Full Scale Range: ', num2str(FSR)));
    [enobv,sndrv,amp] = enobev(Nbit , FSR, levels, points, nin);
    c=clock;
    disp(cat(2, date, ' || Time:    ', num2str(c(4)), ':' , num2str(c(5)) , ':',num2str(c(6))))
    else
    sndrv=zeros(1,points);
    enobv=zeros(1,points);
    amp=zeros(1,points); 
end

if usndrSpec == 1
    set(handles.enobAin,'String',num2str( 0 ));
    disp('Current array configuration - SNDR evaluation at the specified sinusoidal-input amplitude\n') 
    if noiseSel==1
        disp('Noise is included');
        nin=str2double(get(handles.noisein,'string'));
    else
        nin=0;
    end
    FSR=fsrselect(sel,Vdd,Vss);
    SAinput=str2double(get(handles.SAin,'String'));
    disp(cat(2,'Full Scale Range: ', num2str(FSR)));
    disp(cat(2,'Input Amplitude: ', num2str(SAinput)));
    [enobsp,sndrsp] = enobevAmpSpec(Nbit , FSR, levels, SAinput, nin);
    c=clock;
    disp(cat(2, date, ' || Time:    ', num2str(c(4)), ':' , num2str(c(5)) , ':',num2str(c(6))))
    else
    enobsp=0;
    sndrsp=0;
end




%SNDR-ENOB plot and display result section:

if (po==1)
     if indiceB==0
         indiceB=1;
         %param management
         sndrmat=sndrv;
         enobmat=enobv;
         colmB=pcolor(dnlcol,:);
     else
         indiceB=indiceB + 1;
         %parameters management
         if ( Nbit ~= pmeters(indiceB - 1,1))
            indiceB = indiceB - 1;
            disp('Cannot run with "append" plot option when Nbit has changed')
            disp('Keep the same Nbit or select "replace" plot option')
            return
         end 
         sndrmat = [ sndrmat(1:indiceB-1,:) ; sndrv];
         enobmat = [ enobmat(1:indiceB-1,:) ; enobv];    
         colmB = [ colm(1:indiceB-1,:) ; pcolor(dnlcol,:)];
      end 
   else
       indiceB = 1;
       sndrmat=sndrv;
       enobmat=enobv;
       colmB=pcolor(dnlcol,:);
end
   
   %Debiug point
   %size(sndrmat)
   %sndrmat

if usndr==1
    axes(handles.sndrplot)
    if (po==1)
      hold on;
    else
      hold off;
    end
    plot(100*amp,sndrv,'LineWidth',1.5,'color',colmB(indiceB,:),'Marker','o')    
    axis([0 max(100*amp) (min(sndrv)-0.5) (max(max(sndrmat))+3)]);
    grid on
    ylabel('SNDR [dB]','FontSize',8,'FontWeight','bold');
    xlabel('Input Amplitude [%FSR]','FontSize',8,'FontWeight','bold');
    set(handles.sndrplot,'LineWidth',2);
    set(handles.enobmax,'String',num2str(max(enobv)));
    set(handles.sndrmax,'String',num2str(max(sndrv)));
    
end

if usndrSpec==1
     set(handles.enobAin,'String',num2str(max(enobsp)));
end

%Power Evaluation;
[ef,csf]=efsel(sel,Vdd,Vss,Nbit);
ener= ef * cunit * (Vdd-Vss)^2;
set(handles.econs,'String',num2str(ener))
powcon=fs*ener;
powsam=fs*csf*cunit*(0.5*(Vdd-Vss))^2;
set(handles.pcons,'String',num2str(powcon))
set(handles.spcons,'String',num2str(powsam))









function savefilename_Callback(hObject, eventdata, handles)
% hObject    handle to savefilename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function savefilename_CreateFcn(hObject, eventdata, handles)
% hObject    handle to savefilename (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function plotoptions_Callback(hObject, eventdata, handles)
% hObject    handle to plotoptions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function plotoptions_CreateFcn(hObject, eventdata, handles)
% hObject    handle to plotoptions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function dnlplotoptions_Callback(hObject, eventdata, handles)
% hObject    handle to dnlplotoptions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function dnlplotoptions_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dnlplotoptions (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function color_Callback(hObject, eventdata, handles)
% hObject    handle to color (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function color_CreateFcn(hObject, eventdata, handles)
% hObject    handle to color (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function dnlcolor_Callback(hObject, eventdata, handles)
% hObject    handle to dnlcolor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

function dnlcolor_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dnlcolor (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function popupmenu5_Callback(hObject, eventdata, handles)
% hObject    handle to color (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


function popupmenu5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to color (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%----------------------PPEX tool execution----------------------%
%---------------------------------------------------------------%
% --- Executes on button press in PPEXtool.

% 
% function PPEXtool_Callback(hObject, eventdata, handles)

% global Nbit
% global sel
% Nbit=str2double(get(handles.Nbit,'String'));
% 
% %--------Nbit control%
% if (mod(Nbit,2)~=0)&&(Nbit<14)&&(Nbit>6)
%     Nbit=10;
%     set(handles.Nbit,'String','10')
%     else if Nbit<6
%         Nbit=6;
%         set(handles.Nbit,'String','6')
%         else if Nbit>14
%              Nbit=14;
%              set(handles.Nbit,'String','14')
%              end
%     end
% end
% %----------------------%
% 
% sel=get(handles.listbox1,'Value');
% PPEXtool






% --- Executes on button press in Reset.
function Reset_Callback(hObject, eventdata, handles)
% hObject    handle to Reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

%All variables to be reset
%General
global Nbit;
global Vdd;
global Vss;
global Cpar11;
global Cpar12;
global Cpar21;
global Cpar22;
global cunit;
global cbridge;
global STP;
global SBP;
global STBP;
global sel;

%Default Values
Nbit=10;
Vdd=3.3;
Vss=0;
Cpar11=5e-15;
Cpar12=5e-15;
Cpar21=5e-15;
Cpar22=5e-15;
cunit=20e-15;
cbridge=20e-15;
STP=0.001e-15;
SBP=0.001e-15;
STBP=0.001e-15;
sel=0;


%PPEXtool
global PEXM;
global PEXB;
global SPEX;

%Default Values
PEXM=zeros(5,7); 
PEXB=[0 , 0];
SPEX=zeros(2,13);

%technologic
global kc;
global cspec;
global misos;

%Default Values
kc=0.01;
cspec=1e-15;
misos=1e-05;

%plotting options
global dnapp;
global inapp;
global sndrmat;
global enobmat;
global indice;
global colm;
global indiceB;
global levelsmat;
sndrmat=0;
enbomat=0;


%Default Values
indice=1;
indiceB=1;
dnapp=zeros(1,2^Nbit-2);
inapp=zeros(1,2^Nbit-2);
levelsmat=zeros(1,2^Nbit-1);
colm=zeros(indice,3);
colmB=zeros(indiceB,3);
%SNDR and ENOB
global sndrv;
global enobv;

%Default Values
sndrv=0;
enobv=0;

%model features selection
global upar;
global usc;
global usndr;
global usndrSpec;
global umis;

%Default Values
upar=0;
usndr=0;
usndrSpec=0;
usc=0;
umis=0;


%summary vars
global pmeters;
global indice;
global indiceB;
%Default Values
indice=0;
indiceB=0;
pmeters=zeros(1,19);




%--------------------Set/Display Default values---------------------------%

set(handles.text1,'String','Current Topology - Choose One!')
set(handles.Nbit,'String',num2str(10));
set(handles.Vdd,'String',num2str(3));
set(handles.Vss,'String',num2str(0));
set(handles.cp11,'String',num2str(5e-15));
set(handles.cp12,'String',num2str(5e-15));
set(handles.cp21,'String',num2str(5e-15));
set(handles.cp22,'String',num2str(5e-15));
set(handles.cunit,'String',num2str(20e-15));
set(handles.cbridge,'String',num2str(20e-15));
set(handles.STP,'String',num2str(0.001e-15));
set(handles.SBP,'String',num2str(0.001e-15));
set(handles.STBP,'String',num2str(0.001e-15));
set(handles.usesc,'Value',0)
set(handles.usemis,'Value',0)
set(handles.evalsndr,'Value',0)
set(handles.evalsndrSpec,'Value',0)
set(handles.usepar,'Value',0)
set(handles.kc,'String',num2str(kc))
set(handles.cspec,'String',num2str(cspec))
set(handles.mos,'String',num2str(misos))

axes(handles.DNLbox)
cla;
set(handles.DNLbox,'LineWidth',2);
axes(handles.INLbox)
cla;
set(handles.INLbox,'LineWidth',2);
axes(handles.sndrplot)
cla;
set(handles.sndrplot,'LineWidth',2);


function SBP_Callback(hObject, eventdata, handles)
function SBP_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function STBP_Callback(hObject, eventdata, handles)
function STBP_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --------------------------------------------------------------------
function mnFile_Callback(hObject, eventdata, handles)

% --------------------------------------------------------------------
function Save_Callback(hObject, eventdata, handles)


% --------------------------------------------------------------------
function mnTools_Callback(hObject, eventdata, handles)


% --------------------------------------------------------------------
function mnHelp_Callback(hObject, eventdata, handles)


% --------------------------------------------------------------------
function mnPPEX_Callback(hObject, eventdata, handles)


global Nbit
global sel
Nbit=str2double(get(handles.Nbit,'String'));

%--------Nbit control%
if (mod(Nbit,2)~=0)&&(Nbit<14)&&(Nbit>6)
    Nbit=10;
    set(handles.Nbit,'String','10')
    else if Nbit<6
        Nbit=6;
        set(handles.Nbit,'String','6')
        else if Nbit>14
             Nbit=14;
             set(handles.Nbit,'String','14')
             end
    end
end
%----------------------%

sel=get(handles.listbox1,'Value');
PPEXtool







% --------------------------------------------------------------------
function mnStat_Callback(hObject, eventdata, handles)


global Nbit;
global Vdd;
global Vss;
global Cpar11;
global Cpar12;
global Cpar21;
global Cpar22;
global kc;
global misos;
global cspec;
global cunit;
global cbridge;
global ipex;
global PEXM;
global PEXB;
global sel;
global STP;
global SBP;
global STBP;
global SPEX;
global umis;
global usc;

if umis == 0
    kc_Error
    disp('ERROR: SSA tool cannot be used without defining non-zero mismatch parameters')
    disp('...')
    return
else


Nbit=str2double(get(handles.Nbit,'String'));
Vdd=str2double(get(handles.Vdd,'String'));
Vss=str2double(get(handles.Vss,'String'));
sel=get(handles.listbox1,'Value');
Cpar11=str2double(get(handles.cp11,'String'));
Cpar12=str2double(get(handles.cp12,'String'));
Cpar21=str2double(get(handles.cp21,'String'));
Cpar22=str2double(get(handles.cp22,'String'));
kc=umis*str2double(get(handles.kc,'String'));
cspec=umis*str2double(get(handles.cspec,'String'));
misos=umis*str2double(get(handles.mos,'String'));
cunit=str2double(get(handles.cunit,'String'));
cbridge=str2double(get(handles.cbridge,'String'));
STP=usc*str2double(get(handles.STP,'String'));
SBP=usc*str2double(get(handles.SBP,'String'));
STBP=usc*str2double(get(handles.STBP,'String'));


SSA;
end
% --------------------------------------------------------------------
function mnLoad_Callback(hObject, eventdata, handles)

%LOAD STATE FUNCTION

global sel
global Nbit;
global Vdd;
global Vss;
global Cpar11;
global Cpar12;
global Cpar21;
global Cpar22;
global cunit;
global cbridge;
global STP;
global SBP;
global STBP;
global misos;
%PPEXtool
global PEXM;
global PEXB;
global SPEX;

%model features selection
global usc;
global upar;
global usndr;
global umis;
global usndrSpec;
global noiseSel;

%plot settings variables
global inapp;
global dnapp;
global sndrmat;
global enobmat;
global amp
amp=(1:1:15)/15;
global indice;
global indiceB;
global colm;
global colmB;
global sndrv;
global levelsmat;
%pmeters
global pmeters

%technologic vars
global kc;
global cspec;
global misos;

%LOAD STATE
[lstate,lpath,check]=uigetfile('CSAtool/work/stat/*.mat');
if check == 1
ls=load(lstate);
else
    return
end
%SET VARIABLES
%general
Nbit=ls.Nbit;
Vdd=ls.Vdd;
Vss=ls.Vss;
Cpar11=ls.Cpar11;
Cpar12=ls.Cpar12;
Cpar21=ls.Cpar21;
Cpar22=ls.Cpar22;
cunit=ls.cunit;
cbridge=ls.cbridge;
STP=ls.STP;
SBP=ls.SBP;
STBP=ls.STBP;
sel=ls.sel;

%PPEXtool
PEXM=ls.PEXM;
SPEX=ls.SPEX;
PEXB=ls.PEXB;

%technologic 
kc=ls.kc;
cspec=ls.cspec;
misos=ls.misos;

%model features selection
upar=ls.upar;
usc=ls.usc;
usndr=ls.usndr;
umis=ls.umis;
usndrSpec=ls.usndrSpec;
noiseSel=ls.noiseSel;

%CHECK IF THERE IS STILL SOMETHING TO DO WITH SNDRSPEC
if usndr==1
sndrv=ls.sndrv;
end

%plot options
dnapp=ls.dnapp;
inapp=ls.inapp;
indice=ls.indice;
indiceB=ls.indiceB;
colm=ls.colm;
colmB=ls.colmB;
pmeters=ls.pmeters;
sndrmat=ls.sndrmat;
enobmat=ls.enobmat;
levelsmat=ls.levelsmat;
%PRESET/DISPLAY VARIABLES

%Boxes aspect

boxset(hObject,eventdata,handles)

%general
set(handles.Nbit,'String',num2str(Nbit));
set(handles.Vdd,'String',num2str(Vdd));
set(handles.Vss,'String',num2str(Vss));
set(handles.cp11,'String',num2str(Cpar11));
set(handles.cp12,'String',num2str(Cpar12));
set(handles.cp21,'String',num2str(Cpar21));
set(handles.cp22,'String',num2str(Cpar22));
set(handles.cunit,'String',num2str(cunit));
set(handles.cbridge,'String',num2str(cbridge));
set(handles.STP,'String',num2str(STP));
set(handles.SBP,'String',num2str(SBP));
set(handles.STBP,'String',num2str(STBP));
set(handles.listbox1,'Value',sel);

%technologic 
set(handles.kc,'String',num2str(kc));
set(handles.cspec,'String',num2str(cspec));
set(handles.mos,'String',num2str(misos));

%model features selection
set(handles.usepar,'Value',upar);
set(handles.usesc,'Value',usc);
set(handles.usemis,'Value',umis);
set(handles.evalsndr,'Value',usndr);
set(handles.evalsndrSpec,'Value',usndrSpec);
%plot options
axes(handles.DNLbox);
hold off
for i=1:indice
stem(dnapp(i,:),'LineWidth',1,'color',colm(i,:));
hold on;
end
grid on;
axis([0 length(dnapp(1,:)) (-0.1+min(min(dnapp))) (0.1+max(max(dnapp)))])
title('Coarse DNL','FontSize',8,'FontWeight','bold');
xlabel('Output Level','FontSize',8,'FontWeight','bold')
set(handles.DNLbox,'LineWidth',2);

axes(handles.INLbox);
hold off
for i=1:indice
plot(inapp(i,:),'LineWidth',1,'color',colm(i,:));
hold on;
end
grid on;
axis([0 length(inapp(1,:)) (-0.1+min(min(inapp))) (0.1+max(max(inapp)))])
title('Coarse INL','FontSize',8,'FontWeight','bold');
xlabel('Output Level','FontSize',8,'FontWeight','bold')
set(handles.INLbox,'LineWidth',2);

axes(handles.sndrplot)
set(handles.sndrplot,'LineWidth',2);
hold off
for i=1:indiceB
if sndrmat(i,:) ~= zeros(1,length(sndrmat(i,:)))
    aux=sndrmat(i,:);
    plot(amp,aux,'LineWidth',1.5,'color',colmB(i,:));  
end
hold on;
end
grid on;
axis([0 max(100*amp) (min(sndrv)-0.15) (max(max(sndrmat))+3)]);
ylabel('SNDR [dB]','FontSize',8,'FontWeight','bold');
xlabel('Input Amplitude [%FSR]','FontSize',8,'FontWeight','bold');


%---------------------------------------------------------------------
% --------------------------------------------------------------------
function mnSave_Callback(hObject, eventdata, handles)

%SAVE STATE FUNCTION

%All variables to be saved
%General
global Nbit;
global Vdd;
global Vss;
global Cpar11;
global Cpar12;
global Cpar21;
global Cpar22;
global cunit;
global cbridge;
global STP;
global SBP;
global STBP;
global sel;
global misos;
%PPEXtool
global PEXM;
global PEXB;
global SPEX;

%technologic
global kc;
global cspec;
global misos;
%plotting options
global dnapp;
global inapp;

global sndrmat;
global enobmat;
global indice;
global indiceB;
global colmB;
global colm;
global sndrv;
global amp;
global levelsmat;

%model features selection
global upar;
global usc;
global usndr;
global usndrSpec;
global umis;
global noiseSel;

%pmeters
global pmeters

Vss=str2double(get(handles.Vss,'String'));
Vdd=str2double(get(handles.Vdd,'String'));
Cpar11=str2double(get(handles.cp11,'String'));
Cpar12=str2double(get(handles.cp12,'String'));
Cpar21=str2double(get(handles.cp21,'String'));
Cpar22=str2double(get(handles.cp22,'String'));
kc=str2double(get(handles.kc,'String'));
misos=str2double(get(handles.mos,'String'));
cspec=str2double(get(handles.cspec,'String'));
cunit=str2double(get(handles.cunit,'String'));
cbridge=str2double(get(handles.cbridge,'String'));
Nbit=str2double(get(handles.Nbit,'String'));
STP=str2double(get(handles.STP,'String'));
SBP=str2double(get(handles.SBP,'String'));
STBP=str2double(get(handles.STBP,'String'));
sel=get(handles.listbox1,'Value');
%save(['GUI/SARADCtool/work/' savefile '.mat'], 'Vss', 'Vdd', 'Cpar11', 'Cpar22', 'Cpar21','Cpar22','kc','cspec','cunit','cbridge','STP','SBP','STBP','PEXM','PEXB','SPEX','Nbit');


[filename, pathname, check] = uiputfile('CSAtool/work/stat/*.mat','Save Workspace as');
if check == 1
save([pathname filename])
end


% --------------------------------------------------------------------
function mnExit_Callback(hObject, eventdata, handles)

close CSAtool

% --------------------------------------------------------------------
function mnESA_Callback(hObject, eventdata, handles)

global Nbit;
global Vdd;
global Vss;
global Cpar11;
global Cpar12;
global Cpar21;
global Cpar22;
global kc;
global misos;
global cspec;
global cunit;
global cbridge;
global ipex;
global PEXM;
global PEXB;
global sel;
global STP;
global SBP;
global STBP;
global SPEX;
global umis;
global usc;

if umis == 0
    kc_Error
    disp('ERROR: SSA tool cannot be used without defining non-zero mismatch parameters')
    disp('...')
    return
else


Nbit=str2double(get(handles.Nbit,'String'));
Vdd=str2double(get(handles.Vdd,'String'));
Vss=str2double(get(handles.Vss,'String'));
sel=get(handles.listbox1,'Value');
Cpar11=str2double(get(handles.cp11,'String'));
Cpar12=str2double(get(handles.cp12,'String'));
Cpar21=str2double(get(handles.cp21,'String'));
Cpar22=str2double(get(handles.cp22,'String'));
kc=umis*str2double(get(handles.kc,'String'));
cspec=umis*str2double(get(handles.cspec,'String'));
misos=umis*str2double(get(handles.mos,'String'));
cunit=str2double(get(handles.cunit,'String'));
cbridge=str2double(get(handles.cbridge,'String'));
STP=usc*str2double(get(handles.STP,'String'));
SBP=usc*str2double(get(handles.SBP,'String'));
STBP=usc*str2double(get(handles.STBP,'String'));

ESA
end




function enobmax_Callback(hObject, eventdata, handles)

function enobmax_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sndrmax_Callback(hObject, eventdata, handles)
function sndrmax_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function usesc_Callback(hObject, eventdata, handles)
global usc;
usc = get(handles.usesc,'Value');


function usemis_Callback(hObject, eventdata, handles)
global umis;
umis = get(handles.usemis,'Value');


function usepar_Callback(hObject, eventdata, handles)
global upar;
upar = get(handles.usepar,'Value');


function evalsndr_Callback(hObject, eventdata, handles)
global usndr;
usndr = get(handles.evalsndr,'Value');


% -------------------------------------------------------------------%
function mnSaveRes_Callback(hObject, eventdata, handles)

%SAVE STATE AND RESULTS FUNCTION

global DNL;
global INL;
global sndrv;

global Nbit;
global Vdd;
global Vss;
global Cpar11;
global Cpar12;
global Cpar21;
global Cpar22;
global cunit;
global cbridge;

global kc;
global cspec;
global misos;
global STP;
global SBP;
global STBP;
global PEXM;
global PEXB;
global sel;
global SPEX;


global dnapp;
global inapp;
global sndrmat;
global enobmat;
global indice;
global colm;
global indiceB;
global colmB;
[filename, pathname, check] = uiputfile('*.mat');

if check == 1
save([pathname filename],'DNL','INL','sndrmat','enobmat','Nbit','Vdd','Vss','Cpar11','Cpar12','Cpar21','Cpar22','kc','misos','cspec','cunit','cbridge','STP','STBP','SBP','PEXM','SPEX')
end


function viewA_Callback(hObject, eventdata, handles)

global sel
iview



function fsam_Callback(hObject, eventdata, handles)
function fsam_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function econs_Callback(hObject, eventdata, handles)
function econs_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function pcons_Callback(hObject, eventdata, handles)
function pcons_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function spcons_Callback(hObject, eventdata, handles)
function spcons_CreateFcn(hObject, eventdata, handles)
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function nwdnl_Callback(hObject, eventdata, handles)


global po;
global dnapp;
global inapp;
global sndrmat;
global enobmat;
global indice;
global colm;
global indiceB;
global colmB;


figure(1)
for i=1:indice
stem(dnapp(i,:),'LineWidth',1,'color',colm(i,:));
hold on;
end
axis([0 length(dnapp(1,:)) (-0.1+min(min(dnapp))) (0.1+max(max(dnapp)))])
title('Coarse DNL','FontSize',12,'FontWeight','Bold')
xlabel('Output Level');
ylabel('LSB','FontSize',8,'FontWeight','bold');
grid on;
hold off;





function nwinl_Callback(hObject, eventdata, handles)

global po;
global dnapp;
global inapp;
global sndrmat;
global enobmat;
global indice;
global colm;
global indiceB;
global colmB;



figure(2)

for i=1:indice
plot(inapp(i,:),'LineWidth',1,'color',colm(i,:));
hold on;
end
axis([0 length(inapp(1,:)) (-0.1+min(min(inapp))) (0.1+max(max(inapp)))])
title('Coarse INL','FontSize',12,'FontWeight','Bold')
xlabel('Output Level');
ylabel('LSB','FontSize',8,'FontWeight','bold');
grid on;
hold off;

function nwsndr_Callback(hObject, eventdata, handles)

global sndrmat;
global enobmat;
global indiceB;
global colmB;


global usndr;
if usndr == 0
    return;
end

figure(3)
global amp;
global sndrv;

for i=1:indiceB
if sndrmat(i,:) ~= zeros(1,length(sndrmat(i,:)))
    aux=sndrmat(i,:);
    plot(100*amp,aux,'LineWidth',1.5,'color',colmB(i,:),'marker','o');  
end
hold on;
end
grid on;
axis([0 max(100*amp) (min(sndrv)-0.5) (max(max(sndrmat))+3)]);
ylabel('SNDR [dB]','FontSize',8,'FontWeight','bold');
xlabel('Input Amplitude [%FSR]','FontSize',8,'FontWeight','bold');





% --- Executes on button press in scpinfo.
function scpinfo_Callback(hObject, eventdata, handles)
% hObject    handle to scpinfo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
scpview


function boxset(hObject,eventdata,handles)

global sel
if (sel == 1)
    set(handles.text1,'String','Classic Binary Weighted (CBW) - SE');
    set(handles.cp22,'BackgroundColor','black'); 
    set(handles.cp12,'BackgroundColor','black'); 
    set(handles.cp21,'BackgroundColor','black'); 
    set(handles.cp11,'BackgroundColor','white'); 
    set(handles.cbridge,'BackgroundColor','black'); 
elseif (sel == 2)
    set(handles.text1,'String','Split Binary Weighted (SBW) - SE');
    set(handles.cbridge,'BackgroundColor','black'); 
    set(handles.cp22,'BackgroundColor','black'); 
    set(handles.cp12,'BackgroundColor','black'); 
    set(handles.cp21,'BackgroundColor','black'); 
    set(handles.cp11,'BackgroundColor','white'); 
elseif (sel == 3)  
    set(handles.text1,'String','Bridge (BWA) - SE');
    set(handles.cp22,'BackgroundColor','black'); 
    set(handles.cp21,'BackgroundColor','black'); 
    set(handles.cp12,'BackgroundColor','white'); 
    set(handles.cp11,'BackgroundColor','white'); 
    set(handles.cbridge,'BackgroundColor','white'); 
elseif (sel == 4)   
    set(handles.text1,'String','Classic Binary Weighted (CBW) - FD');
    set(handles.cp21,'BackgroundColor','white');   
    set(handles.cp22,'BackgroundColor','black'); 
    set(handles.cp12,'BackgroundColor','black'); 
    set(handles.cp11,'BackgroundColor','white'); 
    set(handles.cbridge,'BackgroundColor','black'); 
elseif (sel == 5) 
    set(handles.text1,'String','Split Binary Weighted (SBW) - FD'); 
    set(handles.cp21,'BackgroundColor','white');   
    set(handles.cp22,'BackgroundColor','black'); 
    set(handles.cp12,'BackgroundColor','black'); 
    set(handles.cp11,'BackgroundColor','white');
    set(handles.cbridge,'BackgroundColor','black'); 
elseif (sel == 6)
    set(handles.text1,'String','Bridge (BWA) - FD');
    set(handles.cbridge,'BackgroundColor','white'); 
    set(handles.cp22,'BackgroundColor','white'); 
    set(handles.cp12,'BackgroundColor','white'); 
    set(handles.cp11,'BackgroundColor','white');
    set(handles.cp21,'BackgroundColor','white');
    elseif (sel == 7)
    set(handles.text1,'String','Monotonic BW (MBW) - FD');
    set(handles.cbridge,'BackgroundColor','black'); 
    set(handles.cp22,'BackgroundColor','black'); 
    set(handles.cp12,'BackgroundColor','black'); 
    set(handles.cp11,'BackgroundColor','white');
    set(handles.cp21,'BackgroundColor','white');
    set(handles.cbridge,'BackgroundColor','black'); 
    elseif (sel == 8)
    set(handles.text1,'String','Monotonic BWA (MBWA) - FD');
    set(handles.cp22,'BackgroundColor','white'); 
    set(handles.cp12,'BackgroundColor','white'); 
    set(handles.cp11,'BackgroundColor','white');
    set(handles.cp21,'BackgroundColor','white');
    set(handles.cbridge,'BackgroundColor','white'); 
    elseif (sel == 9)
    set(handles.text1,'String','Error -No Model');
    set(handles.cbridge,'BackgroundColor','black'); 
    set(handles.cp22,'BackgroundColor','black'); 
    set(handles.cp12,'BackgroundColor','black'); 
    set(handles.cp11,'BackgroundColor','black');
    set(handles.cp21,'BackgroundColor','black');
    set(handles.cbridge,'BackgroundColor','black'); 
    elseif (sel == 10)
    set(handles.text1,'String',' Error -No Model');
    set(handles.cp22,'BackgroundColor','black'); 
    set(handles.cp12,'BackgroundColor','black'); 
    set(handles.cp11,'BackgroundColor','black');
    set(handles.cp21,'BackgroundColor','black');
    set(handles.cbridge,'BackgroundColor','black'); 
end


% --- Executes on button press in resume.
function resume_Callback(hObject, eventdata, handles)

global pmeters;
global indice;
global dnapp;
global inapp;
global sndrmat;
global enobmat;
global indiceB;
global colm;
global colmB;


summary


% --- Executes on button press in pushbutton13.
function pushbutton13_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
iview


% --- Executes on button press in eawin.
function eawin_Callback(hObject, eventdata, handles)






global Nbit;
global sel;
global Nbit;
global Cpar11;
global Cpar12;
global Cpar21;
global Cpar22;
global cbridge;
global cunit;
global cspec;
global Vdd;
global Vss;
global PEXM;
global SPEX;
global ipex;
%global PEXB;



%Design parameters from PPEXtool
%initialization
PEX11=zeros(1,Nbit/2);    
PEX12=zeros(1,Nbit/2);  
PEX21=zeros(1,Nbit/2);  
PEX22=zeros(1,Nbit/2);  
PEXB=zeros (1,Nbit/2);  

%only if PPEX tool is used;
if ipex==1
        m=Nbit/2;
        PEX11=PEXM(1,1:m);
        PEX12=PEXM(2,1:m);
        PEX21=PEXM(3,1:m);
        PEX22=PEXM(4,1:m);
        PEXB=PEXM(5,1:2);
else
        SPEX=zeros(2,13);
end

global STP;
global SBP;
global STBP;



Nbit=str2double(get(handles.Nbit,'String'));

NormEN=zeros(1,2^Nbit);
NormEN_P=zeros(1,2^Nbit);
NormEN_N=zeros(1,2^Nbit);
err=1;

switch sel
    case 1
        [NormEN,codici]=EA_CBW_se_par(Nbit,Vdd,Vss,cunit,0,0,cspec,cbridge,Cpar11,Cpar12,Cpar21,Cpar22,STP,SBP,STBP,PEX11,PEX12,PEX21,PEX22,PEXB);
        
        NormEN_P=zeros(1,length(NormEN));
        NormEN_N=zeros(1,length(NormEN));
        
        err=0;
    case 2
        [NormEN,codici]=EA_SBW_se(Nbit,Vdd,Vss,cunit,cbridge,cspec);
        NormEN_P=zeros(1,length(NormEN));
        NormEN_N=zeros(1,length(NormEN));
        err=0;
    case 3
        [NormEN,codici]=EA_BWA_se_par(Nbit,Vdd,Vss,cunit,0,0,cspec,cbridge,Cpar11,Cpar12,Cpar21,Cpar22,STP,SBP,STBP,PEX11,PEX12,PEX21,PEX22,PEXB);
        NormEN_P=zeros(1,length(NormEN));
        NormEN_N=zeros(1,length(NormEN));
        err=0;
    case 4
        [NormEN,codici]=EA_CBW_par(Nbit,Vdd,Vss,cunit,0,0,cspec,cbridge,Cpar11,Cpar12,Cpar21,Cpar22,STP,SBP,STBP,PEX11,PEX12,PEX21,PEX22,PEXB);
        NormEN_P=zeros(1,length(NormEN));
        NormEN_N=zeros(1,length(NormEN));
        err=0;
    case 5
        [NormEN,codici]=EA_SBW(Nbit,Vdd,Vss,cunit,cbridge,cspec);
        NormEN_P=zeros(1,length(NormEN));
        NormEN_N=zeros(1,length(NormEN));
        err=0;
    case 6
        [NormEN,codici,NormEN_P,NormEN_N]=EA_BWA_par(Nbit,Vdd,Vss,cunit,0,0,cspec,cbridge,Cpar11,Cpar12,Cpar21,Cpar22,STP,SBP,STBP,PEX11,PEX12,PEX21,PEX22,PEXB);
        err=0;
    case 7
        [NormEN,codici]=EA_MCBW(Nbit,Vdd,Vss,cunit,cbridge,cspec);
        NormEN_P=zeros(1,length(NormEN));
        NormEN_N=zeros(1,length(NormEN));
        err=0;
    case 8
        [NormEN,codici]=EA_MBWA(Nbit,Vdd,Vss,cunit,cbridge,cspec);
        NormEN_P=zeros(1,length(NormEN));
        NormEN_N=zeros(1,length(NormEN));
        err=0;
    case 9
        disp('ERROR: No topology is selected');
        err=1;
        return
    case 10
        disp('ERROR: No topology is selected');
        err=1;
        return
end



if err~=1
disp('Displaying energy characteristic...');
figure(10)
plot(codici(1:end-1),NormEN,'r','LineWidth',1.5)
hold on;
plot(codici(1:end-1),NormEN_P,'b','LineWidth',1.5)
plot(codici(1:end-1),NormEN_N,'g','LineWidth',1.5)
grid on;
title('Energy consumption vs Code - Norm. to Cunit*Vref^2 - Current Topology','FontSize',8,'FontWeight','bold');
axis([0 length(codici) 0.95*min(NormEN) 1.05*max(NormEN)]);
xlabel('Output code - Level','FontSize',8,'FontWeight','bold');
ylabel('Energy [CVref^2]','FontSize',8,'FontWeight','bold');
grid on
annotation('textbox',...
    [0.15 0.15 0.25 0.15],...
    'String',cat(2,'AVG = ',num2str(mean(NormEN)) )),...
    'FontSize';12;... 
    'FontName';'Arial';...
    'LineStyle';'-';...
    'EdgeColor';[1 1 1];...
    'LineWidth';2;...
    'BackgroundColor';[0.6  0.6 0.6];...
    'Color';[0.84 0.16 0];
end





% --- Executes on button press in ionw.
function ionw_Callback(hObject, eventdata, handles)

global levelsmat
global indice
global colm



 figure(8)
 hold off
 
 for i=1:indice
 stairs(levelsmat(i,:),0:1:length(levelsmat(i,:))-1,'LineWidth',1.5,'color',colm(i,:));
 hold on
 end
 grid on;
 
 axis([min(min(levelsmat))-0.01 max(max(levelsmat))+0.01 0  length(levelsmat(1,:)) ])
 title('ADC Conversion Charachteristic','Fontsize',10,'FontWeight','bold')
 ylabel('Output Level','Fontsize',8,'Fontweight','bold');
 xlabel('Input Voltage [V]','Fontsize',8,'Fontweight','bold');



function mos_Callback(hObject, eventdata, handles)
% hObject    handle to mos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of mos as text
%        str2double(get(hObject,'String')) returns contents of mos as a double


% --- Executes during object creation, after setting all properties.
function mos_CreateFcn(hObject, eventdata, handles)
% hObject    handle to mos (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in infomis.
function infomis_Callback(hObject, eventdata, handles)

misview
% hObject    handle to infomis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function mnSweep_Callback(hObject, eventdata, handles)
% hObject    handle to mnSweep (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
SWE



function dain_Callback(hObject, eventdata, handles)
% hObject    handle to dain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dain as text
%        str2double(get(hObject,'String')) returns contents of dain as a double


% --- Executes during object creation, after setting all properties.
function dain_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dain (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in evalsndrSpec.
function evalsndrSpec_Callback(hObject, eventdata, handles)

global usndrSpec;
usndr = get(handles.evalsndrSpec,'Value');


function SAin_Callback(hObject, eventdata, handles)
global SAinput
SAinput=get(handles.SAin,'Value');

% --- Executes during object creation, after setting all properties.
function SAin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SAin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function enobAin_Callback(hObject, eventdata, handles)
% hObject    handle to enobAin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of enobAin as text
%        str2double(get(hObject,'String')) returns contents of enobAin as a double


% --- Executes during object creation, after setting all properties.
function enobAin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to enobAin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes during object creation, after setting all properties.
function DNLbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to DNLbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate DNLbox


% --- Executes during object creation, after setting all properties.
function text1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on button press in chnoise.
function chnoise_Callback(hObject, eventdata, handles)
% hObject    handle to chnoise (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global noiseSel;
noiseSel = get(handles.chnoise,'Value');
% Hint: get(hObject,'Value') returns toggle state of chnoise



function noisein_Callback(hObject, eventdata, handles)
% hObject    handle to noisein (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of noisein as text
%        str2double(get(hObject,'String')) returns contents of noisein as a double
global nin;
nin = get(handles.noisein,'Value');

% --- Executes during object creation, after setting all properties.
function noisein_CreateFcn(hObject, eventdata, handles)
% hObject    handle to noisein (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
