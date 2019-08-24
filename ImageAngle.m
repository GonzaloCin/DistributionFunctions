function [ Angle ] = ImageAngle(DF1,DF2,MCOV)
%IMAGEANGLE Dadas dos funciones de densidad y una la matriz de covarianza
%calcula el angulo de dos imagenes
    nume=0;
    Ncel=DF1.Nceldas;
    for i=1:Ncel
        for j=1:Ncel
            nume=nume+ DF1.Datos{i,j}.Cantidad * DF2.Datos{i,j}.Cantidad...
                      * kappa(DF1.Datos{i,j}, DF2.Datos{i,j}, MCOV{i,j});
        end
    end
    Angle=acos(nume/(FunctionNorm(DF1)*FunctionNorm(DF2)));
end

