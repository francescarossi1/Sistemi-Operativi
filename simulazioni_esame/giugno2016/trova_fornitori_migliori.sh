#!/bin/sh

if test $# -ne 3
then 
    echo "Errore numero argomenti"
    exit 1 
fi 

dir="$1"
shift 
cod_parte="$1"
shift
num="$1"
shift 

case "$dir" in 
    /*);;
    *) echo "errore deve essere un path assoluto"
    exit 2 ;;
esac 

if test ! -d "$dir" -o ! -x "$dir" 
then 
    echo "errore non è una dir o non è attraversabile"
    exit 3 
fi 

case "$cod_parte" in 
    *[0-9A-Za-z]*) ;;
    *) echo "errore deve essere alfanumerico"
    exit 4 ;;
esac 

case "$num" in 
    *[!0-9]*) echo " Errore num deve essere un numero"
    exit 5 ;;
esac 

PATH=$PATH:`pwd`
export PATH

MAX_COUNT="/tmp/max_count.tmp"
echo "0" > "$MAX_COUNT"
export MAX_COUNT

MAX_FORNITORE="/tmp/max_fornitore.tmp"
> "$MAX_FORNITORE"
export MAX_FORNITORE

trova_fornitori_migliori_ric.sh "$dir" "$cod_parte" "$num"

cat "$MAX_COUNT"
cat "$MAX_FORNITORE"

rm -f "$MAX_COUNT"
rm -f "$MAX_FORNITORE"

