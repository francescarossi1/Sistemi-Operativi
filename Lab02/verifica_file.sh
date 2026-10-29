#!/bin/sh
# Francesca Rossi 211964

while test "$nome" != fine 
do
    echo "Scrivi nome del file da cercare, fine per uscire" :
    read nome 

    if test "$nome" = fine
    then 
        continue 
    fi 

    if test -f "$nome"
    then    
        echo $nome è un file
    else 
        if test -d "$nome" 
        then 
            echo $nome è un direttorio
        else 
            echo $nome non esiste
        fi 
    fi
done