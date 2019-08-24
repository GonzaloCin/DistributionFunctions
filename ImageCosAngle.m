function [ cosAngle ] = ImageCosAngle( DF1,DF2,MCOV )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
    nume=0;
    Ncel=DF1.Nceldas;
    for i=1:Ncel
            for j=1:Ncel
                nume=nume+DF1.Datos{i,j}.Cantidad*DF2.Datos{i,j}.Cantidad*kappa(DF1.Datos{i,j},DF2.Datos{i,j},MCOV{i,j});
            end
    end
    cosAngle=nume/(FunctionNorm(DF1)*FunctionNorm(DF2));
end
