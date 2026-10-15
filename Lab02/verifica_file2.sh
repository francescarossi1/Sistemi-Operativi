#!/bin/sh
# Francesca Rossi 211964

while true
do
    echo "Scrivi nome del file da cercare, fine per uscire:"
    read nomefile

    if test "$nomefile" = fine
    then 
        echo Ricevuta richiesta di terminazione
        exit 0
    fi 

    if test -f "$nomefile"
    then    
        echo "$nomefile è un file"
    else 
        if test -d "$nomefile" 
        then 
            echo "$nomefile è un direttorio"
        else 
            echo "$nomefile non esiste"
        fi 
    fi
done