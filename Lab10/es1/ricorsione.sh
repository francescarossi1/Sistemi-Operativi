#!/bin/sh
# ricorsione.sh - Script ricorsivo

dir_corrente=$1
dir_destinazione_ass=$2

cd "$dir_corrente" || exit 1

# Processa tutti gli elementi presenti nella directory corrente
for i in *
do
    # Gestione del caso di directory vuota o globbing fallito
    if test ! -e "$i"
    then
        break
    fi

    # Se è un file regolare
    if test -f "$i"
    then
        # Controllo se ha estensione .JPG e se è leggibile dall'utente
        case "$i" in
            *.JPG)
                if test -r "$i"
                then
                    # Verifica se esiste già un file con lo stesso nome nella destinazione
                    if test ! -e "$dir_destinazione_ass/$i"
                    then
                        # Nessun duplicato: sposta direttamente
                        mv "$i" "$dir_destinazione_ass/$i"
                    else
                        # Esiste già: gestione duplicati
                        # Estraiamo base del nome ed estensione (es. foto.JPG -> foto e JPG)
                        nome_base=`echo "$i" | sed 's/\.JPG$//'`
                        
                        num=1
                        # Cerca il primo nome univoco disponibile: nomefile-1.JPG, nomefile-2.JPG, ecc.
                        while test -e "$dir_destinazione_ass/duplicati/${nome_base}-${num}.JPG"
                        do
                            num=`expr $num + 1`
                        done

                        # Sposta il file nella cartella duplicati con il nuovo nome
                        mv "$i" "$dir_destinazione_ass/duplicati/${nome_base}-${num}.JPG"
                    fi
                fi
                ;;
        esac

    # Se è una sottodirectory, invoca ricorsivamente lo script (ignorando la directory 'duplicati' se fosse sotto sorgente)
    elif test -d "$i" -a "$i" != "." -a "$i" != ".."
    then
        ricorsione.sh "$dir_corrente/$i" "$dir_destinazione_ass"
    fi
done