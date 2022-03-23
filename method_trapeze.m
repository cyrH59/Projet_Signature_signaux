function integrale=method_trapeze(y,fmin,fmax,fech)
    integrale = 0;
    deb = 0;
    fin = 0;
    if(fmin>= -fech/2 && fmax<=fech/2 && fmin<fmax)
        N= length(y)-1;
        %R�cup�ration de l'indice de d�but et de fin pour calculer
        %l'int�grale
        for i=0:N-1
            if(-fech/2+ i*fech/N <=fmin && fmin<=-fech/2 + (i+1)*fech/N)
                deb= i+1;
                %disp(deb)
            end
            if(-fech/2+ i*fech/N <=fmax && fmax<=-fech/2 + (i+1)*fech/N)
                fin = i+1;
                %disp(fin)
            end
        end
        pas = fech/N;
        for k= deb:2:fin
            %disp(k)
            integrale = integrale + (y(k)+y(k+1))*pas/2;
        end  
    end
end