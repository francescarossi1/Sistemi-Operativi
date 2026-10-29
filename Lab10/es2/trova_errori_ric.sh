#!/bin/sh

CURRENT_DIR="$1"
DIR_ERRORS=0

# Esamina tutti i file con estensione .log presenti nella directory corrente
for LOGFILE in "$CURRENT_DIR"/*.log; do
    # Verifica che il pattern sia corrisposto a un file reale e che sia leggibile
    if [ -f "$LOGFILE" ] && [ -r "$LOGFILE" ]; then
        
        # 1. Estrazione degli errori e scrittura su $FILE_ERRORI
        # Campi da estrarre: $2 (Progetto), $1 (Sorgente), $6 (Info dettagliate)
        awk -F',' '$4 == "error" { print $2 "," $1 "," $6 }' "$LOGFILE" >> "$FILE_ERRORI"

        # 2. Estrazione dei warning e scrittura su $FILE_WARNING
        awk -F',' '$4 == "warning" { print $2 "," $1 "," $6 }' "$LOGFILE" >> "$FILE_WARNING"

        # 3. Conteggio degli errori nel file corrente per la statistica finale
        N_ERR=$(grep -c ",error," "$LOGFILE")
        DIR_ERRORS=$((DIR_ERRORS + N_ERR))
    fi
done

# Salva il totale degli errori trovati nella directory corrente
echo "$DIR_ERRORS $CURRENT_DIR" >> "$TMP_COUNTS"

# Esplorazione ricorsiva delle sottocartelle
for SUBDIR in "$CURRENT_DIR"/*; do
    if [ -d "$SUBDIR" ] && [ -r "$SUBDIR" ] && [ -x "$SUBDIR" ]; then
        # Invoca ricorsivamente lo script sulla sottodirectory
        "$0" "$SUBDIR"
    fi
done