function [ cosAngle ] = ImageCosAngle( DF1,DF2,MCOV )
%ImageCosAngle Calcula el coseno del angulo de dos distribuciones 
%   De acuerdo a Cauchy-Schwarz segun su producto interno y sus normas
    nume=0;
    Ncel=DF1.Nceldas;
    for i=1:Ncel
            for j=1:Ncel
                nume=nume+DF1.Datos{i,j}.Cantidad*DF2.Datos{i,j}.Cantidad*kappa(DF1.Datos{i,j},DF2.Datos{i,j},MCOV{i,j});
            end
    end
    cosAngle=nume/(FunctionNorm(DF1)*FunctionNorm(DF2));
end
