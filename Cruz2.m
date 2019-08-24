function [] = Cruz2(cant,nombre,rad,cenx,ceny,delta)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
Nwc=cant;
cu=[(rand(Nwc,1)*2*rad)-rad, (rand(Nwc,1)*2*rad)-rad];
%%scatter(cu(:,1),cu(:,2));
%%cu
j=1;
for i=1:Nwc
    if  (cu(i,1)^2 < (delta/2)^2) || (cu(i,2)^2 < (delta/2)^2)
        ci(j,:)=cu(i,:);
        j=j+1;
    end
end
%%ci
rot=[cos(pi/4) -sin(pi/4); sin(pi/4) cos(pi/4)];
B=rot*ci';
cir=B'+[cenx*ones(j-1,1),ceny*ones(j-1,1)];

xlswrite(nombre,{'x','y','dim'},'Hoja1','A1');
xlswrite(nombre,[3000;3000],'Hoja1','C2');
xlswrite(nombre,round(cir),'Hoja1','A2');

figure,scatter(cir(:,1),cir(:,2),10,'filled');
h=gcf;
set(h,'Units','pixels');
set(h,'Position',[0 50 500 500]);
axis([-rad+cenx rad+cenx -rad+ceny rad+ceny]);
axis equal;
axis off;
set(h,'PaperPositionMode','auto')
set(gca,'pos',[0 0 1 1])
print(strcat(strrep(nombre,'.xlsx',''),'.tif'),'-dtiff','-r300');
saveas(h,strcat(strrep(nombre,'.xlsx',''),'.fig'),'fig');
end

