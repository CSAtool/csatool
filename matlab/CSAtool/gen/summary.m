function varargout = summary(varargin)
% SUMMARY M-file for summary.fig
%      SUMMARY, by itself, creates a new SUMMARY or raises the existing
%      singleton*.
%
%      H = SUMMARY returns the handle to a new SUMMARY or the handle to
%      the existing singleton*.
%
%      SUMMARY('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SUMMARY.M with the given input arguments.
%
%      SUMMARY('Property','Value',...) creates a new SUMMARY or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before summary_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to summary_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help summary

% Last Modified by GUIDE v2.5 07-Feb-2013 16:01:53

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @summary_OpeningFcn, ...
                   'gui_OutputFcn',  @summary_OutputFcn, ...
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


% --- Executes just before summary is made visible.
function summary_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to summary (see VARARGIN)

% Choose default command line output for summary
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);



global dnapp;
global inapp;
global indice;
global pmeters;
global colm;
global sndrmat;
global enobmat;
global indiceB;
% UIWAIT makes summary wait for user response (see UIRESUME)
% uiwait(handles.figure1);

axes(handles.sumDNLbox)
hold off
for i=1:indice
stem(dnapp(i,:),'LineWidth',1,'color',colm(i,:));
hold on;
end
grid on;
axis([0 length(dnapp(1,:)) (-0.1+min(min(dnapp))) (0.1+max(max(dnapp)))])
title('Coarse DNL','FontSize',8,'FontWeight','bold');
xlabel('Output Level','FontSize',8,'FontWeight','bold')
ylabel('LSB','FontSize',8,'FontWeight','bold')
set(handles.sumDNLbox,'LineWidth',2);

axes(handles.sumINLbox)
hold off
for i=1:indice
plot(inapp(i,:),'LineWidth',1,'color',colm(i,:));
hold on;
end
grid on;
axis([0 length(inapp(1,:)) (-0.1+min(min(inapp))) (0.1+max(max(inapp)))])
title('Coarse INL','FontSize',8,'FontWeight','bold');
xlabel('Output Level','FontSize',8,'FontWeight','bold')
ylabel('LSB','FontSize',8,'FontWeight','bold')
set(handles.sumINLbox,'LineWidth',2);

set(handles.sumtab,'Data',pmeters');

maxabsdnl=max(abs(dnapp'));
maxabsinl=max(abs(inapp'));
maxsndr=max(sndrmat');
maxenob=max(enobmat');
sumtab2data=[maxabsdnl; maxabsinl; maxsndr; maxenob];
set(handles.sumtab2,'Data',sumtab2data)

% --- Outputs from this function are returned to the command line.
function varargout = summary_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in close.
function close_Callback(hObject, eventdata, handles)
% hObject    handle to close (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
close summary
