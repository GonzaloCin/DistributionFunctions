function [ DegAngle ] = ImageDegAngle( DF1,DF2,MCOV )
%ImageDegAngle Calcula el angulo de dos imagenes en grados segun la matriz de
%covarianza dada
%   Utiliza las funciones disponibles para este proposito, solo convierte
%   de radianes a grados
    DegAngle=radtodeg(ImageAngle(DF1,DF2,MCOV));
end

