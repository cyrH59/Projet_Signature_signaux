clc 
clear all
close all

%% Param�tres et signal
Nombre_point=500;
fech=1000;
fo=100;
Te=1/fech;
abscisse=0:1:Nombre_point-1;
var_bruit = 1 ;
signal=cos(2*pi*(fo/fech)*abscisse);
%signal = signal +var_bruit*randn(size(signal));
%signal = var_bruit*randn(1,Nombre_point);
figure;
plot(abscisse,signal);
xlabel("echantillon");
title("signal sinusoidale");


%Nfft
Nfft = Nombre_point;
% permet d'ajouter le padding nécessaire pour avoir une puissance de 2 
while ((log2(Nfft)-floor(log2(Nfft))) ~= 0)
    Nfft=Nfft+1;
    signal=[signal 0];
    
end
% signal_padding = zeros(1,Nfft);
% for i=1:length(signal)
%     signal_padding(i) = signal(i);
% end

%% fft : 
signal_f=abs(fftshift(fft(signal,Nfft)));
abscissef=-1/2:1/Nfft:(1/2-1/Nfft);
figure;
plot(abscissef,signal_f);
xlabel("Frequence (Hz)");
ylabel("Fft");

%% P�riodogramme simple: 
Dsp= signal_f.^(2)/Nombre_point;
figure;
plot(abscissef,Dsp);
title("P�riodogramme simple avec fen�tre rectangulaire");
xlabel("Frequence reduite");

%% Puissance : 
signal_f=abs(fftshift(fft(signal,Nfft)).^2);
abscissef=-1/2:1/Nfft:(1/2-1/Nfft);
figure;
plot(abscissef,signal_f);
xlabel("Frequence (Hz)");
title("Puissance");

%% P�riodogramme de Welch
y= Mon_Welch(signal,Nfft,fech);

%% P�riodogramme de Daniel:
% calcul de 100 periodogramme pour faire un periodogramme moyenne (daniel)
N_experience = 1000;
signals=zeros(Nombre_point,N_experience);
for k=1:N_experience
    bruit = randn(Nombre_point,1)*var_bruit;
    signals(:,k)=cos(2*pi*(fo/fech).*abscisse(1,:)')+bruit;
end


figure;
plot(abscisse,signals(:,1));
title("exemple signals 1")
[periodogrammedaniel,tabperio]=periodogramme_moyenne(signals);

% affichage : 
figure;
plot(abscissef,periodogrammedaniel);
title("periodogramme Daniel");

%% Spectrogramme
windows=ones(1,length(signal)/4);  %fen�tre rectangulaire
%windows = transpose(hamming(length(signal)/4)); %fen�tre de hamming
%windows = transpose(hanning(length(signal)/4)); %fen�tre de hanning
%windows = transpose(bartlett(length(signal)/4)); %fen�tre de bertlett (triangulaire)
[temps,frequence,spectro]=Mon_spectro(signal,Nfft,fech,windows,50);

figure()
imagesc(temps,frequence,transpose(spectro))
xlabel("temps (s)"),ylabel("Fr�quence (Hz)"),title("Spectrogramme")

%% M�thode des rectangles/trapezes
fmin = 100;
fmax = 300;
integrale1 = method_trapeze(Dsp,fmax,fmin,fech);
integrale2 = method_trapeze(y,fmax,fmin,fech);
disp(["Int�grale1 entre" fmin "et" fmax "vaut" integrale1])
disp(["Int�grale2 entre" fmin "et" fmax "vaut" integrale2])

RX= corrcoef([1 2 4 3]);












