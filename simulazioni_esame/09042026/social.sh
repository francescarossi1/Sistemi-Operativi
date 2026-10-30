#!/bin/sh

if test $# -ne 2
then 
    echo "Errore: il numero degli argomenti deve essere due."
    exit 1
fi 

categoria="$1"
archivio="$2"

if test -z "$categoria"
then 
    echo "Errore: il primo argomento deve essere una stringa."
    exit 2
fi 

case "$categoria" in 
    *[a-zA-Z0-9]*) ;;
    *) echo "Errore: la stringa deve essere alfanumerica."
    exit 3;;
esac

if test ! -d "$archivio"
then 
    echo "Errore: il secondo argomento deve essere una directory."
    exit 4
fi 

if test ! -x "$archivio"
then 
    echo "Errore: la directory deve avere i permessi di esecuzione."
    exit 5
fi 

case "$archivio" in 
    /*) ;;
    *) echo "Errore: la directory deve avere percorso assoluto."
    exit 6;;
esac

PATH=$PATH:$(pwd)
export PATH

LOG="$HOME/riepilogo.log"
> "$LOG"
export LOG

MAX_COUNT="/tmp/max_count.txt"
echo '0' > "$MAX_COUNT"
export MAX_COUNT

MAX_NAME="/tmp/max_name.txt"
> "$MAX_NAME"
export MAX_NAME

social_ric.sh "$categoria" "$archivio"

echo "La categoria che presenta il maggior numero di contenuto in un mese è $(cat "$MAX_NAME") con $(cat "$MAX_COUNT") contenuti."

rm -f "$MAX_COUNT"
rm -f "$MAX_NAME"


