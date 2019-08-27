function [NMC ] = NuevaCov(Dato,Media)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

Dist=zeros(1,length(Dato(:,1)));
for i=1:length(Dato(:,1))
    aux=Dato(i,:)-Media;
    Dist(i)=aux(1)^2+aux(2)^2;
end
Lambda1=max(Dist);
Lambda2=Lambda1/9;
V1=((Dato(1,:)-Media)/norm(Dato(1,:)-Media))';
MG=[0 -1;1 0];
V2=MG*V1;
%M=((Dato(1,:)-Media)/norm(Dato(1,:)-Media))'.*[0 1;-1 0]*((Dato(1,:)-Media)/norm(Dato(1,:)-Media));
M=[V1,V2];
NMC=M*[Lambda1 0; 0 Lambda2]*M';
end

