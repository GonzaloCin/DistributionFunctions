function Quantifiers_ATP( File1, File2, File3)
      
    Fast=DatosFibra(File1,11);  %Fast fibers
    Int=DatosFibra(File2,11);   %Intermediate fibers
    Slow=DatosFibra(File3,11);  %Slow fibers
    COV=MCOV({Slow,Int,Fast});
    
    fprintf( '\n\tDSlowInt  = %f \t' , ImageDistance(Slow,Int,COV) );
    fprintf( '\tAnSlowInt  = %f\n' , ImageDegAngle(Slow,Int,COV) );
    
    fprintf( '\tDSlowFast = %f\t' , ImageDistance(Slow,Fast,COV) );
    fprintf( '\tAnSlowFast = %f\n' , ImageDegAngle(Slow,Fast,COV) );
       
    fprintf( '\tDFastInt  = %f\t' , ImageDistance(Fast,Int,COV) );
    fprintf( '\tAnFastInt  = %f\n' , ImageDegAngle(Fast,Int,COV) );
    
end