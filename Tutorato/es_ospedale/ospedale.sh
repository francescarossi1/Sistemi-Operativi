#!/bin/sh
# Francesca Rossi 211964

if test $# -ne 2 
then 
    echo "errore: il numero di argomenti deve essere 2"
    exit 1 
fi 

reparto="$1"
shift 
anno="$1" 
shift 

# Reparto deve essere alfanumerico
case "$reparto" in 
    *[!0-9A-Za-z]*) echo "errore: reparto deve essere alfanumerico"
    exit 2 ;;
esac 

# Anno deve essere un path relativo (non deve iniziare con /)
case "$anno" in 
    /*) echo "errore: anno deve essere un path relativo" 
    exit 3 ;;
    *) ;;
esac 

# Verifico che anno sia una directory e sia attraversabile
if test ! -d "$anno" -o ! -x "$anno"
then 
    echo "errore: $anno deve essere una directory valida e attraversabile"
    exit 4
fi

# Impostazione PATH per gli script nella cartella corrente
PATH="$PATH:`pwd`"
export PATH

# File di log principale
RICOVERI="$HOME/ricoveri.txt"
> "$RICOVERI"
export RICOVERI

# File temporanei per il calcolo del massimo
MAX_MONTH="/tmp/max_month.txt" 
> "$MAX_MONTH"
export MAX_MONTH

MAX_COUNT="/tmp/max_count.txt"
echo "0" > "$MAX_COUNT"
export MAX_COUNT

# Invocazione dello script ricorsivo
ospedale_ric.sh "$reparto" "$anno" 

# Stampa del risultato finale
echo "Mese e anno con il numero maggiore di ricoveri: `cat "$MAX_MONTH"`" 

# Rimozione file temporanei 
rm -f "$MAX_MONTH" "$MAX_COUNT"