function [periodogramme_daniel] = Periodogramme_daniel(x,windows) 
% on calcule le periodogramme associé à x avec la formule classique (fft
% au carré / taille)
signal_sortie = periodogramme_simple(x);
taillew=length(windows);
k=taillew;
periodogramme_daniel=0;

while (k<length(signal_sortie)) %tant que l'indice k est inférieur à la taille de x
    tmp=signal_sortie(k-length(windows)+1 :k);
    tmp=tmp.*windows;
    moyennetmp=mean(tmp);
    if (length(periodogramme_daniel) ~= 0 ) % on concatène 
        periodogramme_daniel=[periodogramme_daniel moyennetmp];
    end
    if (length(periodogramme_daniel) ==0) % 
        periodogramme_daniel=moyennetmp;
        

    end
    k=k+1;

end

for k=length(signal_sortie)+1:length(signal_sortie)+length(windows)-1
    tmp=signal_sortie(k-length(windows)+1:k-length(windows));
    moyennetmp=mean(tmp);
    periodogramme_daniel=[periodogramme_daniel moyennetmp];

end


end