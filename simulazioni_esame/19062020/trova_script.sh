#!/bin/bash

if test $# -ne 1 
then 
    echo "Errore: numero di argomenti errato"
    exit 1 
fi 

dir="$1"

case "$dir" in 
    /*) ;; 
    *) echo "Errore: deve essere un percorso assoluto"
       exit 2 ;;
esac 

if test ! -d "$dir" -o ! -x "$dir" 
then 
    echo "Errore: la directory non esiste o non è attraversabile"
    exit 3
fi 

PATH=$PATH:`pwd`
export PATH 

script="$HOME/script.txt"
> "$script"
export script

MAX="/tmp/max.tmp"
echo "0" > "$MAX"  
export MAX

DIR_MAX="/tmp/dir_max.tmp"
> "$DIR_MAX"
export DIR_MAX

trova_script_ric.sh "$dir" 

echo "Numero massimo di script trovati in una dir: "
cat "$MAX"
echo "Directory con il maggior numero di script: "
cat "$DIR_MAX"
echo "Lista di tutti gli script trovati (senza estensione):"
cat "$script"

rm -f "$MAX" "$DIR_MAX"