# DistributionFunctions

## Utilizar el Programa Malla para graficar una funcion de densidad de un archivo dado

1. Abrir Matlab y cambiar el directorio a donde tenga los archivos excel y los programas incluidos en esta carpeta

2. Escribir en La Linea de Comando de Matlab la siguiente linea

``` [Matlab]
M= Malla(archivo,numero,res,ver,guardar,VXY,zoom)
```
	 
Donde M es el nombre del objeto malla

El argumento archivo es el nombre del archivo excel a analizar, se debe escribir entre comillas simples: por ejemplo: 'fibras.xls'

El argumento numero es el tamaño de la malla, se ha utilizado el 11 hasta cambio de planes
res es un argumento tecnico, 200 funciona bien
ver y guardar son argumentos de tipo booleano que hacen lo que indica su nombre, note que no puede poner ver como false y guardar como true

El argumento VXY es para usarse cuando se conoce el dominio para graficar la funcion, lo cual se utiliza cuando se combinan dos graficas en una
para casos del analisis de un solo archivo debe colocarse como 'null'

El argumento zoom es para indicar el la apliacion con la que se tomó la imagen para hacer una correcta conversión de pixeles a micras, puede ser '4x' , '10x', o 'default'


En resumen un ejemplo válido de graficacion de un archivo es escribir en la linea de comandos:
``` [Matlab]
M=Malla('C5NadhOscuros.xls',11,200,'false','false','null');
```

## Como Combinar dos funciones en una misma grafica
1. Abrir Matlab y cambiar el directorio a donde tenga los archivos excel y los programas incluidos en esta carpeta

2. Escribir en La Linea de Comando de Matlab la siguiente linea

```
	h = CombinarFunciones( Archivo1, Archivo2,num,res )
```
Donde Archivo1 es el nombre del primer archivo
Analogamente Archivo2
El argumento num es el tamaño de la malla, se ha utilizado el 11 hasta cambio de planes
res es un argumento tecnico, 200 funciona bien


Un ejemplo es el siguiente
```
h=CombinarFunciones('219mPcATP-oxidativas.xls','219mPcATP-glucoliticas.xls',11,200);
```

Este método guardara por defecto un archivo .fig que es modificable en matlab y otra imagen .png



## Como Generar las imagenes .tiff de una base de coordenadas
1. Abrir Matlab y cambiar el directorio a donde tenga los archivos excel y los programas incluidos en esta carpeta

2. Escribir en la linea de comandos
```
Generar_imagenes(archivo,tam)
```

Donde archivo es el mnombre del archivo que contiene la información a graficar, se debe escribir entre comillas simples y con extension, considerando que tambien debe tener las dimensiones de la imagen en la tercera columna
tam es el tamaño de los puntos a graficar

Un ejemplo es el siguiente:
```
Generar_imagenes('219mPcATP-oxidativas.xls',5) 
```

## Como Generar las imagenes .tiff de una base de coordenadas en un solo archivo en distintas 

1. Abrir Matlab y cambiar el directorio a donde tenga los archivos excel y los programas incluidos en esta carpeta

2. Escribir en la linea de comandos

```
Generar_imagenesM(archivo,tam,hoja)
```


Donde archivo es el mnombre del archivo que contiene la información a graficar, se debe escribir entre comillas simples y con extension
tam es el tamaño de los puntos a graficar
hoja es el nombre de la hoja, tambien va entre comillas, considerando que tambien debe tener las dimensiones de la imagen en la tercera columna

Un ejemplo es el siguiente:
```
Generar_imagenes('219mPcATP.xls',5,'Oxidativas') 
```