function [ norm ] = FunctionNorm( DF )
%FUNCTIONNNORM Dada una Funcion de Distribucion calcula su norma
    cuad=0;
    Ncel=DF.Nceldas;
    for i=1:Ncel
            for j=1:Ncel
                cuad=cuad+DF.Datos{i,j}.Cantidad^2;
            end
    end
    norm=sqrt(cuad);
end

