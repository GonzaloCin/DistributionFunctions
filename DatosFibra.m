classdef DatosFibra
%DatosFibra Guarda los datos necesarios de un archivo de coordenadas de
%algun tipo de fibra para hacer posible la obtancion de su distancia o
%angulo con otro archivo ademas de la matriz de covarianza necesaria
%   Extrae datos y los ordena para que esten listos para realizar
%   operaciones mencionadas
    
    properties
        Width
        Height
        Cantidad
        Nceldas
        TamX
        TamY
        Datos
        Coordenadas
    end
    
    methods
    
        function DF = DatosFibra(archivo,numero)
            %% Guardar todos los datos desde el excel
            DF.Coordenadas = xlsread(archivo);
            DF.Width=DF.Coordenadas(1,3);
            DF.Height=DF.Coordenadas(2,3);
            DF.Coordenadas=[DF.Coordenadas(:,1) DF.Coordenadas(:,2)];
            DF.Nceldas=numero;
            DF.TamX=DF.Width/DF.Nceldas;
            DF.TamY=DF.Height/DF.Nceldas;
            DF.Cantidad=length(DF.Coordenadas(:,1));
            %% Clasificar los puntos dentro de cada celda
            for i=1:DF.Nceldas
                for j=1:DF.Nceldas
                    DF.Datos{i,j}=DatosCelda((i-1)*DF.TamX,(i)*DF.TamX,(j-1)*DF.TamY,j*DF.TamY);
                end
            end
           
            for i=1:DF.Cantidad
                auxi=ceil(DF.Coordenadas(i,1)/DF.TamX);  
                auxj=ceil(DF.Coordenadas(i,2)/DF.TamY);
                DF.Datos{auxi,auxj}=anadir(DF.Datos{auxi,auxj},DF.Coordenadas(i,:));           
            end
           
            %% Calcular matrices de covarianza de cada DatosCelda
            for i=1:DF.Nceldas
                for j=1:DF.Nceldas
                    DF.Datos{i,j}=CalcularCov(DF.Datos{i,j});           
                end
            end
            
        end
    end
    
end

