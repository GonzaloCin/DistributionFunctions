function [] = Bola2(cant,nombre,radx,rady,cenx,ceny)
%UNTITLED2 Summary of this function goes here
%   Detailed explanation goes here
    Nwc=cant;
    cu=[(rand(Nwc,1)*2*radx)-radx, (rand(Nwc,1)*2*rady)-rady];
    %%scatter(cu(:,1),cu(:,2));
    j=1;
    for i=1:Nwc
        if ((rady*cu(i,1))^2)+((radx*cu(i,2))^2)<(radx*rady)^2
            ci(j,:)=cu(i,:);
            j=j+1;
        end
    end
    cir=ci+[cenx*ones(j-1,1),ceny*ones(j-1,1)];

    xlswrite(nombre,{'x','y','dim'},'Hoja1','A1');
    xlswrite(nombre,[3000;3000],'Hoja1','C2');
    xlswrite(nombre,round(cir),'Hoja1','A2');

    figure,scatter(cir(:,1),cir(:,2),10,'filled');
    h=gcf;
    set(h,'Units','pixels');
    set(h,'Position',[0 50 500 500]);
    axis([-radx+cenx radx+cenx -rady+ceny rady+ceny]);
    axis equal;
    axis off;
    set(h,'PaperPositionMode','auto')
    set(gca,'pos',[0 0 1 1])
    print(strcat(strrep(nombre,'.xlsx',''),'.tif'),'-dtiff','-r300');
    saveas(h,strcat(strrep(nombre,'.xlsx',''),'.fig'),'fig');
end

