function varargout = TesisInterfaz(varargin)
% TESISINTERFAZ MATLAB code for TesisInterfaz.fig
%      TESISINTERFAZ, by itself, creates a new TESISINTERFAZ or raises the existing
%      singleton*.
%
%      H = TESISINTERFAZ returns the handle to a new TESISINTERFAZ or the handle to
%      the existing singleton*.
%
%      TESISINTERFAZ('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in TESISINTERFAZ.M with the given input arguments.
%
%      TESISINTERFAZ('Property','Value',...) creates a new TESISINTERFAZ or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before TesisInterfaz_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to TesisInterfaz_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help TesisInterfaz

% Last Modified by GUIDE v2.5 05-Jul-2019 16:18:25

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @TesisInterfaz_OpeningFcn, ...
                   'gui_OutputFcn',  @TesisInterfaz_OutputFcn, ...
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


% --- Executes just before TesisInterfaz is made visible.
function TesisInterfaz_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to TesisInterfaz (see VARARGIN)

% Choose default command line output for TesisInterfaz
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes TesisInterfaz wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = TesisInterfaz_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in ExtractFeat.
function ExtractFeat_Callback(hObject, eventdata, handles)
% hObject    handle to ExtractFeat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global M2 M3
M3 = extractFeatures(M2);
set(handles.normalize,'Enable','On');

% --- Executes on button press in DWtfeatures.
function DWtfeatures_Callback(hObject, eventdata, handles)
% hObject    handle to DWtfeatures (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global M2 M4
M4 = extractDWTfeatures(M2);
set(handles.normalize,'Enable','On');

% --- Executes on button press in normalize.
function normalize_Callback(hObject, eventdata, handles)
% hObject    handle to normalize (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global M3 M4 X
normF = get(handles.normfeat,'Value');
DWTF = get(handles.DWTfeat,'Value');
if (normF ==1 && DWTF==1)
    X = normalize(M3,M4);
elseif (normF ==1 && DWTF==0)
    X = normalize(M3,[]);
elseif (normF ==0 && DWTF==1)
    X = normalize([],M4);
else
    msgbox('You need to chose at least one opcion');
end
set(handles.normfeat,'Value',0);
set(handles.DWTfeat,'Value',0);
set(handles.AddSelFeat,'Enable','On');

% --- Executes on button press in normfeat.
function normfeat_Callback(hObject, eventdata, handles)
% hObject    handle to normfeat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of normfeat


% --- Executes on button press in DWTfeat.
function DWTfeat_Callback(hObject, eventdata, handles)
% hObject    handle to DWTfeat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of DWTfeat


% --- Executes on button press in exit.
function exit_Callback(hObject, eventdata, handles)
% hObject    handle to exit (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
clc
close(handles.output);

% --- Executes on button press in load.
function load_Callback(hObject, eventdata, handles)
% hObject    handle to load (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName Path]=uigetfile({'*.csv'},'Abrir Documento');
global M2 y 
[M2,y] = loadData(FileName,Path);
set(handles.ExtractFeat,'Enable','On');
set(handles.DWtfeatures,'Enable','On');

% --- Executes on button press in about.
function about_Callback(hObject, eventdata, handles)
% hObject    handle to about (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
msg='The epilepsy disorder occurs when the localized electrical activity of neurons suffers from an imbalance. Epilepsy has become the third most common neurological disorder after stroke and dementia -it is believed that affects 0.5 - 1.5% of the world population. It mainly affects children under 10 and people over 65, being more common in developing countries and in disadvantaged socioeconomic classes. It is possible to diagnose is via the analysis of electroencephalographic (EEG) signals. Nowadays, since both its appropriate diagnosis and the accurate epileptic source localization must be fulfilled, computational systems are used to support the diagnosis procedure. Broadly, such systems perform the automatic diagnostic-assistance into four main stages, namely: EEG signal acquisition, preprocessing, characterization and classification. Once acquired and preprocessed, EEG signals must be properly represented to be subsequently classified into diagnostic categories (absence or any level of presence of seizure activity). Despite there exists a wide range of alternatives to characterize and classify EEG signals for epilepsy analysis purposes, many key aspects related to the accuracy, computational cost, and physiological interpretation are still considered as open issues. In this connection, in this work, an exploratory study of EEG signal processing techniques is proposed, aimed at identifying the most adequate state-of-the-art techniques for characterizing and classifying epileptic seizures. To do so, a comparative study is designed and developed between four classifiers: Linear discriminant analysis classifier (LDC), Quadratic discriminant analysis clasifier (QDC), k-nearest neighbor (kNN) and Support vector machine (SVM). It is including an exhaustive experimental setup with the dataset “Epileptic Seizure Recognition Data Set”.';
helpdlg(msg,'About');
% --- Executes on button press in manual.
function manual_Callback(hObject, eventdata, handles)
% hObject    handle to manual (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in classify.
function classify_Callback(hObject, eventdata, handles)
% hObject    handle to classify (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global features X y CP_total1 res1 CP_total2 res2 
global CP_total3 res3 CP_total4 res4 CP_total5 res5
global A1 Wldc1 Wqdc1 Wknn1 extraccionP1 SVMdata1
global A2 Wldc2 Wqdc2 Wknn2 extraccionP2 SVMdata2
global A3 Wldc3 Wqdc3 Wknn3 extraccionP3 SVMdata3
global A4 Wldc4 Wqdc4 Wknn4 extraccionP4 SVMdata4
global A5 Wldc5 Wqdc5 Wknn5 extraccionP5 SVMdata5
global error_table1 error_table2 error_table3 error_table4 error_table5
global SeSp_table1 SeSp_table2 SeSp_table3 SeSp_table4 SeSp_table5
global LDCconf1 QDCconf1 KNNconf1 SVMconf1
global LDCconf2 QDCconf2 KNNconf2 SVMconf2
global LDCconf3 QDCconf3 KNNconf3 SVMconf3
global LDCconf4 QDCconf4 KNNconf4 SVMconf4
global LDCconf5 QDCconf5 KNNconf5 SVMconf5
opSel = get(handles.experiments,'SelectedObject');
op = get(opSel,'String');
switch op
    case 'Ex1'
        T=table(X,y==1);
        writetable(T,'FeatNorm_2.csv');
        [CP_total1, res1, A1,Wldc1,Wqdc1,Wknn1,extraccionP1,SVMdata1,error_table1, SeSp_table1, LDCconf1, QDCconf1, KNNconf1, SVMconf1]=test_2classesClasf('FeatNorm_2.csv',features);
    case 'Ex2'
        pos = [];
        for i=1:length(y)
            if(y(i)>2)
                pos=[pos,i];
            end
        end
        X2=X;
        X2(pos,:)=[];
        y2=y;
        y2(pos)=[];
        T=table(X2,y2==1);
        writetable(T,'FeatNorm_2class_12.csv');
        [CP_total2, res2, A2,Wldc2,Wqdc2,Wknn2,extraccionP2,SVMdata2,error_table2,SeSp_table2, LDCconf2, QDCconf2, KNNconf2, SVMconf2]=test_2classesClasf('FeatNorm_2class_12.csv',features);
    case 'Ex3'
        y3=y;
        for i=1:length(y)
            if(y(i)>2)
                y3(i)=3;
            end
        end
        T=table(X,y3);
        writetable(T,'FeatNorm_3class_12.csv');
        [CP_total3, res3, A3, Wldc3, Wqdc3, Wknn3, extraccionP3, SVMdata3,error_table3,SeSp_table3, LDCconf3, QDCconf3, KNNconf3, SVMconf3]=test_3classesClasf('FeatNorm_3class_12.csv',features);
    case 'Ex4'
        pos = [];
        for i=1:length(y)
            if(y(i)>3)
                pos=[pos,i];
            end
        end
        X4=X;
        X4(pos,:)=[];
        y4=y;
        y4(pos)=[];
        T=table(X4,y4);
        writetable(T,'FeatNorm_3class_123.csv');
        [CP_total4, res4, A4, Wldc4, Wqdc4, Wknn4, extraccionP4, SVMdata4,error_table4,SeSp_table4, LDCconf4, QDCconf4, KNNconf4, SVMconf4]=test_3classesClasf('FeatNorm_3class_123.csv',features);
    case 'Ex5'
        y5 = y;
        for i=1:length(y5)
            if(y5(i)<3)
                y5(i)=1;
            elseif (y5(i)==3)
                y5(i)=2;
            else
                y5(i)=3;
            end
        end
        T=table(X,y5);
        writetable(T,'FeatNorm_3class_mix.csv');
        [CP_total5, res5, A5, Wldc5, Wqdc5, Wknn5, extraccionP5, SVMdata5,error_table5,SeSp_table5,LDCconf5, QDCconf5, KNNconf5, SVMconf5]=test_3classesClasf('FeatNorm_3class_mix.csv',features);
end
msgbox('Done','Message');
set(handles.genboxplot,'Enable','On');
set(handles.GenROC,'Enable','On');
set(handles.gentable1,'Enable','On');
set(handles.gentable2,'Enable','On');
set(handles.gentable3,'Enable','On');

% --- Executes on button press in AddSelFeat.
function AddSelFeat_Callback(hObject, eventdata, handles)
% hObject    handle to AddSelFeat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global features X X2
vector = get(handles.InsFeat, 'String');
if isempty(vector)
    errordlg('You must enter a vector of features','Message');
else
    try
        cV = strsplit(vector);
        features = [str2double(cell2mat(cV(1))) str2double(cell2mat(cV(2))) str2double(cell2mat(cV(3))) str2double(cell2mat(cV(4))) str2double(cell2mat(cV(5))) str2double(cell2mat(cV(6))) str2double(cell2mat(cV(7))) str2double(cell2mat(cV(8))) str2double(cell2mat(cV(9)))];
        X2=X(:,features);
    catch
        errordlg('You are no using blank spaces or is not a vector of 9 elements','Message');
    end
end
set(handles.InsFeat, 'String','');
set(handles.PlotFeat,'Enable','On');
set(handles.classify,'Enable','On');


function InsFeat_Callback(hObject, eventdata, handles)
% hObject    handle to InsFeat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of InsFeat as text
%        str2double(get(hObject,'String')) returns contents of InsFeat as a double


% --- Executes during object creation, after setting all properties.
function InsFeat_CreateFcn(hObject, eventdata, handles)
% hObject    handle to InsFeat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in PlotFeat.
function PlotFeat_Callback(hObject, eventdata, handles)
% hObject    handle to PlotFeat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global X2 y
v1str = get(handles.xVec,'String');
v2str = get(handles.yVec,'String');
v3str = get(handles.zVec,'String');

if isempty(v1str) || isempty(v2str) || isempty(v3str)
    warndlg('None fields can be empty','Message');
elseif (v1str == v2str)
    warndlg('x and y cannot be equals','Message');
elseif (v1str == v3str)
    warndlg('x and z cannot be equals','Message');
elseif (v3str == v2str)
    warndlg('y and z cannot be equals','Message');
else
    try
        v1 = str2double(v1str);
        v2 = str2double(v2str);
        v3 = str2double(v3str);
        scatter3(X2(:,v1),X2(:,v2),X2(:,v3),5,y);
    catch
        errordlg('The fields must have only integer numbers')
    end
    
end
set(handles.xVec,'String','');
set(handles.yVec,'String','');
set(handles.zVec,'String','');

function yVec_Callback(hObject, eventdata, handles)
% hObject    handle to yVec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of yVec as text
%        str2double(get(hObject,'String')) returns contents of yVec as a double


% --- Executes during object creation, after setting all properties.
function yVec_CreateFcn(hObject, eventdata, handles)
% hObject    handle to yVec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function zVec_Callback(hObject, eventdata, handles)
% hObject    handle to zVec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of zVec as text
%        str2double(get(hObject,'String')) returns contents of zVec as a double


% --- Executes during object creation, after setting all properties.
function zVec_CreateFcn(hObject, eventdata, handles)
% hObject    handle to zVec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in GenROC.
function GenROC_Callback(hObject, eventdata, handles)
% hObject    handle to GenROC (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global A1 Wldc1 Wqdc1 Wknn1 extraccionP1 SVMdata1
global A2 Wldc2 Wqdc2 Wknn2 extraccionP2 SVMdata2
global A3 Wldc3 Wqdc3 Wknn3 extraccionP3 SVMdata3
global A4 Wldc4 Wqdc4 Wknn4 extraccionP4 SVMdata4
global A5 Wldc5 Wqdc5 Wknn5 extraccionP5 SVMdata5
opSelExp = get(handles.rocExp,'SelectedObject');
opExp = get(opSelExp,'String');
opSelClas = get(handles.classes,'SelectedObject');
opClas = get(opSelClas,'String');
if (strcmp(opExp,'Ex1') && strcmp(opClas,'Class 1'))
    [~,scoresSVM] = predict(SVMdata1,extraccionP1(:,1:9));
    [X1,Y1]=perfcurve(extraccionP1(:,10),scoresSVM(:,2),1);
    Eldc = prroc(A1,Wldc1,2,100);
    Eqdc = prroc(A1,Wqdc1,2,100);
    Eknn = prroc(A1,Wknn1,2,100);
    cla(handles.axes3,'reset');
    axes(handles.axes3);
    hold on
    plot(Eldc.xvalues, 1-Eldc.error);
    plot(Eqdc.xvalues, 1-Eqdc.error);
    plot(Eknn.xvalues, 1-Eknn.error);   
    plot(X1,Y1);
    legend('LDC','QDC','k-NN','SVM','Location','Best')
    xlabel('False positive rate'); ylabel('True positive rate');
    hold off
elseif (strcmp(opExp,'Ex2') && strcmp(opClas,'Class 1'))
    [~,scoresSVM] = predict(SVMdata2,extraccionP2(:,1:9));
    [X1,Y1]=perfcurve(extraccionP2(:,10),scoresSVM(:,2),1);
    Eldc = prroc(A2,Wldc2,2,100);
    Eqdc = prroc(A2,Wqdc2,2,100);
    Eknn = prroc(A2,Wknn2,2,100);
    cla(handles.axes3,'reset');
    axes(handles.axes3);
    hold on
    plot(Eldc.xvalues, 1-Eldc.error)
    plot(Eqdc.xvalues, 1-Eqdc.error)
    plot(Eknn.xvalues, 1-Eknn.error)    
    plot(X1,Y1);
    legend('LDC','QDC','k-NN','SVM','Location','Best')
    xlabel('False positive rate'); ylabel('True positive rate');
    hold off
elseif (strcmp(opExp,'Ex2') && strcmp(opClas,'Class 2'))
    [~,scoresSVM] = predict(SVMdata2,extraccionP2(:,1:9));
    [X1,Y1]=perfcurve(extraccionP2(:,10),scoresSVM(:,1),0);
    Eldc = prroc(A2,Wldc2,1,100);
    Eqdc = prroc(A2,Wqdc2,1,100);
    Eknn = prroc(A2,Wknn2,1,100);
    cla(handles.axes3,'reset');
    axes(handles.axes3);
    hold on
    plot(Eldc.xvalues, 1-Eldc.error)
    plot(Eqdc.xvalues, 1-Eqdc.error)
    plot(Eknn.xvalues, 1-Eknn.error)    
    plot(X1,Y1);
    legend('LDC','QDC','k-NN','SVM','Location','Best')
    xlabel('False positive rate'); ylabel('True positive rate');
    hold off
elseif (strcmp(opExp,'Ex3') && strcmp(opClas,'Class 1'))
    [~,scoresSVM] = predict(SVMdata3,extraccionP3(:,1:9));
    [X1,Y1]=perfcurve(extraccionP3(:,10),scoresSVM(:,1),1);
    Eldc = prroc(A3,Wldc3,1,100);
    Eqdc = prroc(A3,Wqdc3,1,100);
    Eknn = prroc(A3,Wknn3,1,100);
    cla(handles.axes3,'reset');
    axes(handles.axes3);
    hold on
    plot(Eldc.xvalues, 1-Eldc.error)
    plot(Eqdc.xvalues, 1-Eqdc.error)
    plot(Eknn.xvalues, 1-Eknn.error)    
    plot(X1,Y1);
    legend('LDC','QDC','k-NN','SVM','Location','Best')
    xlabel('False positive rate'); ylabel('True positive rate');
    hold off
elseif (strcmp(opExp,'Ex3') && strcmp(opClas,'Class 2'))
    [~,scoresSVM] = predict(SVMdata3,extraccionP3(:,1:9));
    [X1,Y1]=perfcurve(extraccionP3(:,10),scoresSVM(:,2),2);
    Eldc = prroc(A3,Wldc3,2,100);
    Eqdc = prroc(A3,Wqdc3,2,100);
    Eknn = prroc(A3,Wknn3,2,100);
    cla(handles.axes3,'reset');
    axes(handles.axes3);
    hold on
    plot(Eldc.xvalues, 1-Eldc.error)
    plot(Eqdc.xvalues, 1-Eqdc.error)
    plot(Eknn.xvalues, 1-Eknn.error)    
    plot(X1,Y1);
    legend('LDC','QDC','k-NN','SVM','Location','Best')
    xlabel('False positive rate'); ylabel('True positive rate');
    hold off
elseif (strcmp(opExp,'Ex4') && strcmp(opClas,'Class 1'))
    [~,scoresSVM] = predict(SVMdata4,extraccionP4(:,1:9));
    [X1,Y1]=perfcurve(extraccionP4(:,10),scoresSVM(:,1),1);
    Eldc = prroc(A4,Wldc4,1,100);
    Eqdc = prroc(A4,Wqdc4,1,100);
    Eknn = prroc(A4,Wknn4,1,100);
    cla(handles.axes3,'reset');
    axes(handles.axes3);
    hold on
    plot(Eldc.xvalues, 1-Eldc.error)
    plot(Eqdc.xvalues, 1-Eqdc.error)
    plot(Eknn.xvalues, 1-Eknn.error)    
    plot(X1,Y1);
    legend('LDC','QDC','k-NN','SVM','Location','Best')
    xlabel('False positive rate'); ylabel('True positive rate');
    hold off
elseif (strcmp(opExp,'Ex4') && strcmp(opClas,'Class 2'))
    [~,scoresSVM] = predict(SVMdata4,extraccionP4(:,1:9));
    [X1,Y1]=perfcurve(extraccionP4(:,10),scoresSVM(:,2),2);
    Eldc = prroc(A4,Wldc4,2,100);
    Eqdc = prroc(A4,Wqdc4,2,100);
    Eknn = prroc(A4,Wknn4,2,100);
    cla(handles.axes3,'reset');
    axes(handles.axes3);
    hold on
    plot(Eldc.xvalues, 1-Eldc.error)
    plot(Eqdc.xvalues, 1-Eqdc.error)
    plot(Eknn.xvalues, 1-Eknn.error)    
    plot(X1,Y1);
    legend('LDC','QDC','k-NN','SVM','Location','Best')
    xlabel('False positive rate'); ylabel('True positive rate');
    hold off
elseif (strcmp(opExp,'Ex4') && strcmp(opClas,'Class 3'))
    [~,scoresSVM] = predict(SVMdata4,extraccionP4(:,1:9));
    [X1,Y1]=perfcurve(extraccionP4(:,10),scoresSVM(:,3),3);
    Eldc = prroc(A4,Wldc4,3,100);
    Eqdc = prroc(A4,Wqdc4,3,100);
    Eknn = prroc(A4,Wknn4,3,100);
    cla(handles.axes3,'reset');
    axes(handles.axes3);
    hold on
    plot(Eldc.xvalues, 1-Eldc.error)
    plot(Eqdc.xvalues, 1-Eqdc.error)
    plot(Eknn.xvalues, 1-Eknn.error)    
    plot(X1,Y1);
    legend('LDC','QDC','k-NN','SVM','Location','Best')
    xlabel('False positive rate'); ylabel('True positive rate');
    hold off
elseif (strcmp(opExp,'Ex5') && strcmp(opClas,'Class 1'))
    [~,scoresSVM] = predict(SVMdata5,extraccionP5(:,1:9));
    [X1,Y1]=perfcurve(extraccionP5(:,10),scoresSVM(:,1),1);
    Eldc = prroc(A5,Wldc5,1,100);
    Eqdc = prroc(A5,Wqdc5,1,100);
    Eknn = prroc(A5,Wknn5,1,100);
    cla(handles.axes3,'reset');
    axes(handles.axes3);
    hold on
    plot(Eldc.xvalues, 1-Eldc.error)
    plot(Eqdc.xvalues, 1-Eqdc.error)
    plot(Eknn.xvalues, 1-Eknn.error)    
    plot(X1,Y1);
    legend('LDC','QDC','k-NN','SVM','Location','Best')
    xlabel('False positive rate'); ylabel('True positive rate');
    hold off
elseif (strcmp(opExp,'Ex5') && strcmp(opClas,'Class 2'))
    [~,scoresSVM] = predict(SVMdata5,extraccionP5(:,1:9));
    [X1,Y1]=perfcurve(extraccionP5(:,10),scoresSVM(:,2),2);
    Eldc = prroc(A5,Wldc5,2,100);
    Eqdc = prroc(A5,Wqdc5,2,100);
    Eknn = prroc(A5,Wknn5,2,100);
    cla(handles.axes3,'reset');
    axes(handles.axes3);
    hold on
    plot(Eldc.xvalues, 1-Eldc.error)
    plot(Eqdc.xvalues, 1-Eqdc.error)
    plot(Eknn.xvalues, 1-Eknn.error)    
    plot(X1,Y1);
    legend('LDC','QDC','k-NN','SVM','Location','Best')
    xlabel('False positive rate'); ylabel('True positive rate');
    hold off
end


% --- Executes on button press in genboxplot.
function genboxplot_Callback(hObject, eventdata, handles)
% hObject    handle to genboxplot (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global CP_total1 res1 CP_total2 res2 CP_total3 res3 CP_total4 res4 CP_total5 res5
opSel = get(handles.boxExp,'SelectedObject');
op = get(opSel,'String');
switch op
    case 'Ex1'
        boxplot([CP_total1*100 res1*100])
        ylim([85 100])
    case 'Ex2'
        boxplot([CP_total2*100 res2*100])
        ylim([80 100])
    case 'Ex3'
        boxplot([CP_total3*100 res3*100])
        ylim([60 100])
    case 'Ex4'
        boxplot([CP_total4*100 res4*100])
        ylim([60 100])
    case 'Ex5'
        boxplot([CP_total5*100 res5*100])
        ylim([60 100])
end

% --- Executes on button press in gentable2.
function gentable2_Callback(hObject, eventdata, handles)
% hObject    handle to gentable2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global SeSp_table1 SeSp_table2 SeSp_table3 SeSp_table4 SeSp_table5
opSel = get(handles.SeSpExp,'SelectedObject');
op = get(opSel,'String');
switch op
    case 'Ex1'
        set(handles.showTables,'ColumnWidth',{160,160,160});
        set(handles.showTables,'FontSize',19);
        set(handles.showTables,'Data',SeSp_table1);
    case 'Ex2'
        set(handles.showTables,'ColumnWidth',{160,160,160});
        set(handles.showTables,'FontSize',19);
        set(handles.showTables,'Data',SeSp_table2);
    case 'Ex3'
        set(handles.showTables,'ColumnWidth',{105,95,95,95,95,95});
        set(handles.showTables,'FontSize',16);
        set(handles.showTables,'Data',SeSp_table3(:,1:5));
    case 'Ex4'
        set(handles.showTables,'ColumnWidth',{90,'auto','auto','auto','auto','auto'});
        set(handles.showTables,'FontSize',14);
        set(handles.showTables,'Data',SeSp_table4);
    case 'Ex5'
        set(handles.showTables,'FontSize',16);
        set(handles.showTables,'ColumnWidth',{105,95,95,95,95,95});
        set(handles.showTables,'Data',SeSp_table5(:,1:5));
end

% --- Executes on button press in gentable1.
function gentable1_Callback(hObject, eventdata, handles)
% hObject    handle to gentable1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global error_table1 error_table2 error_table3 error_table4 error_table5
opSel = get(handles.MeanStdExp,'SelectedObject');
op = get(opSel,'String');
set(handles.showTables,'ColumnWidth',{120,120,240});
set(handles.showTables,'FontSize',19);
switch op
    case 'Ex1'
        set(handles.showTables,'Data',error_table1);
    case 'Ex2'
        set(handles.showTables,'Data',error_table2);
    case 'Ex3'
        set(handles.showTables,'Data',error_table3);
    case 'Ex4'
        set(handles.showTables,'Data',error_table4);
    case 'Ex5'
        set(handles.showTables,'Data',error_table5);
end


function xVec_Callback(hObject, eventdata, handles)
% hObject    handle to xVec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of xVec as text
%        str2double(get(hObject,'String')) returns contents of xVec as a double


% --- Executes during object creation, after setting all properties.
function xVec_CreateFcn(hObject, eventdata, handles)
% hObject    handle to xVec (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes when selected object is changed in rocExp.
function rocExp_SelectionChangedFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in rocExp 
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
opSelExp = get(handles.rocExp,'SelectedObject');
opExp = get(opSelExp,'String');
switch opExp
    case 'Ex1'
        set(handles.class3,'Enable','Off');
        set(handles.class1,'Enable','On');
        set(handles.class2,'Enable','Off');
    case 'Ex2'
        set(handles.class1,'Enable','On');
        set(handles.class2,'Enable','On');
        set(handles.class3,'Enable','Of');
    case 'Ex3'
        set(handles.class1,'Enable','On');
        set(handles.class2,'Enable','On');
        set(handles.class3,'Enable','Off');
    case 'Ex4'
        set(handles.class1,'Enable','On');
        set(handles.class2,'Enable','On');
        set(handles.class3,'Enable','On');
    case 'Ex5'
        set(handles.class1,'Enable','On');
        set(handles.class2,'Enable','On');
        set(handles.class3,'Enable','Off');
end


% --- Executes on button press in gentable3.
function gentable3_Callback(hObject, eventdata, handles)
% hObject    handle to gentable3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global LDCconf1 QDCconf1 KNNconf1 SVMconf1
global LDCconf2 QDCconf2 KNNconf2 SVMconf2
global LDCconf3 QDCconf3 KNNconf3 SVMconf3
global LDCconf4 QDCconf4 KNNconf4 SVMconf4
global LDCconf5 QDCconf5 KNNconf5 SVMconf5
opSelExp = get(handles.confExp,'SelectedObject');
opExp = get(opSelExp,'String');
opSelClas = get(handles.classifiers,'SelectedObject');
opClas = get(opSelClas,'String');
if(strcmp(opExp,'Ex1') || strcmp(opExp,'Ex2'))
    set(handles.showTables,'ColumnWidth',{242,242});
    set(handles.showTables,'FontSize',52);
elseif(strcmp(opExp,'Ex3') || strcmp(opExp,'Ex4') || strcmp(opExp,'Ex5'))
    set(handles.showTables,'ColumnWidth',{161,161,161});
    set(handles.showTables,'FontSize',34);
end
if (strcmp(opExp,'Ex1') && strcmp(opClas,'LDC'))
    set(handles.showTables,'Data',LDCconf1);
elseif (strcmp(opExp,'Ex1') && strcmp(opClas,'QDC'))
    set(handles.showTables,'Data',QDCconf1);
elseif (strcmp(opExp,'Ex1') && strcmp(opClas,'kNN'))
    set(handles.showTables,'Data',KNNconf1);
elseif (strcmp(opExp,'Ex1') && strcmp(opClas,'SVM'))
    set(handles.showTables,'Data',SVMconf1);
elseif (strcmp(opExp,'Ex2') && strcmp(opClas,'LDC'))
    set(handles.showTables,'Data',LDCconf2);
elseif (strcmp(opExp,'Ex2') && strcmp(opClas,'QDC'))
    set(handles.showTables,'Data',QDCconf2);
elseif (strcmp(opExp,'Ex2') && strcmp(opClas,'kNN'))
    set(handles.showTables,'Data',KNNconf2);
elseif (strcmp(opExp,'Ex2') && strcmp(opClas,'SVM'))
    set(handles.showTables,'Data',SVMconf2);
elseif (strcmp(opExp,'Ex3') && strcmp(opClas,'LDC'))
    set(handles.showTables,'Data',LDCconf3);
elseif (strcmp(opExp,'Ex3') && strcmp(opClas,'QDC'))
    set(handles.showTables,'Data',QDCconf3);
elseif (strcmp(opExp,'Ex3') && strcmp(opClas,'kNN'))
    set(handles.showTables,'Data',KNNconf3);
elseif (strcmp(opExp,'Ex3') && strcmp(opClas,'SVM'))
    set(handles.showTables,'Data',SVMconf3);
elseif (strcmp(opExp,'Ex4') && strcmp(opClas,'LDC'))
    set(handles.showTables,'Data',LDCconf4);
elseif (strcmp(opExp,'Ex4') && strcmp(opClas,'QDC'))
    set(handles.showTables,'Data',QDCconf4);
elseif (strcmp(opExp,'Ex4') && strcmp(opClas,'kNN'))
    set(handles.showTables,'Data',KNNconf4);
elseif (strcmp(opExp,'Ex4') && strcmp(opClas,'SVM'))
    set(handles.showTables,'Data',SVMconf4);
elseif (strcmp(opExp,'Ex5') && strcmp(opClas,'LDC'))
    set(handles.showTables,'Data',LDCconf5);
elseif (strcmp(opExp,'Ex5') && strcmp(opClas,'QDC'))
    set(handles.showTables,'Data',QDCconf5);
elseif (strcmp(opExp,'Ex5') && strcmp(opClas,'kNN'))
    set(handles.showTables,'Data',KNNconf5);
elseif (strcmp(opExp,'Ex5') && strcmp(opClas,'SVM'))
    set(handles.showTables,'Data',SVMconf5);
end
