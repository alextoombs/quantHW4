function varargout = DoubleBarrierTool(varargin)
% DOUBLEBARRIERTOOL MATLAB code for DoubleBarrierTool.fig
%      DOUBLEBARRIERTOOL, by itself, creates a new DOUBLEBARRIERTOOL or raises the existing
%      singleton*.
%
%      H = DOUBLEBARRIERTOOL returns the handle to a new DOUBLEBARRIERTOOL or the handle to
%      the existing singleton*.
%
%      DOUBLEBARRIERTOOL('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DOUBLEBARRIERTOOL.M with the given input arguments.
%
%      DOUBLEBARRIERTOOL('Property','Value',...) creates a new DOUBLEBARRIERTOOL or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DoubleBarrierTool_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DoubleBarrierTool_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DoubleBarrierTool

% Last Modified by GUIDE v2.5 12-Oct-2012 15:09:57

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DoubleBarrierTool_OpeningFcn, ...
                   'gui_OutputFcn',  @DoubleBarrierTool_OutputFcn, ...
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


% --- Executes just before DoubleBarrierTool is made visible.
function DoubleBarrierTool_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DoubleBarrierTool (see VARARGIN)

% Choose default command line output for DoubleBarrierTool
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DoubleBarrierTool wait for user response (see UIRESUME)
% uiwait(handles.figure1);

East=get(handles.Eedit,'String');
Ea=str2double(East);
firstPlot(handles,Ea);


% --- Outputs from this function are returned to the command line.
function varargout = DoubleBarrierTool_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on slider movement.
function dslide_Callback(hObject, eventdata, handles)
% hObject    handle to dslide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=get(handles.dslide,'Value');
ast=num2str(a);
set(handles.dedit,'String',ast);
East=get(handles.Eedit,'String');
Ea=str2double(East);
firstPlot(handles,Ea);

% --- Executes during object creation, after setting all properties.
function dslide_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dslide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function aslide_Callback(hObject, eventdata, handles)
% hObject    handle to aslide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=get(handles.aslide,'Value');
ast=num2str(a);
set(handles.aedit,'String',ast);
East=get(handles.Eedit,'String');
Ea=str2double(East);
firstPlot(handles,Ea);

% --- Executes during object creation, after setting all properties.
function aslide_CreateFcn(hObject, eventdata, handles)
% hObject    handle to aslide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end


% --- Executes on slider movement.
function vslide_Callback(hObject, eventdata, handles)
% hObject    handle to vslide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'Value') returns position of slider
%        get(hObject,'Min') and get(hObject,'Max') to determine range of slider
a=get(handles.vslide,'Value');
ast=num2str(a);
set(handles.vedit,'String',ast);
East=get(handles.Eedit,'String');
Ea=str2double(East);
firstPlot(handles,Ea);

% --- Executes during object creation, after setting all properties.
function vslide_CreateFcn(hObject, eventdata, handles)
% hObject    handle to vslide (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: slider controls usually have a light gray background.
if isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor',[.9 .9 .9]);
end



function dedit_Callback(hObject, eventdata, handles)
% hObject    handle to dedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of dedit as text
%        str2double(get(hObject,'String')) returns contents of dedit as a double
ast=get(handles.dedit,'String');
a=str2double(ast);
set(handles.dslide,'Value',a);
East=get(handles.Eedit,'String');
Ea=str2double(East);
firstPlot(handles,Ea);

% --- Executes during object creation, after setting all properties.
function dedit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to dedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function aedit_Callback(hObject, eventdata, handles)
% hObject    handle to aedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of aedit as text
%        str2double(get(hObject,'String')) returns contents of aedit as a double
ast=get(handles.aedit,'String');
a=str2double(ast);
set(handles.aslide,'Value',a);
East=get(handles.Eedit,'String');
Ea=str2double(East);
firstPlot(handles,Ea);

% --- Executes during object creation, after setting all properties.
function aedit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to aedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function vedit_Callback(hObject, eventdata, handles)
% hObject    handle to vedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of vedit as text
%        str2double(get(hObject,'String')) returns contents of vedit as a double
ast=get(handles.vedit,'String');
a=str2double(ast);
set(handles.vslide,'Value',a);
East=get(handles.Eedit,'String');
Ea=str2double(East);
firstPlot(handles,Ea);

% --- Executes during object creation, after setting all properties.
function vedit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to vedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in plotselect.
function plotselect_Callback(hObject, eventdata, handles)
% hObject    handle to plotselect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns plotselect contents as cell array
%        contents{get(hObject,'Value')} returns selected item from plotselect

firstPlot(handles);

% --- Executes during object creation, after setting all properties.
function plotselect_CreateFcn(hObject, eventdata, handles)
% hObject    handle to plotselect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in probplotselect.
function probplotselect_Callback(hObject, eventdata, handles)
% hObject    handle to probplotselect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns probplotselect contents as cell array
%        contents{get(hObject,'Value')} returns selected item from probplotselect
East=get(handles.Eedit,'String');
Ea=str2double(East);
firstPlot(handles,Ea);
% --- Executes during object creation, after setting all properties.
function probplotselect_CreateFcn(hObject, eventdata, handles)
% hObject    handle to probplotselect (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

function Eedit_Callback(hObject, eventdata, handles)
% hObject    handle to Eedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Eedit as text
%        str2double(get(hObject,'String')) returns contents of Eedit as a double

East=get(handles.Eedit,'String');
Ea=str2double(East);
firstPlot(handles,Ea);

% --- Executes during object creation, after setting all properties.
function Eedit_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Eedit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
