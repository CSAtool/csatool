function varargout = PAR(varargin)
% PAR M-file for PAR.fig
%      PAR, by itself, creates a new PAR or raises the existing
%      singleton*.
%
%      H = PAR returns the handle to a new PAR or the handle to
%      the existing singleton*.
%
%      PAR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PAR.M with the given input arguments.
%
%      PAR('Property','Value',...) creates a new PAR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PAR_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PAR_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PAR

% Last Modified by GUIDE v2.5 21-Feb-2013 19:39:45

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PAR_OpeningFcn, ...
                   'gui_OutputFcn',  @PAR_OutputFcn, ...
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


% --- Executes just before PAR is made visible.
function PAR_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

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










% --- Outputs from this function are returned to the command line.
function varargout = PAR_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function swpstart_Callback(hObject, eventdata, handles)
% hObject    handle to swpstart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of swpstart as text
%        str2double(get(hObject,'String')) returns contents of swpstart as a double


% --- Executes during object creation, after setting all properties.
function swpstart_CreateFcn(hObject, eventdata, handles)
% hObject    handle to swpstart (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function swpstop_Callback(hObject, eventdata, handles)
% hObject    handle to swpstop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of swpstop as text
%        str2double(get(hObject,'String')) returns contents of swpstop as a double


% --- Executes during object creation, after setting all properties.
function swpstop_CreateFcn(hObject, eventdata, handles)
% hObject    handle to swpstop (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function swppoints_Callback(hObject, eventdata, handles)
% hObject    handle to swppoints (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of swppoints as text
%        str2double(get(hObject,'String')) returns contents of swppoints as a double


% --- Executes during object creation, after setting all properties.
function swppoints_CreateFcn(hObject, eventdata, handles)
% hObject    handle to swppoints (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in sw_kc.
function sw_kc_Callback(hObject, eventdata, handles)

get(handles.sw_kc,'Value');
 if ans==1
   set(handles.sw_cp11,'Value',0);
   set(handles.sw_cp12,'Value',0);
   set(handles.sw_cp21,'Value',0);
   set(handles.sw_cp22,'Value',0);
   set(handles.sw_cunit,'Value',0);
 end


% --- Executes on button press in sw_cp11.
function sw_cp11_Callback(hObject, eventdata, handles)

get(handles.sw_cp11,'Value');
 if ans==1
   set(handles.sw_cunit,'Value',0);
   set(handles.sw_cp12,'Value',0);
   set(handles.sw_cp21,'Value',0);
   set(handles.sw_cp22,'Value',0);
   set(handles.sw_kc,'Value',0);
 end


% --- Executes on button press in sw_cp12.
function sw_cp12_Callback(hObject, eventdata, handles)

get(handles.sw_cp12,'Value');
 if ans==1
   set(handles.sw_cp11,'Value',0);
   set(handles.sw_cunit,'Value',0);
   set(handles.sw_cp21,'Value',0);
   set(handles.sw_cp22,'Value',0);
   set(handles.sw_kc,'Value',0);
 end


% --- Executes on button press in sw_cp21.
function sw_cp21_Callback(hObject, eventdata, handles)

get(handles.sw_cp21,'Value');
 if ans==1
   set(handles.sw_cp11,'Value',0);
   set(handles.sw_cp12,'Value',0);
   set(handles.sw_cunit,'Value',0);
   set(handles.sw_cp22,'Value',0);
   set(handles.sw_kc,'Value',0);
 end


% --- Executes on button press in sw_cunit.
function sw_cunit_Callback(hObject, eventdata, handles)


 get(handles.sw_cunit,'Value');
 if ans==1
   set(handles.sw_cp11,'Value',0);
   set(handles.sw_cp12,'Value',0);
   set(handles.sw_cp21,'Value',0);
   set(handles.sw_cp22,'Value',0);
   set(handles.sw_kc,'Value',0);
 end
% Hint: get(hObject,'Value') returns toggle state of sw_cunit


% --- Executes on button press in sw_cp22.
function sw_cp22_Callback(hObject, eventdata, handles)

get(handles.sw_cp22,'Value');
 if ans==1
   set(handles.sw_cp11,'Value',0);
   set(handles.sw_cp12,'Value',0);
   set(handles.sw_cp21,'Value',0);
   set(handles.sw_cunit,'Value',0);
   set(handles.sw_kc,'Value',0);
 end


% --- Executes on button press in outenob.
function outenob_Callback(hObject, eventdata, handles)
% hObject    handle to outenob (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of outenob


% --- Executes on button press in outmaxdnl.
function outmaxdnl_Callback(hObject, eventdata, handles)
% hObject    handle to outmaxdnl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of outmaxdnl


% --- Executes on button press in outmaxinl.
function outmaxinl_Callback(hObject, eventdata, handles)
% hObject    handle to outmaxinl (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of outmaxinl


% --- Executes on button press in outsndr.
function outsndr_Callback(hObject, eventdata, handles)
% hObject    handle to outsndr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of outsndr



function swruns_Callback(hObject, eventdata, handles)
% hObject    handle to swruns (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of swruns as text
%        str2double(get(hObject,'String')) returns contents of swruns as a double


% --- Executes during object creation, after setting all properties.
function swruns_CreateFcn(hObject, eventdata, handles)
% hObject    handle to swruns (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Run.
function Run_Callback(hObject, eventdata, handles)
% hObject    handle to Run (see GCBO)
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


%Setting PPEX tool input data
m=Nbit/2;
if ipex==1
PEX11=PEXM(1,1:m);
PEX12=PEXM(2,1:m);
PEX21=PEXM(3,1:m);
PEX22=PEXM(4,1:m);
PEXB=PEXM(5,1:2);
else
    PEX11=zeros(1,m);
    PEX12=zeros(1,m);
    PEX21=zeros(1,m);
    PEX22=zeros(1,m);
    PEXB=zeros(1,m);
end
%-------------------------------%


%------ Sweep settings----------%
swr=str2double(get(handles.swruns,'String'));


swkc=get(handles.sw_kc,'Value');
swcunit=get(handles.sw_cunit,'Value');
swcp11=get(handles.sw_cp11,'Value');
swcp12=get(handles.sw_cp12,'Value');
swcp21=get(handles.sw_cp21,'Value');
swcp22=get(handles.sw_cp22,'Value');
nmis=get(handles.nomis,'Value');

swstart=str2double(get(handles.swpstart,'String'));
swstop=str2double(get(handles.swpstop,'String'));
swpoints=str2double(get(handles.swppoints,'String'));

%----------------------------------------%




if (swstart > swstop)
disp('ERROR: start value cannot be greater than stop value.')
return
end
if (swpoints==0)
    disp('ERROR: please specify non-zero iteration points.')
    return
end
if (swkc==1)
if (swr==0 || swstart<=0 || swstop <=0)
     disp('.....')
     disp('ERROR: A statistical-parametric analysis was chosen, but')
     disp('cannot be performed as no Runs were specified or because kc is 0.')
     return
end
end


disp('...')
disp('%----------------A New sweep analysis started--------------------%')
c=clock;
disp(cat(2, date, ' || Time:    ', num2str(c(4)), ':' , num2str(c(5)) , ':',num2str(c(6))))
disp('%--------------------------------------------------------------%')

output=1;


%Sweep management

if swkc == 1
    xkc     = linspace(swstart,swstop,swpoints);
    xCpar11 = ones(1,swpoints)*Cpar11;
    xCpar12 = ones(1,swpoints)*Cpar12;
    xCpar21 = ones(1,swpoints)*Cpar21;
    xCpar22 = ones(1,swpoints)*Cpar22;
    xcunit  = ones(1,swpoints)*cunit;
    xcbridge= xcunit;
    xplot=xkc;
    xlab='kc [um]'; 
end
if swcp11 == 1
    xkc     = ones(1,swpoints)*kc;
    xCpar11 = linspace(swstart,swstop,swpoints);
    xCpar12 = ones(1,swpoints)*Cpar12;
    xCpar21 = ones(1,swpoints)*Cpar21;
    xCpar22 = ones(1,swpoints)*Cpar22;
    xcunit  = ones(1,swpoints)*cunit;
    xcbridge= xcunit;
    xplot=xCpar11;
    xlab='Cp11 [F]';
end
if swcp12 == 1
    xkc =     ones(1,swpoints)*kc;
    xCpar11 = ones(1,swpoints)*Cpar11;
    xCpar12 = linspace(swstart,swstop,swpoints);
    xCpar21 = ones(1,swpoints)*Cpar21;
    xCpar22 = ones(1,swpoints)*Cpar22;
    xcunit  = ones(1,swpoints)*cunit;
    xcbridge= xcunit;
    xplot=xCpar12;
     xlab='Cp12 [F]';
end
if swcp21 == 1
    xkc     = ones(1,swpoints)*kc;
    xCpar11 = ones(1,swpoints)*Cpar11;
    xCpar12 = ones(1,swpoints)*Cpar12;
    xCpar21 = linspace(swstart,swstop,swpoints);
    xCpar22 = ones(1,swpoints)*Cpar22;
    xcunit  = ones(1,swpoints)*cunit;
    xcbridge= xcunit;
    xplot=xCpar21;
    xlab='Cp21 [F]';
    xmisos=misos;
end
if swcp22 == 1
    xkc     = ones(1,swpoints)*kc;
    xCpar11 = ones(1,swpoints)*Cpar11;
    xCpar12 = ones(1,swpoints)*Cpar12;
    xCpar21 = ones(1,swpoints)*Cpar21;
    xCpar22 = linspace(swstart,swstop,swpoints);
    xcunit  = ones(1,swpoints)*cunit;
    xcbridge= xcunit;
    xplot=xCpar22;
    xlab='Cp22 [F]';
    xmisos=misos;
end
if swcunit == 1
    xkc    = ones(1,swpoints)*kc;
    xCpar11 = ones(1,swpoints)*Cpar11;
    xCpar12 = ones(1,swpoints)*Cpar12;
    xCpar21 = ones(1,swpoints)*Cpar21;
    xCpar22 = ones(1,swpoints)*Cpar22;
    xcunit  = linspace(swstart,swstop,swpoints);
    xcbridge= xcunit;
    xplot=xcunit;
    xlab='Cunit [F]';
    xmisos=misos;
end
if nmis==1
    swr=1;
    xkc=zeros(1,swpoints);
    xmisos=0;
end





%------------------Output settings--------------------%
outSNDR=get(handles.outsndr,'Value');
outENOB=get(handles.outenob,'Value');
outINL=get(handles.outmaxinl,'Value');
outDNL=get(handles.outmaxdnl,'Value');


if (outINL==0)&&(outDNL==0)&&(outENOB==0)&&(outSNDR==0)
    disp('No output selected.')
    disp('...');
end

if (outINL==1 || outDNL==1) 
  dnlv=zeros(swr,2^Nbit-2);
  inlv=zeros(swr,2^Nbit-2);
for i=1:swpoints
        disp(cat(2,'ITERATION ', num2str(i), ' OUT OF ' ,num2str(swpoints)))
        [ADNL,AINL,MDM,MDS,SDM,MIM,MIS,DSV,ISV] = STAT(sel,swr,Nbit,Vdd,Vss,xcunit(i),xkc(i),xmisos,cspec,xcbridge(i),xCpar11(i),xCpar12(i),xCpar21(i),xCpar22(i),STP,SBP,STBP,PEX11,PEX12,PEX21,PEX22,PEXB,SPEX);
        mxdnlv(i)=MDM;
        mxinlv(i)=MIM;
end
end 
   if outINL==1 
         figure()
         plot(xplot,mxinlv,'Linewidth',1.5)
         title(cat(2,'Sweep Analysis Results: max|INL| vs ',xlab),'Fontsize',10,'FontWeight','bold');
         xlabel(xlab,'Fontsize',8,'FontWeight','bold');
         ylabel('max|INL|','Fontsize',8,'FontWeight','bold');
         grid on;  
    end
   if outDNL==1   
         figure()
         plot(xplot,mxdnlv,'Linewidth',1.5)
         title(cat(2,'Sweep Analysis Results: max|DNL| vs ',xlab),'Fontsize',10,'FontWeight','bold');
         xlabel(xlab,'Fontsize',8,'FontWeight','bold');
         ylabel('max|DNL|','Fontsize',8,'FontWeight','bold');
         grid on; 
   end



if (outSNDR==1)||(outENOB==1)
      
    for i=1:swpoints   
     disp(cat(2,'ITERATION ', num2str(i), ' OUT OF ' ,num2str(swpoints)))
     [DNL0,INL0,levels]=nlfunc(sel,Nbit,Vdd,Vss,xcunit(i),xcbridge(i),0,0,cspec,STP,SBP,STBP,xCpar11(i),xCpar12(i),xCpar21(i),xCpar22(i),PEX11,PEX12,PEX21,PEX22,PEXB,SPEX);
     nmask=maskselect(sel,Nbit);
     FSR=fsrselect(sel,Vdd,Vss);
     sigma=1;
     epoints=3;
     A1=0.9;
     A2=0.98;
     alpha=alphasel(sel,Nbit);
     stDNLmax = alpha * sigma * xkc(i) * sqrt(cspec)/sqrt(xcunit(i));
     ENOBs=zeros(1,swr);
     for j=1:swr
         [ENOBs(j)] = enobst(Nbit, FSR, DNL0 , nmask , stDNLmax ,A1, A2, epoints);
         disp(cat(2,num2str(j),' Runs out of ',num2str(swr),' completed...'))
     end
     vecenob_m(i)=mean(ENOBs);
     vecenob_s(i)=std(ENOBs);
     if (outSNDR==1)
     SNDRs=6.02*ENOBs+1.76;
     vecsndr_m(i)=mean(SNDRs);
     vecsndr_s(i)=std(SNDRs);
     end
     
   end
   disp('%-------END of sweep-------------%')
   c=clock;
   disp(cat(2, date, ' || Time:    ', num2str(c(4)), ':' , num2str(c(5)) , ':',num2str(c(6))))
   disp('%--------------------------------%')
   
   if outENOB==1
   figure()
   plot(xplot,vecenob_m,'Linewidth',1.5)
   title(cat(2,'Sweep Analysis Results: ENOB vs ',xlab),'Fontsize',10,'FontWeight','bold');
   xlabel(xlab,'Fontsize',8,'FontWeight','bold');
   ylabel('ENoB','Fontsize',8,'FontWeight','bold');
   grid on;  
   end
   if outSNDR==1
   figure()
   plot(xplot,vecsndr_m,'Linewidth',1.5)
   title(cat(2,'Sweep Analysis Results: SNDR vs ',xlab),'Fontsize',10,'FontWeight','bold');
   xlabel(xlab,'Fontsize',8,'FontWeight','bold');
   ylabel('SNDR','Fontsize',8,'FontWeight','bold');
   grid on;  
   end
   
end


% --- Executes on button press in nomis.
function nomis_Callback(hObject, eventdata, handles)
% hObject    handle to nomis (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of nomis
