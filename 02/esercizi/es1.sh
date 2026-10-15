#!/bin/sh
# es.1 - file view filename [filename] ...

# Controllo del numero di argomenti
case $# in
    0) 
        echo "Usage: $0 filename [filename]"
        exit 1
        ;;
esac

# Scansione di ciascun argomento passato
for i in "$@"
do
    # Se esiste il file ed è un file ordinario (proprio)
    if test -f "$i"
    then
        echo "$i"  # Visualizza il nome del file
        cat "$i"   # Visualizza il contenuto del file
    else
        echo "file $i: non è un file proprio"
    fi
done