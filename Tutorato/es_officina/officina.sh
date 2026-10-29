#!/bin/sh

#Francesca Rossi 211964
#officina categoria anno 

if test $# -ne 2 # esattamente 2 
then 
    echo "errore numero di parametri errato"
    exit 1 
fi 

categoria="$1"
shift
anno="$1"
shift 

#categoria stringa alfanumerica
case "$categoria" in 
    *[!0-9A-Za-z]*) echo "errore <categoria> non è alfanumerico"
    exit 2 ;;
esac 

#anno path assoluto
case "$anno" in 
    /*) ;;
    *) echo "errore <anno> non è un path assoluto"
    exit 3 ;;
esac

#verifico che anno sia una dir
if test ! -d "$anno"
then 
    echo "errore <anno> non è una dir valida"
    exit 4 
fi 

# verifico che <anno> sia attraversabile 
if test ! -x "$anno"
then 
    echo "errore <anno> non è attraversabile"
    exit 5 
fi 

# Corretto l'aggiornamento del PATH mantenendo i comandi di sistema
PATH="$PATH:`pwd`"
export PATH 

RIEPILOGO="$HOME/riepilogo.log"
if test ! -f "$RIEPILOGO" 
then 
    > "$RIEPILOGO"
fi 
export RIEPILOGO 

MAX_COUNT=/tmp/max_count.txt
echo "0" > "$MAX_COUNT"
export MAX_COUNT

MAX_CAT=/tmp/max_cat.txt
> "$MAX_CAT"
export MAX_CAT

# chiamata script ricorsivo
officina_ric.sh "$categoria" "$anno"

#stampo risultati
echo "categoria con il numero maggiore di interventi in un singolo mese : `cat "$MAX_CAT"`" 

# rimuovo file temporanei 
rm -f "$MAX_CAT" "$MAX_COUNT"