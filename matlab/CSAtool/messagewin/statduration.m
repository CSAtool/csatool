function varargout = statduration(varargin)
% STATDURATION M-file for statduration.fig
%      STATDURATION, by itself, creates a new STATDURATION or raises the existing
%      singleton*.
%
%      H = STATDURATION returns the handle to a new STATDURATION or the handle to
%      the existing singleton*.
%
%      STATDURATION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in STATDURATION.M with the given input arguments.
%
%      STATDURATION('Property','Value',...) creates a new STATDURATION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before statduration_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to statduration_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help statduration

% Last Modified by GUIDE v2.5 20-Jan-2013 20:05:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @statduration_OpeningFcn, ...
                   'gui_OutputFcn',  @statduration_OutputFcn, ...
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


% --- Executes just before statduration is made visible.
function statduration_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to statduration (see VARARGIN)

% Choose default command line output for statduration
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes statduration wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = statduration_OutputFcn(hObject, eventdata, handles) 
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
close statduration
