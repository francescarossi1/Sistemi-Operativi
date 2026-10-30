#!/bin/sh 

if test $# -ne 2
then 
    echo "errore numero argomenti"
    exit 1 
fi 

dir="$1"
shift 
id_robot="$1"
shift 

case "$dir" in 
    /*) "errore dir deve essere un percorso relativo"
    exit 2 ;;
esac 

if test ! -d "$dir" -o ! -x "$dir" 
then 
    echo "Errore dir non è attraversabile o non è una dir"
    exit 3 
fi 

case "$id_robot" in 
    *[!0-9A-Za-z]*) echo "errore id robot non è alfanumerica" 
    exit 4 ;;
esac 

PATH=`pwd`:$PATH
export PATH

LOG="$HOME/$id_robot.log"
> $LOG 
export LOG

MAX_COUNT="/tmp/max_count.tmp"
echo "0" > $MAX_COUNT
export MAX_COUNT

MAX_FILE="/tmp/max_file.tmp"
> $MAX_FILE
export MAX_FILE

monitoraggio_ric.sh "$dir" "$id_robot"

echo "La sottocartella con il maggior numero di file è `cat "$MAX_FILE"` con `cat "$MAX_COUNT"` file" 

rm -f "$MAX_COUNT"
rm -f "$MAX_FILE"