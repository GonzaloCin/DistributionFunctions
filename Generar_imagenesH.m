function [ ] = Generar_imagenesH(archivo,tam,tipo)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    Nombre=archivo;
    Datos=xlsread(archivo,tipo);
    %%Datos
    w=Datos(1,3);
    h=Datos(2,3);
    Datos=[Datos(:,1) Datos(:,2)];
    %%Datos
    %obtener width y height de la segunda columna del excel 
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

    print(j,strcat(strrep(Nombre,'.xls',''),tipo,'Reconstruida.tif'),'-r150','-dtiff')
    saveas(j,strcat(strrep(Nombre,'.xls',''),tipo,'Reconstruida.fig'),'fig');
           
end

