clc 
clear all
close all

%% Projet filtre et estimations : 

Nombre_point=1000;
var_bruit=3;
fech=10000;
fo=4500;
Te=1/fech;
abscisse=0:1:Nombre_point-1;
bruit = randn(1,Nombre_point)*var_bruit;

signal=cos(2*pi*(fo/fech)*abscisse)+bruit;
signal_capon=cos(2*pi*(fo/fech)*abscisse)+bruit;

% definition processus auto-regressif 
c=rand(1);
signal_auto_regressif=zeros(1,Nombre_point);
for k=2:Nombre_point
    signal_auto_regressif(k)=signal_auto_regressif(k-1)+bruit(k);
end

% figure;
% plot(abscisse, signal_auto_regressif)
% title("processus autoregressif");

figure;
plot(abscisse,signal);
xlabel("echantillon");
title("signal sinusoidale");


%Fft : 
Nfft = Nombre_point;
signalnonpadde = signal;
% permet d'ajouter le padding nécessaire pour avoir une puissance de 2 
while ((log2(Nfft)-floor(log2(Nfft))) ~= 0)
    Nfft=Nfft+1;
    signal=[signal 0];
    signal_capon=[signal_capon 0];
    
end
% signal_padding = zeros(1,Nfft);
% for i=1:length(signal)
%     signal_padding(i) = signal(i);
% end

% fft : 
signal_f=abs(fftshift(fft(signal,Nfft)));
abscissef=-1/2:1/Nfft:(1/2-1/Nfft);
figure;
plot(abscissef,signal_f);
xlabel("Frequence (Hz)");
title("Fft");

% DSP : 
Dsp= (signal_f.^2)/Nombre_point;
figure;
plot(abscissef,Dsp);
title("Periodogramme simple");
xlabel("Frequence reduite");

% Puissance : 
signal_f=abs(fftshift(fft(signal,Nfft)).^2);
abscissef=linspace(-fech/2,fech/2,Nfft);
figure;
plot(abscissef,signal_f);
xlabel("Frequence (Hz)");
title("Module fft au carré");

%% périodogramme :
% calcul de 100 periodogramme pour faire un periodogramme moyenne (daniel)
N_experience = 100;
signals=zeros(Nombre_point,N_experience);
for k=1:N_experience
    bruit = randn(Nombre_point,1)*var_bruit;
    signals(:,k)=cos(2*pi*(fo/fech).*abscisse(1,:)')+bruit;
end
% periodogramme moyenné :
[periodogrammemoyenne,tabperio]=periodogramme_moyenne(signals);

tailleswindowsbis=10;
windowsbis=ones(1,tailleswindowsbis);
[periodogrammedaniel]=Periodogramme_daniel(signal,windowsbis);

% affichage : 

figure;
plot(abscissef,periodogrammedaniel);
title("periodogramme Daniel");

periodogrammewelch= Mon_Welch(signal,Nfft,fech);
figure;
plot(abscissef,periodogrammewelch);
title("periodogramme Welch");

% Mon new_welch :
recouvrement=1;
taillewindows=100;
windows=ones(1,taillewindows);
[periodogrammewelch2, tabperio2]= Monnew_Welch(signal,Nfft,fech,windows,recouvrement);

figure;
semilogy(abscissef,periodogrammewelch2);
title("periodogramme Welch new version");

%% spectrogramme : 
% 
% windows = ones(1,10);
% spectro = Spectrogramme(Nfft, signal,fech,windows);
% Ts=1/fech;
% temps=0:0.5*Ts:Ts*length(signal);
% frequence=linspace(-fech/2,fech/2,Nfft);
% figure;
% imagesc(temps,frequence,spectro);

%% méthode capon 
[P]= capon(signal, abscissef, fech);
figure()
plot(abscissef,abs(P)),title("Puissance")


%% Méthode des trapezes
fmin = 100;
fmax = 300;
integrale2 = method_trapeze(periodogrammedaniel,fmin,fmax,fech);
integrale3 = method_trapeze(periodogrammemoyenne,fmin,fmax,fech);
integrale4 = method_trapeze(periodogrammewelch2,fmin,fmax,fech);
disp(["IntégraleDaniel entre" fmin "et" fmax "vaut" integrale2])
disp(["IntégraleMoyenne entre" fmin "et" fmax "vaut" integrale3])
disp(["IntégraleWelch2 entre" fmin "et" fmax "vaut" integrale4])










