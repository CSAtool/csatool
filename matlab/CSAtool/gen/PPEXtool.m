function varargout = PPEXtool(varargin)
% PPEXtool M-file for PPEXtool.fig
%      PPEXtool, by itself, creates a new PPEXtool or raises the existing
%      singleton*.
%
%      H = PPEXtool returns the handle to a new PPEXtool or the handle to
%      the existing singleton*.
%
%      PPEXtool('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PPEXtool.M with the given input arguments.
%
%      PPEXtool('Property','Value',...) creates a new PPEXtool or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PPEXtool_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PPEXtool_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's monotonicbridges menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PPEXtool

% Last Modified by GUIDE v2.5 02-May-2014 18:01:17

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PPEXtool_OpeningFcn, ...
                   'gui_OutputFcn',  @PPEXtool_OutputFcn, ...
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


%---------------PPEX monotonicbridge Opening Function-------------------------------%
% ------ Executes just before PPEXtool is made visible--------%
function PPEXtool_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;
guidata(hObject, handles);
global Nbit
global sel;
global PEXM;
global SPEX;

parschema = imread( 'istruzpar.png' );
imshow(parschema,'Parent',handles.istruzpar);
impex = imread( 'comparat.png' );
imshow(impex,'Parent',handles.axes2);

disp('%-------------------PPEXtool-------------------------%')
c=clock;
disp(cat(2, date, ' || Time:    ', num2str(c(4)), ':' , num2str(c(5)) , ':',num2str(c(6))))
disp('Loading last PPEXset...');
startpex=load('/CSAtool/work/ppexset/last/lastpex.mat');
xsel=startpex.sel;
xNbit=startpex.Nbit;


PEXM=startpex.PEXM;
SPEX=startpex.SPEX;

if (xsel==8)&&(sel==6) || (xsel==6)&&(sel==8)
    %Solo se ho cambiato da BWA a MBWA, che hanno uguale array.
    if (xNbit ~= Nbit)
    disp('WARNING: Last saved array configuration differs in bit number from the current one...')
    disp('The current topology is kept as active configuration and');
    disp('all parasitic values are set to zero.');
    clear xsel;
    clear xNbit;
    PEXM=zeros(5,Nbit/2);
    SPEX=zeros(2,13);
    else
    disp('PPEX set loaded.');
    end
    
else

if (xsel~=sel || xNbit ~= Nbit)
    disp('WARNING: Last saved array configuration differs from the current one...')
    disp('The current topology is kept as active configuration and');
    disp('all parasitic values are set to zero.');
    clear xsel;
    clear xNbit;
    PEXM=zeros(5,Nbit/2);
    SPEX=zeros(2,13);
else
    disp('PPEX set loaded.');
end

end


displayset(hObject, eventdata, handles)
disppexm(hObject, eventdata, handles)




function varargout = PPEXtool_OutputFcn(hObject, eventdata, handles) 

varargout{1} = handles.output;


%------------------------------------------------------------------------%

function MSB1bit1_Callback(hObject, eventdata, handles)

function MSB1bit1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%---------------------------------------------------------------%

function MSB1bit2_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function MSB1bit2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%----------------------------------------------------------------%

function MSB1bit3_Callback(~, eventdata, handles)



function MSB1bit3_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%------------------------------------------------------------%

function MSB1bit4_Callback(hObject, eventdata, handles)



function MSB1bit4_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%----------------------------------------------------------%

function MSB1bit5_Callback(hObject, eventdata, handles)




function MSB1bit5_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%------------------------------------------------------------%

function MSB1bit6_Callback(hObject, eventdata, handles)

function MSB1bit6_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%-------------------------------------------------------------%

function MSB1bit7_Callback(hObject, eventdata, handles)


function MSB1bit7_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%---------------------------------------------------%

function LSB1bit1_Callback(hObject, eventdata, handles)


function LSB1bit1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


%-------------------------------------------------------------------%

function LSB1bit2_Callback(hObject, eventdata, handles)

function LSB1bit2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%---------------------------------------------------------------------%

function LSB1bit3_Callback(hObject, eventdata, handles)


function LSB1bit3_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%--------------------------------------------------------%


function LSB1bit4_Callback(hObject, eventdata, handles)


function LSB1bit4_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%-------------------------------------------------%



function LSB1bit5_Callback(hObject, eventdata, handles)


function LSB1bit5_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



%---------------------------------------------------%


function LSB1bit6_Callback(hObject, eventdata, handles)


function LSB1bit6_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end




%--------------------------------------------------%


function LSB1bit7_Callback(hObject, eventdata, handles)

    


function LSB1bit7_CreateFcn(hObject, eventdata, handles)

 if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
 end
 
 

%----------------------------------------------------%


function MSB2bit1_Callback(hObject, eventdata, handles)

function MSB2bit1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MSB2bit2_Callback(hObject, eventdata, handles)

function MSB2bit2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MSB2bit3_Callback(hObject, eventdata, handles)

function MSB2bit3_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MSB2bit4_Callback(hObject, eventdata, handles)

function MSB2bit4_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MSB2bit5_Callback(hObject, eventdata, handles)

function MSB2bit5_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MSB2bit6_Callback(hObject, eventdata, handles)

function MSB2bit6_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MSB2bit7_Callback(hObject, eventdata, handles)

function MSB2bit7_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function LSB2bit1_Callback(hObject, eventdata, handles)

function LSB2bit1_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%-------------------------------------------------------------%

function LSB2bit2_Callback(hObject, eventdata, handles)

function LSB2bit2_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%-------------------------------------------------------------%

function LSB2bit3_Callback(hObject, eventdata, handles)

function LSB2bit3_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%-------------------------------------------------------------%

function LSB2bit4_Callback(hObject, eventdata, handles)


% --- Executes during object creation, after setting all properties.
function LSB2bit4_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%-------------------------------------------------------------%

function LSB2bit5_Callback(hObject, eventdata, handles)




function LSB2bit5_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%-------------------------------------------------------------%

function LSB2bit6_Callback(hObject, eventdata, handles)

% --- Executes during object creation, after setting all properties.
function LSB2bit6_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%-------------------------------------------------------------%

function LSB2bit7_Callback(hObject, eventdata, handles)

function LSB2bit7_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
%-------------------------------------------------------------%







function pbp_Callback(hObject, eventdata, handles)



function pbp_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function nbp_Callback(hObject, eventdata, handles)



% --- Executes during object creation, after setting all properties.
function nbp_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end











%--------------------------------APPLY------------------------------------%

% --- Executes on button press in apply.
function apply_Callback(hObject, eventdata, handles)


global Nbit;
global ipex;
global PEXM;
global sel;
global SPEX;
ipex=1;

pex_p_msb1=str2double(get(handles.MSB1bit1,'String'));
pex_p_msb2=str2double(get(handles.MSB1bit2,'String'));
pex_p_msb3=str2double(get(handles.MSB1bit3,'String'));


pex_p_lsb1=str2double(get(handles.LSB1bit1,'String'));
pex_p_lsb2=str2double(get(handles.LSB1bit2,'String'));
pex_p_lsb3=str2double(get(handles.LSB1bit3,'String'));


pex_n_msb1=str2double(get(handles.MSB2bit1,'String'));
pex_n_msb2=str2double(get(handles.MSB2bit2,'String'));
pex_n_msb3=str2double(get(handles.MSB2bit3,'String'));


pex_n_lsb1=str2double(get(handles.LSB2bit1,'String'));
pex_n_lsb2=str2double(get(handles.LSB2bit2,'String'));
pex_n_lsb3=str2double(get(handles.LSB2bit3,'String'));
  
PEX11=[pex_p_msb3  pex_p_msb2 pex_p_msb1];
PEX12=[pex_p_lsb3  pex_p_lsb2 pex_p_lsb1];
PEX21=[pex_n_msb3  pex_n_msb2 pex_n_msb1];
PEX22=[pex_n_lsb3  pex_n_lsb2 pex_n_lsb1];

if Nbit>=8
    pex_p_msb4=str2double(get(handles.MSB1bit4,'String'));
    pex_p_lsb4=str2double(get(handles.LSB1bit4,'String'));
    pex_n_msb4=str2double(get(handles.MSB2bit4,'String'));
    pex_n_lsb4=str2double(get(handles.LSB2bit4,'String'));
   PEX11=[pex_p_msb4 pex_p_msb3  pex_p_msb2 pex_p_msb1];
   PEX12=[pex_p_lsb4 pex_p_lsb3  pex_p_lsb2 pex_p_lsb1];
   PEX21=[pex_n_msb4 pex_n_msb3  pex_n_msb2 pex_n_msb1];
   PEX22=[pex_n_lsb4 pex_n_lsb3  pex_n_lsb2 pex_n_lsb1];
    if Nbit>=10
        pex_p_msb5=str2double(get(handles.MSB1bit5,'String'));
        pex_p_lsb5=str2double(get(handles.LSB1bit5,'String'));
        pex_n_msb5=str2double(get(handles.MSB2bit5,'String'));
        pex_n_lsb5=str2double(get(handles.LSB2bit5,'String'));
        PEX11=[pex_p_msb5 pex_p_msb4 pex_p_msb3  pex_p_msb2 pex_p_msb1];
        PEX12=[pex_p_lsb5 pex_p_lsb4 pex_p_lsb3  pex_p_lsb2 pex_p_lsb1];
        PEX21=[pex_n_msb5 pex_n_msb4 pex_n_msb3  pex_n_msb2 pex_n_msb1];
        PEX22=[pex_n_lsb5 pex_n_lsb4 pex_n_lsb3  pex_n_lsb2 pex_n_lsb1];
    if Nbit>=12
         pex_p_msb6= str2double(get(handles.MSB1bit6,'String'));
         pex_p_lsb6= str2double(get(handles.LSB1bit6,'String'));
         pex_n_msb6= str2double(get(handles.MSB2bit6,'String'));
         pex_n_lsb6= str2double(get(handles.LSB2bit6,'String'));
         PEX11=[pex_p_msb6 pex_p_msb5 pex_p_msb4 pex_p_msb3  pex_p_msb2 pex_p_msb1];
         PEX12=[pex_p_lsb6 pex_p_lsb5 pex_p_lsb4 pex_p_lsb3  pex_p_lsb2 pex_p_lsb1];
         PEX21=[pex_n_msb6 pex_n_msb5 pex_n_msb4 pex_n_msb3  pex_n_msb2 pex_n_msb1];
         PEX22=[pex_n_lsb6 pex_n_lsb5 pex_n_lsb4 pex_n_lsb3  pex_n_lsb2 pex_n_lsb1];
         
         if Nbit>=14
         pex_p_msb7= str2double(get(handles.MSB1bit7,'String'));
         pex_p_lsb7= str2double(get(handles.LSB1bit7,'String'));
         pex_n_msb7= str2double(get(handles.MSB2bit7,'String'));
         pex_n_lsb7= str2double(get(handles.LSB2bit7,'String'));
         PEX11=[pex_p_msb7 pex_p_msb6 pex_p_msb5 pex_p_msb4 pex_p_msb3  pex_p_msb2 pex_p_msb1];
         PEX12=[pex_p_lsb7 pex_p_lsb6 pex_p_lsb5 pex_p_lsb4 pex_p_lsb3  pex_p_lsb2 pex_p_lsb1];
         PEX21=[pex_n_msb7 pex_n_msb6 pex_n_msb5 pex_n_msb4 pex_n_msb3  pex_n_msb2 pex_n_msb1];
         PEX22=[pex_n_lsb7 pex_n_lsb6 pex_n_lsb5 pex_n_lsb4 pex_n_lsb3  pex_n_lsb2 pex_n_lsb1];
         
         end
    end
end
end

pexbp=str2double(get(handles.pbp,'String'));
pexbn=str2double(get(handles.nbp,'String'));


%Creating matrix of parasitics
m=Nbit/2;

PEXM=zeros(5,Nbit/2);
PEXM(1,1:m)= PEX11;
PEXM(2,1:m)= PEX12;
PEXM(3,1:m)= PEX21;
PEXM(4,1:m)= PEX22;
PEXM(5,1:2)=[pexbp pexbn];

disp('Saving last PPEX set...');
nomefile= 'lastpex';
savefile=nomefile;
save(['CSAtool/work/ppexset/last/' savefile '.mat'],'PEXM','sel','SPEX','Nbit');
disp('Post layout Parasitics are applied')


close PPEXtool


%------------------------------------------------------------------------%




%---------SYNC------(per il momento non c'è)------------------------------%

function Sync_Callback(hObject, eventdata, handles)

global PEXM;
global SPEX;
global ipex;
global Nbit;
global sel;
global ispex;
disp('Syncronizing PPEXtool with current topology...')
disp(cat(2,'current selection no. : ', num2str(sel)))
ipex=0;
ppexreset_Callback(hObject, eventdata, handles)
displayset(hObject, eventdata, handles)
if PPEXsplit~=0
close PPEXsplit;
ispex=0;
end
if (sel==2 || sel == 5)
    PPEXsplit
end

%------------------------------------------------------------------------%
%------------------------------------------------------------------------%

%--------------------------------RESET-----------------------------------%

function ppexreset_Callback(hObject, eventdata, handles)

global Nbit
global ipex;
global PEXM;
global SPEX;
global sel;

ipex=0;

set(handles.MSB1bit1,'String','0');
set(handles.MSB1bit2,'String','0');
set(handles.MSB1bit3,'String','0');
set(handles.MSB1bit4,'String','0');
set(handles.MSB1bit5,'String','0');
set(handles.MSB1bit6,'String','0');
set(handles.MSB1bit7,'String','0');

set(handles.MSB2bit1,'String','0');
set(handles.MSB2bit2,'String','0');
set(handles.MSB2bit3,'String','0');
set(handles.MSB2bit4,'String','0');
set(handles.MSB2bit5,'String','0');
set(handles.MSB2bit6,'String','0');
set(handles.MSB2bit7,'String','0');

set(handles.LSB1bit1,'String','0');
set(handles.LSB1bit2,'String','0');
set(handles.LSB1bit3,'String','0');
set(handles.LSB1bit4,'String','0');
set(handles.LSB1bit5,'String','0');
set(handles.LSB1bit6,'String','0');
set(handles.LSB1bit7,'String','0');

set(handles.LSB2bit1,'String','0');
set(handles.LSB2bit2,'String','0');
set(handles.LSB2bit3,'String','0');
set(handles.LSB2bit4,'String','0');
set(handles.LSB2bit5,'String','0');
set(handles.LSB2bit6,'String','0');
set(handles.LSB2bit7,'String','0');

PEXM=zeros(5,Nbit/2);

set(handles.pbp,'String','0');
set(handles.nbp,'String','0');

%-------------------------------------------------------------------------%


%---------------------------------ABORT----------------------------------%

% --- Executes on button press in abort.
function abort_Callback(hObject, eventdata, handles)

disp('WARNING: PPEX tool closed by user without applying parasitics')
close PPEXtool

%------------------------------LOAD SET----------------------------------%

% --- Executes on button press in loadpex.
function loadpex_Callback(hObject, eventdata, handles)

global Nbit;
global PEXM;
global sel;
global SPEX;


disp('Loading parasitic pex...')
[pexset,pexpath,check]=uigetfile('CSAtool/work/ppexset/*.mat');
if check==1
pxs=load(pexset);
disp('PPEX loaded...')
else
    return;
end

PEXM=pxs.PEXM;
SPEX=pxs.SPEX;
xsel=pxs.sel;
xNbit=pxs.Nbit;

if (xsel~=sel || xNbit ~= Nbit)
    disp('WARNING: Last saved array configuration differs from the current one...')
    disp('The current topology is kept as active configuration and');
    disp('all parasitic values are set to zero.');
    clear xsel;
    clear xNbit;
    PEXM=zeros(5,Nbit/2);
    SPEX=zeros(2,13);
else
    disp('PPEX set loaded from file.');
end


%setto i valori;
PEX11 = PEXM(1,:);
PEX12 = PEXM(2,:);
PEX21 = PEXM(3,:);
PEX22 = PEXM(4,:);
PEXB  = PEXM(5,1:2);

% %display loaded (or not) values in boxes
displayset(hObject, eventdata, handles)
disppexm(hObject, eventdata, handles)
%------------------------------------------------------------------------%




%------------------------------SAVE PEX----------------------------------%

function savepex_Callback(hObject, eventdata, handles)


global PEXM;
global PEXB;
global sel;
global SPEX;
global Nbit;


pex_p_msb1=str2double(get(handles.MSB1bit1,'String'));
pex_p_msb2=str2double(get(handles.MSB1bit2,'String'));
pex_p_msb3=str2double(get(handles.MSB1bit3,'String'));


pex_p_lsb1=str2double(get(handles.LSB1bit1,'String'));
pex_p_lsb2=str2double(get(handles.LSB1bit2,'String'));
pex_p_lsb3=str2double(get(handles.LSB1bit3,'String'));


pex_n_msb1=str2double(get(handles.MSB2bit1,'String'));
pex_n_msb2=str2double(get(handles.MSB2bit2,'String'));
pex_n_msb3=str2double(get(handles.MSB2bit3,'String'));


pex_n_lsb1=str2double(get(handles.LSB2bit1,'String'));
pex_n_lsb2=str2double(get(handles.LSB2bit2,'String'));
pex_n_lsb3=str2double(get(handles.LSB2bit3,'String'));
  
PEX11=[pex_p_msb3  pex_p_msb2 pex_p_msb1];
PEX12=[pex_p_lsb3  pex_p_lsb2 pex_p_lsb1];
PEX21=[pex_n_msb3  pex_n_msb2 pex_n_msb1];
PEX22=[pex_n_lsb3  pex_n_lsb2 pex_n_lsb1];

if Nbit>=8
    pex_p_msb4=str2double(get(handles.MSB1bit4,'String'));
    pex_p_lsb4=str2double(get(handles.LSB1bit4,'String'));
    pex_n_msb4=str2double(get(handles.MSB2bit4,'String'));
    pex_n_lsb4=str2double(get(handles.LSB2bit4,'String'));
    PEX11=[pex_p_msb4 pex_p_msb3  pex_p_msb2 pex_p_msb1];
    PEX12=[pex_p_lsb4 pex_p_lsb3  pex_p_lsb2 pex_p_lsb1];
    PEX21=[pex_n_msb4 pex_n_msb3  pex_n_msb2 pex_n_msb1];
    PEX22=[pex_n_lsb4 pex_n_lsb3  pex_n_lsb2 pex_n_lsb1];
    if Nbit>=10
        pex_p_msb5=str2double(get(handles.MSB1bit5,'String'));
        pex_p_lsb5=str2double(get(handles.LSB1bit5,'String'));
        pex_n_msb5=str2double(get(handles.MSB2bit5,'String'));
        pex_n_lsb5=str2double(get(handles.LSB2bit5,'String'));
        PEX11=[pex_p_msb5 pex_p_msb4 pex_p_msb3  pex_p_msb2 pex_p_msb1];
        PEX12=[pex_p_lsb5 pex_p_lsb4 pex_p_lsb3  pex_p_lsb2 pex_p_lsb1];
        PEX21=[pex_n_msb5 pex_n_msb4 pex_n_msb3  pex_n_msb2 pex_n_msb1];
        PEX22=[pex_n_lsb5 pex_n_lsb4 pex_n_lsb3  pex_n_lsb2 pex_n_lsb1];
    if Nbit>=12
         pex_p_msb6= str2double(get(handles.MSB1bit6,'String'));
         pex_p_lsb6= str2double(get(handles.LSB1bit6,'String'));
         pex_n_msb6= str2double(get(handles.MSB2bit6,'String'));
         pex_n_lsb6= str2double(get(handles.LSB2bit6,'String'));
         PEX11=[pex_p_msb6 pex_p_msb5 pex_p_msb4 pex_p_msb3  pex_p_msb2 pex_p_msb1];
         PEX12=[pex_p_lsb6 pex_p_lsb5 pex_p_lsb4 pex_p_lsb3  pex_p_lsb2 pex_p_lsb1];
         PEX21=[pex_n_msb6 pex_n_msb5 pex_n_msb4 pex_n_msb3  pex_n_msb2 pex_n_msb1];
         PEX22=[pex_n_lsb6 pex_n_lsb5 pex_n_lsb4 pex_n_lsb3  pex_n_lsb2 pex_n_lsb1];
         
         if Nbit>=14
         pex_p_msb7= str2double(get(handles.MSB1bit7,'String'));
         pex_p_lsb7= str2double(get(handles.LSB1bit7,'String'));
         pex_n_msb7= str2double(get(handles.MSB2bit7,'String'));
         pex_n_lsb7= str2double(get(handles.LSB2bit7,'String'));
         PEX11=[pex_p_msb7 pex_p_msb6 pex_p_msb5 pex_p_msb4 pex_p_msb3  pex_p_msb2 pex_p_msb1];
         PEX12=[pex_p_lsb7 pex_p_lsb6 pex_p_lsb5 pex_p_lsb4 pex_p_lsb3  pex_p_lsb2 pex_p_lsb1];
         PEX21=[pex_n_msb7 pex_n_msb6 pex_n_msb5 pex_n_msb4 pex_n_msb3  pex_n_msb2 pex_n_msb1];
         PEX22=[pex_n_lsb7 pex_n_lsb6 pex_n_lsb5 pex_n_lsb4 pex_n_lsb3  pex_n_lsb2 pex_n_lsb1];
         
         end
    end
    end
end

pexbp=str2double(get(handles.pbp,'String'));
pexbn=str2double(get(handles.nbp,'String'));


%Creating matrix of parasitics
m=Nbit/2;

PEXM=zeros(5,Nbit/2)
PEXM(1,1:m)= PEX11;
PEXM(2,1:m)= PEX12;
PEXM(3,1:m)= PEX21;
PEXM(4,1:m)= PEX22;
PEXM(5,1:2)=[pexbp pexbn];

[filename, pathname, check] = uiputfile('CSAtool/work/ppexset/*.mat');
if check == 1    
    save([pathname filename],'PEXM','sel','SPEX','Nbit')
end


%---------------------PPEX display management----------------------------%

function displayset(hObject, eventdata, handles)

global sel;
global Nbit;
global PEXM;
global SPEX;


dispall(hObject,eventdata,handles)

switch sel
    case 1   %Classic Binary - SE
       
       nobridgeN(hObject,eventdata,handles)
       nobridgeP(hObject,eventdata,handles)
       noarrayN(hObject,eventdata,handles)
       dispASbit(hObject,eventdata,handles)
       setTextbinw(hObject,eventdata, handles)
       return;
       
    case 2   %Binary Split - SE
        
       nobridgeN(hObject,eventdata,handles)
       nobridgeP(hObject,eventdata,handles)
       noarrayN(hObject,eventdata,handles)
       dispASbit(hObject,eventdata,handles)
       setTextbinw(hObject,eventdata, handles)
       
       if Nbit==14
       set(handles.MSB1bit7,'Backgroundcolor','yellow')
       end
       if Nbit==12
       set(handles.MSB1bit6,'Backgroundcolor','yellow') 
       end
       if Nbit==10
       set(handles.MSB1bit5,'Backgroundcolor','yellow')    
       end
       if Nbit==8
       set(handles.MSB1bit4,'Backgroundcolor','yellow')  
       end
       if Nbit==6
       set(handles.MSB1bit3,'Backgroundcolor','yellow')    
       end
       
       PPEXsplit
       return;
        
    case 3    %Classic Bridge - SE
       
       nobridgeN(hObject,eventdata,handles)
       noarrayN(hObject,eventdata,handles)
       dispASbit(hObject,eventdata,handles)
       setTextbridge(hObject,eventdata,handles)
       return;
        
        
    case 4     % Binary Weighted - FD
        
         nobridgeN(hObject,eventdata,handles)
         nobridgeP(hObject,eventdata,handles)
         setTextbinw(hObject,eventdata, handles)
         dispASbit(hObject,eventdata,handles)
         return;
       
    case 5     %Split BW - FD
       
       nobridgeN(hObject,eventdata,handles)
       nobridgeP(hObject,eventdata,handles)
       dispASbit(hObject,eventdata,handles)
       setTextbinw(hObject,eventdata, handles)
           
       if Nbit==14
       set(handles.MSB1bit7,'Backgroundcolor','yellow')
       set(handles.MSB2bit7,'Backgroundcolor','yellow')
       end
       if Nbit==12
       set(handles.MSB1bit6,'Backgroundcolor','yellow') 
       set(handles.MSB2bit6,'Backgroundcolor','yellow') 
       end
       if Nbit==10
       set(handles.MSB1bit5,'Backgroundcolor','yellow') 
       set(handles.MSB2bit5,'Backgroundcolor','yellow') 
       end
       if Nbit==8
       set(handles.MSB1bit4,'Backgroundcolor','yellow')  
       set(handles.MSB2bit4,'Backgroundcolor','yellow')  
       end
       if Nbit==6
       set(handles.MSB1bit3,'Backgroundcolor','yellow')  
       set(handles.MSB2bit3,'Backgroundcolor','yellow')
       end
       
       PPEXsplit
       return;
         
    case 6     %Classic Bridge - FD
        
       dispASbit(hObject,eventdata,handles)
       setTextbridge(hObject,eventdata,handles)
       return;
       
     case 7    %Monotonic Binary - FD

        nobridgeN(hObject,eventdata,handles)
        nobridgeP(hObject,eventdata,handles)
        dispASbit(hObject,eventdata,handles)
        setTextbinw(hObject,eventdata, handles)
        return;
%%TO DEACTIVATE THE OPTION UNCOMMENT THE FOLLOWING LINES AND COMMENT THE PREVIOUS LINES        
%          disp('ERROR PPEX tool cannot work without a topology.')
%          close PPEXtool
%          return;
         
              
         
    case 8     %Monotonic BWA

          dispASbit(hObject,eventdata,handles)
          setTextbridge(hObject,eventdata, handles)
          return;
%%TO DEACTIVATE THE OPTION UNCOMMENT THE FOLLOWING LINES AND COMMENT THE PREVIOUS LINES       
%         disp('ERROR PPEX tool cannot work without a topology.')
%         close PPEXtool
%         return;
        
    case 9     %Modified Monotonic BWA
      
          dispASbit(hObject,eventdata,handles)
          setTextbridge(hObject,eventdata, handles)
          return;
%%TO DEACTIVATE THE OPTION UNCOMMENT THE FOLLOWING LINES AND COMMENT THE PREVIOUS LINES       
%         disp('ERROR PPEX tool cannot work without a topology.')
%         close PPEXtool
%         return;
      
    case 10    %Empty Slot
        
        disp('ERROR PPEX tool cannot work without a topology.')
        close PPEXtool
        return;
              
end


    function disppexm(hObject,eventdata,handles)
        
        
        global PEXM;
        global Nbit;
    %set default values;
    PEX11 = PEXM(1,:);
    PEX12 = PEXM(2,:);
    PEX21 = PEXM(3,:);
    PEX22 = PEXM(4,:);
    PEXB  = PEXM(5,1:2);
    
    dPEX11 =  fliplr(PEX11);
    dPEX12 =  fliplr(PEX12);
    dPEX21 =  fliplr(PEX21);
    dPEX22 =  fliplr(PEX22);
  
    
    
    set(handles.MSB1bit3,'String',num2str(dPEX11(3)));
    set(handles.MSB1bit2,'String',num2str(dPEX11(2)));
    set(handles.MSB1bit1,'String',num2str(dPEX11(1))); 
    
    set(handles.MSB2bit3,'String',num2str(dPEX21(3)));
    set(handles.MSB2bit2,'String',num2str(dPEX21(2)));
    set(handles.MSB2bit1,'String',num2str(dPEX21(1)));
    
    set(handles.LSB1bit3,'String',num2str(dPEX12(3)));
    set(handles.LSB1bit2,'String',num2str(dPEX12(2)));
    set(handles.LSB1bit1,'String',num2str(dPEX12(1)));
    
    set(handles.LSB2bit3,'String',num2str(dPEX22(3)));
    set(handles.LSB2bit2,'String',num2str(dPEX22(2)));
    set(handles.LSB2bit1,'String',num2str(dPEX22(1)));
    if Nbit>=8
    set(handles.MSB1bit4,'String',num2str(dPEX11(4)));
    set(handles.MSB2bit4,'String',num2str(dPEX21(4)));
    set(handles.LSB1bit4,'String',num2str(dPEX12(4)));
    set(handles.LSB2bit4,'String',num2str(dPEX22(4)));
    if Nbit>=10
    set(handles.MSB1bit5,'String',num2str(dPEX11(5)));
    set(handles.LSB1bit5,'String',num2str(dPEX12(5)));
    set(handles.MSB2bit5,'String',num2str(dPEX21(5)));
    set(handles.LSB2bit5,'String',num2str(dPEX22(5)));
    if Nbit>=12
    set(handles.MSB1bit6,'String',num2str(dPEX11(6)));
    set(handles.MSB2bit6,'String',num2str(dPEX21(6)));
    set(handles.LSB1bit6,'String',num2str(dPEX12(6)));
    set(handles.LSB2bit6,'String',num2str(dPEX22(6)));
    if Nbit>=14
    set(handles.MSB1bit7,'String',num2str(dPEX11(7)));
    set(handles.MSB2bit7,'String',num2str(dPEX21(7)));
    set(handles.LSB2bit7,'String',num2str(dPEX22(7)));
    set(handles.LSB1bit7,'String',num2str(dPEX12(7)));
    end
    end
    end
    end
    
    
    


    

    set(handles.pbp,'String',num2str(PEXB(1)));
    set(handles.nbp,'String',num2str(PEXB(2)));

    




function nobridgeP(hObject,eventdata, handles)
       
       set(handles.pbp,'String','0');
       set(handles.pbp,'BackgroundColor','black'); 
       set(handles.nbp,'String','0');
       set(handles.nbp,'BackgroundColor','black'); 
       set(handles.textbp,'String','');
       set(handles.m1text,'String','');   
       set(handles.l1text,'String','');
       

function nobridgeN(hObject,eventdata, handles)
          
       set(handles.nbp,'String','0');
       set(handles.nbp,'BackgroundColor','black'); 
       set(handles.textbn,'String','');
       set(handles.m2text,'String','');
       set(handles.l2text,'String','');

function yesbridge(hObject,eventdata, handles)
       set(handles.pbp,'String','0');
       set(handles.pbp,'BackgroundColor','black'); 
       set(handles.nbp,'String','0');
       set(handles.nbp,'BackgroundColor','black'); 
       set(handles.textbp,'String','');
       set(handles.textbn,'String','');
       set(handles.m1text,'String','');
       set(handles.m2text,'String','');
       set(handles.l1text,'String','');
       set(handles.l2text,'String','');

function noarrayN(hObject,eventdata, handles)


        set(handles.MSB2bit1,'String','0');
        set(handles.MSB2bit1,'BackgroundColor','black');
        set(handles.MSB2bit2,'String','0');
        set(handles.MSB2bit2,'BackgroundColor','black');
        set(handles.MSB2bit3,'String','0');
        set(handles.MSB2bit3,'BackgroundColor','black');
        set(handles.MSB2bit4,'String','0');
        set(handles.MSB2bit4,'BackgroundColor','black');
        set(handles.MSB2bit5,'String','0');
        set(handles.MSB2bit5,'BackgroundColor','black');
        set(handles.MSB2bit6,'String','0');
        set(handles.MSB2bit6,'BackgroundColor','black');
        set(handles.MSB2bit7,'String','0');
        set(handles.MSB2bit7,'BackgroundColor','black');
        set(handles.LSB2bit1,'String','0');
        set(handles.LSB2bit1,'BackgroundColor','black');
        set(handles.LSB2bit2,'String','0');
        set(handles.LSB2bit2,'BackgroundColor','black');
        set(handles.LSB2bit3,'String','0');
        set(handles.LSB2bit3,'BackgroundColor','black');
        set(handles.LSB2bit4,'String','0');
        set(handles.LSB2bit4,'BackgroundColor','black');
        set(handles.LSB2bit5,'String','0');
        set(handles.LSB2bit5,'BackgroundColor','black');
        set(handles.LSB2bit6,'String','0');
        set(handles.LSB2bit6,'BackgroundColor','black');
        set(handles.LSB2bit7,'String','0');
        set(handles.LSB2bit7,'BackgroundColor','black');
        
    function dispall(hObject,eventdata,handles)
        
        %ArrayP
        set(handles.MSB1bit1,'String','0');
        set(handles.MSB1bit1,'BackgroundColor','white');
        set(handles.MSB1bit2,'String','0');
        set(handles.MSB1bit2,'BackgroundColor','white');
        set(handles.MSB1bit3,'String','0');
        set(handles.MSB1bit3,'BackgroundColor','white');
        set(handles.MSB1bit4,'String','0');
        set(handles.MSB1bit4,'BackgroundColor','white');
        set(handles.MSB1bit5,'String','0');
        set(handles.MSB1bit5,'BackgroundColor','white');
        set(handles.MSB1bit6,'String','0');
        set(handles.MSB1bit6,'BackgroundColor','white');
        set(handles.MSB1bit7,'String','0');
        set(handles.MSB1bit7,'BackgroundColor','white');
        set(handles.LSB1bit1,'String','0');
        set(handles.LSB1bit1,'BackgroundColor','white');
        set(handles.LSB1bit2,'String','0');
        set(handles.LSB1bit2,'BackgroundColor','white');
        set(handles.LSB1bit3,'String','0');
        set(handles.LSB1bit3,'BackgroundColor','white');
        set(handles.LSB1bit4,'String','0');
        set(handles.LSB1bit4,'BackgroundColor','white');
        set(handles.LSB1bit5,'String','0');
        set(handles.LSB1bit5,'BackgroundColor','white');
        set(handles.LSB1bit6,'String','0');
        set(handles.LSB1bit6,'BackgroundColor','white');
        set(handles.LSB1bit7,'String','0');
        set(handles.LSB1bit7,'BackgroundColor','white');
        
        %ArrayN
        set(handles.MSB2bit1,'String','0');
        set(handles.MSB2bit1,'BackgroundColor','white');
        set(handles.MSB2bit2,'String','0');
        set(handles.MSB2bit2,'BackgroundColor','white');
        set(handles.MSB2bit3,'String','0');
        set(handles.MSB2bit3,'BackgroundColor','white');
        set(handles.MSB2bit4,'String','0');
        set(handles.MSB2bit4,'BackgroundColor','white');
        set(handles.MSB2bit5,'String','0');
        set(handles.MSB2bit5,'BackgroundColor','white');
        set(handles.MSB2bit6,'String','0');
        set(handles.MSB2bit6,'BackgroundColor','white');
        set(handles.MSB2bit7,'String','0');
        set(handles.MSB2bit7,'BackgroundColor','white');
        set(handles.LSB2bit1,'String','0');
        set(handles.LSB2bit1,'BackgroundColor','white');
        set(handles.LSB2bit2,'String','0');
        set(handles.LSB2bit2,'BackgroundColor','white');
        set(handles.LSB2bit3,'String','0');
        set(handles.LSB2bit3,'BackgroundColor','white');
        set(handles.LSB2bit4,'String','0');
        set(handles.LSB2bit4,'BackgroundColor','white');
        set(handles.LSB2bit5,'String','0');
        set(handles.LSB2bit5,'BackgroundColor','white');
        set(handles.LSB2bit6,'String','0');
        set(handles.LSB2bit6,'BackgroundColor','white');
        set(handles.LSB2bit7,'String','0');
        set(handles.LSB2bit7,'BackgroundColor','white');
        
        
        %Bridges
        set(handles.pbp,'String','0');
        set(handles.pbp,'BackgroundColor','white'); 
        set(handles.nbp,'String','0');
        set(handles.nbp,'BackgroundColor','white'); 
        set(handles.textbp,'String','');
        set(handles.textbn,'String','');
        set(handles.m1text,'String','');
        set(handles.m2text,'String','');
        set(handles.l1text,'String','');
        set(handles.l2text,'String','');

        
          
        function dispASbit(hObject,eventdata,handles)
        
        global Nbit;
        
        if Nbit<=12
            set(handles.MSB1bit7,'String','0');
            set(handles.MSB1bit7,'BackgroundColor','black');
            set(handles.LSB1bit7,'String','0');
            set(handles.LSB1bit7,'BackgroundColor','black');   
            set(handles.MSB2bit7,'String','0');
            set(handles.MSB2bit7,'BackgroundColor','black');
            set(handles.LSB2bit7,'String','0');
            set(handles.LSB2bit7,'BackgroundColor','black');
            set(handles.t164c,'String','');
            set(handles.t264c,'String','');
            if Nbit<=10
                set(handles.t132c,'String','');
                set(handles.t232c,'String','');          
                set(handles.MSB1bit6,'String','0');
                set(handles.MSB1bit6,'BackgroundColor','black');
                set(handles.LSB1bit6,'String','0');
                set(handles.LSB1bit6,'BackgroundColor','black');   
                set(handles.MSB2bit6,'String','0');
                set(handles.MSB2bit6,'BackgroundColor','black');
                set(handles.LSB2bit6,'String','0');
                set(handles.LSB2bit6,'BackgroundColor','black');
                if Nbit<=8
                    set(handles.t116c,'String','');
                    set(handles.t216c,'String','');
                    set(handles.MSB1bit5,'String','0');
                    set(handles.MSB1bit5,'BackgroundColor','black');
                    set(handles.LSB1bit5,'String','0');
                    set(handles.LSB1bit5,'BackgroundColor','black');   
                    set(handles.MSB2bit5,'String','0');
                    set(handles.MSB2bit5,'BackgroundColor','black');
                    set(handles.LSB2bit5,'String','0');
                    set(handles.LSB2bit5,'BackgroundColor','black');
                   if Nbit<=6
                    set(handles.t18c,'String','');
                    set(handles.t28c,'String','');
                    set(handles.MSB1bit4,'String','0');
                    set(handles.MSB1bit4,'BackgroundColor','black');
                    set(handles.LSB1bit4,'String','0');
                    set(handles.LSB1bit4,'BackgroundColor','black');   
                    set(handles.MSB2bit4,'String','0');
                    set(handles.MSB2bit4,'BackgroundColor','black');
                    set(handles.LSB2bit4,'String','0');
                    set(handles.LSB2bit4,'BackgroundColor','black');
                   end
                end
            end
        end
        
                
        
            function setTextbridge(hObject,eventdata, handles)
                global Nbit
                
                %preset text;
                set(handles.t164c,'String','64C');
                set(handles.t132c,'String','32C');
                set(handles.t116c,'String','16C');
                set(handles.t18c,'String','8C');
                set(handles.t14c,'String','4C');
                set(handles.t12c,'String','2C');
                set(handles.t1c,'String','C');
                set(handles.t264c,'String','64C');
                set(handles.t232c,'String','32C');
                set(handles.t216c,'String','16C');
                set(handles.t28c,'String','8C');
                set(handles.t24c,'String','4C');
                set(handles.t22c,'String','2C');
                set(handles.t2c,'String','C');
                set(handles.textbp,'String','P-Bridge cap par')
                set(handles.textbn,'String','N-Bridge cap par')
                set(handles.m1text,'String','MSB Subarray')
                set(handles.l1text,'String','LSB Subarray')
                set(handles.m2text,'String','MSB Subarray')
                set(handles.l2text,'String','LSB Subarray')
                if Nbit<=12
                set(handles.t164c,'String','');
                set(handles.t264c,'String','');
                if Nbit<=10
                   set(handles.t132c,'String','');
                   set(handles.t232c,'String','');
                     
                   if Nbit<=8
                     set(handles.t116c,'String','');
                     set(handles.t216c,'String','');
                  
                        if Nbit<=6
                        set(handles.t18c,'String','');
                        set(handles.t28c,'String','');   
                        end
                   end
                end
                end
                
                function setTextbinw(hObject,eventdata, handles)
                
                global Nbit
  
                set(handles.textbp,'String','');
                set(handles.textbn,'String','');
                set(handles.m1text,'String','');
                set(handles.l1text,'String','');
                set(handles.m2text,'String','');
                set(handles.l2text,'String','');
                
                set(handles.t164c,'String','8192C');
                set(handles.t132c,'String','4096C');
                set(handles.t116c,'String','2048C');
                set(handles.t18c,'String','1024C');
                set(handles.t14c,'String','512C');
                set(handles.t12c,'String','256C');
                set(handles.t1c,'String','128C');
                set(handles.t264c,'String','64C');
                set(handles.t232c,'String','32C');
                set(handles.t216c,'String','16C');
                set(handles.t28c,'String','8C');
                set(handles.t24c,'String','4C');
                set(handles.t22c,'String','2C');
                set(handles.t2c,'String','C');
                
                if Nbit<=12
                set(handles.t164c,'String','');
                set(handles.t264c,'String','');
                set(handles.t132c,'String','2048C');
                set(handles.t116c,'String','1024C');
                set(handles.t18c,'String','512C');
                set(handles.t14c,'String','256C');
                set(handles.t12c,'String','128C');
                set(handles.t1c,'String','64C');
                if Nbit<=10
                   set(handles.t132c,'String','');
                   set(handles.t232c,'String','');
                   set(handles.t116c,'String','512C');
                   set(handles.t18c,'String','256C');
                   set(handles.t14c,'String','128C');
                   set(handles.t12c,'String','64C');
                   set(handles.t1c,'String','32C');
                   if Nbit<=8
                     set(handles.t116c,'String','');
                     set(handles.t216c,'String','');
                     set(handles.t18c,'String','128C');
                     set(handles.t14c,'String','64C');
                     set(handles.t12c,'String','32C');
                     set(handles.t1c,'String','16C');
                        if Nbit<=6
                        set(handles.t18c,'String','');
                        set(handles.t28c,'String','');  
                        set(handles.t14c,'String','32C');
                     set(handles.t12c,'String','16C');
                     set(handles.t1c,'String','8C');
                        end
                   end
                end
                end


% --- Executes on button press in importbut.
function importbut_Callback(hObject, eventdata, handles)
% hObject    handle to importbut (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Nbit;
global sel;
global PEXM;
global SPEX;




if ( sel==3 || sel==6 || sel ==8 )

disp('Choose the first parasitic .dat file') 
[peximpset,peximpath,check]=uigetfile('CSAtool/work/ppexset/*.dat');
fileA=strcat(peximpath,peximpset);

disp('Choose the second parasitic .dat file')
[peximpset,peximpath,check]=uigetfile('CSAtool/work/ppexset/*.dat');
fileB=strcat(peximpath,peximpset);

vpar1=importpar(1,fileA,fileB);
vpar2=vpar1; %Using more memory, but just to remind that we can change the script in the future to
%manage flat layout for fully differential architectures.
SPEX=zeros(2,13);
else

disp('Choose the parasitic .dat file') 
[peximpset,peximpath,check]=uigetfile('CSAtool/work/ppexset/*.dat');
fileA=strcat(peximpath,peximpset);

%filep
vpar1=importpar(1,fileA,fileA);
vpar2=vpar1; %Using more memory, but just to remind that we can change the script in the future to
%manage flat layout for fully differential architectures.
SPEX=zeros(2,13);

if (sel==2 || sel==5)

disp('Choose the split MSB array parasitic .dat file') 
[peximpset,peximpath,check]=uigetfile('CSAtool/work/ppexset/*.dat');
fileC=strcat(peximpath,peximpset);

vparSplit=importpar(1,fileA,fileA);
SPEX=par2spex(vparSplit,Nbit);
dispspex(hObject,eventdata,handles)
%Using more memory, but just to remind that we can change the script in the future to
%manage flat layout for fully differential architectures.
end
end


PEXM=par2pexm(vpar1,vpar2,Nbit);
disppexm(hObject,eventdata,handles)


