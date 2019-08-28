function [ DistanciaN ] = ImageDistanceN( DF1,DF2,MCOV )
%ImageDistanceN Calcula la distancia con la metrica de ???
%   La metrica obtenida va de 0 a 1
    ID=ImageDistance( DF1,DF2,MCOV );
    DistanciaN=ID/(1+ID);
end