function varargout = ASL_Recognition_System(varargin)
% ASL_RECOGNITION_SYSTEM MATLAB code for ASL_Recognition_System.fig
%      ASL_RECOGNITION_SYSTEM, by itself, creates a new ASL_RECOGNITION_SYSTEM or raises the existing
%      singleton*.
%
%      H = ASL_RECOGNITION_SYSTEM returns the handle to a new ASL_RECOGNITION_SYSTEM or the handle to
%      the existing singleton*.
%
%      ASL_RECOGNITION_SYSTEM('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in ASL_RECOGNITION_SYSTEM.M with the given input arguments.
%
%      ASL_RECOGNITION_SYSTEM('Property','Value',...) creates a new ASL_RECOGNITION_SYSTEM or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before ASL_Recognition_System_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to ASL_Recognition_System_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help ASL_Recognition_System

% Last Modified by GUIDE v2.5 28-Nov-2016 21:37:38

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
    'gui_Singleton',  gui_Singleton, ...
    'gui_OpeningFcn', @ASL_Recognition_System_OpeningFcn, ...
    'gui_OutputFcn',  @ASL_Recognition_System_OutputFcn, ...
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


% --- Executes just before ASL_Recognition_System is made visible.
function ASL_Recognition_System_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to ASL_Recognition_System (see VARARGIN)

imaqreset
axes(handles.kinect_axes);
gui_directory = [pwd '\GUI'];
baseFileName = 'grey.jpg';
baseFilePath = fullfile(gui_directory,baseFileName);
placeholderImg = imread(baseFilePath);
imshow(placeholderImg);
% % initialize kinect RGB input
% info = imaqhwinfo('kinect');
% if isempty(info.DeviceInfo) ~= 1
%     colorVid = videoinput('kinect',1,'RGB_640x480');
%     
%     % Create an image object for previewing.
%     % http://www.mathworks.com/help/imaq/preview.html
%     % Use get(colorVid) to view a complete list of all the properties
%     % supported by a video input object or a video source object
%     % VideoResolution of colorVid returns an array of [640 480]
%     % vidRes(2) returns the height of colorVid
%     % vidRes(1) returns the width of colorVid
%     % nBands    returns number of color bands in data to be acquired
%     vidRes = colorVid.VideoResolution;
%     nBands = colorVid.NumberOfBands;
%     % create placeholder image which matches source
%     hImage = image( zeros(vidRes(2), vidRes(1), nBands) );
%     preview(colorVid, hImage);
% end

%Hand Tracking
% imaqreset

% Create color and depth kinect videoinput objects.
% if ~exist('handles.colorVid','var')
%     handles.colorVid = videoinput('kinect', 1);
% end

if ~exist('handles.depthVid','var')
    handles.depthVid = videoinput('kinect', 2);
end

axes(handles.sign_axes);
asl_preview_directory = [pwd '\asl_preview'];
% Select files using a specified pattern
filePattern = fullfile(asl_preview_directory, '*.png');
% Lists out all required files which follows the pattern
reqFiles = dir(filePattern);
for k = 1 : length(reqFiles)
    %Index into the structure to access a particular item from reqFiles
    baseFileName = reqFiles(k).name;
    %fullfile returns a string containing the full path to the file
    baseFilePath = fullfile(asl_preview_directory, baseFileName);
    %fprintf(1, 'Accessing %s\n', baseFilePath);
    %Create cell array S of size() [2,K]
    %Fills up first row of S with length(reqFiles)
    handles.S{1,k} = k;
    %Fills up second row of S imread(baseFilePath)
    handles.S{2,k} = imread(baseFilePath);
end
% converts cell to matrix in order to imshow
handles.FM = imshow(cell2mat(handles.S(2,1)));

% Choose default command line output for ASL_Recognition_System
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes ASL_Recognition_System wait for user response (see UIRESUME)
% uiwait(handles.ASL_Recognition_System);


% --- Outputs from this function are returned to the command line.
function varargout = ASL_Recognition_System_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in alphabet_popupmenu.
function alphabet_popupmenu_Callback(hObject, eventdata, handles)
% hObject    handle to alphabet_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns alphabet_popupmenu contents as cell array
%        contents{get(hObject,'Value')} returns selected item from alphabet_popupmenu

val = get(hObject, 'Value');
str = get(hObject, 'String');
switch str{val}
    case 'A'
        handles.signA = imshow(cell2mat(handles.S(2,2)), 'Parent', handles.sign_axes);
    case 'B'
        handles.signB = imshow(cell2mat(handles.S(2,3)), 'Parent', handles.sign_axes);
    case 'C'
        handles.signC = imshow(cell2mat(handles.S(2,4)), 'Parent', handles.sign_axes);
    case 'D'
        handles.signD = imshow(cell2mat(handles.S(2,5)), 'Parent', handles.sign_axes);
    case 'E'
        handles.signE = imshow(cell2mat(handles.S(2,6)), 'Parent', handles.sign_axes);
    case 'F'
        handles.signF = imshow(cell2mat(handles.S(2,7)), 'Parent', handles.sign_axes);
    case 'G'
        handles.signG = imshow(cell2mat(handles.S(2,8)), 'Parent', handles.sign_axes);
    case 'H'
        handles.signH = imshow(cell2mat(handles.S(2,9)), 'Parent', handles.sign_axes);
    case 'I'
        handles.signI = imshow(cell2mat(handles.S(2,10)), 'Parent', handles.sign_axes);
    case 'K'
        handles.signK = imshow(cell2mat(handles.S(2,12)), 'Parent', handles.sign_axes);
    case 'L'
        handles.signL = imshow(cell2mat(handles.S(2,13)), 'Parent', handles.sign_axes);
    case 'M'
        handles.signM = imshow(cell2mat(handles.S(2,14)), 'Parent', handles.sign_axes);
    case 'N'
        handles.signN = imshow(cell2mat(handles.S(2,15)), 'Parent', handles.sign_axes);
    case 'O'
        handles.signO = imshow(cell2mat(handles.S(2,16)), 'Parent', handles.sign_axes);
    case 'P'
        handles.signP = imshow(cell2mat(handles.S(2,17)), 'Parent', handles.sign_axes);
    case 'Q'
        handles.signQ = imshow(cell2mat(handles.S(2,18)), 'Parent', handles.sign_axes);
    case 'R'
        handles.signR = imshow(cell2mat(handles.S(2,19)), 'Parent', handles.sign_axes);
    case 'S'
        handles.signS = imshow(cell2mat(handles.S(2,20)), 'Parent', handles.sign_axes);
    case 'T'
        handles.signT = imshow(cell2mat(handles.S(2,21)), 'Parent', handles.sign_axes);
    case 'U'
        handles.signU = imshow(cell2mat(handles.S(2,22)), 'Parent', handles.sign_axes);
    case 'V'
        handles.signV = imshow(cell2mat(handles.S(2,23)), 'Parent', handles.sign_axes);
    case 'W'
        handles.signW = imshow(cell2mat(handles.S(2,24)), 'Parent', handles.sign_axes);
    case 'X'
        handles.signX = imshow(cell2mat(handles.S(2,25)), 'Parent', handles.sign_axes);
    case 'Y'
        handles.signY = imshow(cell2mat(handles.S(2,26)), 'Parent', handles.sign_axes);
    case 'FREE MODE'
        handles.FM = imshow(cell2mat(handles.S(2,1)), 'Parent', handles.sign_axes);
end

% Update handles structure
guidata(hObject, handles);

% --- Executes during object creation, after setting all properties.
function alphabet_popupmenu_CreateFcn(hObject, eventdata, handles)
% hObject    handle to alphabet_popupmenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in check_sign_pushbutton.
function check_sign_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to check_sign_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val = get(handles.alphabet_popupmenu, 'Value');
str = get(handles.alphabet_popupmenu, 'String');

set(handles.output_text, 'String', 'Initializing');
set(handles.state_text, 'String', 'State: -');

depthVid = handles.depthVid;

% Look at the device-specific properties on the depth source device,
% which is the depth sensor on the Kinect V2.
% Set 'EnableBodyTracking' to on, so that the depth sensor will
% return body tracking metadata along with the depth frame.
depthSource = getselectedsource(depthVid);
depthSource.EnableBodyTracking = 'on';

% Set triggerconfig to manual and repeat inf
triggerconfig(depthVid, 'manual');
depthVid.FramesPerTrigger = 1;
depthVid.TriggerRepeat = inf;

% Start the depth and color acquisition objects.
% This begins acquisition, but does not start logging of acquired data.
pause(1);
start(depthVid);

% Start handle image variable
% Initialize snapshotCounter variable
global viewer;
viewer = 1;
snapshotCounter = 0;

% Marker colors for up to 6 bodies.
colors = ['r';'g';'b';'c';'y';'m'];

% Set to kinect_axes
axes(handles.kinect_axes);

while viewer == 1
    drawnow()
    trigger(depthVid);
    
    % Get images and metadata from the color and depth device objects.
    [depthMap, ~, depthMetaData] = getdata(depthVid);
    
    % Find the indexes of the tracked bodies.
    anyBodiesTracked = any(depthMetaData.IsBodyTracked ~= 0);
    trackedBodies = find(depthMetaData.IsBodyTracked);
    
    % Find number of Skeletons tracked.
    nBodies = length(trackedBodies);
    
    % Display captured depth data frame.
    imshow(depthMap, [0 4096], 'Parent', handles.kinect_axes);
    
    % If body is being tracked, get the right hand coordnates.
    if (trackedBodies ~= 0)
        rightHand = depthMetaData.DepthJointIndices(12,:,trackedBodies);
        rightThumb = depthMetaData.DepthJointIndices(25,:,trackedBodies);
        
        % Get right hand depth value for all tracked bodies.
        rightHandDepthMulti = [];
        for body = 1:nBodies
            % Prevent getting out of bound values.
            if rightHand(1,1,body) > 512
                rightHand(1,1,body) = 512;
            end
            if rightHand(1,2,body) > 424
                rightHand(1,2,body) = 424;
            end
            rightHandDepthM = depthMap(round(rightHand(1,2,body)),round(rightHand(1,1,body)));
            rightHandDepthMulti = [rightHandDepthMulti rightHandDepthM];
        end
        
        % Only track the lowest right hand depth value / closest hand.
        [rightHandDepth,nearestHand] = min(rightHandDepthMulti);
        
        % Get the right hand state of the nearest hand.
        rightHandState = depthMetaData.HandRightState;
        rightHandState = rightHandState(trackedBodies(nearestHand));
%         if rightHandState == 3
%             set(handles.state_text, 'String', 'State: Closed');
%         else
%             set(handles.state_text, 'String', 'State: Open');
%         end
        
        % Mark the right hand on the captured depth data frame.
        X1 = [round(rightHand(1,1,nearestHand)) round(rightThumb(1,1,nearestHand))];
        Y1 = [round(rightHand(1,2,nearestHand)) round(rightThumb(1,2,nearestHand))];
        line(X1,Y1, 'LineWidth', 1.5, 'LineStyle', '-', 'Marker', '+', 'Color', 'r');
        
        % Draw rectangle border on the captured depth data frame.
        % Yellow = too far
        % Red = too near
        % Green = within threshold
        if rightHandDepth > 700
            rightHandBorder = [rightHand(:,:,nearestHand)-80 160 160];
            rectangle('position', rightHandBorder, 'EdgeColor', 'y', 'LineWidth', 3);
            set(handles.state_text, 'String', 'State: Too Far');
        elseif rightHandDepth < 600
            rightHandBorder = [rightHand(:,:,nearestHand)-80 160 160];
            rectangle('position', rightHandBorder, 'EdgeColor', 'r', 'LineWidth', 3);
            set(handles.state_text, 'String', 'State: Too Close');
        elseif rightHandDepth <700
            rightHandBorder = [rightHand(:,:,nearestHand)-80 160 160];
            rectangle('position', rightHandBorder, 'EdgeColor', 'g', 'LineWidth', 3);
            set(handles.state_text, 'String', 'State: Analyzing');
            snapshotCounter = snapshotCounter + 1; % increase snapshotCounter when within threshold
        end
        
        % Show output_text as Analyzing
        if snapshotCounter == 2
            set(handles.output_text, 'String', '');
        end
        
        % Show output_text as correct/wrong or any alphabets detected in
        % FREE MODE.
        if snapshotCounter == 3
            inputImage = imcrop(depthMap, [rightHand(:,:,nearestHand)-80 160 160]);
            S = ASL_recognition_v1(rightHandState, inputImage);
            % Reset snapshotCounter
            snapshotCounter = 0;
            if strcmp(str{val},'FREE MODE')
                set(handles.output_text, 'String', S);
            else
                viewer = 0;
            end
            close;
        end
    
    end
end
stop(depthVid);

switch str{val}
    case 'A'
        if S == 'A'
            set(handles.output_text, 'String', 'Correct');
        else
            set(handles.output_text, 'String', 'Wrong');
        end
    case 'B'
        if S == 'B'
            set(handles.output_text, 'String', 'Correct');
        else
            set(handles.output_text, 'String', 'Wrong');
        end
    case 'C'
        if S == 'C'
            set(handles.output_text, 'String', 'Correct');
        else
            set(handles.output_text, 'String', 'Wrong');
        end
    case 'D'
        if S == 'D'
            set(handles.output_text, 'String', 'Correct');
        else
            set(handles.output_text, 'String', 'Wrong');
        end
    case 'E'
        if S == 'E'
            set(handles.output_text, 'String', 'Correct');
        else
            set(handles.output_text, 'String', 'Wrong');
        end
    case 'F'
        if S == 'F'
            set(handles.output_text, 'String', 'Correct');
        else
            set(handles.output_text, 'String', 'Wrong');
        end
    case 'G'
        if S == 'G'
            set(handles.output_text, 'String', 'Correct');
        else
            set(handles.output_text, 'String', 'Wrong');
        end
    case 'H'
        if S == 'H'
            set(handles.output_text, 'String', 'Correct');
        else
            set(handles.output_text, 'String', 'Wrong');
        end
    case 'I'
        if S == 'I'
            set(handles.output_text, 'String', 'Correct');
        else
            set(handles.output_text, 'String', 'Wrong');
        end
    case 'K'
        if S == 'K'
            set(handles.output_text, 'String', 'Correct');
        else
            set(handles.output_text, 'String', 'Wrong');
        end
    case 'L'
        if S == 'L'
            set(handles.output_text, 'String', 'Correct');
        else
            set(handles.output_text, 'String', 'Wrong');
        end
    case 'M'
        if S == 'M'
            set(handles.output_text, 'String', 'Correct');
        else
            set(handles.output_text, 'String', 'Wrong');
        end
    case 'N'
        if S == 'N'
            set(handles.output_text, 'String', 'Correct');
        else
            set(handles.output_text, 'String', 'Wrong');
        end
    case 'O'
        if S == 'O'
            set(handles.output_text, 'String', 'Correct');
        else
            set(handles.output_text, 'String', 'Wrong');
        end
    case 'P'
        if S == 'P'
            set(handles.output_text, 'String', 'Correct');
        else
            set(handles.output_text, 'String', 'Wrong');
        end
    case 'Q'
        if S == 'Q'
            set(handles.output_text, 'String', 'Correct');
        else
            set(handles.output_text, 'String', 'Wrong');
        end
    case 'R'
        if S == 'R'
            set(handles.output_text, 'String', 'Correct');
        else
            set(handles.output_text, 'String', 'Wrong');
        end
    case 'S'
        if S == 'S'
            set(handles.output_text, 'String', 'Correct');
        else
            set(handles.output_text, 'String', 'Wrong');
        end
    case 'T'
        if S == 'T'
            set(handles.output_text, 'String', 'Correct');
        else
            set(handles.output_text, 'String', 'Wrong');
        end
    case 'U'
        if S == 'U'
            set(handles.output_text, 'String', 'Correct');
        else
            set(handles.output_text, 'String', 'Wrong');
        end
    case 'V'
        if S == 'V'
            set(handles.output_text, 'String', 'Correct');
        else
            set(handles.output_text, 'String', 'Wrong');
        end
    case 'W'
        if S == 'W'
            set(handles.output_text, 'String', 'Correct');
        else
            set(handles.output_text, 'String', 'Wrong');
        end
    case 'X'
        if S == 'X'
            set(handles.output_text, 'String', 'Correct');
        else
            set(handles.output_text, 'String', 'Wrong');
        end
    case 'Y'
        if S == 'Y'
            set(handles.output_text, 'String', 'Correct');
        else
            set(handles.output_text, 'String', 'Wrong');
        end
end



% --- Executes when user attempts to close ASL_Recognition_System.
function kinect_gui_CloseRequestFcn(hObject, eventdata, handles)
% hObject    handle to ASL_Recognition_System (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: delete(hObject) closes the figure
delete(hObject);


% --- Executes on button press in stop_pushbutton.
function stop_pushbutton_Callback(hObject, eventdata, handles)
% hObject    handle to stop_pushbutton (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global viewer;
viewer = 0;
