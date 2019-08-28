function Histograma(Nombre,N)
    b=xlsread(Nombre);
    sb=length(b(:,1));
    mb=zeros(N);
    k=3800/N;
    for j=1:sb
       x=b(j,1); y=b(j,2);
       for i=0:N-1
            if 200+i*k<=x && x<200+(i+1)*k
               p=i+1;
            end
            if 200+i*k<=y && y<200+(i+1)*k
               q=i+1;
            end
       end
       mb(p,q)=mb(p,q)+1;
    end

    figure
    h=bar3(mb);
    title(strcat(strrep(Nombre,'.xls',''),sprintf('(%i X %i)',N,N)))
    colorbar
    for k = 1:length(h)
        zdata = get(h(k),'ZData');
        set(h(k),'CData',zdata,'FaceColor','interp')
    end
    
end
