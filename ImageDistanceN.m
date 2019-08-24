function [ Distancia ] = ImageDistanceN( DF1,DF2,MCOV )
    ID=ImageDistance( DF1,DF2,MCOV );
    Distancia=ID/(1+ID);
end