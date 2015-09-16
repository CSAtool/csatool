function varargout = kc_Error(varargin)
% KC_ERROR M-file for kc_Error.fig
%      KC_ERROR, by itself, creates a new KC_ERROR or raises the existing
%      singleton*.
%
%      H = KC_ERROR returns the handle to a new KC_ERROR or the handle to
%      the existing singleton*.
%
%      KC_ERROR('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in KC_ERROR.M with the given input arguments.
%
%      KC_ERROR('Property','Value',...) creates a new KC_ERROR or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before kc_Error_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to kc_Error_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help kc_Error

% Last Modified by GUIDE v2.5 02-Dec-2012 14:58:40

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @kc_Error_OpeningFcn, ...
                   'gui_OutputFcn',  @kc_Error_OutputFcn, ...
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


% --- Executes just before kc_Error is made visible.
function kc_Error_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to kc_Error (see VARARGIN)

% Choose default command line output for kc_Error
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes kc_Error wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = kc_Error_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;
