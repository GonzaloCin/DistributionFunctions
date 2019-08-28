classdef Celda
    %CELDA Clase para contener los datos en una celda especifica y calcular
    %el centroide y la funcion de densidad
    %   La clase malla contiene una matriz de objetos Celda para que cada
    %   una contribuya con el calculo por separado de sus caracteristicas
    properties
        Cantidad        % Cantidad  - Cantidad de datos den la celda
        Xm              % Xm - Limite inferior de la celda en el eje x
        XM              % XM - Limite superior de la celda en el eje x
        Ym              % Ym - Limite inferior de la celda en el eje y
        YM              % YM - Limite superior de la celda en el eje y
        Puntos          % Puntos - Todos los puntos pertenecientes a la celda como renglones
        Media           % Es el centroide de Puntos
        MediaX          % MediaX - La coordenada x del centroide
        MediaY          % MediaY - La coordenada y del centroide
        MCovarianza     % MCovarianza - Matriz de covarianza de lo puntos
        MCovInv         % MCovInv -  Inversa de la matriz de covarianza
        VarX            % VarX - La varianza de las coordenadas x de los puntos
        VarY            % VarY - La varianza de las coordenadas y de los puntos
        Cov             % Cov -  Covarianza de las coordenadas x y y
        Ro              % Ro - Variable auxiliar para el calculo de la funcion
        Funcion         % Funcion - funcion de distribucion de la celda
    end
    
    methods
    
    	function C = Celda(Cant,Xm,XM,Ym,YM)
            C.Cantidad=Cant;
            C.Xm = Xm;
            C.XM = XM;
            C.Ym = Ym;
            C.YM = YM;
        end
    	
        function cen = getCentroide(Cel)
            cen = Cel.Media;
        end
        
        
        function cel = anadir(cel,punto)
            cel.Cantidad = cel.Cantidad + 1;
            cel.Puntos(cel.Cantidad,:) = punto;
        end
        
        function disp(Cel)
            if(Cel.Cantidad ~= 0)
                fprintf('Cantidad %i',Cel.Cantidad);
                Cel.Puntos
            end
        end
        
        function Cel=calcular(Cel,XX,YY)
            %% Decidir como se contruira Funcion segun la cantidad de puntos en la celda        
            if(Cel.Cantidad>1)
                   Cel.Media = mean(Cel.Puntos);
                   Cel.MediaX = Cel.Media(1);
                   Cel.MediaY = Cel.Media(2);

                   Cel.MCovarianza = cov(Cel.Puntos);
                  
                   %% Reconstruir matriz de covarianza cuando esta es cercana a ser singular
                   if (det(Cel.MCovarianza)<0.0000001)
                       fprintf('d0,'); % imprime cada vez que se encuentra en esta condicion
                       Cel.MCovarianza = NuevaCov(Cel.Puntos,Cel.Media);
                   end
                   
                   %% Guardar valores en variables para mayor orden y claridad
                   Cel.VarX = Cel.MCovarianza(1,1);
                   Cel.VarY = Cel.MCovarianza(2,2);
                   Cel.Cov = Cel.MCovarianza(2,1);
                   Cel.Ro = Cel.Cov/((Cel.VarX*Cel.VarY)^(1/2));
                   Cel.MCovInv = inv(Cel.MCovarianza);
                   
                   %Es el factor necesario para hacer que la funcion de
                   %densidad tenga el volumen bajo la curva de una
                   %gaussiana autentica, sin embargo no se usa para
                   %nuestros propositos, se prefiera altura maxima de 1
                   
                   Cel.Funcion = exp((-1/2)*(Cel.MCovInv(1,1)*(XX-Cel.MediaX).^2+2*Cel.MCovInv(1,2)*(XX-Cel.MediaX).*(YY-Cel.MediaY)+Cel.MCovInv(2,2)*(YY-Cel.MediaY).^2));
                   
                   %Uncomment to debug
                   %%figure,plot(Cel.Puntos(:,1),Cel.Puntos(:,2)','*')
                   %%figure,surf(XX,YY,Cel.Funcion)
                   %%pause
                   %%Cel.Funcion=reshape(F,length(XX),length(YY));
            elseif(Cel.Cantidad == 1)
            	   %% Construccion sugerida de la matriz de mcovarianza cuando solo hay un punto
                   Cel.Media = Cel.Puntos;
                   Cel.MediaX = Cel.Puntos(1);
                   Cel.MediaY = Cel.Puntos(2);
                   
                   Dm = min([abs(Cel.Puntos(1)-Cel.Xm),abs(Cel.Puntos(1)-Cel.XM),abs(Cel.Puntos(2)-Cel.Ym),abs(Cel.Puntos(2)-Cel.YM)]);
                   Cel.MCovarianza = [(Dm/3)^2 0; 0 (Dm/3)^2];
                   Cel.VarX = Cel.MCovarianza(1,1);
                   Cel.VarY = Cel.MCovarianza(2,2);
                   Cel.Cov = Cel.MCovarianza(2,1);
                   Cel.Ro = Cel.Cov/((Cel.VarX*Cel.VarY)^(1/2));
                   
                   Cel.Funcion = exp((-1/2*((1-Cel.Ro^2)^(1/2)))*(((XX-Cel.MediaX).^2/Cel.VarX)+((YY-Cel.MediaY).^2/Cel.VarY))-(2*Cel.Ro*XX.*YY)/((Cel.VarX*Cel.VarY)^(1/2)));
            else
            	   %% Si no hay datos la funcion es cero
                   Cel.Media = [0 0];
                   Cel.Funcion = zeros(length(XX));
            end
        end
        
        function f = getFuncion(Cel)
            f = Cel.Funcion;
        end
        
        function c = getCantidad(Cel)
            c = Cel.Cantidad;
        end
    end
    
end

