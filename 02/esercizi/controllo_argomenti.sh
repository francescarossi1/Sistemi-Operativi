#!/bin/sh
# Shell Script basato sugli appunti forniti (Controlli su argomenti, nomi di file, espressioni numeriche e shift)

# ==============================================================================
# 1. CONTROLLO DEGLI ARGOMENTI
# ==============================================================================

# Controllo del numero di argomenti tramite 'case' (es. richiede almeno 4 argomenti)[cite: 5]
case $# in
    0|1|2|3)
        echo "errore: Almeno 4 argomenti... >&2"[cite: 5]
        exit 1[cite: 5]
        ;;
esac[cite: 5]

# Oppure controllo analogo usando 'if test'[cite: 5]
if test $# -lt 4
then
    echo "Errore: argomenti insufficienti" >&2[cite: 5]
    exit 1[cite: 5]
fi[cite: 5]

# Verifica se il primo argomento è una directory[cite: 5]
if test ! -d "$1"
then
    echo "argomento sbagliato: $1 non è una directory" >&2[cite: 5]
    exit 2[cite: 5]
fi[cite: 5]

# ==============================================================================
# 2. CONTROLLI SUL NOME DEL FILE (ASSOLUTO O RELATIVO)
# ==============================================================================

# Verifica se il primo argomento è un percorso ASSOLUTO (inizia con /)[cite: 5]
case $1 in
    /*)
        if test ! -f "$1"
        then
            echo "argomento sbagliato: $1 non è un file" >&2[cite: 5]
            exit 2[cite: 5]
        fi
        ;;
    *)
        echo "argomento sbagliato: $1 non è un percorso assoluto" >&2[cite: 5]
        exit 3[cite: 5]
        ;;
esac[cite: 5]

# Verifica se il primo argomento è un percorso RELATIVO (non inizia con /)[cite: 5]
case $1 in
    /*)
        echo "argomento sbagliato: $1 non è un nome relativo" >&2[cite: 5]
        exit 3[cite: 5]
        ;;
    *)
        ;;
esac[cite: 5]

# ==============================================================================
# 3. VERIFICA DI ESPRESSIONI NUMERICHE
# ==============================================================================

# Verifica se un argomento è una stringa numerica usando 'expr'[cite: 5]
expr "$1" + 0 > /dev/null 2> /dev/null[cite: 5]
if test $? -ne 0
then
    echo "errore: l'argomento non è un numero: $1" >&2[cite: 5]
    exit 4[cite: 5]
fi[cite: 5]

# ==============================================================================
# 4. USO DEL COMANDO SHIFT PER ELIMINARE ED ESAMINARE GLI ARGOMENTI
# ==============================================================================

# Salvataggio dei primi due argomenti prima di eliminarli[cite: 5]
salva1="$1"[cite: 5]
shift[cite: 5]
salva2="$1"[cite: 5]
shift[cite: 5]

# Ciclo 'for' sugli argomenti rimanenti escludendo quelli salvati e rimossi con shift[cite: 5]
for i in "$@"
do
    echo "Processo l'argomento esaminato: $i"[cite: 5]
done[cite: 5]

# Gli argomenti iniziali rimangono memorizzati nelle variabili salvate[cite: 5]
echo "Argomento 1 salvato: $salva1"[cite: 5]
echo "Argomento 2 salvato: $salva2"[cite: 5]