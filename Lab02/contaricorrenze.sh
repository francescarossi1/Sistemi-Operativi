#!/bin/sh
# Francesca Rossi 

#controllo argomenti 
if test $# -lt 2 
then 
    echo "Uso: contaricorrenze <file <stringhe...>"
    exit 1 
fi 

file=$1
if test ! -f "$file"
then 
    echo "Errore: il primo argomento deve essere un file"
    exit 2 
fi 

shift # elimino il primo argomento dalla lista

echo Controllo il file $file

for i in $*
do 
    count=`grep "$i" "$file" | wc -l`
    count=`grep -c "$i" "$file"`
    echo "Parametro: $i - Ricorrenze: $count"
done 
