# !/bin/sh

if test $# -ne 2 
then 
    echo "errore nel numero di argomenti"
    exit 1
fi

dir="$1"
shift 
header="$1"
shift 

case "$dir" in 
    /*) ;;
    *) echo " errore dir non è una directory assoluta"
    exit 2 ;;
esac

if test ! -d "$dir" -o ! -x "$dir"
then 
    echo "errore non è una dir o non è attraversabile"
    exit 3 
fi 

PATH=$PATH:`pwd`
export PATH 

misure="$HOME/misure.txt"
> "$misure"
export misure

MAX_COUNT="/tmp/max_count.tmp"
echo "0" > "$MAX_COUNT"
export MAX_COUNT

MAX_DIR="/tmp/max_file.tmp"
> "$MAX_DIR"
export MAX_DIR

cerca_misure_ric.sh "$dir" "$header"

echo `cat "$MAX_COUNT" `
echo `cat "$MAX_DIR"`

rm -f "$MAX_COUNT"
rm -f "$MAX_DIR"



