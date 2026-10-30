#!/bin/sh

if test $# -ne 2 
then 
    echo "errore numero argomenti" 
    exit 1 
fi 

nome="$1"
shift 
anno="$1"
shift 

case "$anno" in 
    /*) ;;
    *) echo "errore anno deve essere un path assoluto"
    exit 2 ;;
esac

if test ! -d "$anno" -o ! -x "$anno"
then 
    echo "errore anno deve essere una dir o non è attraversabile" 
    exit 3
fi 

PATH=`pwd`:$PATH
export PATH

LOG="$HOME/fiumilog.txt"
> "$LOG"
export LOG

GIORNO="/tmp/giorno.tmp"
> "$GIORNO"
export GIORNO

MIN_CORSO="/tmp/min_corso.tmp"
echo "500" > "$MIN_CORSO"
export MIN_CORSO

esame_ric.sh "$nome" "$anno"

echo "numero più basso del corso d'acqua `cat "$MIN_CORSO"` con `cat "$GIORNO"` giorno" 

rm -f "$GIORNO"
rm -f "$MIN_CORSO"