 function [y] = Mon_Welch(x,NFFT,Fe)
 % 100 Fft de 256 échantillons, on doit couper x en 256 échantillons,
 % calculer la transformée de Fourier de chaque échantillon et faire la moyenne de chaque échantillon 
 
 nombre_par_echantillon=floor(length(x)/NFFT);

 ensemble_echantillon=zeros(NFFT,nombre_par_echantillon);
 for k=1:NFFT
     for j=1:(nombre_par_echantillon)       
         ensemble_echantillon(k,j)=x(NFFT*(j-1)+k); 
            
     end
 end
 
TF_ensemble_echantillon=fftshift(fft(ensemble_echantillon,NFFT));

y=zeros(1,NFFT);

y=mean(TF_ensemble_echantillon.*conj(TF_ensemble_echantillon),2)/NFFT;
y=y/Fe;

abscisse = linspace(-1/2,1/2,NFFT);
figure()
plot(abscisse,abs(y));
xlabel("Fr�quence (Hz)")
ylabel("Amplitude")
title("P�riodogramme de Welch")

end
 