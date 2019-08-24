function [Covarianza ] = MCOV( ArrObj )
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    [~,R]=size(ArrObj);
    fprintf('Cantidad de imagenes: %i',R);
    Ncel=ArrObj{1,1}.Nceldas;
    fprintf('Cantidad de celdas: %i',Ncel);
    TX=ArrObj{1,1}.TamX;
    TY=ArrObj{1,1}.TamY;
    MCDatos=cell(Ncel);

    for i=1:Ncel
        for j=1:Ncel
            MCDatos{i,j}=DatosCelda((i-1)*TX,(i)*TX,(j-1)*TY,j*TY);
        end
    end

    for r=1:R
        for i=1:Ncel
            for j=1:Ncel
                for z=1:ArrObj{1,r}.Datos{i,j}.Cantidad
                    MCDatos{i,j}=anadir(MCDatos{i,j},ArrObj{1,r}.Datos{i,j}.Coor(z,:));
                end
            end
        end
    end

    Covarianza=cell(Ncel);
    for i=1:Ncel
        for j=1:Ncel
            MCDatos{i,j}=CalcularCov(MCDatos{i,j});
            Covarianza{i,j}=MCDatos{i,j}.Covar;
        end
    end
end

