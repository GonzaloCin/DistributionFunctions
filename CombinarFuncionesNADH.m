function [ h ] = CombinarFuncionesNADH( Archivo1, Archivo2,num,res,zoom)%%Hacer NADH
    D1=xlsread(Archivo1);%Leer el Archivo 1 y guardarlo en una matriz de n*2
    D2=xlsread(Archivo2);

    if strcmp(zoom,'4x')
        fac=1.4;
    else
        if strcmp(zoom,'10x')
            fac=3.18;
        else
            if strcmp(zoom,'default')
                fac=1;
            end
        end
    end
    D1=(1/fac)*[D1(:,1) D1(:,2)];
    D2=(1/fac)*[D2(:,1) D2(:,2)];

    MinD1=min(D1);%%Vector de dos entradas con las coordenadas minimas x y y del archivo d1
    MaxD1=max(D1);%%Analogo
    MinD2=min(D2);%%Vector de dos entradas con las coordenadas minimas x y y del archivo d1
    MaxD2=max(D2);

    xmin=min(MinD1(1),MinD2(1));
    ymin=min(MinD1(2),MinD2(2));
    xmax=max(MaxD1(1),MaxD2(1));
    ymax=max(MaxD1(2),MaxD2(2));

    M1=Malla(Archivo1,num,res,true,true,[xmin,xmax,ymin,ymax],zoom);
    M2=Malla(Archivo2,num,res,true,true,[xmin,xmax,ymin,ymax],zoom);

    X=M1.xx;
    Y=M1.yy;
    F1=M1.FuncionT;
    F2=M2.FuncionT;

    F1c=M1.CentroideMax;
    F2c=M2.CentroideMax;

    FTCmax=max([M1.Cmax,M2.Cmax]);

    FM1=(F1>F2).*F1;
    FM2=(F2>F1).*F2;

    figure
    surf(X,Y,FM1,'FaceColor',[0 0 255]/255,'LineWidth',0.01);axis([xmin xmax ymin ymax]);
    hold on;
    surf(X,Y,FM2,'FaceColor',[0 255 0]/255,'LineWidth',0.01);
    bg=surf(X,Y,0.3*ones(res,res),'FaceColor',[1 1 1],'LineWidth',0.01);

    plot3(F1c(1),F1c(2),FTCmax,'Color','r','Marker','o','LineWidth',3,'LineStyle','none');
    plot3(F2c(1),F2c(2),FTCmax,'Color','g','Marker','o','LineWidth',3,'LineStyle','none');


    set(gca, 'YDir', 'reverse');   %Revertir el eje Y
    xlabel('X Micras'),ylabel('Y Micras')
    set(get(get(bg(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off')
    h = legend(strrep(Archivo1,'.xlsx',''),strrep(Archivo2,'.xlsx',''),strcat('Centroid',' ',strrep(Archivo1,'.xlsx','')) ,strcat('Centroid',' ',strrep(Archivo2,'.xlsx','')),'Location','NorthEast');
    set(h,'Interpreter','none');
    set(h,'FontSize',6);

    h=gcf;
    title(strcat(strrep(Archivo1,'.xlsx',''),'y',strrep(Archivo2,'.xlsx',''),sprintf('(%i X %i)',num,num),'3D'));
    set(h,'Units','pixels');
    set(h,'Position',[0 0 750 750]);

    view(-45,76);
    saveas(h,strcat(strrep(Archivo1,'.xlsx',''),'y',strrep(Archivo2,'.xlsx',''),sprintf('(%i X %i)',num,num),'3D','.fig'),'fig');
    print(strcat(strrep(Archivo1,'.xlsx',''),'y',strrep(Archivo2,'.xlsx',''),sprintf('(%i X %i)',num,num),'3D','.png'),'-dpng','-r600');

end

