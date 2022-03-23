function [signal_sortie] = periodogramme_simple(signal_entree)
    taille = length(signal_entree);
    ffts = abs(fftshift(fft(signal_entree,taille)));
    signal_sortie = (ffts.^2)/taille;
end