#!/bin/sh

if test "$#" -ne 2
then 
    echo "numero parametri errato"
    exit 1
fi

dir="$1"
shift
id_cliente="$1"
shift

case "$dir" in
    /*) ;;
    *) echo "dir deve essere un percorso assoluto"
    exit 2;;
esac

if test ! -x "$dir"  
then 
    echo "errore la dir non è attraversabile"
    exit 3
fi


case "$id_cliente" in 
    *[a-z]*) echo "id cliente deve avere solo con lettere maiuscole"
    exit 4;;
esac

PATH=`pwd`:$PATH
export PATH

LOG="$HOME/$id_cliente.log"
> "$LOG"
export LOG

MAX_COUNT="/tmp/max_count.tmp"
echo "0" > "$MAX_COUNT"
export MAX_COUNT

MAX_SEDE="/tmp/max_sede.tmp"
> "$MAX_SEDE"
export MAX_SEDE

gelateria_ric.sh "$dir" "$id_cliente"

echo "Cliente $id_cliente: `cat $MAX_SEDE`"

rm -f "$MAX_COUNT" "$MAX_SEDE"


