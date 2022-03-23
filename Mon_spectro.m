function[temps,frequence,spectro]=Mon_spectro(signal,Nfft,Fe,windows,recouvrement)
    spectro =zeros(floor(length(signal)/length(windows)*2),Nfft); %Spectro est une matrice contenant sur chaque ligne la fft du signal fenetre
    Te=1/Fe;
    a=1;
    b=length(windows);
    ligne = 1;
    signal_fenetre = signal(a:b).* windows;
    TF= fft(signal_fenetre,Nfft);
    spectro(ligne,:)=abs(TF).^2;
    while(b< length(signal))
        ligne = ligne+1;
        a= a+length(windows)*(recouvrement/100);
        b= b+length(windows)*(recouvrement/100);
        signal_fenetre = signal(a:b).* windows;
        TF= fft(signal_fenetre,Nfft);
        spectro(ligne,:)=abs(TF).^2;
    end
    
    %temps = 0 : recouvrement*Te: Te*length(signal);
    %frequence = linspace(-1/2,1/2,Nfft);
    frequence=transpose([0:1/Nfft:1 +(1/Nfft)]*Fe);
    temps= Nfft*Te/2: Te: (length(signal)-1)*Te;
end

    
        
    