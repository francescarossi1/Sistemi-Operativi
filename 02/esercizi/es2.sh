#!/bin/sh
# es.2 - file lista <filename>

for i in *
do
    # Stampa il nome del file senza andare a capo (-n) inviando l'output al terminale (/dev/tty)
    echo -n "$i ? " > /dev/tty
    
    # Legge la risposta dell'utente
    read answer
    
    # Se l'utente risponde sì (y, Y, s, S), stampa nome e contenuto
    case $answer in
        y* | Y* | s* | S* ) 
            echo "$i"
            cat "$i"
            ;;
    esac
done