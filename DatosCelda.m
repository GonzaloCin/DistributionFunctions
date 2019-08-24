classdef DatosCelda
    %DATOSCELDA Contiene toda la informacion relevante de cada celda
    %   Guarda los puntos pertenecientes a cada celda, guarda los limites
    %   la media y la maatriz de covarianza
    
    properties
        Covar    %% matriz covarianza
        VarX
        VarY
        Cov      %% sigma_xy
        Coor     %% coordenadas pertenecientes
        Media    %% vector
        MediaX
        MediaY
        Xm       %% limites min y MAX
        Ym
        XM
        YM
        Cantidad %% de datos
    end
    
    methods
        function C = DatosCelda(Xm,XM,Ym,YM)
          C.Xm=Xm;
          C.Ym=Ym;
          C.XM=XM;
          C.YM=YM;
          C.Cantidad=0;
        end
        
        function Dcel = anadir(Dcel,punto)
            Dcel.Cantidad=Dcel.Cantidad+1;
            Dcel.Coor(Dcel.Cantidad,:)=punto;
        end
        
        function m = getMedia(Dcel)
           Dcel.Media=mean(Dcelda.Coor);
           m=Dcel.Media;
        end
        
        function Dcel = CalcularCov(Dcel)
            Dcel.Media = mean(Dcel.Coor);
            if(Dcel.Cantidad>1)
                Dcel.Media=mean(Dcel.Coor);
                Dcel.MediaX=Dcel.Media(1);
                Dcel.MediaY=Dcel.Media(2);
                
                Dcel.Covar=cov(Dcel.Coor);
                
                if (det(Dcel.Covar)<0.0000001)
                    fprintf('d0,');
                    Dcel.Covar=NuevaCov(Dcel.Coor,Dcel.Media);
                end
                Dcel.VarX=Dcel.Covar(1,1);
                Dcel.VarY=Dcel.Covar(2,2);
                Dcel.Cov=Dcel.Covar(2,1);
            else
                if(Dcel.Cantidad==1)
                    Dcel.Media=Dcel.Coor;
                    Dcel.MediaX=Dcel.Coor(1);
                    Dcel.MediaY=Dcel.Coor(2);
                    Dm=min([abs(Dcel.Coor(1)-Dcel.Xm),abs(Dcel.Coor(1)-Dcel.XM),...
                            abs(Dcel.Coor(2)-Dcel.Ym),abs(Dcel.Coor(2)-Dcel.YM)]);
                    Dcel.Covar=[(Dm/3)^2 0; 0 (Dm/3)^2];
                    Dcel.VarX=Dcel.Covar(1,1);
                    Dcel.VarY=Dcel.Covar(2,2);
                    Dcel.Cov=Dcel.Covar(2,1);
                else
                    Dcel.Media=[0 0];
                    Dcel.Covar=zeros(2,2);
                    Dcel.VarX=Dcel.Covar(1,1);
                    Dcel.VarY=Dcel.Covar(2,2);
                    Dcel.Cov=Dcel.Covar(2,1);
                end
            end
        end
        
    end    
end

