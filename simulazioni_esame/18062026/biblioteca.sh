#!/bin/sh

# Francesca Rossi 211964

if test $# -ne 2
then 
    echo " errore numero parametri"
    exit 1 
fi 

cartella="$1"
shift 
id_libro="$1"
shift

case "$cartella" in 
    /*) ;;
    *) echo " errore non è un path assoluto"
    exit 2 ;;
esac

if test ! -x "$cartella"
then 
    echo " errore la dir non è attraversabile"
    exit 3
fi 

PATH=$PATH:`pwd`
export PATH

LOG="$HOME/"$id_libro".log"
> "$LOG"
export LOG 

MAX_COUNT="/tmp/max_count.tmp"
echo "0" > "$MAX_COUNT"
export MAX_COUNT 

MAX_SEZIONE="/tmp/max_sezione.tmp"
> "$MAX_SEZIONE"
export MAX_SEZIONE

biblioteca_ric.sh "$cartella" "$id_libro" 

echo numero maggiore: `cat "$MAX_SEZIONE"` con `cat "$MAX_COUNT"` prestiti 
rm -f "$MAX_COUNT" "$MAX_SEZIONE"