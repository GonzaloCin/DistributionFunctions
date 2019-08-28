function [ Distancia ] = ImageDistance( DF1,DF2,MCOV )
%ImageDistance Calcula la distancia de dos imagenes segun la matriz de
%covarianza dada
%   Utiliza la forma simplificada del calculo de la distancia usando la
%   fincion KAPPA

    Distancia=0;
    Ncel=DF1.Nceldas;
    for i=1:Ncel
        for j=1:Ncel
            Distancia=Distancia ...
                + DF1.Datos{i,j}.Cantidad^2 ...
                + DF2.Datos{i,j}.Cantidad^2 ...
                    - 2 * DF1.Datos{i,j}.Cantidad * DF2.Datos{i,j}.Cantidad ...
                    * kappa(DF1.Datos{i,j},DF2.Datos{i,j},MCOV{i,j});
        end
    end
    Distancia=sqrt(Distancia);
end
