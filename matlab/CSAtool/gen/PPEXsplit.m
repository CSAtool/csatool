function varargout = PPEXsplit(varargin)
% PPEXSPLIT M-file for PPEXsplit.fig
%      PPEXSPLIT, by itself, creates a new PPEXSPLIT or raises the existing
%      singleton*.
%
%      H = PPEXSPLIT returns the handle to a new PPEXSPLIT or the handle to
%      the existing singleton*.
%
%      PPEXSPLIT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in PPEXSPLIT.M with the given input arguments.
%
%      PPEXSPLIT('Property','Value',...) creates a new PPEXSPLIT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before PPEXsplit_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to PPEXsplit_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help PPEXsplit

% Last Modified by GUIDE v2.5 12-Feb-2013 15:22:44

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @PPEXsplit_OpeningFcn, ...
                   'gui_OutputFcn',  @PPEXsplit_OutputFcn, ...
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


% --- Executes just before PPEXsplit is made visible.
function PPEXsplit_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to PPEXsplit (see VARARGIN)
global Nbit;
global sel;
global SPEX;
global ispex;
ispex=1;

set(handles.c_1,'String','0');
set(handles.c2_1,'String','0');
set(handles.c4_1,'String','0');
set(handles.c8_1,'String','0');
set(handles.c16_1,'String','0');
set(handles.c32_1,'String','0');
set(handles.c64_1,'String','0');
set(handles.c128_1,'String','0');
set(handles.c256_1,'String','0');
set(handles.c512_1,'String','0');
set(handles.c1024_1,'String','0');
set(handles.c2048_1,'String','0');
set(handles.c4096_1,'String','0');

set(handles.c_2,'String','0');
set(handles.c2_2,'String','0');
set(handles.c4_2,'String','0');
set(handles.c8_2,'String','0');
set(handles.c16_2,'String','0');
set(handles.c32_2,'String','0');
set(handles.c64_2,'String','0');
set(handles.c128_2,'String','0');
set(handles.c256_2,'String','0');
set(handles.c512_2,'String','0');
set(handles.c1024_2,'String','0');
set(handles.c2048_2,'String','0');
set(handles.c4096_2,'String','0');




% Choose default command line output for PPEXsplit
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

if Nbit<14
    set(handles.c4096_1,'String','0');
    set(handles.c4096_1,'BackgroundColor','black');
    set(handles.c4096_2,'String','0');
    set(handles.c4096_2,'BackgroundColor','black');
    set(handles.c2048_1,'String','0');
    set(handles.c2048_1,'BackgroundColor','black');
    set(handles.c2048_2,'String','0');
    set(handles.c2048_2,'BackgroundColor','black');
    if Nbit<12
        set(handles.c1024_1,'String','0');
        set(handles.c1024_1,'BackgroundColor','black');
        set(handles.c1024_2,'String','0');
        set(handles.c1024_2,'BackgroundColor','black');
        set(handles.c512_1,'String','0');
        set(handles.c512_1,'BackgroundColor','black');
        set(handles.c512_2,'String','0');
        set(handles.c512_2,'BackgroundColor','black');        
        
        if Nbit<10
            set(handles.c256_1,'String','0');
            set(handles.c256_1,'BackgroundColor','black');
            set(handles.c256_2,'String','0');
            set(handles.c256_2,'BackgroundColor','black');  
            set(handles.c128_1,'String','0');
            set(handles.c128_1,'BackgroundColor','black');
            set(handles.c128_2,'String','0');
            set(handles.c128_2,'BackgroundColor','black'); 
            if Nbit<8  
            set(handles.c64_1,'String','0');
            set(handles.c64_1,'BackgroundColor','black');
            set(handles.c64_2,'String','0');
            set(handles.c64_2,'BackgroundColor','black');    
            set(handles.c32_1,'String','0');
            set(handles.c32_1,'BackgroundColor','black');
            set(handles.c32_2,'String','0');
            set(handles.c32_2,'BackgroundColor','black');  
            end
        end
    end
end

if (sel==2)

set(handles.c_2,'String','0');
set(handles.c_2,'BackgroundColor','black');
set(handles.c2_2,'String','0');
set(handles.c2_2,'BackgroundColor','black'); 
set(handles.c4_2,'String','0');
set(handles.c4_2,'BackgroundColor','black'); 
set(handles.c8_2,'String','0');
set(handles.c8_2,'BackgroundColor','black'); 
set(handles.c16_2,'String','0');
set(handles.c16_2,'BackgroundColor','black'); 
set(handles.c32_2,'String','0');
set(handles.c32_2,'BackgroundColor','black'); 
set(handles.c64_2,'String','0');
set(handles.c64_2,'BackgroundColor','black'); 
set(handles.c128_2,'String','0');
set(handles.c128_2,'BackgroundColor','black'); 
set(handles.c256_2,'String','0');
set(handles.c256_2,'BackgroundColor','black'); 
set(handles.c512_2,'String','0');
set(handles.c512_2,'BackgroundColor','black'); 
set(handles.c1024_2,'String','0');
set(handles.c1024_2,'BackgroundColor','black'); 
set(handles.c2048_2,'String','0');
set(handles.c2048_2,'BackgroundColor','black'); 
set(handles.c4096_2,'String','0');
set(handles.c4096_2,'BackgroundColor','black'); 

end


dispspex(hObject,eventdata,handles)
% UIWAIT makes PPEXsplit wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = PPEXsplit_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;



function c2_1_Callback(hObject, eventdata, handles)
% hObject    handle to c2_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c2_1 as text
%        str2double(get(hObject,'String')) returns contents of c2_1 as a double


% --- Executes during object creation, after setting all properties.
function c2_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c2_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function c4_1_Callback(hObject, eventdata, handles)
% hObject    handle to c4_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c4_1 as text
%        str2double(get(hObject,'String')) returns contents of c4_1 as a double


% --- Executes during object creation, after setting all properties.
function c4_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c4_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function c8_1_Callback(hObject, eventdata, handles)
% hObject    handle to c8_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c8_1 as text
%        str2double(get(hObject,'String')) returns contents of c8_1 as a double


% --- Executes during object creation, after setting all properties.
function c8_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c8_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function c16_1_Callback(hObject, eventdata, handles)
% hObject    handle to c16_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c16_1 as text
%        str2double(get(hObject,'String')) returns contents of c16_1 as a double


% --- Executes during object creation, after setting all properties.
function c16_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c16_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function c32_1_Callback(hObject, eventdata, handles)
% hObject    handle to c32_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c32_1 as text
%        str2double(get(hObject,'String')) returns contents of c32_1 as a double


% --- Executes during object creation, after setting all properties.
function c32_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c32_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function c64_1_Callback(hObject, eventdata, handles)
% hObject    handle to c64_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c64_1 as text
%        str2double(get(hObject,'String')) returns contents of c64_1 as a double


% --- Executes during object creation, after setting all properties.
function c64_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c64_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function c128_1_Callback(hObject, eventdata, handles)
% hObject    handle to c128_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c128_1 as text
%        str2double(get(hObject,'String')) returns contents of c128_1 as a double


% --- Executes during object creation, after setting all properties.
function c128_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c128_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function c256_1_Callback(hObject, eventdata, handles)
% hObject    handle to c256_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c256_1 as text
%        str2double(get(hObject,'String')) returns contents of c256_1 as a double


% --- Executes during object creation, after setting all properties.
function c256_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c256_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function c512_1_Callback(hObject, eventdata, handles)
% hObject    handle to c512_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c512_1 as text
%        str2double(get(hObject,'String')) returns contents of c512_1 as a double


% --- Executes during object creation, after setting all properties.
function c512_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c512_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function c_1_Callback(hObject, eventdata, handles)
% hObject    handle to c_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c_1 as text
%        str2double(get(hObject,'String')) returns contents of c_1 as a double


% --- Executes during object creation, after setting all properties.
function c_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function c1024_1_Callback(hObject, eventdata, handles)
% hObject    handle to c1024_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c1024_1 as text
%        str2double(get(hObject,'String')) returns contents of c1024_1 as a double


% --- Executes during object creation, after setting all properties.
function c1024_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c1024_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function c2_2_Callback(hObject, eventdata, handles)
% hObject    handle to c2_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c2_2 as text
%        str2double(get(hObject,'String')) returns contents of c2_2 as a double


% --- Executes during object creation, after setting all properties.
function c2_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c2_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function c4_2_Callback(hObject, eventdata, handles)
% hObject    handle to c4_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c4_2 as text
%        str2double(get(hObject,'String')) returns contents of c4_2 as a double


% --- Executes during object creation, after setting all properties.
function c4_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c4_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function c8_2_Callback(hObject, eventdata, handles)
% hObject    handle to c8_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c8_2 as text
%        str2double(get(hObject,'String')) returns contents of c8_2 as a double


% --- Executes during object creation, after setting all properties.
function c8_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c8_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function c16_2_Callback(hObject, eventdata, handles)
% hObject    handle to c16_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c16_2 as text
%        str2double(get(hObject,'String')) returns contents of c16_2 as a double


% --- Executes during object creation, after setting all properties.
function c16_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c16_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function c32_2_Callback(hObject, eventdata, handles)
% hObject    handle to c32_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c32_2 as text
%        str2double(get(hObject,'String')) returns contents of c32_2 as a double


% --- Executes during object creation, after setting all properties.
function c32_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c32_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function c64_2_Callback(hObject, eventdata, handles)
% hObject    handle to c64_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c64_2 as text
%        str2double(get(hObject,'String')) returns contents of c64_2 as a double


% --- Executes during object creation, after setting all properties.
function c64_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c64_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function c128_2_Callback(hObject, eventdata, handles)
% hObject    handle to c128_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c128_2 as text
%        str2double(get(hObject,'String')) returns contents of c128_2 as a double


% --- Executes during object creation, after setting all properties.
function c128_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c128_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function c256_2_Callback(hObject, eventdata, handles)
% hObject    handle to c256_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c256_2 as text
%        str2double(get(hObject,'String')) returns contents of c256_2 as a double


% --- Executes during object creation, after setting all properties.
function c256_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c256_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function c512_2_Callback(hObject, eventdata, handles)
% hObject    handle to c512_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c512_2 as text
%        str2double(get(hObject,'String')) returns contents of c512_2 as a double


% --- Executes during object creation, after setting all properties.
function c512_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c512_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function c_2_Callback(hObject, eventdata, handles)
% hObject    handle to c_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c_2 as text
%        str2double(get(hObject,'String')) returns contents of c_2 as a double


% --- Executes during object creation, after setting all properties.
function c_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function c1024_2_Callback(hObject, eventdata, handles)
% hObject    handle to c1024_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c1024_2 as text
%        str2double(get(hObject,'String')) returns contents of c1024_2 as a double


% --- Executes during object creation, after setting all properties.
function c1024_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c1024_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in done.
function done_Callback(hObject, eventdata, handles)
% hObject    handle to done (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SPEX;
global ispex;
SPEX=zeros(2,13);

SPEX(1,1)=str2double(get(handles.c_1,'String'));
SPEX(1,2)=str2double(get(handles.c2_1,'String'));
SPEX(1,3)=str2double(get(handles.c4_1,'String'));
SPEX(1,4)=str2double(get(handles.c8_1,'String'));
SPEX(1,5)=str2double(get(handles.c16_1,'String'));
SPEX(1,6)=str2double(get(handles.c32_1,'String'));
SPEX(1,7)=str2double(get(handles.c64_1,'String'));
SPEX(1,8)=str2double(get(handles.c128_1,'String'));
SPEX(1,9)=str2double(get(handles.c256_1,'String'));
SPEX(1,10)=str2double(get(handles.c512_1,'String'));
SPEX(1,11)=str2double(get(handles.c1024_1,'String'));
SPEX(1,12)=str2double(get(handles.c2048_1,'String'));
SPEX(1,13)=str2double(get(handles.c4096_1,'String'));

SPEX(2,1)=str2double(get(handles.c_2,'String'));
SPEX(2,2)=str2double(get(handles.c2_2,'String'));
SPEX(2,3)=str2double(get(handles.c4_2,'String'));
SPEX(2,4)=str2double(get(handles.c8_2,'String'));
SPEX(2,5)=str2double(get(handles.c16_2,'String'));
SPEX(2,6)=str2double(get(handles.c32_2,'String'));
SPEX(2,7)=str2double(get(handles.c64_2,'String'));
SPEX(2,8)=str2double(get(handles.c128_2,'String'));
SPEX(2,9)=str2double(get(handles.c256_2,'String'));
SPEX(2,10)=str2double(get(handles.c512_2,'String'));
SPEX(2,11)=str2double(get(handles.c1024_2,'String'));
SPEX(2,12)=str2double(get(handles.c2048_2,'String'));
SPEX(2,13)=str2double(get(handles.c4096_2,'String'));

ispex=0;
close PPEXsplit


% --- Executes on button press in reset.
function reset_Callback(hObject, eventdata, handles)

global SPEX

SPEX=zeros(2,13);

set(handles.c_1,'String','0');
set(handles.c2_1,'String','0');
set(handles.c4_1,'String','0');
set(handles.c8_1,'String','0');
set(handles.c16_1,'String','0');
set(handles.c32_1,'String','0');
set(handles.c64_1,'String','0');
set(handles.c128_1,'String','0');
set(handles.c256_1,'String','0');
set(handles.c512_1,'String','0');
set(handles.c1024_1,'String','0');
set(handles.c2048_1,'String','0');
set(handles.c4096_1,'String','0');


set(handles.c_2,'String','0');
set(handles.c2_2,'String','0');
set(handles.c4_2,'String','0');
set(handles.c8_2,'String','0');
set(handles.c16_2,'String','0');
set(handles.c32_2,'String','0');
set(handles.c64_2,'String','0');
set(handles.c128_2,'String','0');
set(handles.c256_2,'String','0');
set(handles.c512_2,'String','0');
set(handles.c1024_2,'String','0');
set(handles.c2048_2,'String','0');
set(handles.c4096_2,'String','0');


% hObject    handle to reset (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function c2048_1_Callback(hObject, eventdata, handles)
% hObject    handle to c2048_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c2048_1 as text
%        str2double(get(hObject,'String')) returns contents of c2048_1 as a double


% --- Executes during object creation, after setting all properties.
function c2048_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c2048_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function c2048_2_Callback(hObject, eventdata, handles)
% hObject    handle to c2048_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c2048_2 as text
%        str2double(get(hObject,'String')) returns contents of c2048_2 as a double


% --- Executes during object creation, after setting all properties.
function c2048_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c2048_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function c4096_1_Callback(hObject, eventdata, handles)
% hObject    handle to c4096_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c4096_1 as text
%        str2double(get(hObject,'String')) returns contents of c4096_1 as a double


% --- Executes during object creation, after setting all properties.
function c4096_1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c4096_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function c4096_2_Callback(hObject, eventdata, handles)
% hObject    handle to c4096_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of c4096_2 as text
%        str2double(get(hObject,'String')) returns contents of c4096_2 as a double


% --- Executes during object creation, after setting all properties.
function c4096_2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to c4096_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function dispspex(hObject,eventdata,handles)

global SPEX

set(handles.c_1,'String',num2str(SPEX(1,1)));
set(handles.c2_1,'String',num2str(SPEX(1,2)));
set(handles.c4_1,'String',num2str(SPEX(1,3)));
set(handles.c8_1,'String',num2str(SPEX(1,4)));
set(handles.c16_1,'String',num2str(SPEX(1,5)));
set(handles.c32_1,'String',num2str(SPEX(1,6)));
set(handles.c64_1,'String',num2str(SPEX(1,7)));
set(handles.c128_1,'String',num2str(SPEX(1,8)));
set(handles.c256_1,'String',num2str(SPEX(1,9)));
set(handles.c512_1,'String',num2str(SPEX(1,10)));
set(handles.c1024_1,'String',num2str(SPEX(1,11)));
set(handles.c2048_1,'String',num2str(SPEX(1,12)));
set(handles.c4096_1,'String',num2str(SPEX(1,13)));

set(handles.c_2,'String',num2str(SPEX(2,1)));
set(handles.c2_2,'String',num2str(SPEX(2,2)));
set(handles.c4_2,'String',num2str(SPEX(2,3)));
set(handles.c8_2,'String',num2str(SPEX(2,4)));
set(handles.c16_2,'String',num2str(SPEX(2,5)));
set(handles.c32_2,'String',num2str(SPEX(2,6)));
set(handles.c64_2,'String',num2str(SPEX(2,7)));
set(handles.c128_2,'String',num2str(SPEX(2,8)));
set(handles.c256_2,'String',num2str(SPEX(2,9)));
set(handles.c512_2,'String',num2str(SPEX(2,10)));
set(handles.c1024_2,'String',num2str(SPEX(2,11)));
set(handles.c2048_2,'String',num2str(SPEX(2,12)));
set(handles.c4096_2,'String',num2str(SPEX(2,13)));



% --- Executes on button press in abort.
function abort_Callback(hObject, eventdata, handles)

global ispex;
ispex=0;
close PPEXsplit;




% --- Executes on button press in sync.
function sync_Callback(hObject, eventdata, handles)
% hObject    handle to sync (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

global sel;
global Nbit;

if (sel~=2 || sel ~= 6)
    close PPEXsplit;
else
    
set(handles.c_1,'String','0');
set(handles.c2_1,'String','0');
set(handles.c4_1,'String','0');
set(handles.c8_1,'String','0');
set(handles.c16_1,'String','0');
set(handles.c32_1,'String','0');
set(handles.c64_1,'String','0');
set(handles.c128_1,'String','0');
set(handles.c256_1,'String','0');
set(handles.c512_1,'String','0');
set(handles.c1024_1,'String','0');
set(handles.c2048_1,'String','0');
set(handles.c4096_1,'String','0');

set(handles.c_2,'String','0');
set(handles.c2_2,'String','0');
set(handles.c4_2,'String','0');
set(handles.c8_2,'String','0');
set(handles.c16_2,'String','0');
set(handles.c32_2,'String','0');
set(handles.c64_2,'String','0');
set(handles.c128_2,'String','0');
set(handles.c256_2,'String','0');
set(handles.c512_2,'String','0');
set(handles.c1024_2,'String','0');
set(handles.c2048_2,'String','0');
set(handles.c4096_2,'String','0');

% Choose default command line output for PPEXsplit
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

if Nbit<14
    set(handles.c4096_1,'String','0');
    set(handles.c4096_1,'BackgroundColor','black');
    set(handles.c4096_2,'String','0');
    set(handles.c4096_2,'BackgroundColor','black');
    set(handles.c2048_1,'String','0');
    set(handles.c2048_1,'BackgroundColor','black');
    set(handles.c2048_2,'String','0');
    set(handles.c2048_2,'BackgroundColor','black');
    if Nbit<12
        set(handles.c1024_1,'String','0');
        set(handles.c1024_1,'BackgroundColor','black');
        set(handles.c1024_2,'String','0');
        set(handles.c1024_2,'BackgroundColor','black');
        set(handles.c512_1,'String','0');
        set(handles.c512_1,'BackgroundColor','black');
        set(handles.c512_2,'String','0');
        set(handles.c512_2,'BackgroundColor','black');        
        
        if Nbit<10
            set(handles.c256_1,'String','0');
            set(handles.c256_1,'BackgroundColor','black');
            set(handles.c256_2,'String','0');
            set(handles.c256_2,'BackgroundColor','black');  
            set(handles.c128_1,'String','0');
            set(handles.c128_1,'BackgroundColor','black');
            set(handles.c128_2,'String','0');
            set(handles.c128_2,'BackgroundColor','black'); 
            if Nbit<8  
            set(handles.c64_1,'String','0');
            set(handles.c64_1,'BackgroundColor','black');
            set(handles.c64_2,'String','0');
            set(handles.c64_2,'BackgroundColor','black');    
            set(handles.c32_1,'String','0');
            set(handles.c32_1,'BackgroundColor','black');
            set(handles.c32_2,'String','0');
            set(handles.c32_2,'BackgroundColor','black');  
            end
        end
    end
end

if (sel==2)

set(handles.c_2,'String','0');
set(handles.c_2,'BackgroundColor','black');
set(handles.c2_2,'String','0');
set(handles.c2_2,'BackgroundColor','black'); 
set(handles.c4_2,'String','0');
set(handles.c4_2,'BackgroundColor','black'); 
set(handles.c8_2,'String','0');
set(handles.c8_2,'BackgroundColor','black'); 
set(handles.c16_2,'String','0');
set(handles.c16_2,'BackgroundColor','black'); 
set(handles.c32_2,'String','0');
set(handles.c32_2,'BackgroundColor','black'); 
set(handles.c64_2,'String','0');
set(handles.c64_2,'BackgroundColor','black'); 
set(handles.c128_2,'String','0');
set(handles.c128_2,'BackgroundColor','black'); 
set(handles.c256_2,'String','0');
set(handles.c256_2,'BackgroundColor','black'); 
set(handles.c512_2,'String','0');
set(handles.c512_2,'BackgroundColor','black'); 
set(handles.c1024_2,'String','0');
set(handles.c1024_2,'BackgroundColor','black'); 
set(handles.c2048_2,'String','0');
set(handles.c2048_2,'BackgroundColor','black'); 
set(handles.c4096_2,'String','0');
set(handles.c4096_2,'BackgroundColor','black'); 

end

end





