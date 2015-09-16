function varargout = misview(varargin)
% MISVIEW M-file for misview.fig
%      MISVIEW, by itself, creates a new MISVIEW or raises the existing
%      singleton*.
%
%      H = MISVIEW returns the handle to a new MISVIEW or the handle to
%      the existing singleton*.
%
%      MISVIEW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MISVIEW.M with the given input arguments.
%
%      MISVIEW('Property','Value',...) creates a new MISVIEW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before misview_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to misview_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help misview

% Last Modified by GUIDE v2.5 19-Feb-2013 10:30:11

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @misview_OpeningFcn, ...
                   'gui_OutputFcn',  @misview_OutputFcn, ...
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


% --- Executes just before misview is made visible.
function misview_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to misview (see VARARGIN)

% Choose default command line output for misview
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
im1 = imread( 'mismatch.png' );
imshow(im1,'Parent',handles.axes1);




% --- Outputs from this function are returned to the command line.
function varargout = misview_OutputFcn(hObject, eventdata, handles) 
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
close misview
