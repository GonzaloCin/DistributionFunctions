function Quantifiers_NADH( File1, File2)
    Glu = DatosFibra(File1,11); %glucolytic
    Oxi = DatosFibra(File2,11); %oxidative
    COV = MCOV({Oxi,Glu});
    
    fprintf('\n\tDGluOxi = %f \t' , ImageDistance(Glu,Oxi,COV) );
    fprintf('\tAnGluOxi = %f\n' , ImageDegAngle(Glu,Oxi,COV) );
end