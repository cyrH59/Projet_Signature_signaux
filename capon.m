function [P] = capon(signal, f, fech)
    N=length(signal);
    if (length(signal)~= length(f))
        disp("probleme de dimension");
    end
    
    a=zeros(1,N);
    P=zeros(1,length(f));
    Rx=signal'*signal;
    invRx = 1\Rx;
    for j=1:length(f)
        for k=1:N
            a(k)= exp(-1i*2*pi*(k-1)*(f(j)/fech)); %Steering vecteur
        end
        P(j) = 1./ a*invRx*a';
    end     
end
 
