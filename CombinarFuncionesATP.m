function [ h ] = CombinarFuncionesATP( Archivo1, Archivo2,Archivo3,num,res,zoom)
    D1=xlsread(Archivo1);%Leer el Archivo y guardarlo en una matriz de n*2
    D2=xlsread(Archivo2);
    D3=xlsread(Archivo3);

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
    D3=(1/fac)*[D3(:,1) D3(:,2)];

    MinD1=min(D1);%%Vector de dos entradas con las coordenadas minimas x y y del archivo d1
    MaxD1=max(D1);%%Analogo
    MinD2=min(D2);%%Vector de dos entradas con las coordenadas minimas x y y del archivo d2
    MaxD2=max(D2);
    MinD3=min(D3);%%Vector de dos entradas con las coordenadas minimas x y y del archivo d3
    MaxD3=max(D3);

    xmin=min([MinD1(1),MinD2(1),MinD3(1)]);
    ymin=min([MinD1(2),MinD2(2),MinD3(2)]);
    xmax=max([MaxD1(1),MaxD2(1),MaxD3(1)]);
    ymax=max([MaxD1(2),MaxD2(2),MaxD3(2)]);

    M1=Malla(Archivo1,num,res,true,true,[xmin,xmax,ymin,ymax],zoom);
    M2=Malla(Archivo2,num,res,true,true,[xmin,xmax,ymin,ymax],zoom);
    M3=Malla(Archivo3,num,res,true,true,[xmin,xmax,ymin,ymax],zoom);


    X=M1.xx;
    Y=M1.yy;
    F1=M1.FuncionT;
    F2=M2.FuncionT;
    F3=M3.FuncionT;

    F1c=M1.CentroideMax;
    F2c=M2.CentroideMax;
    F3c=M3.CentroideMax;

    FTCmax=max([M1.Cmax,M2.Cmax,M3.Cmax]);

    FM1=(((F1>F2).*F1)>F3).*F1;
    FM2=(((F2>F1).*F2)>F3).*F2;
    FM3=(((F3>F1).*F3)>F2).*F3;
    figure
    surf(X,Y,40*FM1,'FaceColor',[0 0 255]/255,'LineWidth',0.01);axis([xmin xmax ymin ymax]);
    hold on;
    surf(X,Y,8*FM2,'FaceColor',[255 0 0]/255,'LineWidth',0.01);
    surf(X,Y,FM3,'FaceColor',[0 255 0]/255,'LineWidth',0.01);
    bg = surf(X,Y,0.3*ones(res,res),'FaceColor',[1 1 1],'LineWidth',0.01);

    plot3(F1c(1),F1c(2),40*FTCmax,'Color','r','Marker','o','LineWidth',3,'LineStyle','none');
    plot3(F2c(1),F2c(2),40*FTCmax,'Color','g','Marker','o','LineWidth',3,'LineStyle','none');
    plot3(F3c(1),F3c(2),40*FTCmax,'Color','b','Marker','o','LineWidth',3,'LineStyle','none');

    set(gca, 'YDir', 'reverse');%Revertir el eje Y

    xlabel('X Micras'),ylabel('Y Micras')
    set(get(get(bg(1),'Annotation'),'LegendInformation'),'IconDisplayStyle','off')
    h = legend(strrep(Archivo1,'.xlsx',''),strrep(Archivo2,'.xlsx',''),strrep(Archivo3,'.xlsx',''),strcat('Centroid',' ',strrep(Archivo1,'.xlsx','')) ,strcat('Centroid',' ',strrep(Archivo2,'.xlsx','')) ,strcat('Centroid',' ',strrep(Archivo3,'.xlsx','')),'Location','NorthEast');
    set(h,'Interpreter','none');
    set(h,'FontSize',6);

    h=gcf;
    title(strcat(strrep(Archivo1,'.xlsx',''),', ',strrep(Archivo2,'.xlsx',''),'and',strrep(Archivo3,'.xlsx',''),sprintf('(%i X %i)',num,num),'3D'));
    set(h,'Units','pixels');
    set(h,'Position',[0 0 750 750]);

    view(-45,76);
    saveas(h,strcat(strrep(Archivo1,'.xlsx',''),',',strrep(Archivo2,'.xlsx',''),'and',strrep(Archivo3,'.xlsx',''),sprintf('(%i X %i)',num,num),'3D','.fig'),'fig');
    print(strcat(strrep(Archivo1,'.xlsx',''),',',strrep(Archivo2,'.xlsx',''),'and',strrep(Archivo3,'.xlsx',''),sprintf('(%i X %i)',num,num),'3D','.png'),'-dpng','-r600');
end

