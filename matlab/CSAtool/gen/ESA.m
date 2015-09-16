function varargout = ESA(varargin)
% ESA M-file for ESA.fig
%      ESA, by itself, creates a new ESA or raises the existing
%      singleton*.
%
%      H = ESA returns the handle to a new ESA or the handle to
%      the existing singleton*.
%
%      ESA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ESA.M with the given input arguments.
%
%      ESA('Property','Value',...) creates a new ESA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ESA_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ESA_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ESA

% Last Modified by GUIDE v2.5 11-Feb-2013 20:06:52

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @ESA_OpeningFcn, ...
                   'gui_OutputFcn',  @ESA_OutputFcn, ...
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


% --- Executes just before ESA is made visible.
function ESA_OpeningFcn(hObject, eventdata, handles, varargin)



global ipex;
global sel;
global Nbit;
global Vdd;
global Vss;
global cunit;
global cbridge;
global cspec;
global kc;
global STP;
global STBP;
global SBP;
global Cpar11;
global Cpar12;
global Cpar21;
global Cpar22;
global PEXM;
global SPEX;
global ENOBs;
global stop;
global enobruns
global sigma

sigma=1;
stop=0;
ENOBs=0;
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ESA (see VARARGIN)

% Choose default command line output for ESA
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ESA wait for user response (see UIRESUME)
% uiwait(handles.figure1);
set(handles.enobbox,'LineWidth',2);

% --- Outputs from this function are returned to the command line.
function varargout = ESA_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function runs_Callback(hObject, eventdata, handles)
% hObject    handle to runs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of runs as text
%        str2double(get(hObject,'String')) returns contents of runs as a double


% --- Executes during object creation, after setting all properties.
function runs_CreateFcn(hObject, eventdata, handles)
% hObject    handle to runs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function minA_Callback(hObject, eventdata, handles)
% hObject    handle to minA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of minA as text
%        str2double(get(hObject,'String')) returns contents of minA as a double


% --- Executes during object creation, after setting all properties.
function minA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to minA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function maxA_Callback(hObject, eventdata, handles)
% hObject    handle to maxA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of maxA as text
%        str2double(get(hObject,'String')) returns contents of maxA as a double


% --- Executes during object creation, after setting all properties.
function maxA_CreateFcn(hObject, eventdata, handles)
% hObject    handle to maxA (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function sigma_Callback(hObject, eventdata, handles)
% hObject    handle to sigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of sigma as text
%        str2double(get(hObject,'String')) returns contents of sigma as a double


% --- Executes during object creation, after setting all properties.
function sigma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to sigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Start.
function Start_Callback(hObject, eventdata, handles)



global ipex;
global sel;
global Nbit;
global Vdd;
global Vss;
global cunit;
global cbridge;
global cspec;
global kc;
global misos;
global STP;
global STBP;
global SBP;
global Cpar11;
global Cpar12;
global Cpar21;
global Cpar22;
global PEXM;
global SPEX;
global stop;
global ENOBs
global enobruns
global sigma

stop=0;
PEX11=zeros(1,Nbit/2);    
PEX12=zeros(1,Nbit/2);  
PEX21=zeros(1,Nbit/2);  
PEX22=zeros(1,Nbit/2);  
PEXB=zeros(1,Nbit/2);  

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

%statduration

disp('%-----------------ESA New Run------------------------%')
c=clock;
disp(cat(2, date, ' || Time:    ', num2str(c(4)), ':' , num2str(c(5)) , ':',num2str(c(6))))
cstart=c;
sec_cstart=cstart(6) + cstart(5)*60 + cstart(4)*60^2 + cstart(4)*24*60^2;

kc=0.0095;

%Comment the following line if method 2 (enobst_met2 function)is used below
%[DNL0,INL0,LEV0]=nlfunc(sel,Nbit,Vdd,Vss,cunit,cbridge,0,0,cspec,STP,SBP,STBP,Cpar11,Cpar12,Cpar21,Cpar22,PEX11,PEX12,PEX21,PEX22,PEXB,SPEX);
%---------------------------%


nmask=maskselect(sel,Nbit);
FSR=fsrselect(sel,Vdd,Vss);
OS=osselect(sel,Vdd,Vss);

enobruns=str2double(get(handles.runs,'String'));
sigma=str2double(get(handles.sigma,'String'));
A1=str2double(get(handles.minA,'String')); % in % of FSR
A2=str2double(get(handles.maxA,'String')); % in % of FSR

alpha=alphasel(sel,Nbit);
stDNLmax = alpha * sigma * kc * sqrt(cspec)/sqrt(cunit);

disp('ENOB Statistical Analysis Started..')
disp('Evaluations may take several minutes...%')
points=10;
ENOBs=zeros(1,enobruns);
for i=1:enobruns
    %Method 1: faster but less acurate
    %[ENOBs(i)] = enobst(Nbit, FSR, DNL0 , nmask , stDNLmax ,A1, A2,%points);
    %Method 2: longer but more accurate
    [DNL0,INL0,LEV0]=nlfunc(sel,Nbit,Vdd,Vss,cunit,cbridge,kc,0,cspec,STP,SBP,STBP,Cpar11,Cpar12,Cpar21,Cpar22,PEX11,PEX12,PEX21,PEX22,PEXB,SPEX);
    %nin=0;
    %figure(97)
    %plot(DNL0)
    [ENOBs(i)] = enobst_met2(Nbit , FSR , DNL0 ,A1, A2, points, LEV0, OS);
    disp(cat(2,num2str(i),' RUNS OUT OF ',num2str(enobruns),' COMPLETED...'))
end

ENOBmean=mean(ENOBs);
ENOBstd=std(ENOBs);

c=clock;
sec_c = c(6) + c(5)*60 + c(4)*60^2 + cstart(4)*24*60^2;
disp(cat(2, date, ' || Time:    ', num2str(c(4)), ':' , num2str(c(5)) , ':',num2str(c(6))))
disp(cat(2,'Simulation Time:', num2str(abs(sec_c-sec_cstart)),'s'));

set(handles.menob,'String',num2str(ENOBmean));
set(handles.senob,'String',num2str(ENOBstd));

nist=5;
if enobruns>10
    nist=round(enobruns/3);
end
axes(handles.enobbox)
hist(ENOBs,nist)
title('ENOB Distribution')
xlabel('ENOB');


% --- Executes on button press in close.
function close_Callback(hObject, eventdata, handles)
% hObject    handle to close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close ESA


function menob_Callback(hObject, eventdata, handles)
% hObject    handle to menob (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of menob as text
%        str2double(get(hObject,'String')) returns contents of menob as a double


% --- Executes during object creation, after setting all properties.
function menob_CreateFcn(hObject, eventdata, handles)
% hObject    handle to menob (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


function senob_Callback(hObject, eventdata, handles)
% hObject    handle to senob (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of senob as text
%        str2double(get(hObject,'String')) returns contents of senob as a double


% --- Executes during object creation, after setting all properties.
function senob_CreateFcn(hObject, eventdata, handles)
% hObject    handle to senob (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global stop
stop=1;


% --- Executes on button press in esanw.
function esanw_Callback(hObject, eventdata, handles)
% hObject    handle to esanw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global enobruns
global ENOBs
global sigma
figure(4)
nist=5;
if enobruns>10
    nist=round(enobruns/3);
end
hist(ENOBs,nist)
title(cat(2,'ENOB Distribution - ','Sigma: ',num2str(sigma)))
xlabel('ENOB');
ylabel('Runs');
