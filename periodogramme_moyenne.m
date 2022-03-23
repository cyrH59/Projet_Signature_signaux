function [periodogramme_finale,periodogrammemoyenne] = periodogramme_moyenne(signal_entree)
    % lissage periodogramme, methode de daniel.
    % signal_entree sera un tableau avec tous les signaux d'entree generee
    nombreperiodogramme=length(signal_entree(1,:));
    tailleperiodogramme=length(signal_entree(:,1));
    Nfft = tailleperiodogramme;
    % permet d'ajouter le padding nécessaire pour avoir une puissance de 2 
    while ((log2(Nfft)-floor(log2(Nfft))) ~= 0)
        Nfft=Nfft+1;
        signal_entree=[signal_entree ;zeros(1,length(signal_entree(1,:)))];
    end
    periodogrammemoyenne=zeros(Nfft,length(signal_entree(1,:)));
    for k=1:length(signal_entree(1,:))
        periodogrammemoyenne(:,k)= periodogramme_simple(signal_entree(:,k));
    end
    periodogramme_finale=zeros(1,Nfft);
    for i=1:length(periodogramme_finale)
        periodogramme_finale(i)=mean(periodogrammemoyenne(i,:));
    end

end