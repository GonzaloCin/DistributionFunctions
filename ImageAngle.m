function [ Angle ] = ImageAngle( DF1,DF2,MCOV )
%ImageAngle Calcula el angulo en radianes de dos distrubuciones
%   De acuerdo a Cauchy-Schwarz segun su producto interno y sus normas
    Angle=acos(ImageCosAngle( DF1,DF2,MCOV ));
end

