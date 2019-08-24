
    Glu=DatosFibra(strcat('NADH_G.xlsx'),11);
    Oxi=DatosFibra(strcat('NADH_O.xlsx'),11);
    COV=MCOV({Oxi,Glu});
    
    fprintf( strcat('\n\tDGluOxi','=%f \t') , ImageDistance(Glu,Oxi,COV) );
    fprintf( strcat('\tAnGluOxi','=%f\n') , ImageDegAngle(Glu,Oxi,COV) );