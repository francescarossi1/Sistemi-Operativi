#!/bin/sh

# 1. Controllo numero parametri
if test $# -ne 3
then 
    echo "Errore: occorrono esattamente 3 argomenti"
    echo "Uso: $0 <.estensione> <dir1> <dir2>"
    exit 1
fi 

estensione="$1"

# 2. Controllo estensione (deve iniziare con '.')
case "$estensione" in
    .*) ;;
    *) 
        echo "Errore: il primo argomento deve iniziare con '.'"
        exit 2
        ;;
esac

dir1="$2"

# 3. Controllo dir1 (percorso assoluto ed esistenza)
case "$dir1" in 
    /*) ;;
    *) 
        echo "Errore: il secondo argomento deve essere un percorso assoluto"
        exit 3
        ;;
esac

if test ! -d "$dir1"
then 
    echo "Errore: '$dir1' non è un direttorio valido"
    exit 4
fi

dir2="$3"

# 4. Controllo dir2 (percorso assoluto ed esistenza)
case "$dir2" in 
    /*) ;;
    *) 
        echo "Errore: il terzo argomento deve essere un percorso assoluto"
        exit 5
        ;;
esac

if test ! -d "$dir2"
then 
    echo "Errore: '$dir2' non è un direttorio valido"
    exit 6
fi

# 5. Aggiornamento del PATH per trovare lo script ricorsivo
PATH=$PATH:`pwd`
export PATH

# 6. Esecuzione ricorsiva e conteggio dei file copiati
totale=`esam.sh "$estensione" "$dir1" "$dir2" | wc -l`

echo "Numero di file complessivamente copiati: $totale"