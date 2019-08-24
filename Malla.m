classdef Malla
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        NombreArchivo
        Celdas
        ConteoM
        CentroideMax
        CentroidesAltos
        Cmax
        Datos
        Res
        Total
        Xmin
        Xmax
        Ymin
        Ymax
        DomX
        DomY
        xx
        yy
        FuncionT
        Figura
        TamanoX
        TamanoY
        width
        height
        Histograma
    end
    
    methods
        
        function M= Malla(archivo,numero,res,ver,guardar,VXY,zoom) 
            M.NombreArchivo=archivo;
            M.Datos = xlsread(archivo);
            
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
            
            %%M.Datos
            M.Res=res;
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
            %%length(M.xx)
            M.FuncionT=zeros(length(M.DomX));
            M.TamanoX=(M.Xmax-M.Xmin)/numero;
            M.TamanoY=(M.Ymax-M.Ymin)/numero;
            for i=1:numero
                for j=1:numero
                    M.Celdas{i,j}=Celda(0,(i-1)*M.TamanoX,(i)*M.TamanoX,(j-1)*M.TamanoY,(j)*M.TamanoY);                                                  
                end
            end
            for i=1:length(M.Datos(:,1))
                %M.Datos(i,:);
                auxi=ceil((M.Datos(i,1)-M.Xmin)/M.TamanoX);
                auxj=ceil((M.Datos(i,2)-M.Ymin)/M.TamanoY);
                M.Celdas{auxi,auxj}=anadir(M.Celdas{auxi,auxj},M.Datos(i,:));
              
            end
            
            for i=1:numero
                for j=1:numero
                    %fprintf('Celda %i, %i ',i,j);
                    %disp(M.Celdas{i,j});
                     M.Celdas{i,j}=calcular(M.Celdas{i,j},M.xx,M.yy);
                     %fprintf('Toda');
                     %length(M.FuncionT)
                     %fprintf('Funcion Afuera');
                     f=getFuncion(M.Celdas{i,j});
                     M.ConteoM(i,j)=getCantidad(M.Celdas{i,j});
                     %length(f)
                     M.FuncionT=M.FuncionT+f*(getCantidad(M.Celdas{i,j}));
                    
                end
            end
            M.Cmax=max(max(M.ConteoM));
            %%M.Cmax
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
                       %%M.CentroidesAltos
                    end
                end
            end
            M.CentroideMax=M.CentroideMax/co;
            %%M.FuncionT
            %%set(gcf,'renderer','painters');
            %%surf(M.xx,M.yy,M.FuncionT)
            
            if ver
                figure,surf(M.DomX,M.DomY,M.FuncionT), shading flat ,title(strcat(M.NombreArchivo,sprintf('(%i X %i)',numero,numero)),'FontSize',12),xlabel('x'),ylabel('y'),colorbar,axis([M.Xmin M.Xmax M.Ymin M.Ymax]);hold on;
                surf(M.DomX,M.DomY,0.3*ones(res,res),'FaceColor',[1 1 1],'LineStyle','none');
                    set(gca, 'YDir', 'reverse');  %Revertir el eje Y
                
                    plot3(M.CentroidesAltos(:,1),M.CentroidesAltos(:,2),M.Cmax*ones(length(M.CentroidesAltos),1),'g.','MarkerSize',20);
                    plot3(M.CentroideMax(1),M.CentroideMax(2),M.Cmax,'ro','LineWidth',3)
               
                    h=gcf;
                    set(h,'Units','pixels');
                    set(h,'Position',[0 0 750 750]);
                    xlabel('X Micras'),ylabel('Y Micras')

                 if(guardar)
                    print(strcat(strrep(M.NombreArchivo,'.xls',''),sprintf('(%i X %i)',numero,numero),'3DArriba','.png'),'-dpng','-r300');
                 end

                view(-45,70);

                 if(guardar)
                    %set(h,'papersize',[1000,1000]);
                    saveas(h,strcat(strrep(M.NombreArchivo,'.xls',''),sprintf('(%i X %i)',numero,numero),'3D','.fig'),'fig');
                    %saveas(h,strcat(M.NombreArchivo,sprintf('(%i X %i)',numero,numero),'3D','.png'),'png');
                    print(strcat(strrep(M.NombreArchivo,'.xls',''),sprintf('(%i X %i)',numero,numero),'3D','.png'),'-dpng','-r300');
                 end

                view(-45,38);

                 if(guardar)
                    print(strcat(strrep(M.NombreArchivo,'.xls',''),sprintf('(%i X %i)',numero,numero),'3D2','.png'),'-dpng','-r300');
                 end

                figure,contour(M.DomX,M.DomY,M.FuncionT),title(strcat('Nivel-',M.NombreArchivo,sprintf('(%i X %i)',numero,numero)),'FontSize',12), xlabel('x'),ylabel('y'),colorbar,axis([M.Xmin M.Xmax M.Ymin M.Ymax]);hold on;
                
                set(gca, 'YDir', 'reverse');   %Revertir el eje Y
                
                plot(M.CentroidesAltos(:,1),M.CentroidesAltos(:,2),'g.','MarkerSize',20);
                plot(M.CentroideMax(1),M.CentroideMax(2),'ro','LineWidth',3)
                h=gcf;
                set(h,'Units','pixels');
                set(h,'Position',[700 0 750 750]);
                xlabel('X Micras'),ylabel('Y Micras')
                %%saveas(h,strcat(M.NombreArchivo,sprintf('(%i X %i)',numero,numero),'Contour','.png'),'png');

                 if(guardar)
                print(strcat(strrep(M.NombreArchivo,'.xls',''),sprintf('(%i X %i)',numero,numero),'Contour','.png'),'-dpng','-r300');
                 end
                %%set(h,'papersize',[1000,1000]);
                % print(strcat(M.NombreArchivo,sprintf('(%i X %i)',numero,numero),'Contour2','.jpeg'),'-djpeg','-r300');
                %%figure,[c,h]=contourf(M.DomX,M.DomY,M.FuncionT);clabel(c,h),title(strcat('Nivel-',M.NombreArchivo,sprintf('(%i X %i)',numero,numero)),'FontSize',12), xlabel('x'),ylabel('y'),colorbar,axis equal;

                figure 
                scatter(M.Datos(:,1),M.Datos(:,2),10,'black','filled');
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
                %%set(h,'Position',[0 0 750 750]);
                 if(guardar)
                    print(strcat(strrep(M.NombreArchivo,'.xls',''),sprintf('(%i X %i)',numero,numero),'ReconstruidaSinEjes.tif'),'-dtiff','-r300');
                 end
                 figure, bar(0:M.Cmax,M.Histograma),title(strcat('Histograma-',M.NombreArchivo,sprintf('(%i X %i)',numero,numero)),'FontSize',12), xlabel('Cantidad de Fibras'),ylabel('Fecuencia')
                    if(guardar)
                    print(strcat(strrep(M.NombreArchivo,'.xls',''),sprintf('(%i X %i)',numero,numero),'-Histograma.png'),'-dpng','-r300');
                    end
                xlswrite(strcat(strrep(M.NombreArchivo,'.xls',''),sprintf('(%i X %i)',numero,numero),'-Histograma.xls'),[0:M.Cmax ; M.Histograma]');    
            end    
            %%%%%%set(gca, 'YDir', 'reverse')   Revertir el eje Y
        end  
        
        
        function [x,y,F]=obtenerFuncion(M)
            x=M.xx;
            y=M.yy;
            F=M.FuncionT;
        end
        
        function [g]= obtenerHistograma(M)
           g=M.Histograma; 
        end
        
    end
    
end



