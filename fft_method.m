clear all;
close all;
clc;

%%
N=1024; %Nbre d'échantillons
f0= 10^3;
fe=10000;
Te=1/fe;
n= 1:Te:N*Te;
signal = cos(2*pi*(f0/fe)*n);

figure()
plot(n,signal)
title('Signal cosinus')

% TF=fftshift(fft(signal));
% DSP= (abs(TF).^2)/N;
% 
% figure()
% f = -1/2:1/N:1/2-1/N; 
% plot(f,DSP)
% title('Périodogramme classique'),xlabel('Fréquence réduite (Hz)')
% 
% y = Mon_Welch(signal,N,Fe);




