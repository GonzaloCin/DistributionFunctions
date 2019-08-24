function [ ] = Generar_imagenes(archivo,tam)
%GENERAR_IMAGENES Dado un archivo de excel y el tamaño de los puntos,
%genera grafica y la almacena
    Nombre = strrep(archivo,'.xls','');
    Datos=xlsread(archivo);
    
    %obtener ancho y alto de la tercera columna del excel
    w=Datos(1,3);
    h=Datos(2,3);
    %Obtiene solo coordenadas
    Datos=[Datos(:,1) Datos(:,2)];
    
    figure
    scatter(Datos(:,1),Datos(:,2),tam,'black','filled');
    set(gca, 'YDir', 'reverse')   %Revertir el eje Y

    j=gcf;
    set(j,'Units','pixels');
    set(j,'Position',[0 50 400 400*h/w])
    axis([0 w 0 h])
    axis equal;
    axis off;

    set(j,'PaperPositionMode','auto')
    set(gca,'pos',[0 0 1 1])
    
    print(j,strcat(Nombre,'Reconstruida.tif'),'-r150','-dtiff');
    saveas(j,strcat(Nombre,'Reconstruida.fig'),'fig');
end

