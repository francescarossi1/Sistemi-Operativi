# !/bin/sh

if test $# -ne 2
then 
    echo "errore numero argomenti"
    exit 1
fi 

dir="$1" 
shift 
lista_articoli="$1"
shift 

if test ! -d "$dir" -o ! -x "$dir"
then 
    echo "Errore non è una dir o non è attraversabile"
    exit 2
fi

case "$dir" in 
    /*) ;;
    *) echo "Errore deve essere un path assoluto" 
    exit 3 ;;
esac 

PATH=$PATH:`pwd`
export PATH

out=$HOME/"$lista_articoli"
> "$out"
export out 

max_dir="/tmp/max_dir.tmp"
> "$max_dir"
export max_dir

max="/tmp/max.tmp"
echo "0" > "$max"
export max


trova_categoria_vendita_ric.sh "$dir"

cat "$max"
cat "$max_dir"
cat "$out" 

rm -f "$max_dir" 
rm -f "$out"
rm -f "$max"