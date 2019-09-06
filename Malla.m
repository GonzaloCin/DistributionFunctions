classdef Malla
    %MALLA Clase para generar la funcion de densidad de un conjunto de
    %coordenadas guardadas en un archivo excel
    %   El formato de los archivos excel debe tener en las 2 primeras
    %   columnas las cooerdanadas x,y de los puntos y en la tercer columna
    %   las dimensiones de la imagen , que deben ser mayores que las
    %   coordenadas maximas
    
    properties
        NombreArchivo       % NombreArchivo - Nombre de excel
        Celdas              % Celdas - celdas que contienen objetos de la clase CELDA 
        ConteoM				% ConteoCeldas - Matriz con cantidad de elementos por celda
        CentroideMax        % CentroideMax - Coordenadas del centroide de las celdas con cantidad maxima de elementos
        CentroidesAltos     % CentroidesAltos - Matriz con las coordenadas de los centrides de las celdas mas altas como filas
        Cmax				% ConteoMaximo - Cantidad maxima de puntos en las celdas
        Datos               % Datos - Matriz con todos los datos como filas
        Res					% Resolucion - Mantidad de puntos en el mesh grid por lado para dibujar funcion
        Total               % Total - Mantidad de puntos totales en el archivo excel
        Xmin                % Xmin - Minimo en el eje x para considerar las celdas
        Xmax                % Xmax - Maximo en el eje x para considerar las celdas
        Ymin                % Ymin - Minimo en el eje y para considerar las celdas
        Ymax                % Ymax - Maximo en el eje y para considerar las celdas
        DomX				% DominioX - Dominio de los datos en el eje x, es un vector con cantidad de datos dado por Resolucion
        DomY				% DominioY - Dominio de los datos en el eje y, es un vector con cantidad de datos dado por Resolucion
        xx                  % xx - Usado para hacer meshgrid para dibujar graficas
        yy                  % yy - Usado para hacer meshgrid para dibujar graficas
        FuncionT			% FuncionDistribucion - Es la funcion de distribucion evaluada en el meshgrid
        TamanoX				% TamanoCeldaX - Es tamano de las celdas en el eje x
        TamanoY				% TamanoCeldaY - Es tamano de las celdas en el eje y
        width				% Ancho - Ancho de la imagen en pixeles
        height				% Alto - Alto de la imagen en pixeles
        Histograma          % Histograma - Matriz con las cantidades de puntos por celda y su frecuencia
    end
    
    methods
        
        function M = Malla(archivo,numero,res,ver,guardar,VXY,zoom) 
            %% Lectura del archivo
            M.NombreArchivo=archivo;
            [~,Hojas,~]= xlsfinfo(archivo);
            M.Datos = xlsread(archivo,Hojas{1});
            
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
            
            M.width=(1/fac)*M.Datos(1,3);
            M.height=(1/fac)*M.Datos(2,3);
            M.Datos=(1/fac)*[M.Datos(:,1) M.Datos(:,2)];
            
            M.Res=res;
            
            %% Calculo de ejes
            M.Total=length(M.Datos);
            if strcmp(VXY,'null')
                 M.Xmin= min(M.Datos(:,1))-1;
                 M.Xmax= max(M.Datos(:,1))+1;
                 M.Ymin= min(M.Datos(:,2))-1;
                 M.Ymax= max(M.Datos(:,2))+1;
            else
                M.Xmin= VXY(1)-1;
                M.Xmax= VXY(2)+1;
                M.Ymin= VXY(3)-1;
                M.Ymax= VXY(4)+1;
            end
            M.DomX=linspace(M.Xmin,M.Xmax,M.Res);
            M.DomY=linspace(M.Ymin,M.Ymax,M.Res);
            [M.xx,M.yy]=meshgrid(M.DomX,M.DomY);

            M.FuncionT=zeros(length(M.DomX));
            
            %% Creacion de celdas
            M.TamanoX=(M.Xmax-M.Xmin)/numero;
            M.TamanoY=(M.Ymax-M.Ymin)/numero;
            for i=1:numero
                for j=1:numero
                    M.Celdas{i,j}=Celda(0,(i-1)*M.TamanoX,(i)*M.TamanoX,(j-1)*M.TamanoY,(j)*M.TamanoY);                                                  
                end
            end
            
            %% Clasificacion de los datos en las celdas
            for i=1:length(M.Datos(:,1))
                auxi=ceil((M.Datos(i,1)-M.Xmin)/M.TamanoX);
                auxj=ceil((M.Datos(i,2)-M.Ymin)/M.TamanoY);
                M.Celdas{auxi,auxj}=anadir(M.Celdas{auxi,auxj},M.Datos(i,:));
            end
            
            %% Calculo de funcion por celda y suma a la principal
            for i=1:numero
                for j=1:numero
                     M.Celdas{i,j}=calcular(M.Celdas{i,j},M.xx,M.yy);
                     f=getFuncion(M.Celdas{i,j});
                     M.ConteoM(i,j)=getCantidad(M.Celdas{i,j});
                     M.FuncionT=M.FuncionT+f*(getCantidad(M.Celdas{i,j}));
                end
            end
            
            %% Calculos de variables de informacion
            M.Cmax=max(max(M.ConteoM));
            M.CentroideMax=[0,0];
            co=0;
            M.Histograma=zeros(1,M.Cmax+1);
            for i=1:numero
                for j=1:numero
                     M.Histograma(M.ConteoM(i,j)+1)=M.Histograma(M.ConteoM(i,j)+1)+1;
                    if(M.ConteoM(i,j)>=M.Cmax*7/10)
                       M.CentroideMax=M.CentroideMax+getCentroide(M.Celdas{i,j});
                       co=co+1;
                       M.CentroidesAltos(co,:)=getCentroide(M.Celdas{i,j});
                    end
                end
            end
            M.CentroideMax=M.CentroideMax/co;
            
            %% Graficacion , escritura y/o guardado de resultados
            %xlswrite(archivo,{'Centroide Maximos'} ,Hojas{1},'C4');
            %xlswrite(archivo,M.CentroideMax',Hojas{1},'C5');
            
            if ver
            	%% Dibujar funcion principal
                set(0,'DefaultTextInterpreter','none')
                figure,surf(M.DomX,M.DomY,M.FuncionT), shading flat ,title(strcat(strrep(M.NombreArchivo,'.xlsx',''),sprintf('(%i X %i)',numero,numero)),'FontSize',12),xlabel('x'),ylabel('y'),colorbar,axis([M.Xmin M.Xmax M.Ymin M.Ymax]);hold on;
                surf(M.DomX,M.DomY,0.3*ones(res,res),'FaceColor',[1 1 1],'LineStyle','none');
                	%% Configuracion
                    set(gca, 'YDir', 'reverse');  %Revertir el eje Y
                    plot3(M.CentroidesAltos(:,1),M.CentroidesAltos(:,2),M.Cmax*ones(length(M.CentroidesAltos),1),'g.','MarkerSize',20);
                    plot3(M.CentroideMax(1),M.CentroideMax(2),M.Cmax,'ro','LineWidth',3)
               
                    h=gcf;
                    set(h,'Units','pixels');
                    set(h,'Position',[0 0 750 750]);
                    xlabel('X Micras'),ylabel('Y Micras')

                 if(guardar)
                    print(strcat(strrep(M.NombreArchivo,'.xlsx',''),sprintf('(%i X %i)',numero,numero),'3DArriba','.png'),'-dpng','-r300');
                 end

                view(-45,70);
                if(guardar)
                    %% Guardar Girada y fig
                    saveas(h,strcat(strrep(M.NombreArchivo,'.xlsx',''),sprintf('(%i X %i)',numero,numero),'3D','.fig'),'fig');
                    print(strcat(strrep(M.NombreArchivo,'.xlsx',''),sprintf('(%i X %i)',numero,numero),'3D','.png'),'-dpng','-r300');
                end

                view(-45,38);
                if(guardar)
                	%% Guardar mas girada
                	print(strcat(strrep(M.NombreArchivo,'.xlsx',''),sprintf('(%i X %i)',numero,numero),'3D2','.png'),'-dpng','-r300');
                end
                
                %% Dibujar contornos
                figure,contour(M.DomX,M.DomY,M.FuncionT),title(strcat('Nivel-',strrep(M.NombreArchivo,'.xlsx',''),sprintf('(%i X %i)',numero,numero)),'FontSize',12), xlabel('x'),ylabel('y'),colorbar,axis([M.Xmin M.Xmax M.Ymin M.Ymax]);hold on;
                	%% Configurar
                	set(gca, 'YDir', 'reverse');   %Revertir el eje Y
                    plot(M.CentroidesAltos(:,1),M.CentroidesAltos(:,2),'g.','MarkerSize',20);
                	plot(M.CentroideMax(1),M.CentroideMax(2),'ro','LineWidth',3)
                	h=gcf;
                	set(h,'Units','pixels');
                	set(h,'Position',[700 0 750 750]);
                	xlabel('X Micras'),ylabel('Y Micras')

                if(guardar)
                	print(strcat(strrep(M.NombreArchivo,'.xlsx',''),sprintf('(%i X %i)',numero,numero),'Contour','.png'),'-dpng','-r300');
                end
                
                %% Creacion de imagen binaria de coordenadas
                figure,scatter(M.Datos(:,1),M.Datos(:,2),10,'black','filled');
                	%% Configurar
                	set(gca, 'YDir', 'reverse');   %Revertir el eje Y                
                	h=gcf;
                	set(h,'Units','pixels');
                	set(h,'Position',[0 50 400 400*M.height/M.width])
                	axis([0 M.width 0 M.height])
                	axis equal;
                	axis off;
                    xlabel('X Micras'),ylabel('Y Micras')
                    set(h,'PaperPositionMode','auto')
                    set(gca,'pos',[0 0 1 1])
                if(guardar)
                	print(strcat(strrep(M.NombreArchivo,'.xlsx',''),sprintf('(%i X %i)',numero,numero),'ReconstruidaSinEjes.tif'),'-dtiff','-r300');
                end
                
                %% Dibujar histograma de frecuencias de conteos
                figure, bar(0:M.Cmax,M.Histograma),title(strcat('Histograma-',strrep(M.NombreArchivo,'.xlsx',''),sprintf('(%i X %i)',numero,numero)),'FontSize',12), xlabel('Cantidad de Fibras'),ylabel('Fecuencia')
                if(guardar)
                    print(strcat(strrep(M.NombreArchivo,'.xlsx',''),sprintf('(%i X %i)',numero,numero),'-Histograma.png'),'-dpng','-r300');
                end
                xlswrite(strcat(strrep(M.NombreArchivo,'.xlsx',''),sprintf('(%i X %i)',numero,numero),'-Histograma.xls'),[0:M.Cmax ; M.Histograma]');    
            end
        end  
        
        function [x,y,F] = obtenerFuncion(M)
            x=M.xx;
            y=M.yy;
            F=M.FuncionT;
        end
        
        function [g]= obtenerHistograma(M)
           g=M.Histograma; 
        end
    end
    
end
