#!/bin/sh

# Controllo del numero di argomenti
if [ $# -ne 1 ]; then
    echo "Uso: $0 dir" >&2
    exit 1
fi

DIR="$1"

# Verifica che l'argomento sia un percorso assoluto e una directory valida con permessi di lettura ed esecuzione
case "$DIR" in
    /*) ;;
     *) echo "Errore: '$DIR' non e' un percorso assoluto." >&2; exit 2 ;;
esac

if [ ! -d "$DIR" ] || [ ! -r "$DIR" ] || [ ! -x "$DIR" ]; then
    echo "Errore: la directory '$DIR' non esiste o non ha i permessi necessari." >&2
    exit 3
fi

# Definizione ed esportazione dei file di output nella directory HOME
export FILE_ERRORI="$HOME/errori.txt"
export FILE_WARNING="$HOME/warning.txt"

# Pulizia o creazione dei file di output
> "$FILE_ERRORI"
> "$FILE_WARNING"

# File temporaneo per raccogliere i conteggi degli errori per ciascuna directory
TMP_COUNTS="/tmp/conteggi_errori_$$"
export TMP_COUNTS
> "$TMP_COUNTS"

# Chiamata al secondo script ricorsivo
# Nota: Si assume che 'trova_errori_ric.sh' si trovi nel PATH o nella directory corrente
if [ -x "./trova_errori_ric.sh" ]; then
    ./trova_errori_ric.sh "$DIR"
else
    trova_errori_ric.sh "$DIR"
fi

# Analisi del file temporaneo per individuare la directory con il maggior numero di errori
if [ -s "$TMP_COUNTS" ]; then
    MAX_DIR=""
    MAX_COUNT=-1

    # Legge ogni riga del formato "COUNT DIR"
    while read -r COUNT DIR_PATH; do
        if [ "$COUNT" -gt "$MAX_COUNT" ]; then
            MAX_COUNT="$COUNT"
            MAX_DIR="$DIR_PATH"
        fi
    done < "$TMP_COUNTS"

    if [ "$MAX_COUNT" -gt 0 ]; then
        echo "La directory con il maggior numero di errori ($MAX_COUNT errori) e':"
        echo "$MAX_DIR"
    else
        echo "Nessun errore trovato nelle directory analizzate."
    fi
else
    echo "Nessun file .log analizzabile e' stato trovato."
fi

# Rimozione del file temporaneo
rm -f "$TMP_COUNTS"