classdef Celda
    %UNTITLED Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
        Cantidad
        Xm
        XM
        Ym
        YM
        Puntos
        Media
        MediaX
        MediaY
        MCovarianza
        MCovInv
        VarX
        VarY
        Cov
        Ro
        Proporcion
        Funcion
    end
    
    methods
        function cen = getCentroide(Cel)
            cen=Cel.Media;
        end
        
        function C = Celda(Cant,Xm,XM,Ym,YM)
            C.Cantidad=Cant;
            C.Xm=Xm;
            C.XM=XM;
            C.Ym=Ym;
            C.YM=YM;
        end
        
        function cel = anadir(cel,punto)
            cel.Cantidad = cel.Cantidad + 1;
            cel.Puntos(cel.Cantidad,:)=punto;
        end
        
        function disp(Cel)
            if(Cel.Cantidad~=0)
                fprintf('Cantidad %i',Cel.Cantidad);
                Cel.Puntos
            end
        end
        
        function Cel=calcular(Cel,XX,YY)
            if(Cel.Cantidad>1)
                   Cel.Media=mean(Cel.Puntos);
                   Cel.MediaX=Cel.Media(1);
                   Cel.MediaY=Cel.Media(2);
                   %Cel.Puntos
                   Cel.MCovarianza=cov(Cel.Puntos);
                   %%Cel.MCovarianza
                   %det(Cel.MCovarianza)
                   if (det(Cel.MCovarianza)<0.0000001)
                       fprintf('d0,');
                       %Cel.Puntos;
                       %Cel.MCovarianza;
                       Cel.MCovarianza=NuevaCov(Cel.Puntos,Cel.Media);
                       %Cel.MCovarianza;
                   end
                   Cel.VarX=Cel.MCovarianza(1,1);
                   Cel.VarY=Cel.MCovarianza(2,2);
                   Cel.Cov=Cel.MCovarianza(2,1);
                   Cel.Ro=Cel.Cov/((Cel.VarX*Cel.VarY)^(1/2));
                   Cel.MCovInv=inv(Cel.MCovarianza);
                   %%Fac=1/(2*pi*((Cel.VarX*Cel.VarY)^(1/2))*((1-Cel.Ro^2)^(1/2)));
                   %%Fac=1;
%                    Fac
%                    f1=(-1/2*(1-Cel.Ro^2)^(1/2));
%                    
%                    f1
%                    length(XX)
%                    f2=((XX-Cel.MediaX*ones(length(XX))).^2/Cel.VarX);
%                    f2
%                    length(YY)
%                    Cel.MediaY
%                    YY-Cel.MediaY*ones(length(YY))
%                    f3=((YY-Cel.MediaY*ones(length(YY))).^2/Cel.VarY);
%                    f3
%                    f4=((2*Cel.Ro*XX.*YY)/((Cel.VarX*Cel.VarY)^(1/2)));
%                    f4
%                    
                   %%Cel.Funcion=Fac*exp((-1/(2*(1-Cel.Ro^2)^(1/2)))*(((XX-Cel.MediaX*ones(length(XX))).^2/Cel.VarX)+((1/Cel.VarY)*((YY-Cel.MediaY*ones(length(YY))).^2))-((2*Cel.Ro*XX.*YY)/((Cel.VarX*Cel.VarY)^(1/2)))));
                   
                   Cel.Funcion=exp((-1/2)*(Cel.MCovInv(1,1)*(XX-Cel.MediaX).^2+2*Cel.MCovInv(1,2)*(XX-Cel.MediaX).*(YY-Cel.MediaY)+Cel.MCovInv(2,2)*(YY-Cel.MediaY).^2));
                   %%figure,plot(Cel.Puntos(:,1),Cel.Puntos(:,2)','*')
                   %%figure,surf(XX,YY,Cel.Funcion)
                   %%pause
                   %%Cel.Funcion=reshape(F,length(XX),length(YY));

               else
                   if(Cel.Cantidad==1)
                       Cel.Media=Cel.Puntos;
                       Cel.MediaX=Cel.Puntos(1);
                       Cel.MediaY=Cel.Puntos(2);
                       %Cel.Puntos
                       Dm=min([abs(Cel.Puntos(1)-Cel.Xm),abs(Cel.Puntos(1)-Cel.XM),abs(Cel.Puntos(2)-Cel.Ym),abs(Cel.Puntos(2)-Cel.YM)]);
                       Cel.MCovarianza=[(Dm/3)^2 0; 0 (Dm/3)^2];
                       Cel.VarX=Cel.MCovarianza(1,1);
                       Cel.VarY=Cel.MCovarianza(2,2);
                       Cel.Cov=Cel.MCovarianza(2,1);
                       Cel.Ro=Cel.Cov/((Cel.VarX*Cel.VarY)^(1/2));
                       %%Fac=1/(2*pi*((Cel.VarX*Cel.VarY)^(1/2))*((1-Cel.Ro^2)^(1/2)));
                       %%Fac=1;
                       Cel.Funcion=exp((-1/2*((1-Cel.Ro^2)^(1/2)))*(((XX-Cel.MediaX).^2/Cel.VarX)+((YY-Cel.MediaY).^2/Cel.VarY))-(2*Cel.Ro*XX.*YY)/((Cel.VarX*Cel.VarY)^(1/2)));
                   else
                       Cel.Media=[0 0];
                       Cel.Funcion=zeros(length(XX));
                   end
            end
        end
        
        function f=getFuncion(Cel)
            f=Cel.Funcion;
        end
        
        function c=getCantidad(Cel)
            c=Cel.Cantidad;
        end
    end
    
end

