function varargout = iview(varargin)
% IVIEW M-file for iview.fig
%      IVIEW, by itself, creates a new IVIEW or raises the existing
%      singleton*.
%
%      H = IVIEW returns the handle to a new IVIEW or the handle to
%      the existing singleton*.
%
%      IVIEW('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in IVIEW.M with the given input arguments.
%
%      IVIEW('Property','Value',...) creates a new IVIEW or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before iview_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to iview_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help iview

% Last Modified by GUIDE v2.5 20-Jan-2013 19:37:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @iview_OpeningFcn, ...
                   'gui_OutputFcn',  @iview_OutputFcn, ...
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


% --- Executes just before iview is made visible.
function iview_OpeningFcn(hObject, eventdata, handles, varargin)

handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

global sel
    if (sel == 1)
    set(handles.text1,'String','Classic Binary Weighted (CBW) - SE');
    varargout{1} = handles.output;
    im1 = imread( 'GUI_binarySE.png' );
    imshow(im1,'Parent',handles.viewer);
    
    elseif (sel == 2)
    set(handles.text1,'String','Split Binary Weighted (SBW) - SE');
    varargout{1} = handles.output;
    im2 = imread( 'GUI_binarysplitSE.png' );
    imshow(im2,'Parent',handles.viewer);
   
    elseif (sel == 3) 
    set(handles.text1,'String','Classic Bridge (BWA) - SE');
    varargout{1} = handles.output;
    im3 = imread( 'GUI_bridgeSE.png' );
    imshow(im3,'Parent',handles.viewer);
 
    elseif (sel == 4)
    
    set(handles.text1,'String','Classic Binary Weighted (CBW) - FD');
    varargout{1} = handles.output;
    im5 = imread( 'GUI_binaryFD.png' );
    imshow(im5,'Parent',handles.viewer);
   
    elseif (sel == 5)
    set(handles.text1,'String','Split Binary Weighted (SBW)- FD');
    varargout{1} = handles.output;
    im6 = imread( 'GUI_binarysplitFD.png' );
    imshow(im6,'Parent',handles.viewer); 
   
    elseif (sel == 6)
    set(handles.text1,'String','Classic Bridge (BWA) - FD');
    varargout{1} = handles.output;
    im6 = imread( 'GUI_bridgeFD.png' );
    imshow(im6,'Parent',handles.viewer); 
    
    elseif (sel == 7)
    set(handles.text1,'String','Error: no model.');
    varargout{1} = handles.output;
    im4 = imread( 'GUI_nomodel.png' );
    imshow(im4,'Parent',handles.viewer);
    
    elseif (sel == 8)
    set(handles.text1,'String','Error: no model.');
    varargout{1} = handles.output;
    im6 = imread( 'GUI_nomodel.png' );
    imshow(im6,'Parent',handles.viewer); 
  
    elseif (sel == 9)
    set(handles.text1,'String','Error: no model.');
    varargout{1} = handles.output;
    im6 = imread( 'GUI_nomodel.png' );
    imshow(im6,'Parent',handles.viewer); 
 
    elseif (sel == 10)
    set(handles.text1,'String','Error: no model.');
    varargout{1} = handles.output;
    im6 = imread( 'GUI_nomodel.png' );
    imshow(im6,'Parent',handles.viewer); 
    
end












% --- Outputs from this function are returned to the command line.
function varargout = iview_OutputFcn(hObject, eventdata, handles) 
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
close iview
