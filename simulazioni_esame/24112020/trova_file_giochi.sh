#!/bin/sh

if test $# -ne 1
then
    echo "errore numero argomenti"
    exit 1
fi

dir="$1"
case "$dir" in
    /*) echo "errore: dir non è una directory relativa"
       exit 2 ;;
esac

if test ! -d "$dir" -o ! -x "$dir"
then
    echo "errore: non è una dir o non attraversabile"
    exit 3
fi

PATH=$PATH:`pwd`
export PATH

trovato="$HOME/trovato.txt"
> "$trovato"
export trovato

MAX_COUNT="/tmp/max_count.tmp"
echo "0" > "$MAX_COUNT"
export MAX_COUNT

MAX_FILE="/tmp/max_file.tmp"
> "$MAX_FILE"
export MAX_FILE

trova_file_giochi_ric.sh "$dir"

cat "$MAX_COUNT"
cat "$MAX_FILE"

rm -f "$MAX_COUNT" "$MAX_FILE"