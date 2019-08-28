function [ ka ] = kappa(Dat1,Dat2,CovCel)
%KAPPA Calcula la funcion kappa
% Es una funcion de nucleo y es una metrica para los datos en el plano,
% segun una matriz de covarianza

    if (Dat1.Media(1)==0 &&  Dat1.Media(2)==0) || (Dat2.Media(1)==0 &&  Dat2.Media(2)==0)
        ka=0;
    else
        MediaX1=Dat1.Media(1);
        MediaY1=Dat1.Media(2);
        MediaX2=Dat2.Media(1);
        MediaY2=Dat2.Media(2);
        MCovInv=inv(CovCel);
        ka = exp((-1/2)*(MCovInv(1,1)*(MediaX2-MediaX1).^2+...
            2*MCovInv(1,2)*(MediaX2-MediaX1).*(MediaY2-MediaY1)+...
            MCovInv(2,2)*(MediaY2-MediaY1).^2)...
           );
    end
end

