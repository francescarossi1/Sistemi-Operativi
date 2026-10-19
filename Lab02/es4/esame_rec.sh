#!/bin/sh

est="$1"
dir1="$2"
dir2="$3"

# Entra nella directory sorgente
cd "$dir1"

# 1. Copia dei file con l'estensione specificata nella directory corrente
for i in *"$est"
do 
    # Verifica che sia un file effettivo e che NON esista già in dir2
    if test -f "$i" -a ! -f "$dir2/$i"
    then
        cp "$i" "$dir2/$i"
        # Stampa una riga per ogni file copiato (conteggiata poi da wc -l in es4.sh)
        echo "$i"
    fi
done

# 2. Esplorazione ricorsiva delle sottodirectory
for i in *
do
    if test ! -e "$i"
    then
        break
    fi

    # Se è una directory e si hanno i permessi di esecuzione
    if test -d "$i" -a -x "$i"
    then 
        esam.sh "$est" "$dir1/$i" "$dir2"
    fi
done