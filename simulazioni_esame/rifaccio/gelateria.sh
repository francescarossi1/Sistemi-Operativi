#!/bin/sh
if test $# -ne 2
then 
    echo "errore numero argomenti"
    exit 1 
fi

dir="$1"
shift 
id_cliente="$1"
shift

case "$dir" in 
    /*) ;;
    *) echo "errore deve essere un path assoluto"
    exit 2 ;;
esac 

if test ! -d "$dir" -o ! -x "$dir"
then 
    echo "errore la dir non è attraversabile o non è una dir"
    exit 3
fi 

PATH=$PATH:`pwd`
export PATH

LOG="$HOME/id_cliente.log"
> "$LOG"
export LOG

MAX_COUNT="/tmp/max_count.tmp"
echo "0" > "$MAX_COUNT"
export MAX_COUNT

MAX_SEDE="/tmp/max_sede.tmp"
> "$MAX_SEDE"
export MAX_SEDE 

gelateria_ric.sh "$dir" "$id_cliente"

cat "$MAX_COUNT"
cat "$MAX_SEDE"

rm -f "$MAX_COUNT"
rm -f "$MAX_SEDE"
