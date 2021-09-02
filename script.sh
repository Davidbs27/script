#!/bin/bash
#primero comprobamos que se introducen 2 parametros
if test "$#" -lt 2 
then
	echo "Error : Numero de argumentos incorrecto">&2
	exit 1
fi

if ! test -d "$1"
then 
	echo "$1 no es un diretorio">&2
	exit 1
fi  

#Ahora comprobaremos si los archivos se han copiado
numInicial=`ls $1 | wc -l`
numCopiados=0

for arg
do
	
	if [ "$arg" != "$1" ] # solo copia cuando se tiene el primer argumento inicial
	then
		if test -d $arg
		then
			cp -p -u $arg/* $1 # copiamos los archivos con la propieades que 						  
					   # tenian, en caso de tener mismo nombre se 						   
					   # queda con el ultimo modificado
			if [ $? -ne 0 ]	#si el argumento es = 0 mostramos un error
			then
				echo "Error : Durante la copia de documento">&2
			fi

			#numCopiados=$((`ls $arg|wc -l` + $numCopiados)) #sacamos el numero de archivos copiados
		else
			echo "Error: $arg no es un directorio">&2
			exit 2
		fi
	fi
done

if  [ $? -ne 0 ]
then
	echo "Error: en el recorrido de los argumentos"&2
fi

