function varargout = Interface(varargin)
% INTERFACE MATLAB code for Interface.fig
%      INTERFACE, by itself, creates a new INTERFACE or raises the existing
%      singleton*.
%
%      H = INTERFACE returns the handle to a new INTERFACE or the handle to
%      the existing singleton*.
%
%      INTERFACE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in INTERFACE.M with the given input arguments.
%
%      INTERFACE('Property','Value',...) creates a new INTERFACE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Interface_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Interface_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Interface


% Last Modified by GUIDE v2.5 06-Jan-2022 16:59:19

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Interface_OpeningFcn, ...
                   'gui_OutputFcn',  @Interface_OutputFcn, ...
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


% --- Executes just before Interface is made visible.
function Interface_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Interface (see VARARGIN)

% dataset 1 : 
% fech=10000;
% fo=3000;
global fech;
global fo;
fech=input("Définissez fech : ");
fo=input("Définissez fo : ");



Nombre_point=1000;
var_bruit=1;

%Te=1/fech;
abscisse=0:1:Nombre_point-1;
bruit = randn(1,Nombre_point)*var_bruit;
signal=cos(2*pi*(fo/fech)*abscisse)+bruit;
handles.Cosinus=signal;
% dataset 2 : 
bruit = randn(1,Nombre_point)*var_bruit;
handles.BBGC=bruit;

% dataset 3 : 
% processus auto regressif d'ordre 2 : 
a=0.7;
b=0.3;
processusar=zeros(1,length(bruit));
processusma=zeros(1,length(bruit));
processusar(1)=randn(1,1)*var_bruit;
% simulation d'un processus auto regressif d'ordre 2 :
processusar(2)=randn(1,1)*var_bruit+a*processusar(1);
for k=3:length(bruit)
    processusar(k)=a*processusar(k-1)+b*processusar(k-2)+randn(1,1);
end
% simulation d'un processus à moyenne ajustée d'ordre 2 : 
processusma(1)=bruit(1);
processusma(2)=bruit(2)+a*processusma(1);
for i=3:length(bruit)
    processusma(i)=a*bruit(i-1)+bruit(i);
end

handles.PAR=processusar;
handles.PMA=processusma;
% dataset 4 : 



handles.currentData=handles.BBGC;
%plot(handles.currentData);
% Choose default command line output for Interface
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Interface wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Interface_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on selection change in fenetre.
function fenetre_Callback(hObject, eventdata, handles)
% hObject    handle to fenetre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 str = get(handles.fenetre,'String');
 val=get(handles.fenetre,'Value');
% 
 switch str{val}
     case 'Rectangulaire'
         handles.Rectangulaire=1;
         handles.Hamming=0;
         handles.Hanning=0;
         handles.Bertlatt=0;
         disp("Rectangulaire")
     case 'Hamming'
         handles.Rectangulaire=0;
         handles.Hamming=1;
         handles.Hanning=0;
         handles.Bertlatt=0;
         disp("Hamming")
     case 'Hanning'
         handles.Rectangulaire=0;
         handles.Hamming=0;
         handles.Hanning=1;
         handles.Bertlatt=0;
         disp("Hanning")
     case 'Bertlatt'
         handles.Rectangulaire=0;
         handles.Hamming=0;
         handles.Hanning=0;
         handles.Bertlatt=1;
         disp("Bertlatt");

 end

 guidata(hObject,handles);
% Hints: contents = cellstr(get(hObject,'String')) returns fenetre contents as cell array
%        contents{get(hObject,'Value')} returns selected item from fenetre


% --- Executes during object creation, after setting all properties.
function fenetre_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fenetre (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in periodogramme_welch.
function periodogramme_welch_Callback(hObject, eventdata, handles)
% hObject    handle to periodogramme_welch (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp("Periodogramme Welch")
strcheck = get(handles.checkbox1,'String');
valcheck=get(handles.checkbox1,'Value');
strfmin = get(handles.fmin,'String');
strfmax = get(handles.fmax,'String');
% strfech = get(handles.fech,'String');
% fech=str2num(strfech);
global fech;
global fo;
recouvrement=1;
taillewindows=length(handles.currentData)/10;
disp('taille windows :' + taillewindows)
Nfft = length(handles.currentData);
% permet d'ajouter le padding nÃ©cessaire pour avoir une puissance de 2 
if (valcheck ==1)
    while ((log2(Nfft)-floor(log2(Nfft))) ~= 0)
         Nfft=Nfft+1;
         handles.currentData=[handles.currentData 0];
    end
    disp(Nfft);
end


%windows = transpose(hanning(length(signal)/4)); %fenêtre de hanning
%windows = transpose(bartlett(length(signal)/4));
if (handles.Rectangulaire ==1)
    windows=ones(1,taillewindows);
    disp("fenetre rectangle")
end
if (handles.Hamming ==1)
    windows = transpose(hamming(taillewindows)); %fenêtre de hamming
    disp("fenetre hamming");
end
if (handles.Hanning ==1)
    windows = transpose(hanning(taillewindows));
    disp("fenetre hanning");
end
if (handles.Bertlatt ==1)
    windows = transpose(bartlett(taillewindows));
    disp("fenetre bertlatt");
end

[periodogramme_welch, tabperio2]= Monnew_Welch(handles.currentData,Nfft,fech,windows,recouvrement);
abscisse=linspace(-fech/2,fech/2,Nfft);

plot(abscisse,periodogramme_welch);
xlim([str2num(strfmin) str2num(strfmax)]);
title("Periodogramme de Welch");



% --- Executes on button press in spectrogramme.
function spectrogramme_Callback(hObject, eventdata, handles)
% hObject    handle to spectrogramme (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see G
taillewindows=floor(length(handles.currentData)/4);
strcheck = get(handles.checkbox1,'String');
valcheck=get(handles.checkbox1,'Value');
strfmin = get(handles.fmin,'String');
strfmax = get(handles.fmax,'String');
% strfech = get(handles.fech,'String');
% fech=str2num(strfech);
global fech;
global fo;
if (handles.Rectangulaire ==1)
    windows=ones(1,taillewindows);
    disp("fenetre rectangle")
end
if (handles.Hamming ==1)
    windows = transpose(hamming(taillewindows)); %fenêtre de hamming
    disp("fenetre hamming");
end
if (handles.Hanning ==1)
    windows = transpose(hanning(taillewindows));
    disp("fenetre hanning");
end
if (handles.Bertlatt ==1)
    windows = transpose(bartlett(taillewindows));
    disp("fenetre bertlatt");
end
Nfft=length(handles.currentData);
if (valcheck ==1)
    while ((log2(Nfft)-floor(log2(Nfft))) ~= 0)
         Nfft=Nfft+1;
         handles.currentData=[handles.currentData 0];
    end
    disp(Nfft);
end

% while ((log2(Nfft)-floor(log2(Nfft))) ~= 0)
%     Nfft=Nfft+1;
%     handles.currentData=[handles.currentData 0];
%     
% end
%fenêtre rectangulaire
%windows = transpose(hamming(length(signal)/4)); %fenêtre de hamming
%windows = transpose(hanning(length(signal)/4)); %fenêtre de hanning
%windows = transpose(bartlett(length(signal)/4)); %fenêtre de bertlett (triangulaire)
[temps,frequence,spectro]=Mon_spectro(handles.currentData,Nfft,fech,windows,50);


imagesc(temps,frequence,transpose(spectro))
xlabel("temps (s)"),ylabel("Fréquence (Hz)"),title("Spectrogramme")
% xlim([handles.fmin handles])



% --- Executes on selection change in signaux.
function signaux_Callback(hObject, eventdata, handles)
% hObject    handle to signaux (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
 str = get(hObject,'String');
 val=get(hObject,'Value');
% 
 switch str{val}
     case 'BBGC'
         handles.currentData=handles.BBGC;
         disp("bruit blanc")
     case 'Cosinus'
         disp("on est dans le cos");
         handles.currentData=handles.Cosinus;
     case 'PAR'
         disp("on est dans le PAR");
         handles.currentData=handles.PAR;
     case 'PMA'
         disp("on est dans le PMA");
         handles.currentData=handles.PMA;

 end

 guidata(hObject,handles);
%     case 'Processus à moyenne ajustée'
%     case 'Processus AR'
% 

% Hints: contents = cellstr(get(hObject,'String')) returns signaux contents as cell array
%        contents{get(hObject,'Value')} returns selected item from signaux


% --- Executes during object creation, after setting all properties.
function signaux_CreateFcn(hObject, eventdata, handles)
% hObject    handle to signaux (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fmin_Callback(hObject, eventdata, handles)
% hObject    handle to fmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str = get(handles.fmin,'String');
 val=get(handles.fmin,'Value');
 disp("Valeur défini pour fmin : "+ str);
% Hints: get(hObject,'String') returns contents of fmin as text
%        str2double(get(hObject,'String')) returns contents of fmin as a double


% --- Executes during object creation, after setting all properties.
function fmin_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fmin (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fmax_Callback(hObject, eventdata, handles)
% hObject    handle to fmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
disp(handles.fmax);
str = get(handles.fmax,'String');
 val=get(handles.fmax,'Value');
 disp("valeur définie pour fmax : " + str);

% Hints: get(hObject,'String') returns contents of fmax as text
%        str2double(get(hObject,'String')) returns contents of fmax as a double


% --- Executes during object creation, after setting all properties.
function fmax_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fmax (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in periodoramme_daniel.
function periodoramme_daniel_Callback(hObject, eventdata, handles)
% hObject    handle to periodoramme_daniel (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
Nfft=length(handles.currentData);

taillewindows=10;
strcheck = get(handles.checkbox1,'String');
valcheck=get(handles.checkbox1,'Value');
strfmin = get(handles.fmin,'String');
strfmax = get(handles.fmax,'String');
strpuissance = get(handles.Puissance,'Value');

% strfech = get(handles.fech,'String');
% fech=str2num(strfech);
global fech;
global fo;
if (handles.Rectangulaire ==1)
    windows=ones(1,taillewindows);
    disp("fenetre rectangle")
end
if (handles.Hamming ==1)
    windows = transpose(hamming(taillewindows)); %fenêtre de hamming
    disp("fenetre hamming");
end
if (handles.Hanning ==1)
    windows = transpose(hanning(taillewindows));
    disp("fenetre hanning");
end
if (handles.Bertlatt ==1)
    windows = transpose(bartlett(taillewindows));
    disp("fenetre bertlatt");
end

if (valcheck ==1)
    while ((log2(Nfft)-floor(log2(Nfft))) ~= 0)
         Nfft=Nfft+1;
         handles.currentData=[handles.currentData 0];
    end
    disp(Nfft);
end
[periodogrammedaniel]=Periodogramme_daniel(handles.currentData,windows);
abscisse=linspace(-fech/2,fech/2,Nfft);
plot(abscisse,periodogrammedaniel);
title("Periodogramme de daniel");
xlabel("Frequence (Hz)");
xlim([str2num(strfmin) str2num(strfmax)]);

if(strpuissance==1)
power = method_trapeze(periodogrammedaniel,str2num(strfmin),str2num(strfmax),fech);
disp("La puissance est de " + power + " W ");
end



% --- Executes on button press in periodogramme_moyenne.
function periodogramme_moyenne_Callback(hObject, eventdata, handles)
% hObject    handle to periodogramme_moyenne (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
str = get(handles.signaux,'String');
 val=get(handles.signaux,'Value');
 strcheck = get(handles.checkbox1,'String');
valcheck=get(handles.checkbox1,'Value');
strfmin = get(handles.fmin,'String');
strfmax = get(handles.fmax,'String');
disp(valcheck)
global fech;
global fo;
% fech=10000;
% fo=1000;
Te=1/fech;
Nombre_point=length(handles.currentData);
if (valcheck ==1)
    while ((log2(Nombre_point)-floor(log2(Nombre_point))) ~= 0)
         Nombre_point=Nombre_point+1;
    end
    disp(Nombre_point);
end




abscisse=0:1:Nombre_point-1;
% 
var_bruit=1;
disp("str(val) : ")
disp(str(val));
 switch str{val}
     case 'BBGC'
        N_experience = 10;
        signals=zeros(Nombre_point,N_experience);
        for k=1:N_experience
           bruit = randn(Nombre_point,1)*var_bruit;
           signals(:,k)=bruit;
        end
        disp("bruit blanc")
     case 'Cosinus'
           N_experience = 10;
           signals=zeros(Nombre_point,N_experience);
           for k=1:N_experience
                bruit = randn(Nombre_point,1)*var_bruit;
                signals(:,k)=cos(2*pi*(fo/fech).*abscisse(1,:)')+bruit;
           end
           disp("bruit blanc")
           disp("on est dans le cos");
     case 'PAR'
           N_experience = 10;
           
           signals=zeros(Nombre_point,N_experience);
           for i=1:N_experience
               bruit = randn(Nombre_point,1)*var_bruit;
               a=0.7;
               b=0.3;
               processusar=zeros(1,length(bruit));
               
               processusar(1)=randn(1,1)*var_bruit;
                % simulation d'un processus auto regressif d'ordre 2 :
               processusar(2)=randn(1,1)*var_bruit+a*processusar(1);
               for k=3:length(bruit)
                    processusar(k)=a*processusar(k-1)+b*processusar(k-2)+randn(1,1);
               end
               signals(:,i)=processusar;
           end
      case 'PMA'
           N_experience = 10;
           
           signals=zeros(Nombre_point,N_experience);
           for i=1:N_experience
               bruit = randn(Nombre_point,1)*var_bruit;
               a=0.7;
               b=0.3;
               processusma=zeros(1,length(bruit));
               
               processusma(1)=bruit(1);
               processusma(2)=bruit(2)+a*processusma(1);
               for i=3:length(bruit)
                    processusma(i)=a*bruit(i-1)+bruit(i);
                end
               signals(:,i)=processusma;
           end


 end

% periodogramme moyenné :
[periodogrammemoyenne,tabperio]=periodogramme_moyenne(signals);
Nombre_point=length(periodogrammemoyenne);
abscisse=linspace(-fech/2,fech/2,Nombre_point);
plot(abscisse,periodogrammemoyenne);
xlim([str2num(strfmin) str2num(strfmax)]);
if (valcheck ~=1)
title("Periodogramme moyenné sur 10 réalisations");
end
if (valcheck ==1)
title("Periodogramme moyenné sur 10 réalisations avec zero padding");
end


% --- Executes during object creation, after setting all properties.
function axes1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to axes1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: place code in OpeningFcn to populate axes1


% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% Hint: get(hObject,'Value') returns toggle state of checkbox1


% --- Executes on button press in Signal.
function Signal_Callback(hObject, eventdata, handles)
% hObject    handle to Signal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% strfech = get(handles.fech,'String');
% fe=str2num(strfech);
global fech;
global fo;
Te=1/fech;
abscisse=linspace(0,10000*Te,length(handles.currentData));
plot(abscisse,handles.currentData);
title("Représentation du signal sélectionné");
xlabel("Temps(s)");



function fech_Callback(hObject, eventdata, handles)
% hObject    handle to fech (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fech as text
%        str2double(get(hObject,'String')) returns contents of fech as a double
disp(handles.fech);
str = get(handles.fech,'String');
 val=get(handles.fech,'Value');
 disp("Valeur définie pour fech : " + str);


% --- Executes during object creation, after setting all properties.
function fech_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fech (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function fo_Callback(hObject, eventdata, handles)
% hObject    handle to fo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of fo as text
%        str2double(get(hObject,'String')) returns contents of fo as a double
disp(handles.fo);
str = get(handles.fo,'String');
 val=get(handles.fo,'Value');
 disp("Valeur définie pour fo : " + str);


% --- Executes during object creation, after setting all properties.
function fo_CreateFcn(hObject, eventdata, handles)
% hObject    handle to fo (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in Signal.
function Capon_Callback(hObject, eventdata, handles)
% hObject    handle to Signal (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
global fech;
strfmin = get(handles.fmin,'String');
strfmax = get(handles.fmax,'String');
valcheck=get(handles.checkbox1,'Value');
Nombre_point=length(handles.currentData);
if (valcheck ==1)
    while ((log2(Nombre_point)-floor(log2(Nombre_point))) ~= 0)
         Nombre_point=Nombre_point+1;
    end
    disp(Nombre_point);
end
abscisse=linspace(-fech/2,fech/2,Nombre_point);
[P]= capon(handles.currentData, abscisse, fech);
plot(abscisse,abs(P)),title("Méthode de Capon");

xlim([str2num(strfmin) str2num(strfmax)]);
xlabel("Frequence(Hz)");

% --- Executes on button press in pushbutton10.
function Puissance_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.Puissance=1;
