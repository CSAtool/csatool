function varargout = SSA(varargin)
% SSA M-file for SSA.fig
%      SSA, by itself, creates a new SSA or raises the existing
%      singleton*.
%
%      H = SSA returns the handle to a new SSA or the handle to
%      the existing singleton*.
%
%      SSA('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SSA.M with the given input arguments.
%
%      SSA('Property','Value',...) creates a new SSA or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before SSA_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to SSA_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help SSA

% Last Modified by GUIDE v2.5 25-Feb-2013 18:15:13

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @SSA_OpeningFcn, ...
                   'gui_OutputFcn',  @SSA_OutputFcn, ...
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


% --- Executes just before SSA is made visible.
function SSA_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to SSA (see VARARGIN)

% Choose default command line output for SSA
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

global Nbit;
global Vdd;
global Vss;
global Cpar11;
global Cpar12;
global Cpar21;
global Cpar22;
global kc;
global cspec;
global cunit;
global cbridge;
global misos;

global ipex;
global PEXM;
global PEXB;
global sel;
global STP;
global SBP;
global STBP;
global SPEX;
global runs;
global AINL
global ADNL
global DSV;
global ISV;
DSV=zeros(1,10);
ISV=zeros(1,10);
AINL=0;
ADNL=0;

runs=0;

set(handles.runs,'String','0');
set(handles.dnlstdgraph,'LineWidth',2)
set(handles.inlmaxgraph,'LineWidth',2)
set(handles.dnlmaxgraph,'LineWidth',2)
set(handles.inlmaxgraph,'LineWidth',2)
% UIWAIT makes SSA wait for user response (see UIRESUME)
% uiwait(handles.figure1);
axes(handles.dnlmaxgraph);
title('DNL','FontSize',10','FontWeight','Bold');
xlabel('max|DNL|');
ylabel(num2str(runs),'FontSize',8','FontWeight','Bold');
set(handles.dnlmaxgraph,'LineWidth',2)
 
axes(handles.inlmaxgraph);
title('INL','FontSize',10','FontWeight','Bold');
xlabel('max|INL|');
ylabel(num2str(runs),'FontSize',8','FontWeight','Bold');
set(handles.inlmaxgraph,'LineWidth',2)

axes(handles.dnlstdgraph);
title('DNL distribution vs Output Code','FontSize',10','FontWeight','Bold')
xlabel('Output level')
ylabel('DNL stdev [LSB]','FontSize',8','FontWeight','Bold')
axis([0 1024 0 1 ]);
set(handles.dnlstdgraph,'LineWidth',2)


axes(handles.inlstdgraph);
title('INL distribution vs Output Code','FontSize',10','FontWeight','Bold')
xlabel('Output level')
ylabel('INL stdev [LSB]','FontSize',8','FontWeight','Bold')
axis([0 1024 0 1 ]);
set(handles.dnlstdgraph,'LineWidth',2)


% --- Outputs from this function are returned to the command line.
function varargout = SSA_OutputFcn(hObject, eventdata, handles) 
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


% --- Executes on button press in start.
function start_Callback(hObject, eventdata, handles)
% hObject    handle to start (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global Nbit;
global Vdd;
global Vss;
global Cpar11;
global Cpar12;
global Cpar21;
global Cpar22;
global kc;
global cspec;
global cunit;
global cbridge;
global misos;

global ipex;
global PEXM;
global PEXB;
global sel;
global STP;
global SBP;
global STBP;
global SPEX;
global DSV
global ISV
global AINL
global ADNL
global SSAsigma;


SSAsigma=str2double(get(handles.SSAsigma,'String'));
runs=str2double(get(handles.runs,'String'));

disp('...')
disp('%----------------A NEW SSA analysis started--------------------%')
c=clock;
disp(cat(2, date, ' || Time:    ', num2str(c(4)), ':' , num2str(c(5)) , ':',num2str(c(6))))
disp('%--------------------------------------------------------------%')
if (kc==0)
     kc_error
     disp('ERROR: No statistical analysis can be performed if mismatch kc is 0.')
     return
end


if (sel == 1)
    disp('Classic Binary Weighted (CBW) - SE');
    
elseif (sel == 2)
    disp('Split Binary Weighted (SBW) - SE');
     
elseif (sel == 3)  
    disp('Bridge (BWA) - SE');
     
elseif (sel == 4)   
    disp('Classic Binary Weighted (CBW) - FD'); 
     
elseif (sel == 5) 
    
    disp('Split Binary Weighted (SBW) - FD') 
elseif (sel == 6)
    disp('Bridge (BWA) - FD');
    elseif (sel == 7)
    disp('Monotonic - FD'); 
    elseif (sel == 8)
    disp('Monotonic BWA - FD'); 
    elseif (sel == 9)
     disp('Error: no model selected');
    elseif (sel == 10)
    disp('Error: no model selected'); 
end







PEX11=zeros(1,Nbit/2);    
PEX12=zeros(1,Nbit/2);  
PEX21=zeros(1,Nbit/2);  
PEX22=zeros(1,Nbit/2);  
PEXB=zeros(1,Nbit/2);  
if ipex==1
        m=Nbit/2;
        PEX11=PEXM(1,1:m);
        PEX12=PEXM(2,1:m);
        PEX21=PEXM(3,1:m);
        PEX22=PEXM(4,1:m);
        PEXB=PEXM(5,1:2);
end

global Vecdnl;
global Vecinl;
%statduration
[ADNL,AINL,MDM,MDS,SDM,MIM,MIS,DSV,ISV,SIM,Vecdnl,Vecinl] = STAT(sel,runs,Nbit,Vdd,Vss,cunit,SSAsigma*kc,misos,cspec,cbridge,Cpar11,Cpar12,Cpar21,Cpar22,STP,SBP,STBP,PEX11,PEX12,PEX21,PEX22,PEXB,SPEX);



disp('%------------------SSA Analysis Completed----   ---------------%')
c=clock;
disp(cat(2, date, ' || Time:    ', num2str(c(4)), ':' , num2str(c(5)) , ':',num2str(c(6))))
disp('%--------------------------------------------------------------%')

nist=5;
if runs>10
    nist=round(runs/3);
end


axes(handles.dnlmaxgraph);
hist(ADNL,nist)
title('DNL','FontSize',10','FontWeight','Bold');
grid on;
xlabel('max|DNL|');
ylabel(num2str(runs),'FontSize',8','FontWeight','Bold');
set(handles.dnlmaxgraph,'LineWidth',2)
 
axes(handles.inlmaxgraph);
hist(AINL,nist)
title('INL','FontSize',10','FontWeight','Bold');
grid on;
xlabel('max|INL|');
ylabel(num2str(runs),'FontSize',8','FontWeight','Bold');
set(handles.inlmaxgraph,'LineWidth',2)

axes(handles.dnlstdgraph);
plot(DSV,'r')
grid on;
title('DNL distribution vs Output Code','FontSize',10','FontWeight','Bold')
xlabel('Output level')
ylabel('DNL std [LSB]','FontSize',8','FontWeight','Bold')
axis([0 length(DSV) 0 (1.2)*(max(DSV)) ]);
set(handles.dnlstdgraph,'LineWidth',2)

axes(handles.inlstdgraph);
plot(ISV,'r')
grid on;
title('INL distribution vs Output Code','FontSize',10','FontWeight','Bold')
xlabel('Output level')
ylabel('INL std [LSB]','FontSize',8','FontWeight','Bold')
axis([0 length(ISV) 0 (1.2)*(max(ISV)) ]);
set(handles.dnlstdgraph,'LineWidth',2)


set(handles.maxabsDNLtext,'String',num2str(MDM));
set(handles.maxabsDNLstdtext,'String',num2str(MDS));
set(handles.dnlstdtext,'String',num2str(SDM));
set(handles.inlstdtext,'String',num2str(SIM));
set(handles.maxabsinltext,'String',num2str(MIM));
set(handles.maxabsinlstdtext,'String',num2str(MIS));


% --- Executes on button press in savres.
function savres_Callback(hObject, eventdata, handles)
% hObject    handle to savres (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ISV
global DSV
maxAbsDNL_mean=str2double(get(handles.maxabsDNLtext,'String'));
maxAbsDNL_std=str2double(get(handles.maxabsDNLstdtext,'String'));
DNLstd_mean=str2double(get(handles.dnlstdtext,'String'));
maxAbsINL_mean=str2double(get(handles.maxabsinltext,'String'));
maxAbsINL_std=str2double(get(handles.maxabsinlstdtext,'String'));


[filename, pathname, check] = uiputfile('*.mat');

if check==1
   save([pathname filename],'maxAbsDNL_mean','maxAbsDNL_std','DNLstd_mean','maxAbsINL_mean','maxAbsINL_std','DSV','ISV')
end



% --- Executes on button press in close.
function close_Callback(hObject, eventdata, handles)
% hObject    handle to close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close SSA


% --- Executes on button press in nw_a.
function nw_a_Callback(hObject, eventdata, handles)
% hObject    handle to nw_a (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global DSV
figure(5)
plot(1:1:length(DSV),DSV,'r')
grid on;
xlabel('Output level')
ylabel('DNL std [LSB]','FontSize',8','FontWeight','Bold')
axis([0 length(DSV) 0 (1.2)*(max(DSV))+0.001]);



% --- Executes on button press in nw_b.
function nw_b_Callback(hObject, eventdata, handles)
% hObject    handle to nw_b (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ADNL;
global runs;

nist=5;
if runs>10
    nist=round(runs/3);
end


figure(6)
hist(ADNL,nist)
title('DNL','FontSize',10','FontWeight','Bold');
grid on;
xlabel('max|DNL|');
ylabel(num2str(runs),'FontSize',8','FontWeight','Bold');

% --- Executes on button press in nw_c.
function nw_c_Callback(hObject, eventdata, handles)
% hObject    handle to nw_c (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global AINL;
global runs;

nist=5;
if runs>10
    nist=round(runs/3);
end
figure(7)
hist(AINL,nist)
title('INL','FontSize',10','FontWeight','Bold');
grid on;
xlabel('max|INL|');
ylabel(num2str(runs),'FontSize',8','FontWeight','Bold');


% --- Executes on button press in nw_d.
function nw_d_Callback(hObject, eventdata, handles)
% hObject    handle to nw_d (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global ISV
figure(25)
plot(1:1:length(ISV),ISV,'r')
grid on;
xlabel('Output level')
ylabel('INL std [LSB]','FontSize',8','FontWeight','Bold')
axis([0 length(ISV) 0 ((1.2)*(max(ISV))+0.001)]);



function inlstdtext_Callback(hObject, eventdata, handles)
% hObject    handle to inlstdtext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of inlstdtext as text
%        str2double(get(hObject,'String')) returns contents of inlstdtext as a double


% --- Executes during object creation, after setting all properties.
function inlstdtext_CreateFcn(hObject, eventdata, handles)
% hObject    handle to inlstdtext (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function SSAsigma_Callback(hObject, eventdata, handles)
% hObject    handle to SSAsigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of SSAsigma as text
%        str2double(get(hObject,'String')) returns contents of SSAsigma as a double


% --- Executes during object creation, after setting all properties.
function SSAsigma_CreateFcn(hObject, eventdata, handles)
% hObject    handle to SSAsigma (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
