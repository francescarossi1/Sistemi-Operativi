#!/bin/sh
# Francesca Rossi 

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

shift 

echo Controllo il file $file

for i in $*
do 
    count=`grep "$i" "$file" | wc -l`
    echo "Parametro: $i - Ricorrenze: $count"
done 
