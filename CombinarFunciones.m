function [ h ] = CombinarFunciones( Archivo1, Archivo2,num,res )
    %Leer el Archivo 1 y guardarlo en una matriz de n*2
    D1=xlsread(Archivo1);
    D2=xlsread(Archivo2);
	
	%%Vector de dos entradas con las coordenadas minimas x y y del archivo d1
    MinD1=min(D1);
    MaxD1=max(D1);
    %%Vector de dos entradas con las coordenadas minimas x y y del archivo d2
    MinD2=min(D2);
    MaxD2=max(D2);

    xmin=min(MinD1(1),MinD2(1));
    ymin=min(MinD1(2),MinD2(2));
    xmax=max(MaxD1(1),MaxD2(1));
    ymax=max(MaxD1(2),MaxD2(2));

    M1=Malla(Archivo1,num,res,true,false,[xmin,xmax,ymin,ymax]);
    M2=Malla(Archivo2,num,res,true,false,[xmin,xmax,ymin,ymax]);

    X=M1.xx;
    Y=M1.yy;
    F1=M1.FuncionT;
    F2=M2.FuncionT;

    FM1=(F1>F2).*F1;
    FM2=(F2>F1).*F2;

    figure
    surf(X,Y,FM1,'FaceColor','r','LineWidth',0.01);
    hold on;
    surf(X,Y,FM2,'FaceColor','g','LineWidth',0.01);
    set(gca, 'YDir', 'reverse')   %Revertir el eje Y
    
    h=gcf;
    title(strcat(strrep(Archivo1,'.xls',''),'y',strrep(Archivo2,'.xls',''),sprintf('(%i X %i)',num,num),'3D'));
    set(h,'Units','pixels');
    set(h,'Position',[0 0 750 750]);

    view(-45,76);
    saveas(h,strcat(strrep(Archivo1,'.xls',''),'y',strrep(Archivo2,'.xls',''),sprintf('(%i X %i)',num,num),'3D','.fig'),'fig');
    print(strcat(strrep(Archivo1,'.xls',''),'y',strrep(Archivo2,'.xls',''),sprintf('(%i X %i)',num,num),'3D','.png'),'-dpng','-r600');  
end

