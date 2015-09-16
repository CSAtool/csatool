function varargout = nomodel(varargin)
% NOMODEL M-file for nomodel.fig
%      NOMODEL, by itself, creates a new NOMODEL or raises the existing
%      singleton*.
%
%      H = NOMODEL returns the handle to a new NOMODEL or the handle to
%      the existing singleton*.
%
%      NOMODEL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in NOMODEL.M with the given input arguments.
%
%      NOMODEL('Property','Value',...) creates a new NOMODEL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before nomodel_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to nomodel_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help nomodel

% Last Modified by GUIDE v2.5 25-Jan-2013 11:35:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @nomodel_OpeningFcn, ...
                   'gui_OutputFcn',  @nomodel_OutputFcn, ...
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


% --- Executes just before nomodel is made visible.
function nomodel_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to nomodel (see VARARGIN)

% Choose default command line output for nomodel
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes nomodel wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = nomodel_OutputFcn(hObject, eventdata, handles) 
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
close nomodel
