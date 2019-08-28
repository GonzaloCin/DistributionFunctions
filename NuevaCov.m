function [ NMC ] = NuevaCov(Dato,Media)
%NUEVACOV Contruye la matriz de covarianza sugerida 
%   Para celdas con datos linealmente dependientes, por lo que la matriz de
%   covarianza que resultan cercanas a ser singulares

	% Vector con las distancias de los puntos a la media
	Dist=zeros(1,length(Dato(:,1)));

	for i=1:length(Dato(:,1))
	    aux=Dato(i,:)-Media;
	    Dist(i)=aux(1)^2+aux(2)^2;
	end
	
	% Asigna los valores propios de la matriz que se construira
	Lambda1=max(Dist);
	Lambda2=Lambda1/9;
	
	% Se asigna un vector propio
	V1=((Dato(1,:)-Media)/norm(Dato(1,:)-Media))';
	
	% Se asigna segundo valor propio ortogonal al primero
	MG=[0 -1;1 0];
	V2=MG*V1;
	
	M=[V1,V2];
	% Calculo de la nueva matriz de covarianza con las propiedades deseadas
	NMC=M*[Lambda1 0; 0 Lambda2]*M';

end
