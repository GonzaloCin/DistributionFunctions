
    Len=DatosFibra(strcat('ATP_S.xlsx'),11);
    Int=DatosFibra(strcat('ATP_I.xlsx'),11);
    Rap=DatosFibra(strcat('ATP_F.xlsx'),11);
    COV=MCOV({Len,Int,Rap});
    
    fprintf( '\n\tDistLentInt = %f \t' , ImageDistance(Len,Int,COV) );
    fprintf( '\tAngleLenInt = %f \n'   , ImageDegAngle(Len,Int,COV) );
    
    fprintf( '\tDistLenRap  = %f \t'   , ImageDistance(Len,Rap,COV) );
    fprintf( '\tAngleLenRap = %f \n'   , ImageDegAngle(Len,Rap,COV) );
       
    fprintf( '\tDistRapInt  = %f \t' , ImageDistance(Rap,Int,COV) );
    fprintf( '\tAngleRapInt = %f \n' , ImageDegAngle(Rap,Int,COV) );
    