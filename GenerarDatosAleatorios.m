vals=[500,1000,2000,3000,4000];
Radio=1500;
Cx=1500;
Cy=1500;
Delta=300;
for i=1:length(vals)
    Anillo2(vals(i),strcat('A',num2str(vals(i)),'.xlsx'),Radio,Cx,Cy,Delta);
    Bola2(vals(i),strcat('B',num2str(vals(i)),'.xlsx'),Radio,Radio,Cx,Cy);
    Cruz2(vals(i),strcat('C',num2str(vals(i)),'.xlsx'),Radio,Cx,Cy,Delta);
    Suma2(vals(i),strcat('S',num2str(vals(i)),'.xlsx'),Radio,Cx,Cy,Delta);
end
