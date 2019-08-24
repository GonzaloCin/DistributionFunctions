
    Len=DatosFibra(strcat('ATP_l.xlsx'),11);
    Int=DatosFibra(strcat('ATP_i.xlsx'),11);
    Rap=DatosFibra(strcat('ATP_r.xlsx'),11);
    COV=MCOV({Len,Int,Rap});
    
    fprintf( strcat('\n\tDLentInt','=%f \t') , ImageDistance(Len,Int,COV) );
    fprintf( strcat('\tAnLenInt','=%f\n') , ImageDegAngle(Len,Int,COV) );
    
     fprintf( strcat('\tDLenRap','=%f\t') , ImageDistance(Len,Rap,COV) );
    fprintf( strcat('\tAnLenRap','=%f\n') , ImageDegAngle(Len,Rap,COV) );
       
     fprintf( strcat('\tDRapInt','=%f\t') , ImageDistance(Rap,Int,COV) );
     fprintf( strcat('\tAnRapInt','=%f\n') , ImageDegAngle(Rap,Int,COV) );
    
