function [periodogramme_welch, periodogramme] = Monnew_Welch(x,NFFT,Fe,windows,recouvrement) 
taillex=length(x);
taillew=length(windows);
periodogramme=zeros(1,NFFT);
k=taillew;
%tant que le dernier element ne déborde pas au delà du signal
while (k<taillex)
    tmp=zeros(1,length(x));
    for p=1:length(tmp)
        if ((p>k-taillew) & (p<k+1))
            tmp(p)=x(p)*windows(p-k+taillew);
        end
    end
    periodogramme(size(periodogramme,1),:)=periodogramme_simple(tmp);
    % on rajoute une colonne de zeros pour l'élement suivant 
    k=k+floor(recouvrement*length(windows));
    if(k<taillex)
        periodogramme=[periodogramme;zeros(1,NFFT)];
    end
end
periodogramme_welch=zeros(1,NFFT);
for i=1:length(periodogramme_welch)
    periodogramme_welch(i)=mean(periodogramme(:,i));
end
end